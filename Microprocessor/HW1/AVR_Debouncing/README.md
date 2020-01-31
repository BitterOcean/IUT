# AVR Debouncing  [![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/MaryamSaeedmehr/AVRDebouncing)

AVR Assembly simple debouncer

Author : Maryam Saeedmehr

Language : AVR Assembly

## **Requirement**

For implementing this code yourself, You Need to install below applications :

- <a href="https://www.microchip.com/mplab/avr-support/atmel-studio-7">`Atmel Studio`</a> 
- <a href="https://www.labcenter.com/downloads/">`Proteus`</a> 

## Step1 : Create the Asm code in Atmel Studio

Create a new project in the atmel studio and copy (Ctrl+a then Ctrl+c) <a href="https://github.com/MaryamSaeedmehr/AVRDebouncing/blob/master/Debouncing.asm">`SourceCode`</a> and paste it (Ctrl+v) into your new project.


## Step2 : Build your project

After you have built it , a .hex file will be created in your project's folder. This is the only thing you need to program your avr in the proteus.


## Step3 : Create your circuit

Use proteus to emulate your circuit. Try to make it as I have done....

![Screenshot from 2019-11-01 23-04-32](https://user-images.githubusercontent.com/49061503/68052190-60f3e480-fcfe-11e9-957b-88605ba983f3.png)



## Step4 : Program Atmega16

To program your microcontroler in the proteus , just double click on it and choose the .hex file and press OK !


## Step5 : Enjoy It

![Debouncing](https://user-images.githubusercontent.com/49061503/68051787-7fa5ab80-fcfd-11e9-854e-8caf16418acc.gif)


## **Files**

- <a href="https://github.com/MaryamSaeedmehr/AVRDebouncing/blob/master/Debouncing.asm">`/Debouncing.asm`</a> : This is the main assembly File
- <a href="https://github.com/MaryamSaeedmehr/AVRDebouncing/blob/master/Debouncing.pdsprj">`/Debouncing.pdsprj`</a> : This is emulated circuit in the proteus
- <a href="https://github.com/MaryamSaeedmehr/AVRDebouncing/blob/master/LICENSE">`/LICENSE`</a> : The license of this project



## **Support**

Reach out to me at one of the following places!

- Telegram at <a href="https://t.me/BitterOcean" target="_blank">@BitterOcean</a>
- Gmail at <a href="mailto:maryamsaeedmehr@gmail.com" target="_blank">maryamsaeedmehr@gmail.com</a>

## **License**

[![License](https://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)


- **[MIT license](http://opensource.org/licenses/mit-license.php)**
- Copyright 2018 © <a href="https://github.com/MaryamSaeedmehr/AVRDebouncing/blob/master/LICENSE">AVRDebouncing Project</a>.
