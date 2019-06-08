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
P 2200 2550
F 0 "TB1" H 2200 4117 50  0000 C CNN
F 1 "ARDUINO_NANO" H 2200 4026 50  0000 C CNN
F 2 "SHIELD_ARDUINO_NANO" H 2200 2550 50  0001 L BNN
F 3 "DFRobot" H 2200 2550 50  0001 L BNN
F 4 "Dev.kit: Arduino; UART; ICSP, USB B mini, pin strips" H 2200 2550 50  0001 L BNN "Field4"
F 5 "None" H 2200 2550 50  0001 L BNN "Field5"
F 6 "None" H 2200 2550 50  0001 L BNN "Field6"
F 7 "ARDUINO NANO" H 2200 2550 50  0001 L BNN "Field7"
F 8 "Unavailable" H 2200 2550 50  0001 L BNN "Field8"
	1    2200 2550
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5CF6793D
P 3100 1000
F 0 "#PWR?" H 3100 850 50  0001 C CNN
F 1 "VCC" H 3117 1173 50  0000 C CNN
F 2 "" H 3100 1000 50  0001 C CNN
F 3 "" H 3100 1000 50  0001 C CNN
	1    3100 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2900 1450 3100 1450
Wire Wire Line
	3100 1450 3100 1250
Wire Wire Line
	2900 1250 3100 1250
Connection ~ 3100 1250
Wire Wire Line
	3100 1250 3100 1000
$Comp
L 74xx:74HC595 U1
U 1 1 5CF6A10C
P 5000 1800
F 0 "U1" H 5000 2578 50  0000 C CNN
F 1 "74HC595" H 5000 2487 50  0000 C CNN
F 2 "" H 5000 1800 50  0001 C CNN
F 3 "" H 5000 1800 50  0001 C CNN
	1    5000 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	2900 3850 3100 3850
Wire Wire Line
	3100 3850 3100 4100
$Comp
L power:GND #PWR?
U 1 1 5CF6A4DB
P 3100 4100
F 0 "#PWR?" H 3100 3850 50  0001 C CNN
F 1 "GND" H 3105 3927 50  0000 C CNN
F 2 "" H 3100 4100 50  0001 C CNN
F 3 "" H 3100 4100 50  0001 C CNN
	1    3100 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 3050 1150 3050
Wire Wire Line
	1500 3150 1150 3150
Wire Wire Line
	1500 3350 1150 3350
Wire Wire Line
	1500 3250 1150 3250
Text Label 1200 3050 0    50   ~ 0
SD0
Text Label 1200 3150 0    50   ~ 0
SCLK0
Text Label 1200 3350 0    50   ~ 0
RCLK0
Text Label 1200 3250 0    50   ~ 0
SCLR0
Wire Wire Line
	4600 1400 4200 1400
Wire Wire Line
	4600 1600 4200 1600
Wire Wire Line
	4600 1700 4200 1700
Wire Wire Line
	4600 1900 4200 1900
Text Label 4250 1400 0    50   ~ 0
SD0
Text Label 4250 1600 0    50   ~ 0
SCLK0
Text Label 4250 1700 0    50   ~ 0
SCLR0
Text Label 4250 1900 0    50   ~ 0
RCLK0
Wire Wire Line
	4600 3650 4200 3650
Wire Wire Line
	4600 3850 4200 3850
Wire Wire Line
	4600 3950 4200 3950
Wire Wire Line
	4600 4150 4200 4150
Text Label 4250 3850 0    50   ~ 0
SCLK0
Text Label 4250 3950 0    50   ~ 0
SCLR0
Text Label 4250 4150 0    50   ~ 0
RCLK0
Wire Wire Line
	4600 6150 4200 6150
Wire Wire Line
	4600 6350 4200 6350
Wire Wire Line
	4600 6450 4200 6450
Wire Wire Line
	4600 6650 4200 6650
