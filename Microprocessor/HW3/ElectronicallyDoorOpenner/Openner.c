/*
 * door.c
 *
 * Created: 11/10/1398 09:30:28
 * Author : Sajede.Nick
 */ 

#include <avr/io.h>
#define F_CPU 1000000
#include <util/delay.h>
#include <avr/sfr_defs.h>
#include <stdlib.h>

int main(void)
{
	DDRA=0x00;
	DDRB=0xff;
	DDRC=0x80;
	DDRD=0x00;
	int array[8]={5,5,5,5,5,5,5,5};
	
    while (1) 
    {
		if(bit_is_set(PINA,0)||bit_is_set(PINA,1)||bit_is_set(PINA,2)||bit_is_set(PINA,3)||bit_is_set(PINA,4)||bit_is_set(PINA,5)||bit_is_set(PINA,6)||bit_is_set(PINA,7))
		{
			PORTC=0b10000000;
			_delay_ms(2500);
			PORTC=0b00000000;
		}

		if(bit_is_set(PINC,3))
		{
			// PINC&0x07 is the floor number
			// PIND is the password
			if(array[PINC&0x07]==PIND)
			{
				PORTB=1<<(PINC&0x07);
				_delay_ms(2500);
				PORTB=0x00;
			}
		}
    }
	return 0;
}