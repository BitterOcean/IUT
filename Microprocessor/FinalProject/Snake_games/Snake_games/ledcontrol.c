/*
*	INTERACTION CODE FOR MAX7219 WITH TWO 8X8 LED
*	MATRICES WRITTEN FOR ATMEGA32 @16MHZ
*/

// Outputs, pin definitions
#define PIN_SCK                   PORTB7
#define PIN_MOSI                  PORTB5
#define PIN_SS                    PORTB4
#define ON                        1
#define OFF                       0
#define MAX7219_LOAD1             PORTB |= (1<<PIN_SS)
#define MAX7219_LOAD0             PORTB &= ~(1<<PIN_SS)
#define MAX7219_MODE_DECODE       9
#define MAX7219_MODE_INTENSITY    10
#define MAX7219_MODE_SCAN_LIMIT   11
#define MAX7219_MODE_POWER        12
#define MAX7219_MODE_TEST         15
#define MAX7219_MODE_NOOP         0
#define MAX7219_DIGIT0            1
#define MAX7219_DIGIT1            2
#define MAX7219_DIGIT2            3
#define MAX7219_DIGIT3            4
#define MAX7219_DIGIT4            5
#define MAX7219_DIGIT5            6
#define MAX7219_DIGIT6            7
#define MAX7219_DIGIT7            8
#define MAX7219_CHAR_BLANK        0xF
#define MAX7219_CHAR_NEGATIVE     0xA

#include <avr/io.h>
#include "ledcontrol.h"

static uint8_t status[32] ={0};

void spi_send_byte (uint8_t databyte)
{
	// Copy data into the SPI data register
	SPDR = databyte;
	// Wait until transfer is complete
	while (!(SPSR & (1 << SPIF)));
}

void spi_transfer(uint8_t addr, uint8_t opcode, uint8_t data)
{

    uint8_t spidata[4];
    //Create an array with the data to shift out
    uint8_t offset=addr*2;
    uint8_t i;
    for(i=0;i<4;i++)
        spidata[i]=(uint8_t)0;
    //put our device data into the array
    spidata[offset+1]=opcode;
    spidata[offset]=data;

    //enable the line
    MAX7219_LOAD0;

    //Now shift out the data
    for(i=4;i>0;i--)
        spi_send_byte(spidata[i-1]);

    //latch the data onto the display
    MAX7219_LOAD1;
}
void clear_led_matrix(uint8_t addr)
{
	uint8_t offset = addr*8;
	uint8_t i;
	for (i = 0; i < 8; ++i)
	{
		status[offset+i] = 0;
		spi_transfer(addr, i+1,0x00);
	}
}
void init_led_matrix(uint8_t num_devices)
{
	// SS MOSI SCK
	DDRB |= (1 << PIN_SCK) | (1 << PIN_MOSI) | (1 << PIN_SS);
	SPCR |= (1 << SPE) | (1 << MSTR)| (1<<SPR0);

	//set status of all LEDs to 0
	uint8_t i;
	for (i = 0; i < 32; ++i)
	{
		status[i] = 0;
	}

	//initialize each led matrix
	for (i = 0; i < num_devices; ++i)
	{
		// test mode first
		spi_transfer(i, MAX7219_MODE_TEST, 0);
		spi_transfer(i, MAX7219_MODE_SCAN_LIMIT, 7);
		spi_transfer(i, MAX7219_MODE_DECODE, 0);
		spi_transfer(i, MAX7219_MODE_INTENSITY, 4);
		spi_transfer(i, MAX7219_MODE_POWER, 1);
	}
}

void set_intensity_led_matrix(uint8_t addr, uint8_t value)
{
	spi_transfer(addr, MAX7219_MODE_INTENSITY, value);
}



void set_led_matrix(uint8_t addr, uint8_t row, uint8_t col, uint8_t state)
{
	if(addr<0 || addr>=3)
        return;
    if(row<0 || row>7 || col<0 || col>7)
        return;
    uint8_t offset = addr*8;
    uint8_t val = 0x80 >> col;
    if(state)
        status[offset+row]=status[offset+row]|val;
    else {
        val=~val;
        status[offset+row]=status[offset+row]&val;
    }
    spi_transfer(addr, row+1,status[offset+row]);
}

void set_row_led_matrix(uint8_t addr, uint8_t row, uint8_t value)
{
    if(addr<0 || addr>=3)
        return;
    if(row<0 || row>7)
        return;
    uint8_t offset=addr*8;
    status[offset+row]=value;
    spi_transfer(addr, row+1,status[offset+row]);
}
