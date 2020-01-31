;
; LED_Blinking.asm
;
; Created: 10/29/2019 7:35:07 PM
; Author : Maryam
;

.macro delay
	ldi R21,200
	again:
	ldi R22,250
	here:
	NOP
	NOP
	dec R22
	BRNE here
	dec R21
	BRNE again
.endmacro

cbi DDRD,0 ; set PD0 as input

sbi DDRB,0 ; set PB0 as output
sbi DDRB,1 ; set PB1 as output
sbi DDRB,2 ; set PB2 as output
sbi DDRB,3 ; set PB3 as output
sbi DDRB,4 ; set PB4 as output
sbi DDRB,5 ; set PB5 as output
sbi DDRB,6 ; set PB6 as output
sbi DDRB,7 ; set PB7 as output

start:

	RightToLeft:

		Ri1:sbi PORTB,0
			delay
			cbi PORTB,0
			sbic PIND,0
			RJMP Le1

		Ri2:sbi PORTB,1
			delay
			cbi PORTB,1
			sbic PIND,0
			RJMP Le8

		Ri3:sbi PORTB,2
			delay
			cbi PORTB,2
			sbic PIND,0
			RJMP Le7

		Ri4:sbi PORTB,3
			delay
			cbi PORTB,3
			sbic PIND,0
			RJMP Le6

		Ri5:sbi PORTB,4
			delay
			cbi PORTB,4
			sbic PIND,0
			RJMP Le5

		Ri6:sbi PORTB,5
			delay
			cbi PORTB,5
			sbic PIND,0
			RJMP Le4

		Ri7:sbi PORTB,6
			delay
			cbi PORTB,6
			sbic PIND,0
			RJMP Le3

		Ri8:sbi PORTB,7
			delay
			cbi PORTB,7
			sbic PIND,0
			RJMP Le2

			sbis PIND,0
			RJMP RightToLeft

	LeftToRight:

		Le1:sbi PORTB,7
			delay
			cbi PORTB,7
			sbic PIND,0
			RJMP Ri1
		Le2:sbi PORTB,6
			delay
			cbi PORTB,6
			sbic PIND,0
			RJMP Ri8
		Le3:sbi PORTB,5
			delay
			cbi PORTB,5
			sbic PIND,0
			RJMP Ri7
		Le4:sbi PORTB,4
			delay
			cbi PORTB,4
			sbic PIND,0
			RJMP Ri6
		Le5:sbi PORTB,3
			delay
			cbi PORTB,3
			sbic PIND,0
			RJMP Ri5
		Le6:sbi PORTB,2
			delay
			cbi PORTB,2
			sbic PIND,0
			RJMP Ri4
		Le7:sbi PORTB,1
			delay
			cbi PORTB,1
			sbic PIND,0
			RJMP Ri3
		Le8:sbi PORTB,0
			delay
			cbi PORTB,0
			sbic PIND,0
			RJMP Ri2

			sbis PIND,0
			RJMP LeftToRight

	RJMP start