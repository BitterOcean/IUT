/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : test 8, Introduction to GLCD and Dot Matrix
Version : 
Date    : 5/28/2021
Author  : Maryam Saeedmehr
Std. NO : 9629373


Chip type               : ATmega16
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*******************************************************/
#include "test8_lib.h"

void main(void){
  _board_init_();

  // flowchart ---------
  subRoutine2();
  delay_ms(3000);
  subRoutine3();
  while (1){
    subRoutine1(10);
  }
}

