// eeprog - 28C64/28C256 EEPROM programmer firmware (for Arduino Nano)
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

////////////////////////////////////////////////////////////////////////
// Constants
////////////////////////////////////////////////////////////////////////

#define VERSION_MAJOR 0
#define VERSION_MINOR 1

// Note: constants for I/O pins match the net names used in the
// schematic.  Also: there are some hard-coded references to
// AVR ports and pin numbers because digitalWrite is too slow
// to meet timing requirements for page write mode and software
// write protection disable, and direct bit-banging allows
// sufficiently fast output of addresses and data bytes via the
// 74HC595 shift registers.

// Control pins for the 2 74HC595 shift registers used to
// generate addresses
#define SD0        2    // serial data input
#define SCLK0      3    // shift register clock
#define SCLR0      4    // clear shift register contents
#define RCLK0      5    // output register clock

// Control pins for the 74HC595 shift register used to
// send data to the data bus
#define SD2        6    // serial data input
#define SCLK2      7    // shift register clock
#define SCLR2      8    // clear shift register contents
#define RCLK2      9    // output register clock
#define DOE        12   // output enable

// EEPROM control pins
#define ROM_CE     10   // EEPROM chip enable
#define ROM_WE     11   // EEPROM write enable
#define ROM_OE     13   // EEPROM output enable

// I/O pins for 74HC165 shift register used to read data
// from the EEPROM
#define RDPL       A0   // parallel load
#define RDCP       A1   // shift register clock
#define RDIN       A2   // input from shift register

// I/O pins for data direction indicator LEDs
#define READ_LED   A3
#define WRITE_LED  A4

// Data direction modes
#define MODE_READ  0    // read data from EEPROM
#define MODE_WRITE 1    // write data to EEPROM

////////////////////////////////////////////////////////////////////////
// Data
////////////////////////////////////////////////////////////////////////

const char HEX_DIGITS[] = "0123456789ABCDEF";

// Current address used for read or write operations.
// Autoincremented to reflect number of bytes read or written.
uint16_t g_addr;

// Set to 1 if an error occurs (for example, in parsing serial input)
uint8_t g_err;

// Buffer for page write
uint8_t g_pageBuf[64];

////////////////////////////////////////////////////////////////////////
// Code
////////////////////////////////////////////////////////////////////////

// Set data direction.
void setDataDir(uint8_t mode) {
  if (mode == MODE_WRITE) {
    digitalWrite(ROM_OE, HIGH); // de-assert EEPROM output enable
    digitalWrite(DOE, LOW);     // assert 74HC595 data output enable
    digitalWrite(READ_LED, LOW);
    digitalWrite(WRITE_LED, HIGH);
  } else {
    digitalWrite(DOE, HIGH);    // de-assert 74HC595 data output enable
    digitalWrite(ROM_OE, LOW);  // assert EEPROM output enable
    digitalWrite(READ_LED, HIGH);
    digitalWrite(WRITE_LED, LOW);
  }
}

// Send a high pulse on given output pin.
void pulse(uint8_t pin) {
  digitalWrite(pin, HIGH);
  digitalWrite(pin, LOW);
}

// Send a low pulse on given output pin.
void pulseLow(uint8_t pin) {
  digitalWrite(pin, LOW);
  digitalWrite(pin, HIGH);
}

// Drive specified address to the EEPROM's address inputs.
void setAddr(uint16_t addr) {
  // digitalWrite is too slow to meet tBLC (byte load cycle time),
  // so we directly twiddle bits in PORTD:
  //   SD0 is PD2
  //   SCLK0 is PD3
  //   RCLK0 is PD5
  for (uint8_t i = 0; i < 16; i++) {
    // Set data output (SD0)
    if (addr & 0x1) {
      PORTD |= (1 << 2);
    } else {
      PORTD &= ~(1 << 2);
    }
    // Pulse SCLKC0
    PORTD |= (1 << 3);
    PORTD &= ~(1 << 3);
    // Shift next address bit into place
    addr >>= 1;
  }
  // Pulse RCLK0
  PORTD |= (1 << 5);
  PORTD &= ~(1 << 5);
}

// Drive specified data byte value on the EEPROM's data lines.
void setData(uint8_t data) {
  // digitalWrite is too slow, twiddle bits in PORTD and PORTB:
  //   SD2 is PD6
  //   SCLK2 is PD6
  //   RCLK2 is PB1
  for (uint8_t i = 0; i < 8; i++) {
    // Set data output (SD2)
    if (data & 0x1) {
      PORTD |= (1 << 6);
    } else {
      PORTD &= ~(1 << 6);
    }
    // Pulse SCLK2
    PORTD |= (1 << 7);
    PORTD &= ~(1 << 7);
    // Shift next data bit into place
    data >>= 1;
  }
  // Pulse RCLK2
  PORTB |= (1 << 1);
  PORTB &= ~(1 << 1);
}

