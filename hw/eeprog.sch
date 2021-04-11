EESchema Schematic File Version 4
LIBS:eeprog-cache
EELAYER 26 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L ARDUINO_NANO:ARDUINO_NANO TB1
U 1 1 5CF67873
P 2700 2800
F 0 "TB1" H 2700 4367 50  0000 C CNN
F 1 "ARDUINO_NANO" H 2700 4276 50  0000 C CNN
F 2 "SHIELD_ARDUINO_NANO" H 2700 2800 50  0001 L BNN
F 3 "DFRobot" H 2700 2800 50  0001 L BNN
F 4 "Dev.kit: Arduino; UART; ICSP, USB B mini, pin strips" H 2700 2800 50  0001 L BNN "Field4"
F 5 "None" H 2700 2800 50  0001 L BNN "Field5"
F 6 "None" H 2700 2800 50  0001 L BNN "Field6"
F 7 "ARDUINO NANO" H 2700 2800 50  0001 L BNN "Field7"
F 8 "Unavailable" H 2700 2800 50  0001 L BNN "Field8"
	1    2700 2800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5CF6793D
P 3600 1250
F 0 "#PWR?" H 3600 1100 50  0001 C CNN
F 1 "VCC" H 3617 1423 50  0000 C CNN
F 2 "" H 3600 1250 50  0001 C CNN
F 3 "" H 3600 1250 50  0001 C CNN
	1    3600 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 1700 3600 1700
Wire Wire Line
	3600 1700 3600 1500
Wire Wire Line
	3400 1500 3600 1500
Connection ~ 3600 1500
Wire Wire Line
	3600 1500 3600 1250
$Comp
L 74xx:74HC595 U1
U 1 1 5CF6A10C
P 5200 1800
F 0 "U1" H 5200 2578 50  0000 C CNN
F 1 "74HC595" H 5200 2487 50  0000 C CNN
F 2 "" H 5200 1800 50  0001 C CNN
F 3 "" H 5200 1800 50  0001 C CNN
	1    5200 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 4100 3600 4100
Wire Wire Line
	3600 4100 3600 4350
$Comp
L power:GND #PWR?
U 1 1 5CF6A4DB
P 3600 4350
F 0 "#PWR?" H 3600 4100 50  0001 C CNN
F 1 "GND" H 3605 4177 50  0000 C CNN
F 2 "" H 3600 4350 50  0001 C CNN
F 3 "" H 3600 4350 50  0001 C CNN
	1    3600 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 3300 1650 3300
Wire Wire Line
	2000 3400 1650 3400
Wire Wire Line
	2000 3600 1650 3600
Wire Wire Line
	2000 3500 1650 3500
Text Label 1700 3300 0    50   ~ 0
SD0
Text Label 1700 3400 0    50   ~ 0
SCLK0
Text Label 1700 3600 0    50   ~ 0
RCLK0
Text Label 1700 3500 0    50   ~ 0
SCLR0
Wire Wire Line
	4800 1400 4400 1400
Wire Wire Line
	4800 1600 4400 1600
Wire Wire Line
	4800 1700 4400 1700
Wire Wire Line
	4800 1900 4400 1900
Text Label 4450 1400 0    50   ~ 0
SD0
Text Label 4450 1600 0    50   ~ 0
SCLK0
Text Label 4450 1700 0    50   ~ 0
SCLR0
Text Label 4450 1900 0    50   ~ 0
RCLK0
Wire Wire Line
	4800 3650 4400 3650
Wire Wire Line
	4800 3850 4400 3850
Wire Wire Line
	4800 3950 4400 3950
Wire Wire Line
	4800 4150 4400 4150
Text Label 4450 3850 0    50   ~ 0
SCLK0
Text Label 4450 3950 0    50   ~ 0
SCLR0
Text Label 4450 4150 0    50   ~ 0
RCLK0
Wire Wire Line
	4800 6150 4400 6150
