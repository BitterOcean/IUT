/*
 * test 6:   Introduction to ADC
 * -----------------------------------------------------------------
 * Created:  4/23/2021
 * Author:   Maryam Saeedmehr
 * Std.NO:   9629373
 */
#ifndef _SUBROUTINES_INCLUDED_
#define _SUBROUTINES_INCLUDED_

void subRoutine1(); /* read from adc 
and print them on LCD in 'mv'*/

void subRoutine2(); /* read from adc 
via interrupt and print them on LCD 
in 'mv' if they've changed more than
5% */

void subRoutine3(); /* generate PWM 
wave with timer0 and the period of
what ADC says */

#endif