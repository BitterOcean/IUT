;
; Debouncing.asm
;
; Created: 11/1/2019 10:35:32 PM
; Author : Maryam
;

.def temp = r16 
;--- inits ---
.def b_pressed = r17 
.def eoReg = r18 

        sbi     PORTB,PB2       ;set pullup bit on button
        sbi     DDRA,PA0        ;set ddr output on led pin
loop:   
        rcall   debounce
        brcc    else
        tst     b_pressed
        brne    loop
        in      temp,PORTA
        ldi     eoReg,(1 << PA0)
        eor     temp,eoReg
        out     PORTA,temp
        ldi     b_pressed,1
        rjmp    loop
else:
        ldi     b_pressed,0
        rjmp    loop

;--- suboutines ---
debounce:
.equ d_time = 1000
        sbic    PINB,PB2        ;bit is clear=button is pressed
        rjmp    bitSet
        ldi     r25,high(d_time)
        ldi     r24,low(d_time) 
delay:  sbiw    r25:r24,1
        brne    delay
        sbic    PINB,PB2        ;button still pressed?
        rjmp    bitSet
        sec 
        ret 
bitSet:
        clc 
        ret 