Wire Wire Line
	4800 6350 4400 6350
Wire Wire Line
	4800 6450 4400 6450
Wire Wire Line
	4800 6650 4400 6650
Text Label 4450 6150 0    50   ~ 0
SD2
Text Label 4450 6350 0    50   ~ 0
SCLK2
Text Label 4450 6450 0    50   ~ 0
SCLR2
Text Label 4450 6650 0    50   ~ 0
RCLK2
Wire Wire Line
	3400 3100 3750 3100
Wire Wire Line
	3400 3200 3750 3200
Wire Wire Line
	3400 3300 3750 3300
Text Label 3450 3100 0    50   ~ 0
SCLK2
Text Label 3450 3200 0    50   ~ 0
SCLR2
Text Label 3450 3300 0    50   ~ 0
RCLK2
Wire Wire Line
	1650 3700 2000 3700
Text Label 1700 3700 0    50   ~ 0
SD2
Wire Wire Line
	5200 1200 5500 1200
Wire Wire Line
	5500 1200 5500 1000
$Comp
L power:VCC #PWR?
U 1 1 5CF6CDFA
P 5500 1000
F 0 "#PWR?" H 5500 850 50  0001 C CNN
F 1 "VCC" H 5517 1173 50  0000 C CNN
F 2 "" H 5500 1000 50  0001 C CNN
F 3 "" H 5500 1000 50  0001 C CNN
	1    5500 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 2500 5200 2650
$Comp
L power:GND #PWR?
U 1 1 5CF6D519
P 5200 2650
F 0 "#PWR?" H 5200 2400 50  0001 C CNN
F 1 "GND" H 5205 2477 50  0000 C CNN
F 2 "" H 5200 2650 50  0001 C CNN
F 3 "" H 5200 2650 50  0001 C CNN
	1    5200 2650
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC595 U2
U 1 1 5CF6E302
P 5200 4050
F 0 "U2" H 5200 4828 50  0000 C CNN
F 1 "74HC595" H 5200 4737 50  0000 C CNN
F 2 "" H 5200 4050 50  0001 C CNN
F 3 "" H 5200 4050 50  0001 C CNN
	1    5200 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 3450 5500 3450
Wire Wire Line
	5500 3450 5500 3250
$Comp
L power:VCC #PWR?
U 1 1 5CF6E30A
P 5500 3250
F 0 "#PWR?" H 5500 3100 50  0001 C CNN
F 1 "VCC" H 5517 3423 50  0000 C CNN
F 2 "" H 5500 3250 50  0001 C CNN
F 3 "" H 5500 3250 50  0001 C CNN
	1    5500 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 4750 5200 4900
$Comp
L power:GND #PWR?
U 1 1 5CF6E311
P 5200 4900
F 0 "#PWR?" H 5200 4650 50  0001 C CNN
F 1 "GND" H 5205 4727 50  0000 C CNN
F 2 "" H 5200 4900 50  0001 C CNN
F 3 "" H 5200 4900 50  0001 C CNN
	1    5200 4900
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC595 U3
U 1 1 5CF6F087
P 5200 6550
F 0 "U3" H 5200 7328 50  0000 C CNN
F 1 "74HC595" H 5200 7237 50  0000 C CNN
F 2 "" H 5200 6550 50  0001 C CNN
F 3 "" H 5200 6550 50  0001 C CNN
	1    5200 6550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 5950 5500 5950
Wire Wire Line
	5500 5950 5500 5750
$Comp
L power:VCC #PWR?
U 1 1 5CF6F08F
P 5500 5750
F 0 "#PWR?" H 5500 5600 50  0001 C CNN
F 1 "VCC" H 5517 5923 50  0000 C CNN
F 2 "" H 5500 5750 50  0001 C CNN
F 3 "" H 5500 5750 50  0001 C CNN
	1    5500 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 7250 5200 7400
