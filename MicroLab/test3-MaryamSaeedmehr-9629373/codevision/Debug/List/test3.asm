
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega16
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _i=R5
	.DEF _j=R4
	.DEF _digit=R7
	.DEF _newDigit=R6
	.DEF _lcd_screen=R8
	.DEF _lcd_screen_msb=R9
	.DEF _speed=R11
	.DEF _time=R10
	.DEF _weigt=R13
	.DEF _temp=R12

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  _ext_int0_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_data_key:
	.DB  0x30,0x31,0x32,0x33,0x34,0x35,0x36,0x37
	.DB  0x38,0x39,0x41,0x42,0x43,0x44,0x45,0x46
_tbl10_G102:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G102:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x30,LOW(_0x40005),HIGH(_0x40005)

_0x40004:
	.DB  LOW(_0x40003),HIGH(_0x40003)
_0x40007:
	.DB  LOW(_0x40006),HIGH(_0x40006)
_0x40000:
	.DB  0x57,0x65,0x6C,0x63,0x6F,0x6D,0x65,0x20
	.DB  0x74,0x6F,0x20,0x74,0x68,0x65,0x20,0x6F
	.DB  0x6E,0x6C,0x69,0x6E,0x65,0x20,0x6C,0x61
	.DB  0x62,0x20,0x63,0x6C,0x61,0x73,0x73,0x65
	.DB  0x73,0x20,0x64,0x75,0x65,0x20,0x74,0x6F
	.DB  0x20,0x43,0x6F,0x72,0x6F,0x6E,0x61,0x20
	.DB  0x64,0x69,0x73,0x65,0x61,0x73,0x65,0x0
	.DB  0x30,0x30,0x30,0x30,0x30,0x30,0x30,0x30
	.DB  0x30,0x30,0x30,0x30,0x30,0x30,0x30,0x30
	.DB  0x0,0x30,0x30,0x30,0x30,0x30,0x30,0x30
	.DB  0x30,0x30,0x30,0x30,0x30,0x30,0x30,0x30
	.DB  0x30,0x30,0x30,0x30,0x30,0x30,0x30,0x30
	.DB  0x30,0x30,0x30,0x30,0x30,0x30,0x30,0x30
	.DB  0x30,0x0,0x4D,0x61,0x72,0x79,0x61,0x6D
	.DB  0x20,0x53,0x61,0x65,0x65,0x64,0x6D,0x65
	.DB  0x68,0x72,0x0,0x39,0x36,0x32,0x39,0x33
	.DB  0x37,0x33,0x0,0x45,0x6E,0x64,0x20,0x6F
	.DB  0x66,0x20,0x22,0x53,0x75,0x62,0x52,0x6F
	.DB  0x75,0x74,0x69,0x6E,0x65,0x33,0x22,0x2E
	.DB  0x20,0x4E,0x6F,0x77,0x20,0x69,0x6E,0x74
	.DB  0x65,0x72,0x72,0x75,0x70,0x74,0x73,0x20
	.DB  0x61,0x72,0x65,0x20,0x61,0x63,0x74,0x69
	.DB  0x76,0x61,0x74,0x65,0x64,0x0,0x53,0x70
	.DB  0x65,0x65,0x64,0x20,0x28,0x30,0x2D,0x35
	.DB  0x30,0x72,0x29,0x20,0x3A,0xA,0x0,0x45
	.DB  0x45,0x0,0x74,0x69,0x6D,0x65,0x20,0x28
	.DB  0x30,0x2D,0x39,0x39,0x73,0x29,0x20,0x3A
	.DB  0xA,0x0,0x57,0x65,0x69,0x67,0x74,0x20
	.DB  0x28,0x30,0x2D,0x39,0x39,0x46,0x29,0x20
	.DB  0x3A,0xA,0x0,0x54,0x65,0x6D,0x70,0x20
	.DB  0x28,0x32,0x30,0x2D,0x38,0x30,0x43,0x29
	.DB  0x20,0x3A,0xA,0x0,0x53,0x70,0x65,0x65
	.DB  0x64,0x3A,0x25,0x32,0x64,0x20,0x54,0x69
	.DB  0x6D,0x65,0x3A,0x25,0x32,0x64,0x20,0x57
	.DB  0x65,0x69,0x67,0x74,0x3A,0x25,0x32,0x64
	.DB  0x20,0x54,0x65,0x6D,0x70,0x3A,0x25,0x32
	.DB  0x64,0x0
