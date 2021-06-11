/*
 * test 3:   Introduction to character LCD and matrix keyboard
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
#include <mega16.h> 
#include <delay.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <alcd.h>
#include "board_init.h"
#include "subRoutines.h"

// Define some parameters -------------------------------------------------
#define myName  "Maryam Saeedmehr"
#define stdNO   "9629373"
#define line2x  0
#define line2y  1
#define endSub3 "End of \"SubRoutine3\". Now interrupts are activated"
#define SPEED   "Speed (0-50r) :\n"
#define TIME    "time (0-99s) :\n"
#define WEIGT   "Weigt (0-99F) :\n"
#define TEMP    "Temp (20-80C) :\n"
#define Error   "EE"

// Global variables -------------------------------------------------------
extern char* result; // store the result of subRoutine5
extern char* covid;

#endif