Text Label 4250 6150 0    50   ~ 0
SD2
Text Label 4250 6350 0    50   ~ 0
SCLK2
Text Label 4250 6450 0    50   ~ 0
SCLR2
Text Label 4250 6650 0    50   ~ 0
RCLK2
Wire Wire Line
	2900 2850 3250 2850
Wire Wire Line
	2900 2950 3250 2950
Wire Wire Line
	2900 3050 3250 3050
Text Label 2950 2850 0    50   ~ 0
SCLK2
Text Label 2950 2950 0    50   ~ 0
SCLR2
Text Label 2950 3050 0    50   ~ 0
RCLK2
Wire Wire Line
	1150 3450 1500 3450
Text Label 1200 3450 0    50   ~ 0
SD2
Wire Wire Line
	5000 1200 5300 1200
Wire Wire Line
	5300 1200 5300 1000
$Comp
L power:VCC #PWR?
U 1 1 5CF6CDFA
P 5300 1000
F 0 "#PWR?" H 5300 850 50  0001 C CNN
F 1 "VCC" H 5317 1173 50  0000 C CNN
F 2 "" H 5300 1000 50  0001 C CNN
F 3 "" H 5300 1000 50  0001 C CNN
	1    5300 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 2500 5000 2650
$Comp
L power:GND #PWR?
U 1 1 5CF6D519
P 5000 2650
F 0 "#PWR?" H 5000 2400 50  0001 C CNN
F 1 "GND" H 5005 2477 50  0000 C CNN
F 2 "" H 5000 2650 50  0001 C CNN
F 3 "" H 5000 2650 50  0001 C CNN
	1    5000 2650
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC595 U2
U 1 1 5CF6E302
P 5000 4050
F 0 "U2" H 5000 4828 50  0000 C CNN
F 1 "74HC595" H 5000 4737 50  0000 C CNN
F 2 "" H 5000 4050 50  0001 C CNN
F 3 "" H 5000 4050 50  0001 C CNN
	1    5000 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 3450 5300 3450
Wire Wire Line
	5300 3450 5300 3250
$Comp
L power:VCC #PWR?
U 1 1 5CF6E30A
P 5300 3250
F 0 "#PWR?" H 5300 3100 50  0001 C CNN
F 1 "VCC" H 5317 3423 50  0000 C CNN
F 2 "" H 5300 3250 50  0001 C CNN
F 3 "" H 5300 3250 50  0001 C CNN
	1    5300 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 4750 5000 4900
$Comp
L power:GND #PWR?
U 1 1 5CF6E311
P 5000 4900
F 0 "#PWR?" H 5000 4650 50  0001 C CNN
F 1 "GND" H 5005 4727 50  0000 C CNN
F 2 "" H 5000 4900 50  0001 C CNN
F 3 "" H 5000 4900 50  0001 C CNN
	1    5000 4900
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC595 U3
U 1 1 5CF6F087
P 5000 6550
F 0 "U3" H 5000 7328 50  0000 C CNN
F 1 "74HC595" H 5000 7237 50  0000 C CNN
F 2 "" H 5000 6550 50  0001 C CNN
F 3 "" H 5000 6550 50  0001 C CNN
	1    5000 6550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 5950 5300 5950
Wire Wire Line
	5300 5950 5300 5750
$Comp
L power:VCC #PWR?
U 1 1 5CF6F08F
P 5300 5750
F 0 "#PWR?" H 5300 5600 50  0001 C CNN
F 1 "VCC" H 5317 5923 50  0000 C CNN
F 2 "" H 5300 5750 50  0001 C CNN
F 3 "" H 5300 5750 50  0001 C CNN
	1    5300 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 7250 5000 7400
$Comp
L power:GND #PWR?
U 1 1 5CF6F096
P 5000 7400
F 0 "#PWR?" H 5000 7150 50  0001 C CNN
F 1 "GND" H 5005 7227 50  0000 C CNN
F 2 "" H 5000 7400 50  0001 C CNN
F 3 "" H 5000 7400 50  0001 C CNN
	1    5000 7400
	1    0    0    -1  
