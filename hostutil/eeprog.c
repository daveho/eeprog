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

// The serial communication code was shamelessly stolen from the following
// StackOverflow page:
//   https://stackoverflow.com/questions/6947413/how-to-open-read-and-write-from-serial-port-in-c

#include <errno.h>
#include <fcntl.h> 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <termios.h>
#include <unistd.h>

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

const char *g_port;
const char *g_dataFile;
int g_disableWriteProtect;
int g_enableWriteProtect;

int main(int argc, char **argv) {
	// TODO
}

// vim:ts=2:
