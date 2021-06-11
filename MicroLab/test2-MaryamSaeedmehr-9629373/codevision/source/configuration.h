/*
 * test 2:   Introduction to I/O ports(Complementary)
 * -----------------------------------------------------------------
 *   + Containing global variables and some other header inclusion
 * -----------------------------------------------------------------
 * Created:  3/7/2021 9:11:54 PM
 * Author:   Maryam Saeedmehr
 * Std.NO:   9629373
 */
#ifndef _CONFIGURATION_INCLUDED_
#define _CONFIGURATION_INCLUDED_

// Library inclusion ------------------------------------------------------
#include <io.h> 
#include <delay.h>
#include <stdint.h>
#include "subRoutines.h"

// Define some parameters -------------------------------------------------
#define portA       1
#define portB       2
#define portC       3
#define portD       4

#define input       0x00
#define output      0xFF
#define inOut       0x0F // input{4 MSB}-output{4 LSB}
#define outIn       0xF0 // output{4 MSB}-input{4 LSB}

#define up          0
#define down        1 

#define segment1    1
#define segment2    2
#define segment3    3
#define segment4    4
#define allSegments 5

// Global Variables -------------------------------------------------------
extern unsigned char i; // for-loop variable
extern unsigned char number; /* variable for subRoutine5 -> number = PINA
and for subRoutine3 used as a temporary variable */
extern unsigned char number_digit[4]; // separated number's digits
extern flash unsigned char digit[10]; // to show digits in 7-segments

#endif
