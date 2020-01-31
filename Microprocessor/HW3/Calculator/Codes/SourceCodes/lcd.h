/*
 * lcd.h
 *
 * Created: 12/22/2019 07:44:00 PM
 *  Author: Maryam Saeedmehr
 */ 

#ifndef LCD_H_
#define LCD_H_
#include<stdlib.h>
#include<string.h>
#include "std_types.h"
#include "common_macros.h"
#include "micro_config.h"

/* LCD Data bits mode configuration */
#define DATA_BITS_MODE 8

/* Use higher 4 bits in the data port */
#if (DATA_BITS_MODE == 4)
#undef UPPER_PORT_PINS /*PX4 .. PX7*/ /* use undef for PX3 to PX0 */
/*and remember at this case(4-bits),you connect to LCD to its higher ports*/
#endif

/* LCD HW Pins */
#define RS PD0
#define RW PD1
#define E  PD2
#define LCD_CTRL_PORT PORTD
#define LCD_CTRL_PORT_DIR DDRD
#define LCD_DATA_PORT PORTC
#define LCD_DATA_PORT_DIR DDRC

/* LCD Commands */
#define CLEAR_COMMAND 0x01
#define FOUR_BITS_DATA_MODE 0x02
#define TWO_LINE_LCD_Four_BIT_MODE 0x28
#define TWO_LINE_LCD_Eight_BIT_MODE 0x38
#define CURSOR_OFF 0x0C
#define CURSOR_ON 0x0E
#define SET_CURSOR_LOCATION 0x80 

/*LCD Display Configuration*/
#define CURSOR_STATE CURSOR_ON

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

void LCD_sendCommand(uint8 command);
void LCD_displayCharacter(uint8 data);
void LCD_displayString(const char *Str);
void LCD_init(void);
void LCD_clearScreen(void);
void LCD_displayStringRowColumn(uint8 row,uint8 col,const char *Str);
void LCD_goToRowColumn(uint8 row,uint8 col);
/*Using other methods will cause overflow when working on 16 kbytes flash memory*/
/*When choosing which one to use please uncomment the code in the .c file and here*/

/************************************************************************/
/*                    LCD_Signed_Int32_ToString                         */
/************************************************************************/
//void LCD_Signed_Int32_ToString(sint32 data);
	
/************************************************************************/
/*		 LCD_Unsigned_Int32_ToString                            */
/************************************************************************/
//void LCD_Unsigned_Int32_ToString(uint32 data);
	
/************************************************************************/
/*              LCD_Unsigned_Int64_ToString                             */
/************************************************************************/
//void LCD_Unsigned_Int64_ToString(uint64 data);
	
/************************************************************************/
/*               LCD_Signed_Int64_ToString                              */
/************************************************************************/
void LCD_Signed_Int64_ToString(sint64 data);
	


#endif /* LCD_H_ */
