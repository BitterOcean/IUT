.ORG 100
LDI r18,0x00;
OUT DDRC,r18;
LDI r18,0xff;
OUT DDRB,r18;
LDI r16,8;
CLR r20;
loop:
	SBIS PINC,6;
	RJMP loop;
	IN r17,PINC;
	ANDI r17,0b10000000;
	LSR r20;
	ADD r20,r17;
	DEC r16;
	BRNE loop;
OUT PORTB,r20;
loop2:RJMP loop2;
