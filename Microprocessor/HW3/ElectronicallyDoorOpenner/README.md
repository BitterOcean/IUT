# ElectronicallyDoorOpenner[![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/MaryamSaeedmehr/ElectronicallyDoorOpenner)

A simple Electronically Door Opener

Author : Maryam Saeedmehr

Language : C

## **Requirement**

For implementing this code yourself, You Need to install below applications :

- <a href="https://www.microchip.com/mplab/avr-support/atmel-studio-7">`Atmel Studio`</a> 
- <a href="https://www.labcenter.com/downloads/">`Proteus`</a> 
- <a href="https://www.amazon.com/ATMEGA32-16PU-Microcontroller-System-Programmable-ATMEGA/dp/B071VYGJB9">`Avr Atmega32`</a>
- <a href="https://www.amazon.com/DiCUNO-450pcs-Emitting-Assorted-Yellow/dp/B072B75W79?ref_=ast_slp_dp">`LEDs`</a>
- <a href="https://www.amazon.com/100pcs-Momentary-Tactile-Button-6x6x5mm/dp/B0814G432F/ref=sr_1_5?crid=1DVKGK9CIDSEK&keywords=micro+push+button+switch+on+off&qid=1578182677&sprefix=push+button+switch+on+off+%2Caps%2C367&sr=8-5">`Push Button`</a>


## Step1 : Create the C code in Atmel Studio

Create a new project in the atmel studio and copy all files in the <a href="https://github.com/MaryamSaeedmehr/ElectronicallyDoorOpenner/blob/master/Openner.c">`/Openner.c`</a> file into your new project folder .


## Step2 : Build your project

After you have built it ,`Openner.hex` file will be created in your project's folder. This is the only thing you need to program your avr in the proteus.


## Step3 : Create your circuit

Use proteus to emulate your circuit. Try to make it as I have done....

![EXC3_Q2](https://user-images.githubusercontent.com/59505261/71773145-bc478a80-2f6c-11ea-84bf-e992d058d02a.png)


## Step4 : Program Atmega32

To ptogram your microcontroler in the proteus , just double click on it and choose the .hex file and press OK !


## Step5 : Enjoy It

![EXC3_Q2](https://user-images.githubusercontent.com/59505261/71773148-cec1c400-2f6c-11ea-8764-4c4150ac5ae6.gif)



## **Files**
- <a href="https://github.com/MaryamSaeedmehr/ElectronicallyDoorOpenner/blob/master/Openner.c">`/Openner.c`</a> : This is the main file
- <a href="https://github.com/MaryamSaeedmehr/ElectronicallyDoorOpenner/blob/master/door.pdsprj">`/door.pdsprj`</a> : Simulation file using proteus
- <a href="https://github.com/MaryamSaeedmehr/ElectronicallyDoorOpenner/blob/master/LICENSE">`/LICENSE`</a> : The license of this project



## **Support**

Reach out to me at one of the following places!

- Telegram at <a href="https://t.me/BitterOcean" target="_blank">@BitterOcean</a>
- Gmail at <a href="mailto:maryamsaeedmehr@gmail.com" target="_blank">maryamsaeedmehr@gmail.com</a>

## **License**

[![License](https://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)