$Comp
L power:GND #PWR?
U 1 1 5CF6F096
P 5200 7400
F 0 "#PWR?" H 5200 7150 50  0001 C CNN
F 1 "GND" H 5205 7227 50  0000 C CNN
F 2 "" H 5200 7400 50  0001 C CNN
F 3 "" H 5200 7400 50  0001 C CNN
	1    5200 7400
	1    0    0    -1  
$EndComp
Wire Wire Line
	3750 3400 3400 3400
Wire Wire Line
	3750 3500 3400 3500
Text Label 3450 3400 0    50   ~ 0
ROM_CE
Text Label 3450 3500 0    50   ~ 0
ROM_WE
Wire Wire Line
	4800 2000 4400 2000
Wire Wire Line
	4800 6750 4400 6750
Text Label 4450 6750 0    50   ~ 0
DOE
Text Notes 6450 6950 0    50   ~ 0
Programmer for 28C64/28C256 EEPROMs
$Comp
L memory:28C256 U4
U 1 1 5CF7FF77
P 8300 2200
F 0 "U4" H 8300 3378 50  0000 C CNN
F 1 "28C256" H 8300 3287 50  0000 C CNN
F 2 "" H 8300 2200 50  0001 C CNN
F 3 "" H 8300 2200 50  0001 C CNN
	1    8300 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 1300 7100 1300
Wire Wire Line
	7600 1400 7100 1400
Wire Wire Line
	7600 1500 7100 1500
Wire Wire Line
	7600 1600 7100 1600
Wire Wire Line
	7600 1700 7100 1700
Wire Wire Line
	7600 1800 7100 1800
Wire Wire Line
	7600 1900 7100 1900
Wire Wire Line
	7600 2000 7100 2000
Wire Wire Line
	7600 2100 7100 2100
Wire Wire Line
	7600 2200 7100 2200
Wire Wire Line
	7600 2300 7100 2300
Wire Wire Line
	7600 2400 7100 2400
Wire Wire Line
	7600 2500 7100 2500
Wire Wire Line
	7600 2600 7100 2600
Wire Wire Line
	7600 2700 7100 2700
Text Label 7150 1300 0    50   ~ 0
A0
Text Label 7150 1400 0    50   ~ 0
A1
Text Label 7150 1500 0    50   ~ 0
A2
Text Label 7150 1600 0    50   ~ 0
A3
Text Label 7150 1700 0    50   ~ 0
A4
Text Label 7150 1800 0    50   ~ 0
A5
Text Label 7150 1900 0    50   ~ 0
A6
Text Label 7150 2000 0    50   ~ 0
A7
Text Label 7150 2100 0    50   ~ 0
A8
Text Label 7150 2200 0    50   ~ 0
A9
Text Label 7150 2300 0    50   ~ 0
A10
Text Label 7150 2400 0    50   ~ 0
A11
Text Label 7150 2500 0    50   ~ 0
A12
Text Label 7150 2600 0    50   ~ 0
A13
Text Label 7150 2700 0    50   ~ 0
A14
Wire Wire Line
	7600 2900 7100 2900
Wire Wire Line
	7600 3000 7100 3000
Wire Wire Line
	7600 3100 7100 3100
Text Label 7150 2900 0    50   ~ 0
ROM_WE
Text Label 7150 3100 0    50   ~ 0
ROM_CE
Wire Wire Line
	3750 3700 3400 3700
Text Label 3450 3700 0    50   ~ 0
ROM_OE
Text Label 7150 3000 0    50   ~ 0
ROM_OE
Wire Wire Line
	9000 1300 9400 1300
Wire Wire Line
	9000 1400 9400 1400
Wire Wire Line
	9000 1500 9400 1500
Wire Wire Line
	9000 1600 9400 1600
Wire Wire Line
	9000 1700 9400 1700
Wire Wire Line
	9000 1800 9400 1800
