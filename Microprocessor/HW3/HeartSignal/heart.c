/*
 * heart.c
 *
 * Created: 13/10/1398 02:49:42 ب.ظ
 * Author : Sajede.Nick
 */ 

#include <avr/io.h>
#include <util/delay.h>


int main(void)
{
    /* Replace with your application code */
	unsigned char i=50;
	DDRB=0xff;
	double timer=0;

    while (1) 
    {
		PORTB=i;
		if(timer<30){
			_delay_ms(1);
			timer++;
			i++;
		}
		else if(timer>=30&&timer<60){
			_delay_ms(30);
			timer+=30;
		}
		else if(timer>=60&&timer<90){
			_delay_ms(1);
			timer++;
			i--;
		}
		else if(timer>=90&&timer<120){
			_delay_ms(70);
			timer+=70;
		}
		else if(timer>=120&&timer<125){
			_delay_ms(1);
			timer+=(1);
			i-=3;
		}
		else if(timer>=125&&timer<155){
			_delay_ms(1);
			timer+=(1);
			i+=6;
		}
		else if(timer>=155&&timer<187){
			_delay_ms(1);
			timer+=(1);
			i-=6;
		}
		else if(timer>=187&&timer<196){
			_delay_ms(1);
			timer+=(1);
			i+=3;
		}
		else if(timer>=196&&timer<285){
			_delay_ms(89);
			timer+=89;
		}
		else if(timer>=285&&timer<340){
			_delay_ms(1);
			timer++;
			i++;
		}
		else if(timer>=340&&timer<395){
			_delay_ms(55);
			timer+=55;
		}
		else if(timer>=395&&timer<450){
			_delay_ms(1);
			timer++;
			i--;
		}
    }
}
