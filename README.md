# 28C64/28C256 EEPROM programmer

This is an attempt to make a programmer for 28C64 and 28C256 EEPROMs using an Arduino Nano and 74HC595/74HC165 shift registers.

The hardware seems to work.

So far, the firmware can successfully:

* read data from the EEPROM
* write single bytes to the EEPROM
* disable write protection

Page mode still needs to be implemented, but the timing requirements are similar to disabling write protection, so hopefully it won't be too difficult to implement.

There is no host software yet.
