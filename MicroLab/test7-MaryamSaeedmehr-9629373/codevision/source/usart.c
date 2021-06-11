#include "test7_lib.h"

// USART Receiver buffer
#define RX_BUFFER_SIZE 8
char rx_buffer[RX_BUFFER_SIZE];

#if RX_BUFFER_SIZE <= 256
unsigned char rx_wr_index=0,rx_rd_index=0;
#else
unsigned int rx_wr_index=0,rx_rd_index=0;
#endif

#if RX_BUFFER_SIZE < 256
unsigned char rx_counter=0;
#else
unsigned int rx_counter=0;
#endif

// This flag is set on USART Receiver buffer overflow
bit rx_buffer_overflow;

int flag = 0;

// USART Receiver interrupt service routine
interrupt [USART_RXC] void usart_rx_isr(void){
  char status,data;
  status=UCSRA;
  data=UDR;
  if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0){
    rx_buffer[rx_wr_index++]=data;
    #if RX_BUFFER_SIZE == 256
      // special case for receiver buffer size=256
      if (++rx_counter == 0) rx_buffer_overflow=1;
    #else
      if (rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
      if (++rx_counter == RX_BUFFER_SIZE){
        rx_counter=0;
        rx_buffer_overflow=1;
      }
    #endif
  }
  
  if (flag == 0) {
    //subRoutine3(data);
    flag = 1;
  } 
}

char getchar(void){
  char data;
  while (rx_counter==0);
  data=rx_buffer[rx_rd_index++];
  #if RX_BUFFER_SIZE != 256
  if (rx_rd_index == RX_BUFFER_SIZE) rx_rd_index=0;
  #endif
  #asm("cli")
  --rx_counter;
  #asm("sei")
  return data;
}

// USART Transmitter buffer
#define TX_BUFFER_SIZE 8
char tx_buffer[TX_BUFFER_SIZE];

#if TX_BUFFER_SIZE <= 256
unsigned char tx_wr_index=0,tx_rd_index=0;
#else
unsigned int tx_wr_index=0,tx_rd_index=0;
#endif

#if TX_BUFFER_SIZE < 256
unsigned char tx_counter=0;
#else
unsigned int tx_counter=0;
#endif

// USART Transmitter interrupt service routine
interrupt [USART_TXC] void usart_tx_isr(void){
  if (tx_counter){
    --tx_counter;
    UDR=tx_buffer[tx_rd_index++];
    #if TX_BUFFER_SIZE != 256
      if (tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
    #endif
    }
}

#ifndef _DEBUG_TERMINAL_IO_
// Write a character to the USART Transmitter buffer
#define _ALTERNATE_PUTCHAR_
#pragma used+
void putchar(char c){
  while (tx_counter == TX_BUFFER_SIZE);
  #asm("cli")
  if (tx_counter || ((UCSRA & DATA_REGISTER_EMPTY)==0)){
    tx_buffer[tx_wr_index++]=c;
    #if TX_BUFFER_SIZE != 256
      if (tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
    #endif
    ++tx_counter;
  }
  else
    UDR=c;
  #asm("sei")
}
#pragma used-
#endif