Wire Wire Line
	9000 1900 9400 1900
Wire Wire Line
	9000 2000 9400 2000
Text Label 9200 1300 0    50   ~ 0
D0
Text Label 9200 1400 0    50   ~ 0
D1
Text Label 9200 1500 0    50   ~ 0
D2
Text Label 9200 1600 0    50   ~ 0
D3
Text Label 9200 1700 0    50   ~ 0
D4
Text Label 9200 1800 0    50   ~ 0
D5
Text Label 9200 1900 0    50   ~ 0
D6
Text Label 9200 2000 0    50   ~ 0
D7
$Comp
L 74xx:74LS165 U5
U 1 1 5CF987FE
P 8250 5100
F 0 "U5" H 8250 6178 50  0000 C CNN
F 1 "74HCT165" H 8250 6087 50  0000 C CNN
F 2 "" H 8250 5100 50  0001 C CNN
F 3 "" H 8250 5100 50  0001 C CNN
	1    8250 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7750 4600 7550 4600
Wire Wire Line
	7750 4700 7550 4700
Wire Wire Line
	7750 4800 7550 4800
Wire Wire Line
	7750 4900 7550 4900
Wire Wire Line
	7750 5000 7550 5000
Wire Wire Line
	7750 5100 7550 5100
Wire Wire Line
	7750 5200 7550 5200
Wire Wire Line
	7750 5300 7550 5300
Text Label 7600 4600 0    50   ~ 0
D0
Text Label 7600 4700 0    50   ~ 0
D1
Text Label 7600 4800 0    50   ~ 0
D2
Text Label 7600 4900 0    50   ~ 0
D3
Text Label 7600 5000 0    50   ~ 0
D4
Text Label 7600 5100 0    50   ~ 0
D5
Text Label 7600 5200 0    50   ~ 0
D6
Text Label 7600 5300 0    50   ~ 0
D7
Wire Wire Line
	7750 5800 7650 5800
Wire Wire Line
	7650 5800 7650 6200
$Comp
L power:GND #PWR?
U 1 1 5CFAEB9E
P 7650 6300
F 0 "#PWR?" H 7650 6050 50  0001 C CNN
F 1 "GND" H 7655 6127 50  0000 C CNN
F 2 "" H 7650 6300 50  0001 C CNN
F 3 "" H 7650 6300 50  0001 C CNN
	1    7650 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	7750 5500 7450 5500
Text Label 7500 5500 0    50   ~ 0
RDPL
Wire Wire Line
	7750 5700 7450 5700
Text Label 7500 5700 0    50   ~ 0
RDCP
Wire Wire Line
	8250 6100 8250 6200
Wire Wire Line
	8250 6200 7650 6200
Connection ~ 7650 6200
Wire Wire Line
	7650 6200 7650 6300
Wire Wire Line
	8750 4500 9100 4500
Text Label 8850 4500 0    50   ~ 0
RDIN
Wire Wire Line
	3750 3600 3400 3600
Text Label 3450 3600 0    50   ~ 0
DOE
Wire Wire Line
	2000 2200 1650 2200
Wire Wire Line
	2000 2300 1650 2300
Wire Wire Line
	2000 2400 1650 2400
Text Label 1700 2200 0    50   ~ 0
RDPL
Text Label 1700 2300 0    50   ~ 0
RDCP
Text Label 1700 2400 0    50   ~ 0
RDIN
Wire Wire Line
	8250 4200 8550 4200
Wire Wire Line
	8550 4200 8550 3900
$Comp
L power:VCC #PWR?
U 1 1 5CFD9C61
P 8550 3900
F 0 "#PWR?" H 8550 3750 50  0001 C CNN
F 1 "VCC" H 8567 4073 50  0000 C CNN
F 2 "" H 8550 3900 50  0001 C CNN
F 3 "" H 8550 3900 50  0001 C CNN
	1    8550 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 2300 5900 2300
