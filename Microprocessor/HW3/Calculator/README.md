# Calculator [![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/MaryamSaeedmehr/Calculator)

A simple calculator which can perform Signed operations on 64bits numbers with max of two different math symbols or any number of operands but with the same math symbol.

Author : Maryam Saeedmehr

Language : C

## **Functionalities**
- Can perform (+,-,/,*) operations whether signed or unsigned.
- Generic number of operands with only one math operation like (2*2*2*5*..) : the number of operands can be set before compilation in calculator_blocks.h in (MaxNumberOfOperands) macro
- Only can handle two different math operations like 2*3+10 with priority.
- Almost detecting the user mistyping and throw exception .

## **Requirement**

For implementing this code yourself, You Need to install below applications :

- <a href="https://www.microchip.com/mplab/avr-support/atmel-studio-7">`Atmel Studio`</a> 
- <a href="https://www.labcenter.com/downloads/">`Proteus`</a> 
- <a href="https://www.amazon.com/Refaxi-Matrix-Membrane-Keyboard-Arduino/dp/B07NSHHFZ5/ref=sr_1_fkmr0_1?keywords=calculator+keypad+avr&qid=1577036639&sr=8-1-fkmr0">`4 * 4 keypad interface`</a>
- <a href="https://www.amazon.com/Basic-16x2-Character-LCD-White/dp/B07RDLWH7Q/ref=sr_1_5?keywords=16*2+LCD&qid=1577036480&sr=8-5">`16*2 LM016L LCD interface`</a>
- <a href="https://www.amazon.com/ATMEGA32-16PU-Microcontroller-System-Programmable-ATMEGA/dp/B071VYGJB9">`Avr Atmega32`</a>
	
## **The main Workflow of the program**
This is just a general explaintion of what you will see in the code but the code is already commented when needed to be able to trace it

- `calculator.c` contains globel flag which can contain state of the program flow inside the code 
  in enum var as defined in calculator_blocks.h: 
	`enum StageFlag{Reset,StartPoint,AnalyzePoint,CalculatePoint,DisplayPoint,ErrorPoint};`
  and by that i cannot move to the next stage until i complete the previous stage correctly with a flag is set to the next value when sucess. 
  
- the next idea is that my ` uint8 KeyPad_getPressedKey(); ` returns one byte of data[0..9] 
		but if the user enters 54578,how i convert it to valuable data to make operations on it? 
		this is done using a simple math trick:
    		* storing the keypad inputs in `MyArr` for instance
    		* then taking the last element `MYArr[len-1] + MyArr[len-2]*10 +..+MyArr[len-i]*PowerOf(10,i)= Valuable Number` to use( it's deciaml number of base 10 :) )
    
- When the application starts, i stored all the inputs coming from the user inside an array using `GetData();` then i analyze it using `Analyze()` and seperate the operands in another array and the operations as well.

- then i do the required operation in `calculate();` then display if the input is valid.

- Higher range number(greater than signed 32bits) weather inputs or a result won't display on the LCD correctly due to the limiation in `itoa.c` standard function, so i modifiy it to `LCD_Signed_Int64_ToString` function :) .

## Step1 : Create the C code in Atmel Studio

Create a new project in the atmel studio and copy all files in the <a href="https://github.com/MaryamSaeedmehr/Calculator/blob/master/Codes/">`/Codes`</a> folder into your new project folder .


## Step2 : Build your project

After you have built it , a <a href="https://github.com/MaryamSaeedmehr/Calculator/blob/master/Codes/Debug/Calculator.hex">`Calculator.hex`</a> file will be created in your project's folder. This is the only thing you need to program your avr in the proteus.


## Step3 : Create your circuit

Use proteus to emulate your circuit. Try to make it as I have done....

![calculator_proteus](https://user-images.githubusercontent.com/49061503/71325450-54bc2480-2502-11ea-850a-7d0bc72238c8.png)


## Step4 : Program Atmega32

To ptogram your microcontroler in the proteus , just double click on it and choose the .hex file and press OK !


## Step5 : Enjoy It

![EXC3_Q1](https://user-images.githubusercontent.com/49061503/71325448-466e0880-2502-11ea-964d-78017eab339a.gif)



## **Files**
- <a href="https://github.com/MaryamSaeedmehr/Calculator/blob/master/Codes/">`/Codes`</a> : This is the main folder consists of :
    * <a href="https://github.com/MaryamSaeedmehr/Calculator/blob/master/Codes/SourceCodes/std_types.h">`/Codes/SourceCodes/std_types.h`</a> : Contains new types of standards data types
    * <a href="https://github.com/MaryamSaeedmehr/Calculator/blob/master/Codes/calculator_blocks.h">`/Codes/calculator_blocks.h`</a> : Contains the configuarion you set to how much the calculator can handle number of operands,operation
    * <a href="https://github.com/MaryamSaeedmehr/Calculator/blob/master/Codes/calculator_blocks.c">`/Codes/calculator_blocks.c`</a> : Contains the main work of the calculator as will be explain later
    * <a href="https://github.com/MaryamSaeedmehr/Calculator/blob/master/Codes/Calculator.c">`/Codes/Calculator.c`</a> : the main of the application
    * <a href="https://github.com/MaryamSaeedmehr/Calculator/blob/master/Codes/SourceCodes/lcd.c">`/Codes/SourceCodes/lcd.c`</a> : normal c driver
    * <a href="https://github.com/MaryamSaeedmehr/Calculator/blob/master/Codes/SourceCodes/keypad.c">`/Codes/SourceCodes/keypad.c`</a> : normal c driver
- <a href="https://github.com/MaryamSaeedmehr/Calculator/blob/master/Calculator.pdsprj">`/Calculator.pdsprj`</a> : Simulation file using proteus
- <a href="https://github.com/MaryamSaeedmehr/Calculator/blob/master/LICENSE">`/LICENSE`</a> : The license of this project



## **Support**

Reach out to me at one of the following places!

- Telegram at <a href="https://t.me/BitterOcean" target="_blank">@BitterOcean</a>
- Gmail at <a href="mailto:maryamsaeedmehr@gmail.com" target="_blank">maryamsaeedmehr@gmail.com</a>

## **License**

[![License](https://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

    
    
    
    
    