_0x2020060:
	.DB  0x1
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0
_0x2060003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x03
	.DW  0x07
	.DW  __REG_VARS*2

	.DW  0x38
	.DW  _0x40003
	.DW  _0x40000*2

	.DW  0x02
	.DW  _covid
	.DW  _0x40004*2

	.DW  0x11
	.DW  _0x40005
	.DW  _0x40000*2+56

	.DW  0x21
	.DW  _0x40006
	.DW  _0x40000*2+73

	.DW  0x02
	.DW  _result
	.DW  _0x40007*2

	.DW  0x11
	.DW  _0x40010
	.DW  _0x40000*2+106

	.DW  0x08
	.DW  _0x40010+17
	.DW  _0x40000*2+123

	.DW  0x33
	.DW  _0x4001F
	.DW  _0x40000*2+131

	.DW  0x11
	.DW  _0x40020
	.DW  _0x40000*2+182

	.DW  0x11
	.DW  _0x40020+17
	.DW  _0x40000*2+182

	.DW  0x03
	.DW  _0x40020+34
	.DW  _0x40000*2+199

	.DW  0x11
	.DW  _0x40020+37
	.DW  _0x40000*2+182

	.DW  0x10
	.DW  _0x40020+54
	.DW  _0x40000*2+202

	.DW  0x10
	.DW  _0x40020+70
	.DW  _0x40000*2+202

	.DW  0x03
	.DW  _0x40020+86
	.DW  _0x40000*2+199

	.DW  0x10
	.DW  _0x40020+89
	.DW  _0x40000*2+202

	.DW  0x11
	.DW  _0x40020+105
	.DW  _0x40000*2+218

	.DW  0x11
	.DW  _0x40020+122
	.DW  _0x40000*2+218

	.DW  0x03
	.DW  _0x40020+139
	.DW  _0x40000*2+199

	.DW  0x11
	.DW  _0x40020+142
	.DW  _0x40000*2+218

	.DW  0x11
	.DW  _0x40020+159
	.DW  _0x40000*2+235

	.DW  0x11
	.DW  _0x40020+176
	.DW  _0x40000*2+235

	.DW  0x03
	.DW  _0x40020+193
	.DW  _0x40000*2+199

	.DW  0x11
	.DW  _0x40020+196
	.DW  _0x40000*2+235

	.DW  0x01
	.DW  __seed_G101
	.DW  _0x2020060*2

	.DW  0x02
	.DW  __base_y_G103
	.DW  _0x2060003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;/*******************************************************
;This program was created by the
;CodeWizardAVR V3.12 Advanced
;Automatic Program Generator
;Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project     : test 3
;Description : Introduction to character LCD and matrix keyboard
;Version     : 1.0
;Date        : 18/3/2021
;Author      : Maryam Saeedmehr
;Std.NO      : 9629373
;
;
;Chip type               : ATmega16
;Program type            : Application
;AVR Core Clock frequency: 8.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*******************************************************/
;
;#include "test3Lib.h"
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;
;void main(void){
; 0000 001A void main(void){

	.CSEG
_main:
; .FSTART _main
; 0000 001B 
; 0000 001C     board_init();
	RCALL _board_init
; 0000 001D 
; 0000 001E     // flowchart --------------------
; 0000 001F     subRoutine1();
	CALL _subRoutine1
; 0000 0020     subRoutine2(covid);
	LDS  R26,_covid
	LDS  R27,_covid+1
	CALL _subRoutine2
; 0000 0021     subRoutine3();
	CALL _subRoutine3
; 0000 0022 
; 0000 0023     // Global enable interrupts -----
; 0000 0024     #asm("sei")
	sei
; 0000 0025 
; 0000 0026     subRoutine4();
	CALL _subRoutine4
; 0000 0027     subRoutine5();
	CALL _subRoutine5
; 0000 0028 
; 0000 0029     while (1){
_0x3:
; 0000 002A         subRoutine2(result);
	LDS  R26,_result
	LDS  R27,_result+1
	CALL _subRoutine2
; 0000 002B     }
	RJMP _0x3
; 0000 002C }
_0x6:
	RJMP _0x6
; .FEND
;#include <mega16.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <alcd.h> // Alphanumeric LCD functions
;
;void io_init(){
; 0001 0004 void io_init(){

	.CSEG
_io_init:
; .FSTART _io_init
; 0001 0005     /* Input/Output Ports initialization */
; 0001 0006 
; 0001 0007     // Port A initialization -----------------------------------------
; 0001 0008     // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out
; 0001 0009     //           Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0001 000A     DDRA = (1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) |
; 0001 000B            (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (1<<DDA0);
	LDI  R30,LOW(255)
	OUT  0x1A,R30
; 0001 000C     // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0001 000D     PORTA = (0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) |
; 0001 000E             (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0001 000F 
; 0001 0010     // Port B initialization -----------------------------------------
; 0001 0011     // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out
; 0001 0012     //           Bit3=In Bit2=In Bit1=In Bit0=In
; 0001 0013     DDRB = (1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) |
; 0001 0014            (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	LDI  R30,LOW(240)
	OUT  0x17,R30
; 0001 0015     // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=T Bit2=T Bit1=T Bit0=T
; 0001 0016     PORTB = (0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) |
; 0001 0017             (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0001 0018 
; 0001 0019     // Port C initialization -----------------------------------------
; 0001 001A     // Function: Bit7=In Bit6=In Bit5=In Bit4=In
; 0001 001B     //           Bit3=In Bit2=In Bit1=In Bit0=Out
; 0001 001C     DDRC = (0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) |
; 0001 001D            (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (1<<DDC0);
	LDI  R30,LOW(1)
	OUT  0x14,R30
; 0001 001E     // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0001 001F     PORTC = (0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) |
; 0001 0020             (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0001 0021 
; 0001 0022     // Port D initialization -----------------------------------------
; 0001 0023     // Function: Bit7=In Bit6=In Bit5=In Bit4=In
; 0001 0024     //           Bit3=In Bit2=In Bit1=In Bit0=In
; 0001 0025     DDRD = (0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) |
; 0001 0026            (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0001 0027     // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0001 0028     PORTD = (0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) |
; 0001 0029             (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	OUT  0x12,R30
; 0001 002A }
	RET
; .FEND
;
;void interrupt_init(){
; 0001 002C void interrupt_init(){
_interrupt_init:
; .FSTART _interrupt_init
; 0001 002D     /* External Interrupt(s) initialization */
; 0001 002E 
; 0001 002F     // INT0: Off
; 0001 0030     // INT1: On
; 0001 0031     // INT1 Mode: Rising Edge
; 0001 0032     // INT2: Off
; 0001 0033     GICR|=(1<<INT1) | (0<<INT0) | (0<<INT2);
	IN   R30,0x3B
	ORI  R30,0x80
	OUT  0x3B,R30
; 0001 0034     MCUCR=(1<<ISC11) | (1<<ISC10) | (0<<ISC01) | (0<<ISC00);
	LDI  R30,LOW(12)
	OUT  0x35,R30
; 0001 0035     MCUCSR=(0<<ISC2);
	LDI  R30,LOW(0)
	OUT  0x34,R30
; 0001 0036     GIFR=(1<<INTF1) | (0<<INTF0) | (0<<INTF2);
	LDI  R30,LOW(128)
	OUT  0x3A,R30
; 0001 0037 }
	RET
; .FEND
;
;void board_init(){
; 0001 0039 void board_init(){
_board_init:
; .FSTART _board_init
; 0001 003A     io_init();
	RCALL _io_init
; 0001 003B     lcd_init(16);
	LDI  R26,LOW(16)
	CALL _lcd_init
; 0001 003C     /*
; 0001 003D     LCD initialization :
; 0001 003E     Connections are specified in the
; 0001 003F     Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0001 0040     RS - PORTA Bit 0
; 0001 0041     RD - PORTA Bit 1
; 0001 0042     EN - PORTA Bit 2
; 0001 0043     D4 - PORTA Bit 4
; 0001 0044     D5 - PORTA Bit 5
; 0001 0045     D6 - PORTA Bit 6
; 0001 0046     D7 - PORTA Bit 7
; 0001 0047     Characters/line: 16
; 0001 0048     */
; 0001 0049     interrupt_init();
	RCALL _interrupt_init
; 0001 004A }
	RET
; .FEND
;#include "test3Lib.h"
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;
;// Variable definition -----------------------------------------------------
;unsigned char i; // for-loop variable
;unsigned char j; // for-loop variable
;unsigned char digit = '0'; // which key is pushed? (Interrupt)
;unsigned char newDigit; // used in subRoutine5
;flash unsigned char data_key[4][4] = {
;    // keypad data
;    {'0','1','2','3'},
;    {'4','5','6','7'},
;    {'8','9','A','B'},
;    {'C','D','E','F'}
;};
;char* covid = "Welcome to the online lab classes due to Corona disease";

	.DSEG
_0x40003:
	.BYTE 0x38
;char* lcd_screen = "0000000000000000"; /* used in subRoutine2
;for scrolling string. initialized with "0000000000000000" to
;not have problem with clearing the lcd. */
_0x40005:
	.BYTE 0x11
;uint8_t speed; // used in subRoutine5 (0-50 r)
;uint8_t time; // used in subRoutine5 (0-99 s)
;uint8_t weigt; // used in subRoutine5 (0-99 F)
;uint8_t temp; // used in subRoutine5 (20-80 C)
;char* result = "00000000000000000000000000000000"; // store the result of subRoutine5
_0x40006:
	.BYTE 0x21
;
;// Interrupt Handler ------------------------------
;interrupt [EXT_INT1] void ext_int0_isr(void){
; 0002 001A interrupt [3] void ext_int0_isr(void){

	.CSEG
_ext_int0_isr:
; .FSTART _ext_int0_isr
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0002 001B     // External Interrupt 0 service routine
; 0002 001C     PORTC = 0x01;
	LDI  R30,LOW(1)
	OUT  0x15,R30
; 0002 001D     for (i = 0; i < 4; i++){ //row
	CLR  R5
_0x40009:
	LDI  R30,LOW(4)
	CP   R5,R30
	BRSH _0x4000A
; 0002 001E         PORTB = 1 << (i + 4); //portB.4 to portB.8 are rows
	CALL SUBOPT_0x0
; 0002 001F         for (j = 0; j < 4; j++){ //column
_0x4000C:
	LDI  R30,LOW(4)
	CP   R4,R30
	BRSH _0x4000D
; 0002 0020             if ((PINB&(1<<j))==(1<<j)){
	CALL SUBOPT_0x1
	BRNE _0x4000E
; 0002 0021                 if(data_key[i][j]!='F')
	CALL SUBOPT_0x2
	CPI  R26,LOW(0x46)
	BREQ _0x4000F
; 0002 0022                     lcd_putchar(data_key[i][j]);
	CALL SUBOPT_0x2
	CALL _lcd_putchar
; 0002 0023                 digit = data_key[i][j];
_0x4000F:
	MOV  R30,R5
	LDI  R26,LOW(_data_key*2)
	LDI  R27,HIGH(_data_key*2)
	LDI  R31,0
	CALL __LSLW2
	ADD  R26,R30
	ADC  R27,R31
	MOV  R30,R4
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	LPM  R7,Z
; 0002 0024                 newDigit = 1;
	LDI  R30,LOW(1)
	MOV  R6,R30
; 0002 0025             }
; 0002 0026         }
_0x4000E:
	INC  R4
	RJMP _0x4000C
_0x4000D:
; 0002 0027     }
	INC  R5
	RJMP _0x40009
_0x4000A:
; 0002 0028     PORTC = 0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0002 0029     PORTB = 0xFF;
	LDI  R30,LOW(255)
	OUT  0x18,R30
; 0002 002A }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;
;// SubRoutines Implementation -----------------------------------------------
;void subRoutine1(){
; 0002 002D void subRoutine1(){
_subRoutine1:
; .FSTART _subRoutine1
; 0002 002E     lcd_clear();
	CALL _lcd_clear
; 0002 002F     lcd_puts(myName);
	__POINTW2MN _0x40010,0
	CALL _lcd_puts
; 0002 0030     lcd_gotoxy(line2x,line2y); // go to next line
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	CALL _lcd_gotoxy
; 0002 0031     lcd_puts(stdNO);
	__POINTW2MN _0x40010,17
	CALL _lcd_puts
; 0002 0032     delay_ms(1500);
	LDI  R26,LOW(1500)
	LDI  R27,HIGH(1500)
	CALL _delay_ms
; 0002 0033 }
	RET
; .FEND

	.DSEG
_0x40010:
	.BYTE 0x19
;
;void subRoutine2(char* str){
; 0002 0035 void subRoutine2(char* str){

	.CSEG
_subRoutine2:
; .FSTART _subRoutine2
; 0002 0036     lcd_clear();
	ST   -Y,R27
	ST   -Y,R26
;	*str -> Y+0
	CALL _lcd_clear
; 0002 0037     for (i = 0; i <= strlen(str); i++){
	CLR  R5
_0x40012:
	LD   R26,Y
	LDD  R27,Y+1
	CALL _strlen
	MOV  R26,R5
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BRLO _0x40013
; 0002 0038         delay_ms(100);
	LDI  R26,LOW(100)
	LDI  R27,0
	CALL SUBOPT_0x3
; 0002 0039         lcd_clear();
; 0002 003A         strncpy(lcd_screen,str + i,16);
	ST   -Y,R9
	ST   -Y,R8
	MOV  R30,R5
	LDI  R31,0
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(16)
	CALL _strncpy
; 0002 003B         lcd_puts(lcd_screen);
	MOVW R26,R8
	CALL _lcd_puts
; 0002 003C     }
	INC  R5
	RJMP _0x40012
_0x40013:
; 0002 003D }
	JMP  _0x20C0002
; .FEND
;
;void subRoutine3(){
; 0002 003F void subRoutine3(){
_subRoutine3:
; .FSTART _subRoutine3
; 0002 0040     while (1){
_0x40014:
; 0002 0041         for (i = 0; i < 4; i++){ //row
	CLR  R5
_0x40018:
	LDI  R30,LOW(4)
	CP   R5,R30
	BRSH _0x40019
; 0002 0042             PORTB = 1 << (i + 4); //portB.4 to portB.8 are rows
	CALL SUBOPT_0x0
; 0002 0043             for (j = 0; j < 4; j++){ //column
_0x4001B:
	LDI  R30,LOW(4)
	CP   R4,R30
	BRSH _0x4001C
; 0002 0044                 if ((PINB&(1<<j))==(1<<j)){
	CALL SUBOPT_0x1
	BRNE _0x4001D
; 0002 0045                     lcd_clear();
	CALL _lcd_clear
; 0002 0046                     lcd_putchar(data_key[i][j]);
	CALL SUBOPT_0x2
	CALL _lcd_putchar
; 0002 0047                     delay_ms(100);
	LDI  R26,LOW(100)
	LDI  R27,0
	CALL _delay_ms
; 0002 0048                     if(data_key[i][j]=='F'){ //End condition
	CALL SUBOPT_0x2
	CPI  R26,LOW(0x46)
	BRNE _0x4001E
; 0002 0049                         delay_ms(700);
	LDI  R26,LOW(700)
	LDI  R27,HIGH(700)
	CALL _delay_ms
; 0002 004A                         subRoutine2(endSub3);
	__POINTW2MN _0x4001F,0
	RCALL _subRoutine2
; 0002 004B                         return;
	RET
; 0002 004C                     }
; 0002 004D                 }
_0x4001E:
; 0002 004E             }
_0x4001D:
	INC  R4
	RJMP _0x4001B
_0x4001C:
; 0002 004F         }
	INC  R5
	RJMP _0x40018
_0x40019:
; 0002 0050     }
	RJMP _0x40014
; 0002 0051 }
; .FEND

	.DSEG
_0x4001F:
	.BYTE 0x33
;
;void subRoutine4(){
; 0002 0053 void subRoutine4(){

	.CSEG
_subRoutine4:
; .FSTART _subRoutine4
; 0002 0054     PORTB = 0xFF;
	LDI  R30,LOW(255)
	OUT  0x18,R30
; 0002 0055 }
	RET
; .FEND
;
;void subRoutine5(){
; 0002 0057 void subRoutine5(){
_subRoutine5:
; .FSTART _subRoutine5
; 0002 0058     // Speed -----------------------------------
; 0002 0059     newDigit = 0;
	CLR  R6
; 0002 005A     lcd_clear();
	CALL _lcd_clear
; 0002 005B     lcd_puts(SPEED);
	__POINTW2MN _0x40020,0
	CALL _lcd_puts
; 0002 005C     speed = 0;
	CLR  R11
; 0002 005D     while(1){
_0x40021:
; 0002 005E         if((digit!='F') && newDigit){
	LDI  R30,LOW(70)
	CP   R30,R7
	BREQ _0x40025
	TST  R6
	BRNE _0x40026
_0x40025:
	RJMP _0x40024
_0x40026:
; 0002 005F             newDigit = 0;
	CLR  R6
; 0002 0060             speed = speed * 10 + (digit - '0');
	MOV  R30,R11
	CALL SUBOPT_0x4
	MOV  R11,R30
; 0002 0061         }
; 0002 0062         else if ((digit=='F') && speed>50){
	RJMP _0x40027
_0x40024:
	LDI  R30,LOW(70)
	CP   R30,R7
	BRNE _0x40029
	LDI  R30,LOW(50)
	CP   R30,R11
	BRLO _0x4002A
_0x40029:
	RJMP _0x40028
_0x4002A:
; 0002 0063             newDigit = 0;
	CLR  R6
; 0002 0064             lcd_clear();
	CALL _lcd_clear
; 0002 0065             lcd_puts(SPEED);
	__POINTW2MN _0x40020,17
	CALL _lcd_puts
; 0002 0066             lcd_puts(Error);
	__POINTW2MN _0x40020,34
	CALL SUBOPT_0x5
; 0002 0067             delay_ms(400);
; 0002 0068             lcd_clear();
; 0002 0069             lcd_puts(SPEED);
	__POINTW2MN _0x40020,37
	CALL SUBOPT_0x6
; 0002 006A             digit = '0';
; 0002 006B             speed = 0;
	CLR  R11
; 0002 006C         }
; 0002 006D         else if ((digit=='F') && (speed>=0 && speed<=50))
	RJMP _0x4002B
_0x40028:
	LDI  R30,LOW(70)
	CP   R30,R7
	BRNE _0x4002D
	LDI  R30,LOW(0)
	CP   R11,R30
	BRLO _0x4002E
	LDI  R30,LOW(50)
	CP   R30,R11
	BRSH _0x4002F
_0x4002E:
	RJMP _0x4002D
_0x4002F:
	RJMP _0x40030
_0x4002D:
	RJMP _0x4002C
_0x40030:
; 0002 006E             break;
	RJMP _0x40023
; 0002 006F     }
_0x4002C:
_0x4002B:
_0x40027:
	RJMP _0x40021
_0x40023:
; 0002 0070     // Time -------------------------------------
; 0002 0071     newDigit = 0;
	CALL SUBOPT_0x7
; 0002 0072     digit = '0';
; 0002 0073     lcd_clear();
; 0002 0074     lcd_puts(TIME);
	__POINTW2MN _0x40020,54
	CALL _lcd_puts
; 0002 0075     time = 0;
	CLR  R10
; 0002 0076     while(1){
_0x40031:
; 0002 0077         if((digit!='F') && newDigit){
	LDI  R30,LOW(70)
	CP   R30,R7
	BREQ _0x40035
	TST  R6
	BRNE _0x40036
_0x40035:
	RJMP _0x40034
_0x40036:
; 0002 0078             newDigit = 0;
	CLR  R6
; 0002 0079             time = time * 10 + (digit - '0');
	MOV  R30,R10
	CALL SUBOPT_0x4
	MOV  R10,R30
; 0002 007A         }
; 0002 007B         else if ((digit=='F') && time>99){
	RJMP _0x40037
_0x40034:
	LDI  R30,LOW(70)
	CP   R30,R7
	BRNE _0x40039
	LDI  R30,LOW(99)
	CP   R30,R10
	BRLO _0x4003A
_0x40039:
	RJMP _0x40038
_0x4003A:
; 0002 007C             newDigit = 0;
	CLR  R6
; 0002 007D             lcd_clear();
	CALL _lcd_clear
; 0002 007E             lcd_puts(TIME);
	__POINTW2MN _0x40020,70
	CALL _lcd_puts
; 0002 007F             lcd_puts(Error);
	__POINTW2MN _0x40020,86
	CALL SUBOPT_0x5
; 0002 0080             delay_ms(400);
; 0002 0081             lcd_clear();
; 0002 0082             lcd_puts(TIME);
	__POINTW2MN _0x40020,89
	CALL SUBOPT_0x6
; 0002 0083             digit = '0';
; 0002 0084             time = 0;
	CLR  R10
; 0002 0085         }
; 0002 0086         else if ((digit=='F') && (time>=0 && time<=99))
	RJMP _0x4003B
_0x40038:
	LDI  R30,LOW(70)
	CP   R30,R7
	BRNE _0x4003D
	LDI  R30,LOW(0)
	CP   R10,R30
	BRLO _0x4003E
	LDI  R30,LOW(99)
	CP   R30,R10
	BRSH _0x4003F
_0x4003E:
	RJMP _0x4003D
_0x4003F:
	RJMP _0x40040
_0x4003D:
	RJMP _0x4003C
_0x40040:
; 0002 0087             break;
	RJMP _0x40033
; 0002 0088     }
_0x4003C:
_0x4003B:
_0x40037:
	RJMP _0x40031
_0x40033:
; 0002 0089     // Weigt ------------------------------------
; 0002 008A     newDigit = 0;
	CALL SUBOPT_0x7
; 0002 008B     digit = '0';
; 0002 008C     lcd_clear();
; 0002 008D     lcd_puts(WEIGT);
	__POINTW2MN _0x40020,105
	CALL _lcd_puts
; 0002 008E     weigt = 0;
	CLR  R13
; 0002 008F     while(1){
_0x40041:
; 0002 0090         if((digit!='F') && newDigit){
	LDI  R30,LOW(70)
	CP   R30,R7
	BREQ _0x40045
	TST  R6
	BRNE _0x40046
_0x40045:
	RJMP _0x40044
_0x40046:
; 0002 0091             newDigit = 0;
	CLR  R6
; 0002 0092             weigt = weigt * 10 + (digit - '0');
	MOV  R30,R13
	CALL SUBOPT_0x4
	MOV  R13,R30
; 0002 0093         }
; 0002 0094         else if ((digit=='F') && weigt>99){
	RJMP _0x40047
_0x40044:
	LDI  R30,LOW(70)
	CP   R30,R7
	BRNE _0x40049
	LDI  R30,LOW(99)
	CP   R30,R13
	BRLO _0x4004A
_0x40049:
	RJMP _0x40048
_0x4004A:
; 0002 0095             newDigit = 0;
	CLR  R6
; 0002 0096             lcd_clear();
	CALL _lcd_clear
; 0002 0097             lcd_puts(WEIGT);
	__POINTW2MN _0x40020,122
	CALL _lcd_puts
; 0002 0098             lcd_puts(Error);
	__POINTW2MN _0x40020,139
	CALL SUBOPT_0x5
; 0002 0099             delay_ms(400);
; 0002 009A             lcd_clear();
; 0002 009B             lcd_puts(WEIGT);
	__POINTW2MN _0x40020,142
	CALL SUBOPT_0x6
; 0002 009C             digit = '0';
; 0002 009D             weigt = 0;
	CLR  R13
; 0002 009E         }
; 0002 009F         else if ((digit=='F') && (weigt>=0 && weigt<=99))
	RJMP _0x4004B
_0x40048:
	LDI  R30,LOW(70)
	CP   R30,R7
	BRNE _0x4004D
	LDI  R30,LOW(0)
	CP   R13,R30
	BRLO _0x4004E
	LDI  R30,LOW(99)
	CP   R30,R13
	BRSH _0x4004F
_0x4004E:
	RJMP _0x4004D
_0x4004F:
	RJMP _0x40050
_0x4004D:
	RJMP _0x4004C
_0x40050:
; 0002 00A0             break;
	RJMP _0x40043
; 0002 00A1     }
_0x4004C:
_0x4004B:
_0x40047:
	RJMP _0x40041
_0x40043:
; 0002 00A2     // Temp -------------------------------------
; 0002 00A3     newDigit = 0;
	CALL SUBOPT_0x7
; 0002 00A4     digit = '0';
; 0002 00A5     lcd_clear();
; 0002 00A6     lcd_puts(TEMP);
	__POINTW2MN _0x40020,159
	CALL _lcd_puts
; 0002 00A7     temp = 0;
	CLR  R12
; 0002 00A8     while(1){
_0x40051:
; 0002 00A9         if((digit!='F') && newDigit){
	LDI  R30,LOW(70)
	CP   R30,R7
	BREQ _0x40055
	TST  R6
	BRNE _0x40056
_0x40055:
	RJMP _0x40054
_0x40056:
; 0002 00AA             newDigit = 0;
	CLR  R6
; 0002 00AB             temp = temp * 10 + (digit - '0');
	MOV  R30,R12
	CALL SUBOPT_0x4
	MOV  R12,R30
; 0002 00AC         }
; 0002 00AD         else if ((digit=='F') && (temp<20 || temp>80)){
	RJMP _0x40057
_0x40054:
	LDI  R30,LOW(70)
	CP   R30,R7
	BRNE _0x40059
	LDI  R30,LOW(20)
	CP   R12,R30
	BRLO _0x4005A
	LDI  R30,LOW(80)
	CP   R30,R12
	BRSH _0x40059
_0x4005A:
	RJMP _0x4005C
_0x40059:
	RJMP _0x40058
_0x4005C:
; 0002 00AE             newDigit = 0;
	CLR  R6
; 0002 00AF             lcd_clear();
	CALL _lcd_clear
; 0002 00B0             lcd_puts(TEMP);
	__POINTW2MN _0x40020,176
	CALL _lcd_puts
; 0002 00B1             lcd_puts(Error);
	__POINTW2MN _0x40020,193
	CALL SUBOPT_0x5
; 0002 00B2             delay_ms(400);
; 0002 00B3             lcd_clear();
; 0002 00B4             lcd_puts(TEMP);
	__POINTW2MN _0x40020,196
	CALL SUBOPT_0x6
; 0002 00B5             digit = '0';
; 0002 00B6             temp = 0;
	CLR  R12
; 0002 00B7         }
; 0002 00B8         else if ((digit=='F') && (temp>=20 && temp<=80))
	RJMP _0x4005D
_0x40058:
	LDI  R30,LOW(70)
	CP   R30,R7
	BRNE _0x4005F
	LDI  R30,LOW(20)
	CP   R12,R30
	BRLO _0x40060
	LDI  R30,LOW(80)
	CP   R30,R12
	BRSH _0x40061
_0x40060:
	RJMP _0x4005F
_0x40061:
	RJMP _0x40062
_0x4005F:
	RJMP _0x4005E
_0x40062:
; 0002 00B9             break;
	RJMP _0x40053
; 0002 00BA     }
_0x4005E:
_0x4005D:
_0x40057:
	RJMP _0x40051
_0x40053:
; 0002 00BB     // Final ------------------------------------
; 0002 00BC     sprintf(result,
; 0002 00BD             "Speed:%2d Time:%2d Weigt:%2d Temp:%2d",
; 0002 00BE             speed,time,weigt,temp);
	LDS  R30,_result
	LDS  R31,_result+1
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x40000,252
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R11
	CALL SUBOPT_0x8
	MOV  R30,R10
	CALL SUBOPT_0x8
	MOV  R30,R13
	CALL SUBOPT_0x8
	MOV  R30,R12
	CALL SUBOPT_0x8
	LDI  R24,16
	CALL _sprintf
	JMP  _0x20C0004
; 0002 00BF 
; 0002 00C0 }
; .FEND

	.DSEG
_0x40020:
	.BYTE 0xD5

	.CSEG
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND
_strncpy:
; .FSTART _strncpy
	ST   -Y,R26
    ld   r23,y+
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
    movw r24,r26
strncpy0:
    tst  r23
    breq strncpy1
    dec  r23
    ld   r22,z+
    st   x+,r22
    tst  r22
    brne strncpy0
strncpy2:
    tst  r23
    breq strncpy1
    dec  r23
    st   x+,r22
    rjmp strncpy2
strncpy1:
    movw r30,r24
    ret
; .FEND

	.CSEG

	.DSEG

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_put_buff_G102:
; .FSTART _put_buff_G102
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x2040010
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,4
	CALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2040012
	__CPWRN 16,17,2
	BRLO _0x2040013
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1SNS 2,4
_0x2040012:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+4
	STD  Z+0,R26
_0x2040013:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL __GETW1P
	TST  R31
	BRMI _0x2040014
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
_0x2040014:
	RJMP _0x2040015
_0x2040010:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x2040015:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
; .FEND
__print_G102:
; .FSTART __print_G102
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2040016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2040018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x204001C
	CPI  R18,37
	BRNE _0x204001D
	LDI  R17,LOW(1)
	RJMP _0x204001E
_0x204001D:
	CALL SUBOPT_0x9
_0x204001E:
	RJMP _0x204001B
_0x204001C:
	CPI  R30,LOW(0x1)
	BRNE _0x204001F
	CPI  R18,37
	BRNE _0x2040020
	CALL SUBOPT_0x9
	RJMP _0x20400CC
_0x2040020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2040021
	LDI  R16,LOW(1)
	RJMP _0x204001B
_0x2040021:
	CPI  R18,43
	BRNE _0x2040022
	LDI  R20,LOW(43)
	RJMP _0x204001B
_0x2040022:
	CPI  R18,32
	BRNE _0x2040023
	LDI  R20,LOW(32)
	RJMP _0x204001B
_0x2040023:
	RJMP _0x2040024
_0x204001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2040025
_0x2040024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2040026
	ORI  R16,LOW(128)
	RJMP _0x204001B
_0x2040026:
	RJMP _0x2040027
_0x2040025:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x204001B
_0x2040027:
	CPI  R18,48
	BRLO _0x204002A
	CPI  R18,58
	BRLO _0x204002B
_0x204002A:
	RJMP _0x2040029
_0x204002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x204001B
_0x2040029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x204002F
	CALL SUBOPT_0xA
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0xB
	RJMP _0x2040030
_0x204002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2040032
	CALL SUBOPT_0xA
	CALL SUBOPT_0xC
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2040033
_0x2040032:
	CPI  R30,LOW(0x70)
	BRNE _0x2040035
	CALL SUBOPT_0xA
	CALL SUBOPT_0xC
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2040033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2040036
_0x2040035:
	CPI  R30,LOW(0x64)
	BREQ _0x2040039
	CPI  R30,LOW(0x69)
	BRNE _0x204003A
_0x2040039:
	ORI  R16,LOW(4)
	RJMP _0x204003B
_0x204003A:
	CPI  R30,LOW(0x75)
	BRNE _0x204003C
_0x204003B:
	LDI  R30,LOW(_tbl10_G102*2)
	LDI  R31,HIGH(_tbl10_G102*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x204003D
_0x204003C:
	CPI  R30,LOW(0x58)
	BRNE _0x204003F
	ORI  R16,LOW(8)
	RJMP _0x2040040
_0x204003F:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2040071
_0x2040040:
	LDI  R30,LOW(_tbl16_G102*2)
	LDI  R31,HIGH(_tbl16_G102*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x204003D:
	SBRS R16,2
	RJMP _0x2040042
	CALL SUBOPT_0xA
	CALL SUBOPT_0xD
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2040043
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2040043:
	CPI  R20,0
	BREQ _0x2040044
	SUBI R17,-LOW(1)
	RJMP _0x2040045
_0x2040044:
	ANDI R16,LOW(251)
_0x2040045:
	RJMP _0x2040046
_0x2040042:
	CALL SUBOPT_0xA
	CALL SUBOPT_0xD
_0x2040046:
_0x2040036:
	SBRC R16,0
	RJMP _0x2040047
_0x2040048:
	CP   R17,R21
	BRSH _0x204004A
	SBRS R16,7
	RJMP _0x204004B
	SBRS R16,2
	RJMP _0x204004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x204004D
_0x204004C:
	LDI  R18,LOW(48)
_0x204004D:
	RJMP _0x204004E
_0x204004B:
	LDI  R18,LOW(32)
_0x204004E:
	CALL SUBOPT_0x9
	SUBI R21,LOW(1)
	RJMP _0x2040048
_0x204004A:
_0x2040047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x204004F
_0x2040050:
	CPI  R19,0
	BREQ _0x2040052
	SBRS R16,3
	RJMP _0x2040053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2040054
_0x2040053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2040054:
	CALL SUBOPT_0x9
	CPI  R21,0
	BREQ _0x2040055
	SUBI R21,LOW(1)
_0x2040055:
	SUBI R19,LOW(1)
	RJMP _0x2040050
_0x2040052:
	RJMP _0x2040056
_0x204004F:
_0x2040058:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x204005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x204005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x204005A
_0x204005C:
	CPI  R18,58
	BRLO _0x204005D
	SBRS R16,3
	RJMP _0x204005E
	SUBI R18,-LOW(7)
	RJMP _0x204005F
_0x204005E:
	SUBI R18,-LOW(39)
_0x204005F:
_0x204005D:
	SBRC R16,4
	RJMP _0x2040061
	CPI  R18,49
	BRSH _0x2040063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2040062
_0x2040063:
	RJMP _0x20400CD
_0x2040062:
	CP   R21,R19
	BRLO _0x2040067
	SBRS R16,0
	RJMP _0x2040068
_0x2040067:
	RJMP _0x2040066
_0x2040068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2040069
	LDI  R18,LOW(48)
_0x20400CD:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x204006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0xB
	CPI  R21,0
	BREQ _0x204006B
	SUBI R21,LOW(1)
_0x204006B:
_0x204006A:
_0x2040069:
_0x2040061:
	CALL SUBOPT_0x9
	CPI  R21,0
	BREQ _0x204006C
	SUBI R21,LOW(1)
_0x204006C:
_0x2040066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2040059
	RJMP _0x2040058
_0x2040059:
_0x2040056:
	SBRS R16,0
	RJMP _0x204006D
_0x204006E:
	CPI  R21,0
	BREQ _0x2040070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0xB
	RJMP _0x204006E
_0x2040070:
_0x204006D:
_0x2040071:
_0x2040030:
_0x20400CC:
	LDI  R17,LOW(0)
_0x204001B:
	RJMP _0x2040016
_0x2040018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
_0x20C0004:
	ADIW R28,20
	RET
; .FEND
_sprintf:
; .FSTART _sprintf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	CALL SUBOPT_0xE
	SBIW R30,0
	BRNE _0x2040072
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20C0003
_0x2040072:
	MOVW R26,R28
	ADIW R26,6
	CALL __ADDW2R15
	MOVW R16,R26
	CALL SUBOPT_0xE
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOVW R26,R28
	ADIW R26,10
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G102)
	LDI  R31,HIGH(_put_buff_G102)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,10
	RCALL __print_G102
	MOVW R18,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x20C0003:
	CALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G103:
; .FSTART __lcd_write_nibble_G103
	ST   -Y,R26
	IN   R30,0x1B
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x1B,R30
	__DELAY_USB 13
	SBI  0x1B,2
	__DELAY_USB 13
	CBI  0x1B,2
	__DELAY_USB 13
	RJMP _0x20C0001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G103
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G103
	__DELAY_USB 133
	RJMP _0x20C0001
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G103)
	SBCI R31,HIGH(-__base_y_G103)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R30,Y+1
	STS  __lcd_x,R30
	LD   R30,Y
	STS  __lcd_y,R30
_0x20C0002:
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0xF
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0xF
	LDI  R30,LOW(0)
	STS  __lcd_y,R30
	STS  __lcd_x,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2060005
	LDS  R30,__lcd_maxx
	LDS  R26,__lcd_x
	CP   R26,R30
	BRLO _0x2060004
_0x2060005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R26,__lcd_y
	SUBI R26,-LOW(1)
	STS  __lcd_y,R26
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2060007
	RJMP _0x20C0001
_0x2060007:
_0x2060004:
	LDS  R30,__lcd_x
	SUBI R30,-LOW(1)
	STS  __lcd_x,R30
	SBI  0x1B,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x1B,0
	RJMP _0x20C0001
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2060008:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x206000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2060008
_0x206000A:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x1A
	ORI  R30,LOW(0xF0)
	OUT  0x1A,R30
	SBI  0x1A,2
	SBI  0x1A,0
	SBI  0x1A,1
	CBI  0x1B,2
	CBI  0x1B,0
	CBI  0x1B,1
	LD   R30,Y
	STS  __lcd_maxx,R30
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G103,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G103,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0x10
	CALL SUBOPT_0x10
	CALL SUBOPT_0x10
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G103
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x20C0001:
	ADIW R28,1
	RET
; .FEND

	.CSEG

	.CSEG

	.DSEG
_result:
	.BYTE 0x2
_covid:
	.BYTE 0x2
__seed_G101:
	.BYTE 0x4
__base_y_G103:
	.BYTE 0x4
__lcd_x:
	.BYTE 0x1
__lcd_y:
	.BYTE 0x1
__lcd_maxx:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x0:
	MOV  R30,R5
	SUBI R30,-LOW(4)
	LDI  R26,LOW(1)
	CALL __LSLB12
	OUT  0x18,R30
	CLR  R4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x1:
	IN   R1,22
	MOV  R30,R4
	LDI  R26,LOW(1)
	LDI  R27,HIGH(1)
	CALL __LSLW12
	MOV  R26,R1
	LDI  R27,0
	AND  R30,R26
	AND  R31,R27
	MOVW R22,R30
	MOV  R30,R4
	LDI  R26,LOW(1)
	LDI  R27,HIGH(1)
	CALL __LSLW12
	CP   R30,R22
	CPC  R31,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:30 WORDS
SUBOPT_0x2:
	MOV  R30,R5
	LDI  R26,LOW(_data_key*2)
	LDI  R27,HIGH(_data_key*2)
	LDI  R31,0
	CALL __LSLW2
	ADD  R26,R30
	ADC  R27,R31
	MOV  R30,R4
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	LPM  R26,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3:
	CALL _delay_ms
	JMP  _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x4:
	LDI  R26,LOW(10)
	MULS R30,R26
	MOVW R30,R0
	MOV  R26,R30
	MOV  R30,R7
	SUBI R30,LOW(48)
	ADD  R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x5:
	CALL _lcd_puts
	LDI  R26,LOW(400)
	LDI  R27,HIGH(400)
	RJMP SUBOPT_0x3

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6:
	CALL _lcd_puts
	LDI  R30,LOW(48)
	MOV  R7,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x7:
	CLR  R6
	LDI  R30,LOW(48)
	MOV  R7,R30
	JMP  _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x8:
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x9:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xA:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xC:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xD:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x10:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G103
	__DELAY_USW 200
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__LSLB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSLB12R
__LSLB12L:
	LSL  R30
	DEC  R0
	BRNE __LSLB12L
__LSLB12R:
	RET

__LSLW12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	BREQ __LSLW12R
__LSLW12L:
	LSL  R30
	ROL  R31
	DEC  R0
	BRNE __LSLW12L
__LSLW12R:
	RET

__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