// Read data byte from the EEPROM's data lines.
uint8_t readDataByte() {
  // parallel load data
  pulseLow(RDPL);

  // read serial data from shift register
  uint8_t data = 0;
  for (uint8_t i = 0; i < 8; i++) {
    data <<= 1;
    uint8_t val = digitalRead(RDIN);
    if (val) { data |= 0x1; }
    pulse(RDCP);
  }

  return data;
}

void eepromWriteByte(uint16_t addr, uint8_t data) {
  // Assert address
  setAddr(addr);

  // Assert data
  setData(data);

  // Pulse CE and WE low for tWP, which according to both the
  // CAT28C256 and AT28C256 datasheets must be at least 100 ns.
  // One microsecond should work fine.
  digitalWrite(ROM_CE, LOW);
  digitalWrite(ROM_WE, LOW);
  delayMicroseconds(1);
  digitalWrite(ROM_WE, HIGH);
  digitalWrite(ROM_CE, HIGH);
}

// Read a byte from the serial port (i.e., from the user or
// host program.)
uint8_t readSer() {
  while (!Serial.available()) {
    // do nothing
  }
  return (uint8_t) Serial.read();
}

// Read and discard serial input until a newline character is seen.
void scanToEol() {
  uint8_t c;
  do {
    c = readSer();
  } while (c != '\n');
}

// Decode one hex digit, returning its numeric value.
// Sets g_err if the specified character is not a hex digit.
uint8_t decodeHex(uint8_t c) {
  g_err = 0;
  if (c >= '0' && c <= '9') {
    return c - '0';
  } else if (c >= 'A' && c <= 'F') {
    return 10 + (c - 'A');
  } else if (c >= 'a' && c <= 'f') {
    return 10 + (c - 'a');
  } else {
    g_err = 1;
    return 0;
  }
}

// Read one byte of hex data from the serial port.
// Sets g_err if the input is not valid.
uint8_t readHex() {
  uint8_t c, val = 0;
  c = readSer();
  val = decodeHex(c);
  if (g_err) return 0;
  val <<= 4;
  c = readSer();
  val |= decodeHex(c);
  return val;
}

// Print a byte as two hex digits.
void printHex(uint8_t val) {
  Serial.print(HEX_DIGITS[val >> 4]);
  Serial.print(HEX_DIGITS[val & 0xF]);
}

// Print an error message.
void printErrMsg(const char *msg) {
  Serial.print("Error: ");
  Serial.println(msg);
}

// Print the OK message which indicates a successfully executed command.
void printOkMsg() {
  Serial.println("OK");
}

// Handle the '?' command by printing version number and current address.
void handleQuesCmd() {
  Serial.print("eeprog ");
  Serial.print(VERSION_MAJOR);
  Serial.print(".");
  Serial.print(VERSION_MINOR);
  Serial.print(" addr=");
  printHex(g_addr >> 8);
  printHex(g_addr & 0xFF);
  Serial.println();
  printOkMsg();
  scanToEol();
}

// Handle 'A' command to set current address.
void handleACmd() {
  uint16_t addr;
  addr = readHex();
  if (g_err) goto err;
  addr <<= 8;
  addr |= readHex();
  if (g_err) goto err;
  g_addr = addr;
  scanToEol();
  printOkMsg();
  return;

err:
  printErrMsg("Invalid address");
}

// Handle 'R' command to read up to 255 bytes of data from current address.
void handleRCmd() {
  uint8_t count = readHex();
  scanToEol();
  if (g_err) goto err;

  setDataDir(MODE_READ);

  for (uint8_t i = 0; i < count; i++) {
    setAddr(g_addr);
    delayMicroseconds(1);

    // assert chip enable
    digitalWrite(ROM_CE, LOW);
    delayMicroseconds(1);

    uint8_t data = readDataByte();

    // de-assert chip enable
    digitalWrite(ROM_CE, HIGH);

    printHex(data);
    g_addr++;
  }

  Serial.println();
  printOkMsg();
  return;

err:
  printErrMsg("Invalid read command");
}

// Handle 'W' command to write one byte at current address.
void handleWCmd() {
  uint8_t data = readHex();
  scanToEol();
  if (g_err) goto err;

  setDataDir(MODE_WRITE);

  eepromWriteByte(g_addr, data);
  g_addr++;

  // Wait for write cycle to complete.
  delay(5);

  printOkMsg();
  return;

err:
  printErrMsg("Invalid data");
}

// Handle 'D' command to disable software write protection.
void handleDCmd() {
  scanToEol();

  setDataDir(MODE_WRITE);

  // See "Software Data Protection Disable Algorithm" section
  // of AT28C256 datasheet.
  eepromWriteByte(0x5555, 0xAA);
  eepromWriteByte(0x2AAA, 0x55);
  eepromWriteByte(0x5555, 0x80);
  eepromWriteByte(0x5555, 0xAA);
  eepromWriteByte(0x2AAA, 0x55);
  eepromWriteByte(0x5555, 0x20);

  // Wait for write cycle to complete.
  delay(5);

  printOkMsg();
}