$EndComp
Wire Wire Line
	3250 3150 2900 3150
Wire Wire Line
	3250 3250 2900 3250
Text Label 2950 3150 0    50   ~ 0
ROM_CE
Text Label 2950 3250 0    50   ~ 0
ROM_WE
Wire Wire Line
	4600 2000 4200 2000
Wire Wire Line
	4600 6750 4200 6750
Text Label 4250 6750 0    50   ~ 0
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
	3250 3450 2900 3450
Text Label 2950 3450 0    50   ~ 0
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
F 1 "74HC165" H 8250 6087 50  0000 C CNN
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
	3250 3350 2900 3350
Text Label 2950 3350 0    50   ~ 0
DOE
Wire Wire Line
	1500 1950 1150 1950
Wire Wire Line
	1500 2050 1150 2050
Wire Wire Line
	1500 2150 1150 2150
Text Label 1200 1950 0    50   ~ 0
RDPL
Text Label 1200 2050 0    50   ~ 0
RDCP
Text Label 1200 2150 0    50   ~ 0
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
	5400 2300 5700 2300
Wire Wire Line
	5700 2300 5700 2950
Wire Wire Line
	5700 2950 4200 2950
Wire Wire Line
	4200 2950 4200 3650
Wire Wire Line
	5400 1400 5800 1400
Wire Wire Line
	5400 1500 5800 1500
Wire Wire Line
	5400 1600 5800 1600
Wire Wire Line
	5400 1700 5800 1700
Wire Wire Line
	5400 1800 5800 1800
Wire Wire Line
	5400 1900 5800 1900
Wire Wire Line
	5400 2000 5800 2000
Wire Wire Line
	5400 2100 5800 2100
Text Label 5600 1500 0    50   ~ 0
A14
Text Label 5600 1600 0    50   ~ 0
A13
Text Label 5600 1700 0    50   ~ 0
A12
Text Label 5600 1800 0    50   ~ 0
A11
Text Label 5600 1900 0    50   ~ 0
A10
Text Label 5600 2000 0    50   ~ 0
A9
Text Label 5600 2100 0    50   ~ 0
A8
Wire Wire Line
	5400 3650 5800 3650
Wire Wire Line
	5400 3750 5800 3750
Wire Wire Line
	5400 3850 5800 3850
Wire Wire Line
	5400 3950 5800 3950
Wire Wire Line
	5400 4050 5800 4050
Wire Wire Line
	5400 4150 5800 4150
Wire Wire Line
	5400 4250 5800 4250
Wire Wire Line
	5400 4350 5800 4350
Text Label 5600 3650 0    50   ~ 0
A7
Text Label 5600 3750 0    50   ~ 0
A6
Text Label 5600 3850 0    50   ~ 0
A5
Text Label 5600 3950 0    50   ~ 0
A4
Text Label 5600 4050 0    50   ~ 0
A3
Text Label 5600 4150 0    50   ~ 0
A2
Text Label 5600 4250 0    50   ~ 0
A1
Text Label 5600 4350 0    50   ~ 0
A0
NoConn ~ 5800 1400
Wire Wire Line
	5400 6150 5800 6150
Wire Wire Line
	5400 6250 5800 6250
Wire Wire Line
	5400 6350 5800 6350
Wire Wire Line
	5400 6450 5800 6450
Wire Wire Line
	5400 6550 5800 6550
Wire Wire Line
	5400 6650 5800 6650
Wire Wire Line
	5400 6750 5800 6750
Wire Wire Line
	5400 6850 5800 6850
Text Label 5600 6150 0    50   ~ 0
D7
Text Label 5600 6250 0    50   ~ 0
D6
Text Label 5600 6350 0    50   ~ 0
D5
Text Label 5600 6450 0    50   ~ 0
D4
Text Label 5600 6550 0    50   ~ 0
D3
Text Label 5600 6650 0    50   ~ 0
D2
Text Label 5600 6750 0    50   ~ 0
D1
Text Label 5600 6850 0    50   ~ 0
D0
Text Notes 4050 950  0    50   ~ 0
Serial to parallel shift\nregisters for address\ngeneration
Wire Notes Line
	4000 600  4000 5150