Wire Wire Line
	5900 2300 5900 2950
Wire Wire Line
	5900 2950 4400 2950
Wire Wire Line
	4400 2950 4400 3650
Wire Wire Line
	5600 1400 6000 1400
Wire Wire Line
	5600 1500 6000 1500
Wire Wire Line
	5600 1600 6000 1600
Wire Wire Line
	5600 1700 6000 1700
Wire Wire Line
	5600 1800 6000 1800
Wire Wire Line
	5600 1900 6000 1900
Wire Wire Line
	5600 2000 6000 2000
Wire Wire Line
	5600 2100 6000 2100
Text Label 5800 1500 0    50   ~ 0
A14
Text Label 5800 1600 0    50   ~ 0
A13
Text Label 5800 1700 0    50   ~ 0
A12
Text Label 5800 1800 0    50   ~ 0
A11
Text Label 5800 1900 0    50   ~ 0
A10
Text Label 5800 2000 0    50   ~ 0
A9
Text Label 5800 2100 0    50   ~ 0
A8
Wire Wire Line
	5600 3650 6000 3650
Wire Wire Line
	5600 3750 6000 3750
Wire Wire Line
	5600 3850 6000 3850
Wire Wire Line
	5600 3950 6000 3950
Wire Wire Line
	5600 4050 6000 4050
Wire Wire Line
	5600 4150 6000 4150
Wire Wire Line
	5600 4250 6000 4250
Wire Wire Line
	5600 4350 6000 4350
Text Label 5800 3650 0    50   ~ 0
A7
Text Label 5800 3750 0    50   ~ 0
A6
Text Label 5800 3850 0    50   ~ 0
A5
Text Label 5800 3950 0    50   ~ 0
A4
Text Label 5800 4050 0    50   ~ 0
A3
Text Label 5800 4150 0    50   ~ 0
A2
Text Label 5800 4250 0    50   ~ 0
A1
Text Label 5800 4350 0    50   ~ 0
A0
NoConn ~ 6000 1400
Wire Wire Line
	5600 6150 6000 6150
Wire Wire Line
	5600 6250 6000 6250
Wire Wire Line
	5600 6350 6000 6350
Wire Wire Line
	5600 6450 6000 6450
Wire Wire Line
	5600 6550 6000 6550
Wire Wire Line
	5600 6650 6000 6650
Wire Wire Line
	5600 6750 6000 6750
Wire Wire Line
	5600 6850 6000 6850
Text Label 5800 6150 0    50   ~ 0
D7
Text Label 5800 6250 0    50   ~ 0
D6
Text Label 5800 6350 0    50   ~ 0
D5
Text Label 5800 6450 0    50   ~ 0
D4
Text Label 5800 6550 0    50   ~ 0
D3
Text Label 5800 6650 0    50   ~ 0
D2
Text Label 5800 6750 0    50   ~ 0
D1
Text Label 5800 6850 0    50   ~ 0
D0
Text Notes 4250 950  0    50   ~ 0
Serial to parallel shift\nregisters for address\ngeneration
Wire Notes Line
	4200 600  4200 5150
Wire Notes Line
	4200 5150 6100 5150
Wire Notes Line
	6100 5150 6100 600 
Wire Notes Line
	6100 600  4200 600 
Text Notes 4400 5800 0    50   ~ 0
Serial to parallel\nshift register for\nwriting data
Wire Notes Line
	4200 7700 6100 7700
Wire Notes Line
	6100 7700 6100 5400
Wire Notes Line
	6100 5400 4200 5400
Wire Notes Line
	4200 5400 4200 7700
Text Notes 7550 800  0    50   ~ 0
28C64 or 28C256 EEPROM
Text Notes 7450 3950 0    50   ~ 0
Parallel to serial\nshift register to read\nback data
Wire Notes Line
	7150 3600 7150 6550
Wire Notes Line
	7150 6550 9250 6550
