/*
 * initialization.h
 *
 * Created: 12/22/2019 07:44:00 PM
 *  Author: Maryam Saeedmehr
 */ 
#ifndef INITIALIZATION_H_
#define INITIALIZATION_H_

#include "micro_config.h"
#include "common_macros.h"
#include "lcd.h"
#include "keypad.h"

/*This is used to Set your peripherals initializations functions */
inline extern void InitPeripherals(void) 
{
	/*Don't Forget to include the Peripherals header files above*/
	/*Unless it's defined in the main and this is the last one to include !*/
	LCD_init();
	LCD_clearScreen();
	
}

/*This is used to Set Ports initializations*/
inline extern void InitPorts(void) { }

#endif /* INITIALIZATION_H_ */