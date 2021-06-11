#ifndef _Usart_INCLUDED_
#define _Usart_INCLUDED_

#define DATA_REGISTER_EMPTY (1<<UDRE)
#define RX_COMPLETE (1<<RXC)
#define FRAMING_ERROR (1<<FE)
#define PARITY_ERROR (1<<UPE)
#define DATA_OVERRUN (1<<DOR)

// USART Receiver buffer
#define RX_BUFFER_SIZE 8
extern char rx_buffer[RX_BUFFER_SIZE];

#if RX_BUFFER_SIZE <= 256
extern unsigned char rx_wr_index,rx_rd_index;
#else
extern unsigned int rx_wr_index,rx_rd_index;
#endif

#if RX_BUFFER_SIZE < 256
extern unsigned char rx_counter;
#else
extern unsigned int rx_counter;
#endif
// This flag is set on USART Receiver buffer overflow
extern bit rx_buffer_overflow;

// USART Receiver interrupt service routine
interrupt [USART_RXC] void usart_rx_isr(void);

#ifndef _DEBUG_TERMINAL_IO_
// Get a character from the USART Receiver buffer
#define _ALTERNATE_GETCHAR_
#pragma used+
char getchar(void);
#pragma used-
#endif

// USART Transmitter buffer
#define TX_BUFFER_SIZE 8
extern char tx_buffer[TX_BUFFER_SIZE];

#if TX_BUFFER_SIZE <= 256
extern unsigned char tx_wr_index,tx_rd_index;
#else
extern unsigned int tx_wr_index,tx_rd_index;
#endif

#if TX_BUFFER_SIZE < 256
extern unsigned char tx_counter;
#else
extern unsigned int tx_counter;
#endif

interrupt [USART_TXC] void usart_tx_isr(void);

#ifndef _DEBUG_TERMINAL_IO_
// Write a character to the USART Transmitter buffer
#define _ALTERNATE_PUTCHAR_
#pragma used+
void putchar(char c);
#pragma used-
#endif

extern int flag;

#endif