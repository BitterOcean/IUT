/*
 * test 4:   Introduction to LCD, interrupts and timers
 * -----------------------------------------------------------------
 * Created:  22/3/2021
 * Author:   Maryam Saeedmehr
 * Std.NO:   9629373
 */
#ifndef _BOARD_INIT_INCLUDED_
#define _BOARD_INIT_INCLUDED_

void io_init();
void timer_init();
void interrupt_init();
void lcd_puts_init();
void board_init();

#endif