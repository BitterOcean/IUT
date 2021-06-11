/*
 * test 4:   Introduction to LCD, interrupts and timers
 * -----------------------------------------------------------------
 * Created:  22/3/2021
 * Author:   Maryam Saeedmehr
 * Std.NO:   9629373
 */
#ifndef _TEST4_LIB_INCLUDED_
#define _TEST4_LIB_INCLUDED_

// Library inclusion ------------------------------------------------------
#include <mega16.h> 
#include <stdint.h> // uint8_t
#include <stdio.h> // sprintf
#include <alcd.h>
#include "board_init.h"
#include "subRoutines.h"

// Define some parameters -------------------------------------------------
#define maxOfHundredthOfSecond  99
#define maxOfSecond             59
#define maxOfMinute             59
#define maxOfHoure              99
#define reset                   0
#define line2x                  0
#define line2y                  1
#define line1x                  0
#define line1y                  0
#define StartButton             PINB.4
#define StopButton              PINB.5
#define Car_in_Button           PINB.7
#define Car_out_Button          PINB.3
#define start                   1
#define stop                    0
#define isClicked               0
#define full                    0
#define maxParkingCapacuty      10
#define timerFrequency          8000000
#define OCRconstant             1/2*timerFrequency
#define microUnit               0.000001
#define inputPeriodPin          PINA

// Global variables -------------------------------------------------------
extern char* LCD_line1_template;
extern char* LCD_line2_parking_template;
extern char* LCD_line2_period_template;

#endif