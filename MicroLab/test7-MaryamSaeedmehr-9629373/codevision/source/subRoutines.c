#include "test7_lib.h"

void subRoutine1(int budrate, int TX, int RX){   
  char s [10];                                                                                                        
  UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
  UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8); 
  UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
                                                    
  
  if (TX == ON || TX == Interrupt) 
    UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (1<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
  if (RX == ON || RX == Interrupt)
    UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);  
    
  if (TX == Interrupt) 
    UCSRB=(0<<RXCIE) | (1<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (1<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
  if (RX == Interrupt)
    UCSRB=(1<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);  
  
  budrate = 500000/budrate-1;
  
  sprintf(s, "%0x", budrate);  
  lcd_puts(s); 
  
  UBRRH = budrate & 0xFF00;
  UBRRL = budrate & 0x00FF ;   
}


void subRoutine2(){
  char str[14];
  char str2[17];
  Q2_Usart_init(); 
  
  gets(str, 14); 
  strcat(str2, "(");
  strcat(str2, str);
  strcat(str2,")"); 
  puts(str2);
  lcd_puts(str2);
}

void subRoutine3(char data){
  char str [10];
  if (data >= '0' && data <= '9'){  
    sprintf(str, "%d", (data - '0')*10);
    puts(str);  
    lcd_clear();
    lcd_gotoxy(0, 0);
    lcd_puts(str);
  } 
  else if (data == 'D' || data == 'd'){
    puts("LCD Delete"); 
    lcd_clear();
    lcd_gotoxy(0, 0);
    lcd_puts("LCD Delete");
  }
  else if (data == 'H' || data == 'h'){
    puts("MicroProcessor Lab"); 
    lcd_clear();
    lcd_gotoxy(0, 0);
    lcd_puts("MicroProcessor Lab");
  }
  else{
    puts("No Function Defined !"); 
    lcd_clear();
    lcd_gotoxy(0, 0);
    lcd_puts("No Function Defined !");
  }    
} 

void subRoutine4(){  
  int counter = 0, i=0; 
  int flagg = 0;
  char str [50], copy[6];
  char c; 
  
  Q4_Usart_init(); 
  while (1){   
    c = getchar();
    str[counter++] = c;
    if (c == ')'){ 
      if (counter == 7){
        for (i=1; i<=5; i++){    
          if (str[i] >= '0' && str[i] <= '9')
            flagg = 0;
          else
            flagg = 1;      
        }   
        if (flagg == 1){
          lcd_clear();
          lcd_gotoxy(0, 0);
          lcd_puts("Frame must be 5 integer");  
          puts("Frame must be 5 integer");
        }
        if (flagg == 0 && str[0] == '('){
          lcd_clear();
          lcd_gotoxy(0, 0);
          lcd_puts("Frame is Correct");
          puts("Frame is Correct");
          strncpy(copy, str+1, 5);  
          lcd_puts(copy);
          puts(copy); 
        }
      }
      else{
        lcd_clear();
        lcd_gotoxy(0, 0);
        lcd_puts("Lenght Of Frame is not Correct");  
        puts("Lenght Of Frame is not Correct"); 
      }
      
      counter = 0;
      flagg = 0;
    }    
  }
}