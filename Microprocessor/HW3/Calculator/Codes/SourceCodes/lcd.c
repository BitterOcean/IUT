/*
 * lcd.c
 *
 * Created: 12/22/2019 07:44:00 PM
 *  Author: Maryam Saeedmehr
 */ 

#include "lcd.h"

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

void LCD_init(void)
{
	LCD_CTRL_PORT_DIR |= (1<<E) | (1<<RS) | (1<<RW); /* Configure the control pins(E,RS,RW) as output pins */
	
	#if (DATA_BITS_MODE == 4)
		#ifdef UPPER_PORT_PINS
			LCD_DATA_PORT_DIR |= 0xF0; /* Configure the highest 4 bits of the data port as output pins */
		#else
			LCD_DATA_PORT_DIR |= 0x0F; /* Configure the lowest 4 bits of the data port as output pins */
		#endif		 
		LCD_sendCommand(FOUR_BITS_DATA_MODE); /* initialize LCD in 4-bit mode ? */
		LCD_sendCommand(TWO_LINE_LCD_Four_BIT_MODE); /* use 2-line lcd + 4-bit Data Mode + 5*7 dot display Mode */
	#elif (DATA_BITS_MODE == 8)
		LCD_DATA_PORT_DIR = 0xFF; /* Configure the data port as output port */ 
		LCD_sendCommand(TWO_LINE_LCD_Eight_BIT_MODE); /* use 2-line lcd + 8-bit Data Mode + 5*7 dot display Mode */
	#endif
	
	LCD_sendCommand(CURSOR_STATE); /* cursor off */
	LCD_sendCommand(CLEAR_COMMAND); /* clear LCD at the beginning */
}

void LCD_sendCommand(uint8 command)
{
	CLEAR_BIT(LCD_CTRL_PORT,RS); /* Instruction Mode RS=0 */
	CLEAR_BIT(LCD_CTRL_PORT,RW); /* write data to LCD so RW=0 */
	_delay_ms(1); /* delay for processing Tas = 50ns */
	SET_BIT(LCD_CTRL_PORT,E); /* Enable LCD E=1 */
	_delay_ms(1); /* delay for processing Tpw - Tdws = 190ns */
	#if (DATA_BITS_MODE == 4)
		/* out the highest 4 bits of the required command to the data bus D4 --> D7 */
		#ifdef UPPER_PORT_PINS
			LCD_DATA_PORT = (command & 0xF0); 
		#else 
			LCD_DATA_PORT = ((command >> 4) & 0x0F);/*Because LCD force you to output the MSbits first*/
		#endif
			
		_delay_ms(1); /* delay for processing Tdsw = 100ns */
		CLEAR_BIT(LCD_CTRL_PORT,E); /* disable LCD E=0 */
		_delay_ms(1); /* delay for processing Th = 13ns */
		SET_BIT(LCD_CTRL_PORT,E); /* Enable LCD E=1 */
		_delay_ms(1); /* delay for processing Tpw - Tdws = 190ns */
		
		/* out the lowest 4 bits of the required command to the data bus D4 --> D7 */
		#ifdef UPPER_PORT_PINS
			LCD_DATA_PORT = (command << 4) & 0xF0; 
		#else 
			LCD_DATA_PORT = (command & 0x0F);
		#endif
		
		_delay_ms(1); /* delay for processing Tdsw = 100ns */
		CLEAR_BIT(LCD_CTRL_PORT,E); /* disable LCD E=0 */
		_delay_ms(1); /* delay for processing Th = 13ns */
	#elif (DATA_BITS_MODE == 8)
		LCD_DATA_PORT = command; /* out the required command to the data bus D0 --> D7 */ 
		_delay_ms(1); /* delay for processing Tdsw = 100ns */
		CLEAR_BIT(LCD_CTRL_PORT,E); /* disable LCD E=0 */
		_delay_ms(1); /* delay for processing Th = 13ns */
	#endif	
}

void LCD_displayCharacter(uint8 data)
{
	SET_BIT(LCD_CTRL_PORT,RS); /* Data Mode RS=1 */
	CLEAR_BIT(LCD_CTRL_PORT,RW); /* write data to LCD so RW=0 */
	_delay_ms(1); /* delay for processing Tas = 50ns */
	SET_BIT(LCD_CTRL_PORT,E); /* Enable LCD E=1 */
	_delay_ms(1); /* delay for processing Tpw - Tdws = 190ns */
	#if (DATA_BITS_MODE == 4)
		/* out the highest 4 bits of the required command to the data bus D4 --> D7 */
		#ifdef UPPER_PORT_PINS
			LCD_DATA_PORT = (data & 0xF0); 
		#else 
			LCD_DATA_PORT = ((data >> 4) & 0x0F);
		#endif
		
		_delay_ms(1); /* delay for processing Tdsw = 100ns */
		CLEAR_BIT(LCD_CTRL_PORT,E); /* disable LCD E=0 */
		_delay_ms(1); /* delay for processing Th = 13ns */
		SET_BIT(LCD_CTRL_PORT,E); /* Enable LCD E=1 */
		_delay_ms(1); /* delay for processing Tpw - Tdws = 190ns */
		
		/* out the lowest 4 bits of the required data to the data bus D4 --> D7 */
		#ifdef UPPER_PORT_PINS
			LCD_DATA_PORT = (data << 4) & 0xF0; 
		#else 
			LCD_DATA_PORT = (data & 0x0F);
		#endif
		
		_delay_ms(1); /* delay for processing Tdsw = 100ns */
		CLEAR_BIT(LCD_CTRL_PORT,E); /* disable LCD E=0 */
		_delay_ms(1); /* delay for processing Th = 13ns */
	#elif (DATA_BITS_MODE == 8)
		LCD_DATA_PORT = data; /* out the required data to the data bus D0 --> D7 */
		_delay_ms(1); /* delay for processing Tdsw = 100ns */
		CLEAR_BIT(LCD_CTRL_PORT,E); /* disable LCD E=0 */
		_delay_ms(1); /* delay for processing Th = 13ns */
	#endif	
}

