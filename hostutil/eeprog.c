// eeprog - 28C64/28C256 EEPROM programmer host program
// Copyright (c) 2019, David H. Hovemeyer <david.hovemeyer@gmail.com>

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#include <stdint.h>
#include <errno.h>
#include <fcntl.h> 
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <termios.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <regex.h>

#define VER_MAJOR 1
#define VER_MINOR 1

//
// IO channel data type.
//
struct IO {
	const char *fileName;
	int fd;
	FILE *fh;
};

//
// Global variables
//
const char *g_port, *g_fileName, *g_outputFileName;
int g_writeProtectEnable, g_writeProtectDisable;
int g_verify;
off_t g_dataReadSize = -1;
int g_showHelp;

off_t g_dataSize;
uint8_t g_dataBuf[65536];
uint8_t g_dataReadBuf[65536];

//
// Configure serial communication parameters:
// code stolen from:
//   https://stackoverflow.com/questions/6947413/how-to-open-read-and-write-from-serial-port-in-c
//
int set_interface_attribs(int fd, int speed) {
	struct termios tty;

	if (tcgetattr(fd, &tty) < 0) {
		printf("Error from tcgetattr: %s\n", strerror(errno));
		return -1;
	}

	cfsetospeed(&tty, (speed_t)speed);
	cfsetispeed(&tty, (speed_t)speed);

	tty.c_cflag |= (CLOCAL | CREAD);	/* ignore modem controls */
	tty.c_cflag &= ~CSIZE;
	tty.c_cflag |= CS8;		 /* 8-bit characters */
	tty.c_cflag &= ~PARENB;	 /* no parity bit */
	tty.c_cflag &= ~CSTOPB;	 /* only need 1 stop bit */
	tty.c_cflag &= ~CRTSCTS;	/* no hardware flowcontrol */

	/* setup for non-canonical mode */
	tty.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP | INLCR | IGNCR | ICRNL | IXON);
	tty.c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
	tty.c_oflag &= ~OPOST;

	/* fetch bytes as they become available */
	tty.c_cc[VMIN] = 1;
	tty.c_cc[VTIME] = 1;

	if (tcsetattr(fd, TCSANOW, &tty) != 0) {
		printf("Error from tcsetattr: %s\n", strerror(errno));
		return -1;
	}
	return 0;
}

//
// Display an error message.
//
void display_error(const char *tag, const char *fmt, va_list args) {
	fprintf(stderr, "%s: ", tag);
	vfprintf(stderr, fmt, args);
}

//
// Display an illegal state error message, meaning
// that an illegal state has been reached (possibly because
// of bad input), but there is no errno value from which
// to produce a more specific diagnostic.
// Terminates the program.
//
void illegal_state(const char *fmt, ...) {
	va_list args;

	va_start(args, fmt);
	display_error("Error", fmt, args);
	fprintf(stderr, "\n");
	va_end(args);

	exit(1);
}

//
// Display a fatal runtime error, in which errno is set
// and we can print a meaningful diagnostic.
// Terminates the program.
//
void fatal(const char *fmt, ...) {
	va_list args;

	va_start(args, fmt);
	display_error("Error", fmt, args);
	fprintf(stderr, ": %s", strerror(errno));
	fprintf(stderr, "\n");
	va_end(args);

	exit(1);
}

//
// Display a non-fatal warning message.
//
void warn(const char *fmt, ...) {
	va_list args;

	va_start(args, fmt);
	display_error("Warning", fmt, args);
	fprintf(stderr, "\n");
	va_end(args);
}

//
// Display help information.
//
void showHelp() {
	printf("Usage: eeprog <options>\n"
		"Options are:\n"
		"  -f <filename>     specify input filename\n"
		"  -p <port>         specify comm port\n"
		"  -o <filename>     specify output filename\n"
		"  -r <num bytes>    specify number of bytes to read\n"
		"  -N                enable write protection\n"
		"  -D                disable write protection\n"
		"  -v                verify data after writing\n"
		"  -h                print this help text\n"
		);
}

