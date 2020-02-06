#define	F_CPU 8000000UL// 8MHz clock
#include <avr/io.h>
#include <util/delay.h>
#include <stdio.h>
#include <stdlib.h>		// for rand() function
#include "ledcontrol.h"	// 8x16 LED Matrix header
#include "font.h"		//Fonts for scrolling text and notes for buzzer
#include <avr/interrupt.h>

//user defined variables for simplicity
typedef unsigned char   uint8_t;
typedef unsigned int    uint16_t;

//variable to hold the game state
static uint8_t gameover = 0;

//variable to hold the highscore of the game 
static uint16_t highscore;

/*
*	custom delay function
*/
void delay_ms(uint16_t d)
{
	uint16_t i;
	for (i = 0; i < d/10; i++)
		_delay_ms(1);
}

void delay_us(uint16_t d)
{
	uint16_t i;
	for(i = 0; i < d/10; i++)
		_delay_us(1);
}

void beep(long frequency, long time)
{
	long x;
	long delay_amount = (long)(1000000/frequency/2);
	long num_cycles = frequency*time/1000;
	
	for (x=0;x<num_cycles;x++)
	{
		PORTD = 0x80;
		delay_us(delay_amount);
		PORTD = 0x00;
		delay_us(delay_amount);
	}
}

void march()
{
	int size = sizeof(melody) / sizeof(int);
	int note;
	for (note = 0; note < size; note++) 
	{
		
		// to calculate the note duration, take one second
		// divided by the note type.
		//e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
		int note_duration = 1000 / tempo[note];
		
		beep(melody[note], note_duration);
		
		// to distinguish the notes, set a minimum time between them.
		// the note's duration + 30% seems to work well:
		int pause_bw = note_duration * 1.30;
		
		delay_us(10*pause_bw);
		
		// stop the tone playing:
		beep(0, note_duration);
	}
}

void EEPROM_WriteByte(uint16_t v_eepromAddress_u16, uint8_t v_eepromData_u8)
{
	while(((EECR)&(1<<(EEWE)))!=0u);// Wait for completion of previous write.
	// EEWE will be cleared by hardware once EEPROM write is completed.

	EEAR = v_eepromAddress_u16;//Load the EEPROM address and data
	EEDR = v_eepromData_u8;

	EECR |= (1<<(EEMWE));// EEPROM Master Write Enable

	EECR |= (1<<EEWE);// Start EEPROM write by setting EEWE
}

uint8_t EEPROM_ReadByte(uint16_t v_eepromAddress_u16)
{
	while((EECR & (1<<EEWE))!=0u);//Wait for completion of previous write if any.

	EEAR = v_eepromAddress_u16;//Load the address from where the data needs to be read.
	EECR |= (1<<EERE);// start EEPROM read by setting EERE

	return EEDR;// Return data from data register
}

/*
*	function used to scroll messages on the matrix display
*	scrolls input message for a given time in milliseconds
*	converts message to dot matrix display pattern and saves it to buffer
*	the buffer is used to scroll message for a given time
*/
void scroll_text(char *msg, uint16_t scrollTime)
{
	char msgBuff[120];
	int segCnt = 0, buffLen = 0, dotCnt = 0, gCnt = 0;
	uint8_t scrollSpeed = 25;//time in milliseconds, decrease it to scroll faster, increase to scroll slower
	
	//create dot matrix patter in local buffer
	while(msg[gCnt]!= '\0')
	{
		for(dotCnt =0; dotCnt<7; dotCnt++)
		{
			msgBuff[(gCnt*7)+dotCnt] = pgm_read_byte(&Font[msg[gCnt]-32][dotCnt]);
		}
		gCnt++;
	}
	buffLen = gCnt * 7;

	for(gCnt =0; gCnt< buffLen; gCnt++)
	{
		for(segCnt = 16; segCnt > 0; segCnt--)
		{
			if(segCnt<8)
			{

				if((gCnt+segCnt)<buffLen)
				{
					set_row_led_matrix(0,segCnt,msgBuff[(gCnt*1)+segCnt]);
				}
				else
				{
					set_row_led_matrix(0,segCnt,0);
				}
				
			}
			else
			{
				if((gCnt+segCnt)<buffLen)
				{
					set_row_led_matrix(1,segCnt%8,msgBuff[(gCnt*1)+segCnt]);
				}
				else
				{
					set_row_led_matrix(1,segCnt%8,0);
				}
			}
		}

		delay_ms(scrollSpeed);
		clear_led_matrix(0);
		clear_led_matrix(1);
	}
}

/* 
*	This function initializes the Buzzer and the two led matrices and Keys
*/
void init_game()
{
	DDRA = 0; //port a as input	
	
	//make some tune with the buzzer
	DDRD = 0x80;
	PORTD = 0x00;
	
	//initialize first LED Matrix
	init_led_matrix(2);
	clear_led_matrix(0);

	//initialize second LED Matrix
	clear_led_matrix(1);
	
	//set intensity
	set_intensity_led_matrix(0, 2);
	set_intensity_led_matrix(1, 2);
	
	//Welcome text
	scroll_text("WELCOME", 5000);
	
	march();
}

