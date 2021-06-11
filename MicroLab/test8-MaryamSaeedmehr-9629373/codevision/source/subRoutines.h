/*
 * test 8:   Introduction to GLCD and Dot Matrix
 * -----------------------------------------------------------------
 * Created:  5/28/2021
 * Author:   Maryam Saeedmehr
 * Std.NO:   9629373
 */
#ifndef _SUBROUTINES_INCLUDED_
#define _SUBROUTINES_INCLUDED_

// Helping Functions ----------------------------------
uint8_t set_portD(uint8_t a, uint8_t b, uint8_t size);
uint16_t set_portA(uint8_t num);

// Main Functions -------------------------------------
void subRoutine1(uint8_t round);
/* Show the first letter of your name
and lastname on the dot matrix in a 
moving mode. for me it should be 'MS' */

void subRoutine2(); /* Show a preferal
image on the glcd */

void subRoutine3(); /* Show an analoge
clock on the glcd */

#endif
