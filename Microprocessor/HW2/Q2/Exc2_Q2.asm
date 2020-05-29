;
; ExE2_Q2.asm
;
; Created: 12/2/2019 2:28:34 AM
; Author : Maryam Saeedmehr
;

; Program to count the number of ONEs in a binary number

// First Method------------------------------------------------

;Register Definitions 
		.def NUM =r16 ; 8 bit num
		.def RES =r17 ; Result reg.
		.def CNT =r18 ; Counter reg.
		.def TMP =R19 ; Template reg.

;Program Initialisation
		ldi NUM , 0b01010111 ; Example
		ldi RES , 0 
		ldi CNT , 8
		ldi TMP , 1

;Main Program 
Loop:	and TMP , NUM
		add RES , TMP
		lsr NUM
		dec CNT
		ldi TMP , 1
		brne Loop

;END of Program
END:	rjmp END

// Second Method------------------------------------------------

;Register Definitions 
		.def NUM =r16 ; 8 bit num
		.def RES =r17 ; Result reg.
		.def TMP =r18 ; Template reg.

;Program Initialisation
		ldi NUM , 0b01010111 ; Example
		ldi RES , 0 

;Main Program 
Loop:	ldi TMP , -1
		add TMP , NUM ; TMP := NUM - 1
		inc RES
		and NUM , TMP ; NUM := NUM & ( NUM - 1 )
		brne Loop

;END of Program
END:	rjmp END

// Third Method : Mapping numbers with the bit------------------

/*
It simply maintains a Map(or array) of
numbers to bits for a nibble. A nibble
contains 4 bits. So we need an array up
to 16.
int num_to_bits[16]={0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4}
*/

.org 0
;Register Definitions 
		.def NUM =r16 ; 8 bit num
		.def RES =r17 ; Result reg.
		.def NIB =r18 ; Nibble reg.
		.def LTDATA =r19 ; Return DATA from LOOKUP TABLE

;Program Initialisation
		ldi NUM , 0b01010111 ; Example
		ldi RES , 0 
		ldi NIB , 0x0f ; find first nibble

;Main Program 
		and NIB , NUM
		// r20 = low byte of mydata
		ldi zh , high(mydata << 1)
		ldi zl , low(mydata << 1)
		add zl , NIB
		lpm LTDATA , z
		add RES , LTDATA

		ldi	NIB , 0xf0 ; find last nibble
		and NIB , NUM
		swap NIB
		ldi zl , 0
		ldi zh , 0
		// r20 = low byte of mydata
		ldi zh , high(mydata << 1)
		ldi zl , low(mydata << 1)
		add zl , NIB
		ldi LTDATA , 0
		lpm LTDATA , z
		add RES , LTDATA

		.org 0x100
		MYDATA : .DB 0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4

;END of Program
		END: rjmp END
