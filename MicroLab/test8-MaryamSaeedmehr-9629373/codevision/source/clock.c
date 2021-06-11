#include "test8_lib.h"

uint8_t second = 20;
uint8_t minute = 10;
uint8_t hour = 1;
char* digital_time = "  :  :  ";

float radian(float degree) {
  return degree*(3.14/180.0);
}

void my_line(uint8_t amount, uint8_t mode) {
  if(mode==0) { //second
    glcd_line(32, 31, 32+(29*sin(radian(6*amount))), 31-(29*cos(radian(6*amount))));
  }

  else if(mode==1) { //minute
    glcd_line(32, 31, 32+(25*sin(radian(6*amount))), 31-(25*cos(radian(6*amount))));
  }  

  else if(mode==2) { //hour
    glcd_line(32, 31, 32+(20*sin(radian(30*amount))), 31-(20*cos(radian(30*amount))));
  }   
}

void update_clock() {
  glcd_clear(); 
  glcd_putimagef(0, 0, clock, GLCD_PUTCOPY);
  my_line(second, 0);
  my_line(minute, 1);
  my_line(hour, 2);

  sprintf(digital_time, "%d:%d:%d   ", hour, minute, second); 
  glcd_outtextxy (70, 30, digital_time);   
    
  glcd_outtextxy(0, 0, " ");   
  glcd_outtextxy(32, 50, "6");    
  glcd_outtextxy(50, 32, "3");
  glcd_outtextxy(4, 32, "9");
  glcd_outtextxy(27, 3, "12");
                
  glcd_circle (32, 31, 30);  
}

interrupt [TIM1_OVF] void timer1_ovf_isr(void) {
  // Reinitialize Timer1 value
  TCNT1H=0x85EE >> 8;
  TCNT1L=0x85EE & 0xff;

  second++;
  if(second==60) {
    second=0;
    minute++;
    if(minute==60) {
      minute=0;
      hour++;
      if(hour==12) {
        hour=0;
      }
    }
  }                               
  update_clock();
}