Wire Notes Line
	4000 5150 5900 5150
Wire Notes Line
	5900 5150 5900 600 
Wire Notes Line
	5900 600  4000 600 
Text Notes 4200 5800 0    50   ~ 0
Serial to parallel\nshift register for\nwriting data
Wire Notes Line
	4000 7700 5900 7700
Wire Notes Line
	5900 7700 5900 5400
Wire Notes Line
	5900 5400 4000 5400
Wire Notes Line
	4000 5400 4000 7700
Text Notes 7850 900  0    50   ~ 0
28C64 or 28C256 EEPROM
Wire Notes Line
	6850 750  6850 3250
Wire Notes Line
	6850 3250 9500 3250
Wire Notes Line
	9500 3250 9500 750 
Wire Notes Line
	9500 750  6850 750 
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
	4200 2000 4200 2250
$Comp
L power:GND #PWR?
U 1 1 5CF879D2
P 4200 2250
F 0 "#PWR?" H 4200 2000 50  0001 C CNN
F 1 "GND" H 4205 2077 50  0000 C CNN
F 2 "" H 4200 2250 50  0001 C CNN
F 3 "" H 4200 2250 50  0001 C CNN
	1    4200 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 4250 4200 4250
Wire Wire Line
	4200 4250 4200 4500
$Comp
L power:GND #PWR?
U 1 1 5CF87A58
P 4200 4500
F 0 "#PWR?" H 4200 4250 50  0001 C CNN
F 1 "GND" H 4205 4327 50  0000 C CNN
F 2 "" H 4200 4500 50  0001 C CNN
F 3 "" H 4200 4500 50  0001 C CNN
	1    4200 4500
	1    0    0    -1  
$EndComp
$Comp
L device:R_Network08 RN1
U 1 1 5CFC8FF9
P 2250 6050
F 0 "RN1" V 1633 6050 50  0000 C CNN
F 1 "10k" V 1724 6050 50  0000 C CNN
F 2 "Resistors_THT:R_Array_SIP9" V 2725 6050 50  0001 C CNN
F 3 "" H 2250 6050 50  0001 C CNN
	1    2250 6050
	0    1    1    0   
$EndComp
Wire Wire Line
	2450 5650 2650 5650
Wire Wire Line
	2650 5650 2650 5350
$Comp
L power:VCC #PWR?
U 1 1 5CFD929D
P 2650 5350
F 0 "#PWR?" H 2650 5200 50  0001 C CNN
F 1 "VCC" H 2667 5523 50  0000 C CNN
F 2 "" H 2650 5350 50  0001 C CNN
F 3 "" H 2650 5350 50  0001 C CNN
	1    2650 5350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2050 5650 1700 5650
Wire Wire Line
	2050 5750 1700 5750
Wire Wire Line
	2050 5850 1700 5850
Wire Wire Line
	2050 5950 1700 5950
Wire Wire Line
	2050 6050 1700 6050
Wire Wire Line
	2050 6150 1700 6150
Wire Wire Line
	2050 6250 1700 6250
Wire Wire Line
	2050 6350 1700 6350
Text Label 1800 5650 0    50   ~ 0
D0
Text Label 1800 5750 0    50   ~ 0
D1
Text Label 1800 5850 0    50   ~ 0
D2
Text Label 1800 5950 0    50   ~ 0
D3
Text Label 1800 6050 0    50   ~ 0
D4
Text Label 1800 6150 0    50   ~ 0
D5
Text Label 1800 6250 0    50   ~ 0
D6
Text Label 1800 6350 0    50   ~ 0
D7
Text Notes 1550 6900 0    50   ~ 0
Pull-up resistors for data lines.\nShown as a resistor network,\nbut it could also be 10 individual\n10k resistors.
$EndSCHEMATC
