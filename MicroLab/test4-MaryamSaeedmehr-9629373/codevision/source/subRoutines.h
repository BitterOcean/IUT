/*
 * test 4:   Introduction to LCD, interrupts and timers
 * -----------------------------------------------------------------
 * Created:  22/3/2021
 * Author:   Maryam Saeedmehr
 * Std.NO:   9629373
 */
#ifndef _SUBROUTINES_INCLUDED_
#define _SUBROUTINES_INCLUDED_

long map(long x, 
         long in_min, 
         long in_max, 
         long out_min, 
         long out_max);
/* for mapping betwee period range 
[1 us, 10'000 us] with PORTA that 
can differ in range [0, 255]  */

void subRoutine1(); /* a Stopwatch with 
accuracy of 0.01 second */

void subRoutine2(); /* a system to show 
empty parking capacity */

void subRoutine3(); /* generate square 
wave with period of <PINA> */

#endif