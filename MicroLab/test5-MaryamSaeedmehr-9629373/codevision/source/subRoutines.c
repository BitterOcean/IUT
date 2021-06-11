#include "test5_lib.h"

uint8_t counter = 0; 
uint8_t Stepper = Left;
uint8_t duty_cycle;      

interrupt [TIM0_COMP] void timer0_comp_isr(void){
  duty_cycle = PINA;
  duty_cycle = (0.38 * (duty_cycle)) + 5;
  duty_cycle = (duty_cycle * 2.56) - 1;
  OCR0 = duty_cycle; 
}
 
interrupt [TIM2_OVF] void timer2_ovf_isr(void){
  if (counter <= 50){
    unsigned char temp1 = PORTB.4;
    unsigned char temp2 = PORTB.5;
    unsigned char temp3 = PORTB.6;
    unsigned char temp4 = PORTB.7;
    
    PORTB.4 = temp4;
    PORTB.5 = temp1;
    PORTB.6 = temp2;
    PORTB.7 = temp3; 
    
    Stepper = Right;
    PORTD.0 = 0;
    PORTD.1 = 1; 
  }
  
  else if (counter>100 && counter <=150){
    unsigned char temp1 = PORTB.4;
    unsigned char temp2 = PORTB.5;
    unsigned char temp3 = PORTB.6;
    unsigned char temp4 = PORTB.7;
    
    PORTB.4 = temp2;
    PORTB.5 = temp3;
    PORTB.6 = temp4;
    PORTB.7 = temp1;
  
    Stepper = Left;
    PORTD.0 = 1;
    PORTD.1 = 0;
  } 
  
  else{
    PORTD.0 = 0;
    PORTD.1 = 0;
  }   
  
  if (counter==0 || counter==101){
    lcd_clear();
    lcd_gotoxy(0, 0);
    lcd_puts("9000 (rpm)");
  }
  else if (counter == 51){
    lcd_clear();
    lcd_gotoxy(0, 0);
    lcd_puts("0 (rpm)");
  }
  
  counter = (counter + 1) % 150;      
}
 
void subRoutine1(){
  delay_ms(5000);

  // 10 % duty cycle (17 rpm)
  TCNT0 = 0x00;
  lcd_clear();
  lcd_puts("Duty Cycle = 10%");
  OCR0 = 0x1A;
  
  delay_ms(5000); 
  
  // 30 % duty cycle (50 rpm)
  TCNT0 = 0x00;
  lcd_clear();
  lcd_puts("Duty Cycle = 30%");
  OCR0 = 0x4D;
  
  delay_ms(5000); 
  
  // 50 % duty cycle (84 rpm)
  TCNT0 = 0x00;
  lcd_clear();
  lcd_puts("Duty Cycle = 50%");
  OCR0 = 0x80;
  
  delay_ms(5000); 
  
  // 70 % duty cycle (116 rpm)
  TCNT0 = 0x00;
  lcd_clear();
  lcd_puts("Duty Cycle = 70%");
  OCR0 = 0xB2;
  
  delay_ms(5000); 
  
  // 90 % duty cycle (149 rpm)
  TCNT0 = 0x00;
  lcd_clear();
  lcd_puts("Duty Cycle = 90%");
  OCR0 = 0xE5;
}
 
void subRoutine3(){               
  duty_cycle = PINA;
  duty_cycle = (0.38 * (duty_cycle)) + 5;
  duty_cycle = (duty_cycle * 2.56) - 1;
  TCNT0 = 0x00;
  OCR0 = duty_cycle; 
} 
 
void subRoutine4(){   
  PORTB.4 = 1;
  PORTB.5 = 0;
  PORTB.6 = 0;
  PORTB.7 = 0;  
}
