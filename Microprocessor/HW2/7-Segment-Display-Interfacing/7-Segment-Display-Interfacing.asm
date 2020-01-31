;
; EXC2_Q8.asm
;
; Created: 12/3/2019 11:02:58 PM
; Author : Maryam Saeedmehr
;

;Program to sequence LEDs on port C, using a look up table 

;Register Definitions 
		.def leds =r0 ;Register to store data pointed to by Z 
		.def temp =r16 ;Temporary storage register 
		.def controler=r17 ;Check not to go more than 9 or less than 0

;Program Initialisation 
;Set stack pointer to end of memory 
		ldi temp,high(RAMEND) 
		out SPH,temp ;Load high byte of end of memory address 
		ldi temp,low(RAMEND) 
		out SPL,temp ;Load low byte of end of memory address 
;Initialise output ports 
		ldi temp,$ff 
		out DDRC,temp ;Set Port C for output by sending $FF to direction register 
;Initialise input ports  
		cbi DDRB,0 ;Set Port B.0 for input by sending ; Incrementing Switch
		cbi DDRB,7 ;Set Port B.7 for input by sending ; Decrementing Switch

;Delay Subroutine (25.349 ms @ 1MHz) 
.macro delay
		ldi YH,high($FFFF) ;Load high byte of Y 
		ldi YL,low($FFFF) ;Load low byte of Y 
		loop:	sbiw Y,1 ;Decrement Y 
				brne loop ;and continue to decrement until Y=0 
.endmacro


;Main Program 
reset:	ldi ZL,low(table*2) ;Set Z pointer to start of table 
		ldi ZH,high(table*2)
		clr controler
		lpm ;Load R0 with data pointed to by Z 
		out PORTC,leds ;and display data on port C 
always:	sbic PINB,0
		rjmp incr
		sbic PINB,7
		rjmp decr
		rjmp always
incr:	delay
		adiw ZL,1 ;Increment Z to point to next location in table 
		lpm ;Load R0 with data pointed to by Z 
		out PORTC,leds ;and display data on port C 
		inc controler
		cpi controler,10
		breq reset
		rjmp always
decr:	delay
		sbiw ZL,1 ;Decrement Z to point to previous location in table 
		lpm ;Load R0 with data pointed to by Z 
		out PORTC,leds ;and display data on port C 
		dec controler
		cpi controler,-1
		breq reset
		rjmp always	

table: .DB $3F,$06,$5B,$4F,$66,$6D,$7D,$07,$7F,$6F

/*
								" FOR COMMON CATHODE 7 SEGMENT "

		HEX NUM	|dot=C.7|g=C.6	|f=C.5	|e=C.4	|d=C.3	|c=C.2	|b=C.1	|a=C.0	| HEX DECODED
	   ----------------------------------------------------------------------------------------
		   0	|0		|0		|1		|1		|1		|1		|1		|1		| $3F
		   1	|0		|0		|0		|0		|0		|1		|1		|0		| $06
		   2	|0		|1		|0		|1		|1		|0		|1		|1		| $5B
		   3	|0		|1		|0		|0		|1		|1		|1		|1		| $4F
		   4	|0		|1		|1		|0		|0		|1		|1		|0		| $66
		   5	|0		|1		|1		|0		|1		|1		|0		|1		| $6D
		   6	|0		|1		|1		|1		|1		|1		|0		|1		| $7D
		   7	|0		|0		|0		|0		|0		|1		|1		|1		| $07
		   8	|0		|1		|1		|1		|1		|1		|1		|1		| $7F
		   9	|0		|1		|1		|0		|0		|1		|1		|1		| $67
											  ________
											 _|__a___|_
											|f|______|b|
											|_|	 g 	 |_|
											|e|______|c|	
											|_|______|_|	
											  |__d___|	 |dot|
											  
*/