#ifndef _SUBROUTINES_INCLUDED_
#define _SUBROUTINES_INCLUDED_

// Function Declaration -----------------------------------------------------
void subRoutine1(); /* print first name and last name in first line and
student number in second line */

void subRoutine2(char* str); /* Scrolling string on 16X2 LCD and the string is 
"Welcome to the online lab classes due to Corona disease" */

void subRoutine3(); /* Polling method to detect keypad is pushed or not */

void subRoutine4(); /* Interrupt method to detect keypad is pushed or not */

void subRoutine5(); /* Get info from keypad and print in lcd :
    Speed:??(0-50r)
    Time:??(0-99s)
    Weigt:??(0-99F)
    Temp:??(20-80C) 
*/

#endif