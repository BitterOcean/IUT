/*
 * Calculator.c
 *
 * Created: 12/22/2019 07:44:00 PM
 *  Author: Maryam Saeedmehr
 */ 

#include "SourceCodes/std_types.h"
#include "SourceCodes/micro_config.h"
#include "SourceCodes/common_macros.h"
#include "SourceCodes/initialization.h"
#include "calculator_blocks.h"

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
uint8 Flag=StartPoint;/*Contains the state of the program flow*/

int main(void)
{

	InitPeripherals(); /*Initiate the LCD driver*/

    while(1)
    {
		ResetData();
		LCD_clearScreen();
		Flag=StartPoint;
		 while(Flag==StartPoint) GetData(); /*Don't get out until pressing equal sign*/
		 while(Flag==AnalyzePoint) Analyze(); /*Don't get out until separating every thing correctly*/
		 while(Flag==CalculatePoint) Calculate(); /*Don't get out until calculate the value*/
		 while(Flag==DisplayPoint) DisplayResult(); /*Display the result*/
		 	/*If an error is found in one of these stages, the Flag will be sit to "Error point" and will set 
			 to "StartPoint" again in the start of the loop after clearing every thing*/
	}
	
	
}






