/*
 * test 1:   Introduction to I/O ports
 *
 * Created:  3/1/2021 12:09:42 PM
 * Author:   Maryam Saeedmehr
 * Std.NO:   9629373
 */
#include <io.h> 
#include <delay.h>

// Global Variables -------------------------------------------------------
unsigned char i; // for-loop variable
unsigned char number; // variable for subRoutine5,6 -> number = PINA
unsigned char reset; // variable for subRoutine6 -> reset = PIND
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

// Function Declaration ---------------------------------------------------
void subRoutine1(); // turn on all LEDs 4 time (0.5s delay)
void subRoutine2(); // scrolling dot light for 3s
void subRoutine3(); // show port A on LEDs
void subRoutine4(); // count down from 9 to 0 on all 7-segments
void subRoutine5(); // count down from PortA to 0 by 0.2 steps
void subRoutine6(); // subRoutine5 with reset option for each digit

// Main Function ----------------------------------------------------------
void main(void)
{
    // port configuration -------
    DDRA = 0x00; // input
    DDRB = 0xFF; // output
    DDRC = 0xFF; // output
    DDRD = 0x0F; // input{4 MSB}-output{4 LSB}

    // flowchart ----------------
    subRoutine1();
    subRoutine2();
    subRoutine4();
    
    while (1)
    {
        subRoutine3();
        subRoutine5();
        subRoutine6();
    }
}

// Function Implementation ------------------------------------------------
void subRoutine1()
{
    for (i = 0; i < 4; i++)
    {
        PORTB = 0xFF; // turn on all LEDs
        delay_ms(500);
        PORTB = 0x00; // turn off all LEDs
        delay_ms(500);
    }
}

void subRoutine2()
{
    for (i = 0; i < 8; i++)
    {
        PORTB = 1 << i; // turn on i'th LED
        delay_ms(420); // 7*420 ms = 2.94 sec ~ 3 sec
    } 
    PORTB = 0x00;
}

void subRoutine3()
{
    PORTB = PINA;
}

void subRoutine4()
{
    PORTD = 0X00; // enable all 7-segments 

    for (i = 9; i != 0xFF; i--)
    {
        // in unsigned char : 0x00 - 0x01 = 0xFF
        // so stop condition is "i != 0xFF"  
        PORTC = digit[i];
        delay_ms(1000);
    }
}

void subRoutine5()
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

        // reduce 0.2 ---------------------------------------
        if (!number_digit[0])
        {
            number_digit[0] = 8;
            number--;
        }
        else
        {
            number_digit[0] -= 2;
        }
    }
}

void subRoutine6()
{
    number = PINA;
    while (number != 0)
    {
        reset = PIND;
        // extract decimal digits (SAME AS SUBROUTINE 5)----
        number_digit[1] = (number) % 10; // ones
        number_digit[2] = (number / 10) % 10; // tens
        number_digit[3] = (number / 100) % 10; // hundreds

        // reset control -----------------------------------
        if (!(reset & (1 << 7)))
        {
            number_digit[3] = (PINA / 100) % 10; // reseting hundreds
        }
        if (!(reset & (1 << 6)))
        {
            number_digit[2] = (PINA / 10) % 10; // reseting tens
        }
        if (!(reset & (1 << 5)))
        {
            number_digit[1] = (PINA) % 10; // reseting ones
        }
        if (!(reset & (1 << 4)))
        {
            number_digit[0] = 0; // reseting one tenth
        }
        number = number_digit[3] * 100 +
                 number_digit[2] * 10 +
                 number_digit[1]; // updating the number

        
        // set 7-segments (SAME AS SUBROUTINE 5) -----------
        for (i = 0; i < 20; i++)
        {
            PORTD = ~( 1 << i%4 ); 
            PORTC = i%4 == 2 
                    ? digit[number_digit[1]] | 0x80
                    : digit[number_digit[3-i%4]];
            delay_ms(5);
        }

        if (!number_digit[0])
        {
            number_digit[0] = 8;
            number--;
        }
        else
        {
            number_digit[0] -= 2;
        }
    }
}