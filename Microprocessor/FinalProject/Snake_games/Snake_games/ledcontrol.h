/*
*	INTERACTION CODE FOR MAX7219 WITH TWO 8X8 LED
*	MATRICES WRITTEN FOR ATMEGA32 @16MHZ
*/
#ifndef _LEDCONTROL_H
#define _LEDCONTROL_H

typedef unsigned char   uint8_t;
typedef unsigned int    uint16_t;

void init_led_matrix(uint8_t num_devices);
void set_intensity_led_matrix(uint8_t addr, uint8_t value);
void clear_led_matrix(uint8_t addr);
void set_led_matrix(uint8_t addr, uint8_t row, uint8_t col, uint8_t state);
void set_row_led_matrix(uint8_t addr, uint8_t row, uint8_t value);
void spi_send_byte (uint8_t databyte);
void spi_transfer(uint8_t addr, uint8_t opcode, uint8_t data);

#endif
