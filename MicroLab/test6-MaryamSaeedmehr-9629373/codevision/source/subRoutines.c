#include "test6_lib.h"

uint8_t i = 0; 
uint8_t duty_cycle;
uint16_t result = 0;
uint16_t adc = 0;

interrupt [TIM0_COMP] void timer0_comp_isr(void){
  duty_cycle = read_adc(0); // read duty cycle from adc
  duty_cycle = (duty_cycle * 0.087) + 5; // transformation duty_cycle (5-95)%
  duty_cycle = (duty_cycle * 2.56) - 1; // calculate ocr accrding to duty_cycle    
  OCR0 = duty_cycle;
}
 
void subRoutine1(){   
  Q1_adc_init();
  lcd_puts("Subroutine 1 :");
  for (i = 0; i < 8; i++){
    char str[16];
    result = read_adc(i);
    result = result * 4.887;
    lcd_gotoxy(line2x, line2y);
    sprintf(str, "adc%d = %4d (mv)", i, result); 
    lcd_puts(str);
    delay_ms(1000);
  }
}
 
void subRoutine2(){
  Q2_adc_init();
  lcd_clear();
  lcd_puts("Subroutine 2 :");
  for (i = 0; i < 8; i++){
    char str[16];
    if (abs(adc_data[i] - adc_data_copy[i]) >= (adc_data[i]/20)){
      lcd_gotoxy(line2x, line2y); 
      result = adc_data[i] * 4.887;
      sprintf(str, "adc%d = %4d (mv)", i, adc_data[i]); 
      lcd_puts(str);
      delay_ms(1000);
    } 
    adc_data_copy[i] = adc_data[i];
  }
} 
 
void subRoutine3(){   
  timer_init();
  Q1_adc_init();
  lcd_clear();
  lcd_puts("Subroutine 3 :");
  while(1){
    char str[16];
    adc = 0;
    duty_cycle = 0;
    adc = read_adc(0);                      // read duty cycle from adc
    duty_cycle = (adc * 0.087) + 5;         // transformation duty_cycle (5-95)%
    sprintf(str,"duty cycle = %d",duty_cycle);
    duty_cycle = (duty_cycle * 2.56) - 1;   // calculate ocr accrding to duty_cycle
    lcd_gotoxy(line2x, line2y);
    lcd_puts(str);
    OCR0 = duty_cycle;
  }
}