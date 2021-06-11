/*
 * test 7:   Introduction to USART
 * -----------------------------------------------------------------
 * Created:  5/14/2021
 * Author:   Maryam Saeedmehr
 * Std.NO:   9629373
 */
#ifndef _SUBROUTINES_INCLUDED_
#define _SUBROUTINES_INCLUDED_

void subRoutine1(int, int, int);
/* subRoutine with three input arguments
 :param baudrate:
 :param RX:
 :param TX:
 RX , TX has three status : OFF,
 noneinterrupt_enable, interrupt_e */

void subRoutine2(); /* get a string
 with pulling method and add ( , ) 
 and print it in LCD 
 e.g. Hello -> (Hello) */

void subRoutine3(char); /* TX with interrupt 
 and RX without interrupt and act like the
 table below : 
 sample               |  operation         |  character
 ------------------------------------------------------
 TX: 5                |  print 10*data     |  char in 
 RX: Data is          |                    |  range 0-9 
 an integer           |                    | 
 and                  |                    |     
 10*data=50           |                    | 
 ------------------------------------------------------
    -                 |  print LCD delete  |  char 'D'
 ------------------------------------------------------
 *******************  |  print preferal    |  char 'H'
 Microprocessor lab   |  description       | 
 *******************  |                    |
 ------------------------------------------------------
 no function defined! |  print             |  other 
                      |  'no function'     |  chars
 ------------------------------------------------------
*/
void subRoutine4(); /* TX and RX with 
 interrupt and act like the
 table below : 
  sample              |  operation         | character
 ------------------------------------------------------
        -             |  length of frame   | (123) 
                      |  not correct       |  
 ------------------------------------------------------
 print 12345 on LCD   |  frame is correct  | (12345)
 ------------------------------------------------------
         -            |  frame must be 5   | (12w34)or
                      |  integer           | (1234567)  
 ------------------------------------------------------
*/

#endif