Wire Notes Line
	9250 6550 9250 3600
Wire Notes Line
	9250 3600 7150 3600
Wire Wire Line
	7750 4500 7300 4500
Wire Wire Line
	7300 4500 7300 4650
$Comp
L power:GND #PWR?
U 1 1 5CFA4886
P 7300 4650
F 0 "#PWR?" H 7300 4400 50  0001 C CNN
F 1 "GND" H 7305 4477 50  0000 C CNN
F 2 "" H 7300 4650 50  0001 C CNN
F 3 "" H 7300 4650 50  0001 C CNN
	1    7300 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 2000 4400 2250
$Comp
L power:GND #PWR?
U 1 1 5CF879D2
P 4400 2250
F 0 "#PWR?" H 4400 2000 50  0001 C CNN
F 1 "GND" H 4405 2077 50  0000 C CNN
F 2 "" H 4400 2250 50  0001 C CNN
F 3 "" H 4400 2250 50  0001 C CNN
	1    4400 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 4250 4400 4250
Wire Wire Line
	4400 4250 4400 4500
$Comp
L power:GND #PWR?
U 1 1 5CF87A58
P 4400 4500
F 0 "#PWR?" H 4400 4250 50  0001 C CNN
F 1 "GND" H 4405 4327 50  0000 C CNN
F 2 "" H 4400 4500 50  0001 C CNN
F 3 "" H 4400 4500 50  0001 C CNN
	1    4400 4500
	1    0    0    -1  
$EndComp
$Comp
L device:R_Network08 RN1
U 1 1 5CFC8FF9
P 2100 5350
F 0 "RN1" V 1483 5350 50  0000 C CNN
F 1 "10k" V 1574 5350 50  0000 C CNN
F 2 "Resistors_THT:R_Array_SIP9" V 2575 5350 50  0001 C CNN
F 3 "" H 2100 5350 50  0001 C CNN
	1    2100 5350
	0    1    1    0   
$EndComp
Wire Wire Line
	2300 4950 2500 4950
Wire Wire Line
	2500 4950 2500 4650
$Comp
L power:VCC #PWR?
U 1 1 5CFD929D
P 2500 4650
F 0 "#PWR?" H 2500 4500 50  0001 C CNN
F 1 "VCC" H 2517 4823 50  0000 C CNN
F 2 "" H 2500 4650 50  0001 C CNN
F 3 "" H 2500 4650 50  0001 C CNN
	1    2500 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 4950 1550 4950
Wire Wire Line
	1900 5050 1550 5050
Wire Wire Line
	1900 5150 1550 5150
Wire Wire Line
	1900 5250 1550 5250
Wire Wire Line
	1900 5350 1550 5350
Wire Wire Line
	1900 5450 1550 5450
Wire Wire Line
	1900 5550 1550 5550
Wire Wire Line
	1900 5650 1550 5650
Text Label 1650 4950 0    50   ~ 0
D0
Text Label 1650 5050 0    50   ~ 0
D1
Text Label 1650 5150 0    50   ~ 0
D2
Text Label 1650 5250 0    50   ~ 0
D3
Text Label 1650 5350 0    50   ~ 0
D4
Text Label 1650 5450 0    50   ~ 0
D5
Text Label 1650 5550 0    50   ~ 0
D6
Text Label 1650 5650 0    50   ~ 0
D7
Text Notes 1400 6200 0    50   ~ 0
Pull-up resistors for data lines.\nShown as a resistor network,\nbut it could also be 10 individual\n10k resistors.
$Comp
L device:LED D1
U 1 1 5CFDDDF2
P 750 2850
F 0 "D1" V 788 2733 50  0000 R CNN
F 1 "LED" V 697 2733 50  0000 R CNN
F 2 "" H 750 2850 50  0001 C CNN
F 3 "" H 750 2850 50  0001 C CNN
	1    750  2850
	0    -1   -1   0   