//
// Allocate memory buffer.
//
void *xmalloc(size_t n) {
	void *buf = malloc(n);
	if (!buf) { fatal("memory allocation failure"); }
	return buf;
}

//
// Duplicate a character string.
//
char *xstrdup(const char *s) {
	char *copy = strdup(s);
	if (!copy) { fatal("memory allocation failure"); }
	return copy;
}

//
// Open an IO channel: mode is a Unix file mode.
//
struct IO *io_open(const char *fileName, int mode, int attr) {
	struct IO *io = xmalloc(sizeof(struct IO));
	io->fd = open(fileName, mode, attr);
	if (io->fd < 0) { fatal("couldn't open '%s'", fileName); }
	io->fileName = fileName;
	switch (mode) {
	case O_RDONLY:
		io->fh = fdopen(io->fd, "r"); break;
	case O_WRONLY:
	case (O_WRONLY|O_CREAT):
		io->fh = fdopen(io->fd, "w"); break;
	case O_RDWR:
		io->fh = fdopen(io->fd, "w+"); break;
	default:
		illegal_state("unknown file mode %d", mode);
	}
	if (!io->fh) { fatal("fdopen failed"); }
	return io;
}

//
// Get the size of a file.
//
off_t io_getSize(struct IO *io) {
	struct stat st;
	if (fstat(io->fd, &st) < 0) { fatal("couldn't get size of file '%s'", io->fileName); }
	return st.st_size;
}

//
// Read data from a file or IO device: fatal error
// if an I/O error occurs or not enough data can be read.
//
void io_read(struct IO *io, uint8_t *buf, off_t size) {
	size_t rc = fread(buf, 1, size, io->fh);
	if (rc != size) { fatal("failed to read %ld bytes", (long)size); }
}

//
// Scan until the prompt "> " is seen.
//
void io_scanUntilPrompt(struct IO *io) {
	int last = -1;
	for (;;) {
		int c = fgetc(io->fh);
		if (c == EOF) { fatal("EOF before prompt was seen"); }
		if (c == ' ' && last == '>') {
			// Saw the prompt!
			return;
		}
		last = c;
	}
}

//
// Read a line of text from IO channel.
// Returns a malloc'ed buffer.
//
char *io_readLine(struct IO *io) {
	// The longest line would be the result of an R command
	// with a count of 255, which would be 512 bytes (255
	// data bytes at 2 hex digits per byte, and a \r\n
	// line terminator.)  We'll read up to 1000 bytes,
	// ignoring anything after 1000.
	char *buf = xmalloc(1024);
	size_t pos = 0;
	for (;;) {
		int c = fgetc(io->fh);
		if (c == EOF) {
			break;
		}
		if (pos < 1000) {
			buf[pos++] = (char) c;
		}
		if (c == '\n') {
			break;
		}
	}
	buf[pos] = '\0';
	if (pos >= 2 && buf[pos-2] == '\r' && buf[pos-1] == '\n') {
		buf[pos-2] = '\0';
	} else if (pos >= 1 && buf[pos-1] == '\n') {
		buf[pos-1] = '\0';
	}
	return buf;
}

//
// Expect the "OK" response indicating the successful execution
// of a command.
//
void io_expectOk(struct IO *io) {
	char *resp = io_readLine(io);
	if (strcmp(resp, "OK") != 0) { illegal_state("did not see OK response"); }
	free(resp);
}

//
// Write data to specified IO.
//
void io_write(struct IO *io, const void *buf, size_t n) {
	size_t rc = fwrite(buf, 1, n, io->fh);
	if (rc != n) { illegal_state("could not write %lu bytes", (unsigned long) n); }
	fflush(io->fh);
}

