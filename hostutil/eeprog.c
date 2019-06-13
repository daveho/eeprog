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

// The serial communication setup code was shamelessly stolen from the following
// StackOverflow page:
//   https://stackoverflow.com/questions/6947413/how-to-open-read-and-write-from-serial-port-in-c

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

struct IO {
	const char *fileName;
	int fd;
};

const char *g_port, *g_fileName, *g_outputFileName;
int g_writeProtectEnable, g_writeProtectDisable;
int g_verify;
off_t g_dataReadSize = -1;
int g_showHelp;

off_t g_dataSize;
uint8_t g_dataBuf[65536];

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

void display_error(const char *tag, const char *fmt, va_list args) {
	fprintf(stderr, "%s: ", tag);
	vfprintf(stderr, fmt, args);
}

// Function for a fatal usage error.
void usage_error(const char *fmt, ...) {
	va_list args;

	va_start(args, fmt);
	display_error("Error", fmt, args);
	fprintf(stderr, "\n");
	va_end(args);

	exit(1);
}

// Function for a fatal runtime error, in which errno is set
// and we can print a meaningful diagnostic.
void fatal(const char *fmt, ...) {
	va_list args;

	va_start(args, fmt);
	display_error("Error", fmt, args);
	fprintf(stderr, "\n");
	va_end(args);

	exit(1);
}

void warn(const char *fmt, ...) {
	va_list args;

	va_start(args, fmt);
	display_error("Warning", fmt, args);
	fprintf(stderr, ": %s", strerror(errno));
	fprintf(stderr, "\n");
	va_end(args);
}

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

void *xmalloc(size_t n) {
	void *buf = malloc(n);
	if (!buf) { fatal("memory allocation failure"); }
	return buf;
}

char *xstrdup(const char *s) {
	char *copy = strdup(s);
	if (!copy) { fatal("memory allocation failure"); }
	return copy;
}

struct IO *io_open(const char *fileName, int mode) {
	struct IO *io = xmalloc(sizeof(struct IO));
	io->fd = open(fileName, mode);
	if (io->fd < 0) { fatal("couldn't open '%s'", fileName); }
	io->fileName = fileName;
	return io;
}

off_t io_getSize(struct IO *io) {
	struct stat st;
	if (fstat(io->fd, &st) < 0) { fatal("couldn't get size of file '%s'", io->fileName); }
	return st.st_size;
}

void io_read(struct IO *io, uint8_t *buf, off_t size) {
	ssize_t nread = 0;
	while (nread < size) {
		ssize_t rc = read(io->fd, buf + nread, size);
		if (rc < 0) { fatal("error reading data from '%s'", io->fileName); }
		nread += rc;
	}
}

int main(int argc, char **argv) {
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
					usage_error("invalid data size '%s'", optarg);
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
		usage_error("comm port must be specified");
	}

	if (!g_fileName && !g_outputFileName) {
		usage_error("either -f or -o must be specified");
	}
	if (g_outputFileName && g_dataReadSize < 0) {
		usage_error("-r must be specified to specify read size");
	}

	struct IO *comm = io_open(g_port, O_RDWR);
	if (set_interface_attribs(comm->fd, B57600) != 0) {
		fatal("could not configure communication parameters for '%s'", g_port);
	}

	struct IO *dataIn = NULL;

	if (g_fileName) {
		dataIn = io_open(g_fileName, O_RDONLY);
		g_dataSize = io_getSize(dataIn);
		if (g_dataSize > 65536) { usage_error("Size of file '%s' exceeds 64K", g_fileName); }
		io_read(dataIn, g_dataBuf, g_dataSize);
	}

	if (g_writeProtectDisable) {
		// TODO: disable write protection
	}

	if (g_fileName) {
		// TODO: write data to EEPROM
	}

	if (g_writeProtectEnable) {
		// TODO: enable write protection
	}

	if (g_verify || g_outputFileName) {
		// TODO: read data
	}
}

// vim:ts=2:
