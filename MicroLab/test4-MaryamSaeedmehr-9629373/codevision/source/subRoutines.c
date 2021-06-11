#include "test4_lib.h"

// ----------------------------------------------------
uint8_t houre = 0;
uint8_t minute = 0;
uint8_t second = 0;
uint8_t hundredth_of_a_second = 0;
uint8_t parking_empty_capacity = maxParkingCapacuty;
uint8_t period = 255;
uint16_t in_period;
uint16_t temp;
char which_one_is_clicked = stop;
char timer0_error_handler = 0;
char* LCD_line1_template = "00:00:00:00";
char* LCD_line2_parking_template = "CE:0000**";
char* LCD_line2_period_template = "0000000";

// ---------------------------------------------------- 
// for mapping betwee period range [1 us, 10'000 us]  
// with PORTA that can differ in range [0, 255] 
long map(
    long x, 
    long in_min, 
    long in_max, 
    long out_min, 
    long out_max)
{
    return (x - in_min) * 
           (out_max - out_min) / 
           (in_max - in_min) + 
           out_min;
}

// ----------------------------------------------------
// External Interrupt 0 service routine
interrupt [EXT_INT0] void ext_int0_isr(void){
    subRoutine2();
}

// External Interrupt 1 service routine
interrupt [EXT_INT1] void ext_int1_isr(void){
    if (which_one_is_clicked == stop && 
            StopButton == isClicked){
        // STOP is double clicked
        houre = reset;
        minute = reset;
        second = reset;
        hundredth_of_a_second = reset;
    }
    which_one_is_clicked = (
        StartButton == isClicked 
        ? start
        : stop
        );
}

// External Interrupt 2 service routine
interrupt [EXT_INT2] void ext_int2_isr(void){
    period = inputPeriodPin;
    subRoutine3();
}

// Timer 0 overflow interrupt service routine
interrupt [TIM0_OVF] void timer0_ovf_isr(void){
    // Reinitialize Timer 0 value
    TCNT0=0x83;

    // this timer generate 1ms but I need 10ms so:
    if (timer0_error_handler != 10){
        timer0_error_handler++;
    }
    else { // timer0_error_handler == 10 => 10ms delay generated !
        timer0_error_handler = 0;

        if (which_one_is_clicked == start){
            subRoutine1();
        }
        sprintf(LCD_line1_template,
                "%2d:%2d:%2d:%2d",
                houre,minute,second,hundredth_of_a_second);
        lcd_gotoxy(line1x, line2x);
        lcd_puts(LCD_line1_template);
    }
}

// Timer1 overflow interrupt service routine
interrupt [TIM1_OVF] void timer1_ovf_isr(void){
    // Reinitialize Timer1 value
    temp = map(period,0,255,1,10000) * microUnit * OCRconstant;
    TCNT1H= temp >> 8;
    TCNT1L= temp & 0xff;
}

// ----------------------------------------------------
void subRoutine1(){
    /* a Stopwatch with accuracy of 0.01 second */
    if (hundredth_of_a_second == maxOfHundredthOfSecond){
        hundredth_of_a_second = reset;

        if (second == maxOfSecond){
            second = reset;

            if (minute == maxOfMinute){
                minute = reset;

                houre = (
                    houre !=maxOfHoure
                    ? houre + 1 
                    : reset
                    ) ; 
            }
            else{minute++;}   
        }
        else{second++;}
    }
    else{hundredth_of_a_second++;}
}

void subRoutine2(){
    /* a system to show empty parking capacity */
    if (Car_in_Button == isClicked && 
            parking_empty_capacity > 0){
        parking_empty_capacity--;
    }
    else if (Car_out_Button == isClicked && 
            parking_empty_capacity < maxParkingCapacuty){
        parking_empty_capacity++;
    }
    if (parking_empty_capacity == full){
        sprintf(LCD_line2_parking_template,
                "CE:FULL**");
    }
    else {
        sprintf(LCD_line2_parking_template,
                "CE:%4d**", parking_empty_capacity);
    }
    lcd_gotoxy(line2x, line2y);// go to next line
    lcd_puts(LCD_line2_parking_template);
}

void subRoutine3(){
    /* generate square wave with period of <PINA> */
    in_period = map(period,0,255,1,10000); 
    if (in_period % 1000 == 0){
        sprintf(LCD_line2_period_template, "%4dMS0", in_period/1000);
    }
    else {
        sprintf(LCD_line2_period_template, "%4dUS0", in_period);
    }
    lcd_gotoxy(line2x, line2y);
    lcd_puts(LCD_line2_parking_template);
    lcd_puts(LCD_line2_period_template);
}