/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project     : test 3 
Description : Introduction to character LCD and matrix keyboard
Version     : 1.0
Date        : 18/3/2021
Author      : Maryam Saeedmehr
Std.NO      : 9629373


Chip type               : ATmega16
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*******************************************************/

#include "test3Lib.h"

void main(void){

    board_init();

    // flowchart --------------------
    subRoutine1();
    subRoutine2(covid);
    subRoutine3();

    // Global enable interrupts -----
    #asm("sei")

    subRoutine4();
    subRoutine5();

    while (1){
        subRoutine2(result);
    }    
}