//
// Send a string to specified IO.
//
void io_send(struct IO *io, const char *s, ...) {
	va_list args;

	va_start(args, s);
	vfprintf(io->fh, s, args);
	va_end(args);

	fflush(io->fh);
}

//
// Parse id string received from firmware.
//
void parseId(char *id) {
	regex_t regex;
	int rc;

	if (regcomp(&regex, "^eeprog ([0-9]+)\\.([0-9]+)", REG_EXTENDED) != 0) {
		illegal_state("could not compile regex to parse id string");
	}

	regmatch_t capture[3];
	rc = regexec(&regex, id, 3, capture, 0);
	if (rc != 0) { illegal_state("id string has unexpected format"); }
	id[capture[1].rm_eo] = '\0';
	id[capture[2].rm_eo] = '\0';

	// If we wanted to do something with the firmware version information,
	// this is where we'd do it.

	printf("Detected firmware version %s.%s\n", &id[capture[1].rm_so], &id[capture[2].rm_so]);
}

//
// Initiate communication with programmer by:
// - waiting for prompt
// - issuing '?' command
// - parsing ID string (result of '?') command
// - receiving the "OK" response from the '?' command
// If this is successful then we should be ready to communicate
// with the programmer to do actual reading or writing of data.
//
void beginComm(struct IO *comm) {
	io_scanUntilPrompt(comm);
	io_send(comm, "?\r\n");
	char *id = io_readLine(comm);
	parseId(id);
	free(id);
	io_expectOk(comm);
}

//
// Write g_dataSize bytes of data in g_dataBuf to the EEPROM
// device, starting at address 0.
//
void writeFullData(struct IO *comm) {
	printf("Writing %d bytes", (int)g_dataSize);
	fflush(stdout);

	// Make sure the programmer is at address 0.
	io_scanUntilPrompt(comm);
	io_send(comm, "A0000\r\n");
	io_expectOk(comm);

	off_t remain = g_dataSize;

	int pos = 0;

	while (remain > 0) {
		// Progress indication every 1K.
		if (pos % 1024 == 0) {
			printf(".");
			fflush(stdout);
		}

		// Write one page of up to 64 bytes.
		// Since we're starting at address 0, and all writes
		// except the last will be exactly 64 bytes, we're
		// guaranteed to always write at a page-aligned address.
		int toWrite = (remain >= 64) ? 64 : (int)remain;
		io_scanUntilPrompt(comm);
		io_send(comm, "P%02x", toWrite);
		for (int i = 0; i < toWrite; i++) {
			io_send(comm, "%02x", g_dataBuf[pos++]);
		}
		io_send(comm, "\r\n");
		io_expectOk(comm);

		remain -= toWrite;
	}

	printf("done\n");
}

void readFullData(struct IO *comm) {
	printf("Reading %d bytes", (int)g_dataReadSize);
	fflush(stdout);

	// Make sure the programmer is at address 0.
	io_scanUntilPrompt(comm);
	io_send(comm, "A0000\r\n");
	io_expectOk(comm);

	off_t remain = g_dataReadSize;

	int pos = 0;

	while (remain > 0) {
		// Progress indication every 1K.
		if (pos % 1024 == 0) {
			printf(".");
			fflush(stdout);
		}

		// Read 128 bytes at a time
		int toRead = (remain >= 128) ? 128 : (int)remain;
		io_scanUntilPrompt(comm);
		//printf("R%02x\n", toRead);
		io_send(comm, "R%02x\r\n", toRead);

		// Read data
		char *data = io_readLine(comm);
		io_expectOk(comm);

		// Parse returned hex data and store it in g_dataReadBuf
		size_t dataLen = strlen(data);
		if (dataLen != (size_t)toRead * 2) {
			printf("Received data: %s\n", data);
			illegal_state("returned data is wrong size (expected %d, received %lu)",
				toRead * 2, (unsigned long) dataLen);
		}
		for (int i = 0; i < toRead; i++) {
			int val;
			if (sscanf(data + i*2, "%02x", &val) != 1) { illegal_state("invalid data returned"); }
			g_dataReadBuf[pos++] = (uint8_t) val;
		}
		free(data);

		remain -= toRead;
	}

	printf("done\n");
}

