/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : test 4, Introduction to LCD, interrupts and timers
Version : 1.0
Date    : 22/3/2021
Author  : Maryam Saeedmehr
Std. NO : 9629373


Chip type               : ATmega16
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*******************************************************/
#include "test4_lib.h"

void main(void){
      // Global enable interrupts
      #asm("sei")
      
      board_init();
}
