/*
 * test 2:   Introduction to I/O ports(Complementary)
 * -------------------------------------------------------------------------
 *   + subRoutines Declaration
 *     - subRoutine1(<portSel>, <turningOn>, <delay>);
 *     - subRoutine2(<portSel>, <duration>);
 *     - subRoutine3(<inPort>, <outPort>);
 *     - subRoutine4(<direction>, <segment>) ;
 *     - subRoutine5(<stepSize>);
 * -------------------------------------------------------------------------
 * Created:  3/7/2021 9:11:54 PM
 * Author:   Maryam Saeedmehr
 * Std.NO:   9629373
 */

#ifndef _SUBROUTINES_INCLUDED_
#define _SUBROUTINES_INCLUDED_

// Function Declaration -----------------------------------------------------
void ioConfiguration(char portSel, char config); /* setup I/O ports */


void subRoutine1(char portSel, char turningOn, uint16_t delay); /* turn 
on all LEDs on port <portSel> for <turningOn> times with <delay>
ms delay */

void subRoutine2(char x, uint16_t duration); /* scrolling dot 
light starting at portB.<x> for <duration> ms */


void subRoutine3(char inPort, char outPort); /* show date from
port <inPort> on port <outPort> */


void subRoutine4(char direction, char segment); /* count <direction> 
in range (0,9) on <segment> of 7-segments */


void subRoutine5(char stepSize); /* count down from PortA to 0 by 
<stepSize> steps with 100ms delay. 
Note: real step size is <stepSize>*0.1  so stepSize can be in 
range of 1 to 10. */


#endif