$EndComp
$Comp
L device:LED D2
U 1 1 5CFDDE71
P 1150 2850
F 0 "D2" V 1188 2733 50  0000 R CNN
F 1 "LED" V 1097 2733 50  0000 R CNN
F 2 "" H 1150 2850 50  0001 C CNN
F 3 "" H 1150 2850 50  0001 C CNN
	1    1150 2850
	0    -1   -1   0   
$EndComp
$Comp
L device:R R1
U 1 1 5D02782E
P 750 3300
F 0 "R1" H 820 3346 50  0000 L CNN
F 1 "R" H 820 3255 50  0000 L CNN
F 2 "" V 680 3300 50  0001 C CNN
F 3 "" H 750 3300 50  0001 C CNN
	1    750  3300
	1    0    0    -1  
$EndComp
$Comp
L device:R R2
U 1 1 5D02788B
P 1150 3300
F 0 "R2" H 1220 3346 50  0000 L CNN
F 1 "R" H 1220 3255 50  0000 L CNN
F 2 "" V 1080 3300 50  0001 C CNN
F 3 "" H 1150 3300 50  0001 C CNN
	1    1150 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 2500 750  2500
Wire Wire Line
	750  2500 750  2700
Wire Wire Line
	2000 2600 1150 2600
Wire Wire Line
	1150 2600 1150 2700
Wire Wire Line
	750  3000 750  3150
Wire Wire Line
	1150 3000 1150 3150
Wire Wire Line
	750  3450 750  3550
$Comp
L power:GND #PWR?
U 1 1 5D04ADDB
P 750 3550
F 0 "#PWR?" H 750 3300 50  0001 C CNN
F 1 "GND" H 755 3377 50  0000 C CNN
F 2 "" H 750 3550 50  0001 C CNN
F 3 "" H 750 3550 50  0001 C CNN
	1    750  3550
	1    0    0    -1  
$EndComp
Wire Wire Line
	1150 3450 1150 3550
$Comp
L power:GND #PWR?
U 1 1 5D04AE04
P 1150 3550
F 0 "#PWR?" H 1150 3300 50  0001 C CNN
F 1 "GND" H 1155 3377 50  0000 C CNN
F 2 "" H 1150 3550 50  0001 C CNN
F 3 "" H 1150 3550 50  0001 C CNN
	1    1150 3550
	1    0    0    -1  
$EndComp
$Comp
L device:C C1
U 1 1 5D0596B2
P 1050 7000
F 0 "C1" H 1165 7046 50  0000 L CNN
F 1 "0.1uF" H 1165 6955 50  0000 L CNN
F 2 "" H 1088 6850 50  0001 C CNN
F 3 "" H 1050 7000 50  0001 C CNN
	1    1050 7000
	1    0    0    -1  
$EndComp
$Comp
L device:C C2
U 1 1 5D05977A
P 1500 7000
F 0 "C2" H 1615 7046 50  0000 L CNN
F 1 "0.1uF" H 1615 6955 50  0000 L CNN
F 2 "" H 1538 6850 50  0001 C CNN
F 3 "" H 1500 7000 50  0001 C CNN
	1    1500 7000
	1    0    0    -1  
$EndComp
$Comp
L device:C C3
U 1 1 5D060B77
P 1950 7000
F 0 "C3" H 2065 7046 50  0000 L CNN
F 1 "0.1uF" H 2065 6955 50  0000 L CNN
F 2 "" H 1988 6850 50  0001 C CNN
F 3 "" H 1950 7000 50  0001 C CNN
	1    1950 7000
	1    0    0    -1  
$EndComp
$Comp
L device:C C4
U 1 1 5D060B7D
P 2400 7000
F 0 "C4" H 2515 7046 50  0000 L CNN
F 1 "0.1uF" H 2515 6955 50  0000 L CNN
F 2 "" H 2438 6850 50  0001 C CNN
F 3 "" H 2400 7000 50  0001 C CNN
	1    2400 7000
	1    0    0    -1  
