/*
 * test 6:   Introduction to ADC
 * -----------------------------------------------------------------
 * Created:  4/23/2021
 * Author:   Maryam Saeedmehr
 * Std.NO:   9629373
 */
#ifndef _TEST6_LIB_INCLUDED_
#define _TEST6_LIB_INCLUDED_

// Library inclusion ------------------------------------------------------
#include <mega16.h> 
#include <alcd.h>
#include <adc.h>
#include <delay.h>
#include <stdint.h> // uint16/8_t
#include <stdio.h>  // sprintf
#include <stdlib.h> // abs
#include "board_init.h"
#include "subRoutines.h"
#include "adc.h"

// Define some parameters -------------------------------------------------
#define line1x          0
#define line1y          0
#define line2x          0
#define line2y          1
#define FIRST_ADC_INPUT 0
#define LAST_ADC_INPUT  7
#define ADC_VREF_TYPE   ((0<<REFS1) | (1<<REFS0) | (0<<ADLAR))


// Global variables -------------------------------------------------------
extern uint16_t adc_data[LAST_ADC_INPUT-FIRST_ADC_INPUT+1];
extern uint16_t adc_data_copy[LAST_ADC_INPUT-FIRST_ADC_INPUT+1];

#endif