/*
*	This function reads the Buttons and returns the direction
*	0 : Stationary
*	1 : Up  
*	2 : Right 
*	3 : Down 
*	4 : Left
*/
uint8_t snake_direction()
{
	static uint8_t direction = 0; //static to retain direction during subsequent calls
	
	if(PINA & 0X01)
		direction=1;
	if(PINA & 0X02)
		direction=2;
	if(PINA & 0X04)
		direction=3;
	if(PINA & 0X08)
		direction=4;
		
	return direction;
}

/*
* This function gets random values for food generation
*/
uint8_t* get_food(uint8_t vlen)
{
	static uint8_t v_pos[2]; // food position to retain value
	srand(vlen); // generate seed for random number generation
	v_pos[0] = rand()%15; // generate random numbers
	v_pos[1] = rand()%7;
	return v_pos;
}

/* 
*	This function contains the main logic of the game. It takes the direction as input
*	and draws the modified snake on the display. This function also contains the code for
*	displaying the food and growing the snake if it eats the food. It also checks for self
*	collision 
*/
void snake_main(uint8_t v_dir)
{

	//A 2D array hold the snake position with rows and column matrices(pixels)
	//old snake
	static uint8_t snake[50][2] = { {1,1},{2,1} };
	
	//new snake
	static uint8_t n_snake[50][2] = { {1,1},{2,1} };
	
	//game variables -->
	//v_len stores the current length of the snake
	static uint8_t v_len = 2;

	//This variable holds the current direction of the snake
	static uint8_t curr_dir = 0;

	//loop variables
	static uint8_t i, j = 0;

	//variable to indicate which led matrix to use while displaying
	static uint8_t v_matrix = 0;

	//variable to indicate the delay of the game (which directly affects the speed of the snake)
	static uint16_t snake_speed = 17; // in milli seconds

	// food variables
	static uint8_t *food_pos; // pointer to hold snake food position
	static uint8_t food_draw = 1; // variable to indicate if food is present on board.
	
	//load highscore from eeprom
	highscore = EEPROM_ReadByte(0x00);
	/*==============================================================================================
	==========================CHANGE THE SNAKE AND DISPLAY THE MODIFIED SNAKE=======================
	================================================================================================*/

	// shift the old snake until the last point(i.e the 'head')
	for(i =0; i<v_len-1; i++)
	{
		for(j=0; j<2; j++)
		n_snake[i][j] = snake[i+1][j];
	}

	// finding if direction change is possible (up to down, left to right, etc not feasible)
	// else no direction change
	if(curr_dir - v_dir == 2 || curr_dir - v_dir == -2)
	if(!(curr_dir == 0 && v_dir == 2))
	v_dir = curr_dir;

	// finding the next 'head' according to the analog input (% rotates through the matrix)
	switch(v_dir)
	{
		// take lite
		case 0: break;

		// up is pressed, column of old snake head should be incremented.
		case 1:
		n_snake[v_len-1][0] = (snake[v_len-1][0]%16);
		n_snake[v_len-1][1] = (snake[v_len-1][1]+1)%8; break;

		// right is pressed, row of old snake head should be incremented
		case 2:
		n_snake[v_len-1][0] = (snake[v_len-1][0]+1)%16;
		n_snake[v_len-1][1] = snake[v_len-1][1]%8; break;

		// down is pressed, column of old snake head should be decremented
		case 3:
		n_snake[v_len-1][0] = snake[v_len-1][0]%16;

		if((snake[v_len-1][1]-1) < 0)
		{
			// rotate to the top row
			n_snake[v_len-1][1] = 7;
		}
		else
		{
			n_snake[v_len-1][1] = (snake[v_len-1][1]-1)%8;
		}
		break;

		// left is pressed, row of old snake head should be decremented
		case 4:
		if((snake[v_len-1][0]-1)<0)
		{
			// rotate through left to rightmost column
			n_snake[v_len-1][0] = 15;
		}
		else
		{
			n_snake[v_len-1][0] = (snake[v_len-1][0]-1)%16;
		}

		n_snake[v_len-1][1] = snake[v_len-1][1]%8;
		break;
	}

	// clear old Snake
	for(i =0; i < v_len; i++)
	{
		if(snake[i][0]<8)
		v_matrix = 0;
		if(snake[i][0] >= 8)
		v_matrix = 1;
		set_led_matrix(v_matrix,(snake[i][0])%8, (snake[i][1]),0); // draw new snake
	}

	// Display the new snake
	for(i =0; i < v_len; i++)
	{
		if(n_snake[i][0]<8)
		v_matrix = 0;
		if(n_snake[i][0] >= 8)
		v_matrix = 1;
		set_led_matrix(v_matrix,(n_snake[i][0])%8, (n_snake[i][1]),1); // draw new snake
	}


	// copy the snake for next time
	for(i =0; i<v_len; i++)
	{
		for(j=0; j<2; j++)
		snake[i][j] = n_snake[i][j];
	}
	/*==================================================================================================
	=================================FOOD AND COLLISION DETECTION==============================
	===================================================================================================*/

	// if food is not drawn draw it and make the flag zero
	if(food_draw)
	{
		uint8_t flag;
		uint8_t seeder = 0;
		while(1)
		{
			flag = 0;
			// get a random position for food
			food_pos = get_food(v_len+seeder);
			seeder++;
			uint8_t i;
			for(i = 0; i<v_len; i++)
			{
				if((food_pos[0] == snake[i][0]) && (food_pos[1] == snake[i][1]))
				flag = 1;
			}
			if(flag == 0)
			break;
		}
		if(food_pos[0]>7)
		{
			// draw on matrix 2
			set_led_matrix(1, food_pos[0]%8, food_pos[1], 1 );
		}
		else
		{
			// draw on matrix 1
			set_led_matrix(0, food_pos[0], food_pos[1], 1 );
		}
		food_draw = 0;
	}



	// check if snakes eats the food and grow the snake
	if((n_snake[v_len-1][0] == food_pos[0])&&(n_snake[v_len-1][1] == food_pos[1]))
	{

		// beep the buzzer with some tune
		PORTD = 0x80;
		_delay_ms(1);
		PORTD = 0x00;
		


		food_draw = 1; // new food needs to be drawn next time

		if(food_pos[0]>7)
		{
			// remove the food from LED 2
			set_led_matrix(1, food_pos[0]%8, food_pos[1], 0 );
		}
		else
		{
			// remove the food from LED 1
			set_led_matrix(0, food_pos[0], food_pos[1], 0 );
		}

		// increment the length variable
		v_len++;

		// grow the snake according to the direction
		switch(v_dir)
		{
			case 1:
			n_snake[v_len-1][0] = food_pos[0];
			n_snake[v_len-1][1] = food_pos[1]+1;
			snake[v_len-1][0] = food_pos[0];
			snake[v_len-1][1] = food_pos[1]+1;
			break;
			case 2:
			n_snake[v_len-1][0] = food_pos[0]+1;
			n_snake[v_len-1][1] = food_pos[1];
			snake[v_len-1][0] = food_pos[0]+1;
			snake[v_len-1][1] = food_pos[1];
			break;
			case 3:
			n_snake[v_len-1][0] = food_pos[0];
			n_snake[v_len-1][1] = food_pos[1]-1;
			snake[v_len-1][0] = food_pos[0];
			snake[v_len-1][1] = food_pos[1]-1;
			break;
			case 4:
			n_snake[v_len-1][0] = food_pos[0]-1;
			n_snake[v_len-1][1] = food_pos[1];
			snake[v_len-1][0] = food_pos[0]-1;
			snake[v_len-1][1] = food_pos[1];
			break;
		}
		if(snake_speed > 5)
		snake_speed -= 1; // increase the speed by decreasing the delay
	}

	// check for snake collision
	// if head hits any part on snake body the game is over
	for(i = 1; i < v_len-1; i++)
	{
		if((n_snake[i][0] == n_snake[0][0])&&(n_snake[i][1] == n_snake[0][1]))
		{

			beep(NOTE_A6, 250);
			beep(NOTE_A7, 250);
			beep(NOTE_A6, 250);
			
			//Scroll "GAMEOVER" on the display
			scroll_text("GAMEOVER!", 5000);
			
			
			if(v_len -2 > highscore)
			{
				highscore = v_len-2;
				EEPROM_WriteByte(0x00, highscore);
			}
			
			char* str = (char*)malloc(sizeof(char));
			
			sprintf(str, "%s%d", "YOUR SCORE IS ", v_len-2);
			scroll_text(str, 5000);
			
			sprintf(str, "%s%d", "HIGH SCORE IS ", highscore);
			scroll_text(str, 5000);
			
			
			

			v_len = 2; // reset the snake length
			gameover = 1; // set gameover variable
			snake_speed = 17;
			food_draw = 1; // reset the snake speed
			beep(NOTE_G6, 200);
			beep(NOTE_A6, 100);
			beep(NOTE_DS8, 200);
			
			break; // break from the for loop
		}

	}
	curr_dir = v_dir;
	delay_ms(snake_speed*10); // delay of the snake (which ultimately affects the game speed)
}

int main(void)
{
	init_game();//initialize the snake & led
	while(1)//game loop
	{
		if(!gameover)
			snake_main(snake_direction());
		else
			gameover = 0;
	}
}
