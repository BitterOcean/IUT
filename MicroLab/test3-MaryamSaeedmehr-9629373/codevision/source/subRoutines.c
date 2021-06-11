#include "test3Lib.h"

// Variable definition -----------------------------------------------------
unsigned char i; // for-loop variable
unsigned char j; // for-loop variable
unsigned char digit = '0'; // which key is pushed? (Interrupt)
unsigned char newDigit; // used in subRoutine5
flash unsigned char data_key[4][4] = {
    // keypad data
    {'0','1','2','3'},
    {'4','5','6','7'},
    {'8','9','A','B'},
    {'C','D','E','F'}
};
char* covid = "Welcome to the online lab classes due to Corona disease";
char* lcd_screen = "0000000000000000"; /* used in subRoutine2 
for scrolling string. initialized with "0000000000000000" to 
not have problem with clearing the lcd. */
uint8_t speed; // used in subRoutine5 (0-50 r)
uint8_t time; // used in subRoutine5 (0-99 s)
uint8_t weigt; // used in subRoutine5 (0-99 F)
uint8_t temp; // used in subRoutine5 (20-80 C)
char* result = "00000000000000000000000000000000"; // store the result of subRoutine5

// Interrupt Handler ------------------------------
interrupt [EXT_INT1] void ext_int0_isr(void){
    // External Interrupt 0 service routine  
    PORTC = 0x01;
    for (i = 0; i < 4; i++){ //row
        PORTB = 1 << (i + 4); //portB.4 to portB.8 are rows
        for (j = 0; j < 4; j++){ //column
            if ((PINB&(1<<j))==(1<<j)){
                if(data_key[i][j]!='F')
                    lcd_putchar(data_key[i][j]);
                digit = data_key[i][j];
                newDigit = 1;
            } 
        }
    }
    PORTC = 0x00;
    PORTB = 0xFF;
}

// SubRoutines Implementation -----------------------------------------------
void subRoutine1(){
    lcd_clear();
    lcd_puts(myName);
    lcd_gotoxy(line2x,line2y); // go to next line
    lcd_puts(stdNO);
    delay_ms(1500);
}

void subRoutine2(char* str){
    lcd_clear();
    for (i = 0; i <= strlen(str); i++){
        delay_ms(100); 
        lcd_clear();   
        strncpy(lcd_screen,str + i,16);
        lcd_puts(lcd_screen);
    }
}

void subRoutine3(){
    while (1){    
        for (i = 0; i < 4; i++){ //row
            PORTB = 1 << (i + 4); //portB.4 to portB.8 are rows
            for (j = 0; j < 4; j++){ //column
                if ((PINB&(1<<j))==(1<<j)){
                    lcd_clear();
                    lcd_putchar(data_key[i][j]);
                    delay_ms(100);
                    if(data_key[i][j]=='F'){ //End condition
                        delay_ms(700);
                        subRoutine2(endSub3);
                        return;
                    }   
                }
            }
        }
    }
}

void subRoutine4(){
    PORTB = 0xFF;
}

void subRoutine5(){  
    // Speed -----------------------------------
    newDigit = 0;
    lcd_clear();
    lcd_puts(SPEED);
    speed = 0;
    while(1){
        if((digit!='F') && newDigit){
            newDigit = 0;
            speed = speed * 10 + (digit - '0');
        }
        else if ((digit=='F') && speed>50){
            newDigit = 0;
            lcd_clear();
            lcd_puts(SPEED);
            lcd_puts(Error);
            delay_ms(400);
            lcd_clear();
            lcd_puts(SPEED);
            digit = '0';
            speed = 0;
        }
        else if ((digit=='F') && (speed>=0 && speed<=50))
            break;
    }
    // Time -------------------------------------
    newDigit = 0;
    digit = '0';
    lcd_clear();
    lcd_puts(TIME);
    time = 0;
    while(1){
        if((digit!='F') && newDigit){
            newDigit = 0;
            time = time * 10 + (digit - '0');
        }
        else if ((digit=='F') && time>99){
            newDigit = 0;
            lcd_clear();
            lcd_puts(TIME);
            lcd_puts(Error);
            delay_ms(400);
            lcd_clear();
            lcd_puts(TIME);
            digit = '0';
            time = 0;
        }
        else if ((digit=='F') && (time>=0 && time<=99))
            break;
    }
    // Weigt ------------------------------------
    newDigit = 0;
    digit = '0';
    lcd_clear();
    lcd_puts(WEIGT);
    weigt = 0;
    while(1){
        if((digit!='F') && newDigit){
            newDigit = 0;
            weigt = weigt * 10 + (digit - '0');
        }
        else if ((digit=='F') && weigt>99){
            newDigit = 0;
            lcd_clear();
            lcd_puts(WEIGT);
            lcd_puts(Error);
            delay_ms(400);
            lcd_clear();
            lcd_puts(WEIGT);
            digit = '0';
            weigt = 0;
        }
        else if ((digit=='F') && (weigt>=0 && weigt<=99))
            break;
    }
    // Temp -------------------------------------
    newDigit = 0;
    digit = '0';
    lcd_clear();
    lcd_puts(TEMP);
    temp = 0;
    while(1){
        if((digit!='F') && newDigit){
            newDigit = 0;
            temp = temp * 10 + (digit - '0');
        }
        else if ((digit=='F') && (temp<20 || temp>80)){
            newDigit = 0;
            lcd_clear();
            lcd_puts(TEMP);
            lcd_puts(Error);
            delay_ms(400);
            lcd_clear();
            lcd_puts(TEMP);
            digit = '0';
            temp = 0;
        }
        else if ((digit=='F') && (temp>=20 && temp<=80))
            break;
    }
    // Final ------------------------------------
    sprintf(result,
            "Speed:%2d Time:%2d Weigt:%2d Temp:%2d",
            speed,time,weigt,temp);

}