$EndComp
$Comp
L device:C C5
U 1 1 5D06F1C1
P 2850 7000
F 0 "C5" H 2965 7046 50  0000 L CNN
F 1 "0.1uF" H 2965 6955 50  0000 L CNN
F 2 "" H 2888 6850 50  0001 C CNN
F 3 "" H 2850 7000 50  0001 C CNN
	1    2850 7000
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5D084D59
P 1950 6650
F 0 "#PWR?" H 1950 6500 50  0001 C CNN
F 1 "VCC" H 1967 6823 50  0000 C CNN
F 2 "" H 1950 6650 50  0001 C CNN
F 3 "" H 1950 6650 50  0001 C CNN
	1    1950 6650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5D084DDA
P 1950 7350
F 0 "#PWR?" H 1950 7100 50  0001 C CNN
F 1 "GND" H 1955 7177 50  0000 C CNN
F 2 "" H 1950 7350 50  0001 C CNN
F 3 "" H 1950 7350 50  0001 C CNN
	1    1950 7350
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 6650 1950 6750
Wire Wire Line
	1950 7150 1950 7250
Wire Wire Line
	1050 6850 1050 6750
Wire Wire Line
	1050 6750 1500 6750
Connection ~ 1950 6750
Wire Wire Line
	1950 6750 1950 6850
Wire Wire Line
	1500 6850 1500 6750
Connection ~ 1500 6750
Wire Wire Line
	1500 6750 1950 6750
Wire Wire Line
	2850 6850 2850 6750
Wire Wire Line
	2850 6750 2400 6750
Wire Wire Line
	2400 6850 2400 6750
Connection ~ 2400 6750
Wire Wire Line
	2400 6750 1950 6750
Wire Wire Line
	1050 7150 1050 7250
Wire Wire Line
	1050 7250 1500 7250
Connection ~ 1950 7250
Wire Wire Line
	1950 7250 1950 7350
Wire Wire Line
	2850 7150 2850 7250
Wire Wire Line
	2850 7250 2400 7250
Wire Wire Line
	1500 7150 1500 7250
Connection ~ 1500 7250
Wire Wire Line
	1500 7250 1950 7250
Wire Wire Line
	2400 7150 2400 7250
Connection ~ 2400 7250
Wire Wire Line
	2400 7250 1950 7250
Text Notes 1350 7750 0    50   ~ 0
Decoupling caps: place near power\npins of U1-U5.
Text Notes 700  4000 0    50   ~ 0
Data direction\nindicators.
$Comp
L power:GND #PWR?
U 1 1 5D81E85C
P 8300 3150
F 0 "#PWR?" H 8300 2900 50  0001 C CNN
F 1 "GND" H 8305 2977 50  0000 C CNN
F 2 "" H 8300 3150 50  0001 C CNN
F 3 "" H 8300 3150 50  0001 C CNN
	1    8300 3150
	1    0    0    -1  
$EndComp
Wire Notes Line
	9650 600  9650 3400
Wire Notes Line
	6650 600  9650 600 
Wire Notes Line
	6650 3400 9650 3400
Wire Notes Line
	6650 600  6650 3400
Wire Wire Line
	8500 1250 8500 1100
Wire Wire Line
	8500 1100 8900 1100
Wire Wire Line
	8900 1100 8900 1000
$Comp
L power:VCC #PWR?
U 1 1 5D881F1E
P 8900 1000
F 0 "#PWR?" H 8900 850 50  0001 C CNN
F 1 "VCC" H 8917 1173 50  0000 C CNN
F 2 "" H 8900 1000 50  0001 C CNN
F 3 "" H 8900 1000 50  0001 C CNN
	1    8900 1000
	1    0    0    -1  
$EndComp
$EndSCHEMATC