void LCD_displayString(const char *Str)
{
	uint8 i = 0;
	while(Str[i] != '\0')
	{
		LCD_displayCharacter(Str[i]);
		i++;
	}
	/***************** Another Method ***********************
	while((*Str) != '\0')
	{
		LCD_displayCharacter(*Str);
		Str++;
	}		
	*********************************************************/
}

void LCD_goToRowColumn(uint8 row,uint8 col)
{
	uint8 Address;
	
	/* first of all calculate the required address */
	switch(row)
	{
		case 0:
				Address=col;
				break;
		case 1:
				Address=col+0x40;
				break;
		case 2:
				Address=col+0x10;
				break;
		case 3:
				Address=col+0x50;
				break;
	}					
	/* to write to a specific address in the LCD 
	 * we need to apply the corresponding command 0b10000000+Address */
	LCD_sendCommand(Address | SET_CURSOR_LOCATION); /*0x80+Address*/
}

void LCD_displayStringRowColumn(uint8 row,uint8 col,const char *Str)
{
	LCD_goToRowColumn(row,col); /* go to to the required LCD position */
	LCD_displayString(Str); /* display the string */
}

void LCD_clearScreen(void)
{
	LCD_sendCommand(CLEAR_COMMAND); //clear display
}
/************************************************************************/
/*                    LCD_Signed_Int32_ToString                                                  */
/************************************************************************/
/*
void LCD_Signed_Int32_ToString(sint32 data)
{
   char buff[16]={0}; 
   itoa(data,buff,10); 
   LCD_displayString(buff);
}
*/
/************************************************************************/
/*				 LCD_Unsigned_Int32_ToString                                                              */
/************************************************************************/
/*
static uint8 Unsigned_Int32_ToASCI(uint32 num, uint8* str, uint8 len, uint8 base)
{
	uint32 sum = num;
	uint8 i = 0;
	uint8 digit;

	do
	{
		digit = sum % base;
		if (digit < 0xA)
		str[i++] = '0' + digit;
		else
		str[i++] = 'A' + digit - 0xA;
		sum /= base;
	}while (sum >0);

	str[i] = '\0';
	strrev(str);
	return 0;
}
void LCD_Unsigned_Int32_ToString(uint32 data)
{
	char buf[16]={0};
	Unsigned_Int32_ToASCI(data,buf,16,10);
	LCD_displayString(buf);
}*/


/************************************************************************/
/*              LCD_Unsigned_Int64_ToString                                                        */
/************************************************************************/
/*static uint8 Unsigned_Int64_ToASCI(uint64 num, uint8* str, uint8 len, uint8 base)
{
	
	uint64 sum = num;
	uint8 i = 0;
	uint8 digit;

	do
	{
		digit = sum % base;
		if (digit < 0xA)
			str[i++] = '0' + digit;
		else
			str[i++] = 'A' + digit - 0xA;
		sum /= base;
	}while (sum > 0);

	str[i] = '\0';
	strrev(str);
	return 0;
}
void LCD_Unsigned_Int64_ToString(uint64 data)
{
	char buf[16]={0};
	Unsigned_Int64_ToASCI(data,buf,16,10);
	LCD_displayString(buf);
}

*/
/************************************************************************/
/*               LCD_Signed_Int64_ToString                                     */
/************************************************************************/

static uint8 Signed_Int64_ToASCI(sint64 num, uint8* str, uint8 len, uint8 base)
{
	sint64 sum = num;
	uint8 i = 0;
	uint8 digit;
	uint8 Negative=0;
	
	if(sum < 0){
		sum=-sum;
		Negative=1;
	}
	
	do
	{
		digit = sum % base;
		if (digit < 0xA)
			str[i++] = '0' + digit;
		else
			str[i++] = 'A' + digit - 0xA;
		sum /= base;
	}while (sum > 0);

	if(Negative) str[i]='-';
	++i;
	str[i] = '\0';
	strrev(str);
	return 0;
}


void LCD_Signed_Int64_ToString(sint64 data)
{
	char buf[16]={0};
	Signed_Int64_ToASCI(data,buf,16,10);
	LCD_displayString(buf);
}


