/*
 * test 2:   Introduction to I/O ports(Complementary)
 * 
 * 
 * Created:  3/7/2021 9:11:54 PM
 * Author:   Maryam Saeedmehr
 * Std.NO:   9629373
 */

#include "configuration.h"

// Global Variables definition ------------------------------------------
unsigned char i; // for-loop variable
unsigned char number; /* variable for subRoutine5 -> number = PINA
and for subRoutine3 used as a temporary variable */
unsigned char number_digit[4] = {0}; // separated number's digits
flash unsigned char digit[] = {
    // to show digits in 7-segments
    0x3F, // 0
    0x06, // 1
    0x5B, // 2
    0x4F, // 3
    0x66, // 4
    0x6D, // 5
    0x7D, // 6
    0x07, // 7
    0x7F, // 8
    0x6F  // 9
};

// I/O configuration -----------------------------------------------------
void ioConfiguration(char portSel, char config){
    switch (portSel)
    {
    case 1:
        DDRA = config;
        break;
    case 2:
        DDRB = config;
        break;
    case 3:
        DDRC = config;
        break;
    case 4:
        DDRD = config;
        break;
    default:
        return;
    }
}

// Subroutines Implementation ---------------------------------------------
void subRoutine1(char portSel, char turningOn, uint16_t delay)
{
    switch (portSel)
    {
    case 1:
        for (i = 0; i < turningOn; i++)
        {
            PORTA = 0xFF; // turn on all LEDs
            delay_ms(delay);
            PORTA = 0x00; // turn off all LEDs
            delay_ms(delay);
        }
        break;
    case 2:
        for (i = 0; i < turningOn; i++)
        {
            PORTB = 0xFF; // turn on all LEDs
            delay_ms(delay);
            PORTB = 0x00; // turn off all LEDs
            delay_ms(delay);
        }
        break;
    case 3:
        for (i = 0; i < turningOn; i++)
        {
            PORTC = 0xFF; // turn on all LEDs
            delay_ms(delay);
            PORTC = 0x00; // turn off all LEDs
            delay_ms(delay);
        }
        break;
    case 4:
        for (i = 0; i < turningOn; i++)
        {
            PORTD = 0xFF; // turn on all LEDs
            delay_ms(delay);
            PORTD = 0x00; // turn off all LEDs
            delay_ms(delay);
        }
        break;
    default:
        return;
    }
}

void subRoutine2(char x, uint16_t duration)
{
    for (i = 0; i < 8; i++)
    {
        PORTB = 1 << (i + x - 1) % 8; // turn on i'th LED
        delay_ms(duration/8); // 8*duration/8 ms = duration sec
    } 
    PORTB = 0x00;
}

void subRoutine3(char inPort, char outPort)
{
    switch (inPort)
    {
    case 1:
        number = PINA;
        break;
    case 2:
        number = PINB;
        break;
    case 3:
        number = PINC;
        break;
    case 4:
        number = PIND;
        break;
    default:
        return;
    }
    switch (outPort)
    {
    case 1:
        PORTA = number;
        break;
    case 2:
        PORTB = number;
        break;
    case 3:
        PORTC = number;
        break;
    case 4:
        PORTD = number;
        break;
    default:
        return;
    }
}

void subRoutine4(char direction, char segment)
{
    switch (segment)
    {
    case 1:
        PORTD = 0X0E; // enable first segment 
        break;
    case 2:
        PORTD = 0X0D; // enable second segment 
        break;
    case 3:
        PORTD = 0X0B; // enable third segment 
        break;
    case 4:
        PORTD = 0X07; // enable fourth segment 
        break;
    case 5:
        PORTD = 0X00; // enable all 7-segments 
        break;
    default:
        return;
    }

    switch (direction)
    {
    case 0: // up
        for (i = 0; i < 10; i++)
        {
            // in unsigned char : 0x00 - 0x01 = 0xFF
            // so stop condition is "i != 0xFF"  
            PORTC = digit[i];
            delay_ms(1000);
        }
        break;
    case 1: // down
        for (i = 9; i != 0xFF; i--)
        {
            // in unsigned char : 0x00 - 0x01 = 0xFF
            // so stop condition is "i != 0xFF"  
            PORTC = digit[i];
            delay_ms(1000);
        }
        break;
    default:
        return;
    }
}

void subRoutine5(char stepSize)
{
    number = PINA;
    while (number != 0)
    {
        // extract decimal digits---------------------------
        number_digit[1] = (number) % 10; // ones
        number_digit[2] = (number / 10) % 10; // tens
        number_digit[3] = (number / 100) % 10; // hundreds

        // set 7-segments ----------------------------------
        for (i = 0; i < 20; i++)
        {
            PORTD = ~( 1 << i%4 ); 
            /* 
            * 0b1111_1110 -> set hundreds
            * 0b1111_1101 -> set tens
            * 0b1111_1011 -> set ones
            * 0b1111_0111 -> set one tenth
            */
            PORTC = i%4 == 2 
                    ? digit[number_digit[1]] | 0x80 // turn on DP
                    : digit[number_digit[3-i%4]];
            delay_ms(5);
        }
        // 20 * 5 = 100ms -> frequency = 100ms

        // reduce 0.1*stepSize ------------------------------
        if (stepSize > 10 || stepSize < 1) return;
        if (number_digit[0]<stepSize)
        {
            number_digit[0] = 10 + (number_digit[0] - stepSize);
            number--;
        }
        else
        {
            number_digit[0] -= stepSize;
        }
    }
}