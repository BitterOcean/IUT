/*
 * keypad.h
 *
 * Created: 12/22/2019 07:44:00 PM
 *  Author: Maryam Saeedmehr
 */ 

#ifndef KEYPAD_H_
#define KEYPAD_H_

#include "std_types.h"
#include "micro_config.h"
#include "common_macros.h"
#include <util/delay.h>
#define N_col 4
#define N_row 4

/*
*  #include "SourceCodes/std_types.h" :
*
*  typedef unsigned char uint8;
*  typedef signed char sint8;
*  typedef unsigned short uint16;
*  typedef signed short sint16;
*  typedef unsigned long uint32;
*  typedef signed long sint32;
*  typedef unsigned long long uint64;
*  typedef signed long long sint64;
*  typedef unsigned char bool;
*/

/* Keypad Port Configurations */
#define KEYPAD_PORT_OUT PORTA
#define KEYPAD_PORT_IN  PINA
#define KEYPAD_PORT_DIR DDRA 
/*
 *Note on Connecting the keypad :Crucial
 *PX7 is connect to the last pin to right in keypad,then go backward
 *PX3 is connect to the last pin to down in keypad,then go up
*/
/*
 * Function responsible for getting the pressed keypad key
 */
uint8 KeyPad_getPressedKey(void);
/*
 * Responsible for returning a number of 4 bytes range of length "NumberOfPressing"
 * i.e. : if you clicked 1,5,9 respectively on keypad,you will get 159 as return
 * a delay from one press and another is equal to 300 ms(Approx to the Normal human Press)
 */
uint32 KeyPad_getSeriesOfPressedNumbers(uint8 NumberOfPressing);
/*
 * Function responsible for mapping the switch number in the keypad to 
 * its corresponding functional number in the proteus for 4x3 keypad 
 */
uint8 KeyPad_4x3_adjustKeyNumber(uint8 button_number); /*C code may be configurable*/

/*
 * Function responsible for mapping the switch number in the keypad to 
 * its corresponding functional number in the proteus for 4x4 keypad  
 */
uint8 KeyPad_4x4_adjustKeyNumber(uint8 button_number); /*C code may be configurable*/

uint32 powerOf(uint8 x,uint8 y);

#endif /* KEYPAD_H_ */