// Handle 'N' command to enable software write protection.
void handleNCmd() {
  scanToEol();

  setDataDir(MODE_WRITE);

  // See Figure 10 ("Write Sequence for Activating Software
  // Data Protection") in the CAT28C256 datasheet.
  eepromWriteByte(0x5555, 0xAA);
  eepromWriteByte(0x2AAA, 0x55);
  eepromWriteByte(0x5555, 0xA0);

  // Wait for write cycle to complete.
  delay(5);

  printOkMsg();
}

// Handle 'E' command to perform a software erase.
// It's possible that only Atmel chips support this:
// the CAT28C256 datasheet doesn't mention software erase.
void handleECmd() {
  scanToEol();

  setDataDir(MODE_WRITE);

  // See Atmel "Software Chip Erase" application note
  // (http://db.zmitac.aei.polsl.pl/Electronics_Firm_Docs/ATMEL/Atmel/acrobat/doc0544.pdf).
  eepromWriteByte(0x5555, 0xAA);
  eepromWriteByte(0x2AAA, 0x55);
  eepromWriteByte(0x5555, 0x80);
  eepromWriteByte(0x5555, 0xAA);
  eepromWriteByte(0x2AAA, 0x55);
  eepromWriteByte(0x5555, 0x10);

  // Wait for erase cycle to complete
  delay(20);

  printOkMsg();
}

// Handle 'P' command to write a page (up to 64 bytes).
// Note that there is no check to make sure that the
// write does not cross a page boundary.
void handlePCmd() {
  uint8_t nbytes = readHex();
  if (g_err || nbytes > 64) goto err_nbytes;

  // Read the data
  for (uint8_t i = 0; i < nbytes; i++) {
    g_pageBuf[i] = readHex();
    if (g_err) goto err_data;
  }

  scanToEol();

  setDataDir(MODE_WRITE);

  // Send bytes to the EEPROM
  for (uint8_t i = 0; i < nbytes; i++) {
    eepromWriteByte(g_addr, g_pageBuf[i]);
    g_addr++;
  }

  // Wait for write cycle to complete.
  delay(5);

  printOkMsg();
  return;

err_nbytes:
  scanToEol();
  printErrMsg("Bad nbytes");
  return;

err_data:
  scanToEol();
  printErrMsg("Bad data");
}

// Handle unknown command.
void handleUnknownCmd() {
  scanToEol();
  printErrMsg("Unknown command");
}

void setup() {
  // Configure pin modes
  pinMode(SD0, OUTPUT);
  pinMode(SCLK0, OUTPUT);
  pinMode(SCLR0, OUTPUT);
  pinMode(RCLK0, OUTPUT);
  pinMode(SD2, OUTPUT);
  pinMode(SCLK2, OUTPUT);
  pinMode(SCLR2, OUTPUT);
  pinMode(RCLK2, OUTPUT);
  pinMode(DOE, OUTPUT);
  pinMode(ROM_CE, OUTPUT);
  pinMode(ROM_WE, OUTPUT);
  pinMode(ROM_OE, OUTPUT);
  pinMode(RDPL, OUTPUT);
  pinMode(RDCP, OUTPUT);
  pinMode(RDIN, INPUT);
  pinMode(READ_LED, OUTPUT);
  pinMode(WRITE_LED, OUTPUT);

  // De-assert EEPROM chip enable and write enable
  digitalWrite(ROM_CE, HIGH);
  digitalWrite(ROM_WE, HIGH);

  // Set initial data direction
  setDataDir(MODE_WRITE);
  
  Serial.begin(57600);

  // clear shift register contents
  pulseLow(SCLR0);
  pulseLow(SCLR2);

  // set clock signals low initially
  digitalWrite(SCLK0, LOW);
  digitalWrite(RCLK0, LOW);
  digitalWrite(SCLK2, LOW);
  digitalWrite(RCLK2, LOW);
  digitalWrite(RDCP, LOW);

  // set 74HC165 parallel load high (not asserted) initially
  digitalWrite(RDPL, HIGH);
}

void loop() {
  Serial.print("> ");
  uint8_t cmd = readSer();
  switch(cmd) {
    case '?':
      handleQuesCmd();
      break;
    case 'A':
      handleACmd();
      break;
    case 'R':
      handleRCmd();
      break;
    case 'W':
      handleWCmd();
      break;
    case 'D':
      handleDCmd();
      break;
    case 'N':
      handleNCmd();
      break;
    case 'E':
      handleECmd();
      break;
    case 'P':
      handlePCmd();
      break;
    default:
      handleUnknownCmd();
      break;
  }
}