int verifyFullData() {
	for (int i = 0; i < g_dataSize; i++) {
		if (g_dataBuf[i] != g_dataReadBuf[i]) {
			printf("Verify: incorrect data byte at address %04x (wrote %02x, read %02x)\n",
				i, g_dataBuf[i], g_dataReadBuf[i]);
			return 0;
		}
	}
	printf("Successful verification!\n");
	return 1;
}

//
// Main function.
//
int main(int argc, char **argv) {
	printf("eeprog host program version %d.%d (https://github.com/daveho/eeprog)\n",
		VER_MAJOR, VER_MINOR);

	// Parse options
	int opt;
	while ((opt = getopt(argc, argv, "p:f:o:r:NDvh")) != -1) {
		switch (opt) {
		case 'p':
			g_port = xstrdup(optarg); break;
		case 'f':
			g_fileName = xstrdup(optarg); break;
		case 'o':
			g_outputFileName = xstrdup(optarg); break;
		case 'r':
			{
				int readSize;
				if (sscanf(optarg, "%d", &readSize) != 1) {
					illegal_state("invalid data size '%s'", optarg);
				}
				g_dataReadSize = readSize;
			}
			break;
		case 'N':
			g_writeProtectEnable = 1; break;
		case 'D':
			g_writeProtectDisable = 1; break;
		case 'v':
			g_verify = 1; break;
		case 'h':
		case '?':
			g_showHelp = opt; break;
		}
	}

	if (g_showHelp) {
		showHelp();
		exit(g_showHelp == '?' ? 1 : 0);
	}

	if (!g_port) {
		illegal_state("comm port must be specified");
	}

	if (!g_fileName && !g_outputFileName) {
		illegal_state("either -f or -o must be specified");
	}
	if (g_outputFileName && g_dataReadSize < 0) {
		illegal_state("-r must be specified to specify read size");
	}

	struct IO *comm = io_open(g_port, O_RDWR, 0);
	if (set_interface_attribs(comm->fd, B57600) != 0) {
		fatal("could not configure communication parameters for '%s'", g_port);
	}

	// Initiate communication with programmer
	beginComm(comm);

	struct IO *dataIn = NULL;

	if (g_fileName) {
		dataIn = io_open(g_fileName, O_RDONLY, 0);
		g_dataSize = io_getSize(dataIn);
		if (g_dataSize > 65536) { illegal_state("Size of file '%s' exceeds 64K", g_fileName); }
		io_read(dataIn, g_dataBuf, g_dataSize);
	}

	if (g_writeProtectDisable) {
		printf("Disabling write protection...\n");
		io_scanUntilPrompt(comm);
		io_send(comm, "D\r\n");
		io_expectOk(comm);
	}

	if (g_fileName) {
		writeFullData(comm);
	}

	if (g_writeProtectEnable) {
		printf("Enabling write protection...\n");
		io_scanUntilPrompt(comm);
		io_send(comm, "N\r\n");
		io_expectOk(comm);
	}

	if (g_verify || g_outputFileName) {
		if (g_verify) {
			// When verifying, the idea is to read back all of the
			// data that was written and confirm it's the same.
			g_dataReadSize = g_dataSize;
		}
		readFullData(comm);
	}

	if (g_verify) {
		if (!verifyFullData()) {
			printf("Verification failed!\n");
			exit(1);
		}
	}

	if (g_outputFileName) {
		printf("Writing read data to '%s'\n", g_outputFileName);
		struct IO *dataOut = io_open(g_outputFileName, O_WRONLY|O_CREAT, 0600);
		io_write(dataOut, g_dataReadBuf, g_dataReadSize);
	}

	printf("Done!\n");

	return 0;
}

// vim:ts=2:
