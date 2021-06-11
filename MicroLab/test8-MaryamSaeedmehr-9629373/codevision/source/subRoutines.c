#include "test8_lib.h"

uint8_t i, j, k; 
unsigned short name[] = {
  0xFF, 0x81, 0xF1, 0xE3, 0xE3, 0xF1, 0x81, 0xFF, // code for char M 
  0xFF, 0xA1, 0xA1, 0xAD, 0xAD, 0x8D, 0x8D, 0xFF, // code for char S
  0xFF, 0x81, 0xF1, 0xE3, 0xE3, 0xF1, 0x81, 0xFF, // code for char M 
  0xFF, 0xA1, 0xA1, 0xAD, 0xAD, 0x8D, 0x8D, 0xFF  // code for char S
};

uint8_t set_portD(uint8_t a, uint8_t b, uint8_t size) {
  if (b-a < size) 
    return 0; 
  return 1;
}

uint16_t set_portA(uint8_t num) {
  return pow(2, num);
}


void subRoutine1(uint8_t round) {
  for(k = 0 ; k < round ; k++) {
    for (i = 0 ; i < 16 ; i++) {
      for (j = i ; j < i + 16 ; j++) { 
        PORTD.7 = set_portD(i, j, 8); 
        PORTA = set_portA((j-i)%8);
        PORTB = name[j];
        delay_ms(3);    
      }
    }   
  }  
}

void subRoutine2() {
  glcd_putimagef(0, 0, picture,GLCD_PUTCOPY);
}

void subRoutine3() {
  _timer_init_();
  #asm("sei");
  update_clock();
}