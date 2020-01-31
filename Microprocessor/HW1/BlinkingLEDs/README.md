# BlinkingLED [![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/MaryamSaeedmehr/BlinkingLED)


Blinking LED with Atmega16 and Push Button

Author : Maryam Saeedmehr

Language : AVR Assembly


## **Requirement**

For implementing this code yourself, You Need to install below applications :

- <a href="https://www.microchip.com/mplab/avr-support/atmel-studio-7">`Atmel Studio`</a> 
- <a href="https://www.labcenter.com/downloads/">`Proteus`</a> 


## Step1 : Create the Asm code in Atmel Studio

Create a new project in the atmel studio and copy (Ctrl+a then Ctrl+c) <a href="https://github.com/MaryamSaeedmehr/BlinkingLED/blob/master/BlinkingLED.asm">`SourceCode`</a> and paste it into your new project.


## Step2 : Build your project

After you have built it , a .hex file will be created in your project's folder. This is the only thing you need to program your avr in the proteus.


## Step3 : Create your circuit

Use proteus to emulate your circuit. Try to make it as I have done....

![proteus_design](https://user-images.githubusercontent.com/49061503/67945564-7846ab00-fbf4-11e9-8089-cd3641aead15.jpg)


## Step4 : Program Atmega16

To ptogram your microcontroler in the proteus , just double click on it and choose the .hex file and press OK !


## Step5 : Enjoy It

![Micro_pj_exe1](https://user-images.githubusercontent.com/49061503/67945912-58fc4d80-fbf5-11e9-8851-e9e3b42e7d7c.gif)

### To see how the real circuit works, <a href="https://drive.google.com/open?id=1Au6_5e89w9f9P62xurAPdfuXmeGuFvgd">click here</a>


## **Files**

- <a href="https://github.com/MaryamSaeedmehr/BlinkingLED/blob/master/BlinkingLED.asm">`/BlinkingLED.asm`</a> : This is the main assembly File
- <a href="https://github.com/MaryamSaeedmehr/BlinkingLED/blob/master/BlinkingLED.pdsprj">`/BlinkingLED.pdsprj`</a> : This is emulated circuit in the proteus
- <a href="https://github.com/MaryamSaeedmehr/BlinkingLED/blob/master/LICENSE">`/LICENSE`</a> : The license of this project



## **Support**

Reach out to me at one of the following places!

- Telegram at <a href="https://t.me/BitterOcean" target="_blank">@BitterOcean</a>
- Gmail at <a href="mailto:maryamsaeedmehr@gmail.com" target="_blank">maryamsaeedmehr@gmail.com</a>

## **License**

[![License](https://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)


- **[MIT license](http://opensource.org/licenses/mit-license.php)**
- Copyright 2018 © <a href="https://github.com/MaryamSaeedmehr/BlinkingLED/blob/master/LICENSE">BlinkingLED Project</a>.
