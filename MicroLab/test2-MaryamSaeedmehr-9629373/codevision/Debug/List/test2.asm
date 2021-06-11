
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
;Global 'const' stored in FLASH: No
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

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
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
	JMP  0x00
	JMP  0x00

_digit:
	.DB  0x3F,0x6,0x5B,0x4F,0x66,0x6D,0x7D,0x7
	.DB  0x7F,0x6F

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
;/*
; * test 2:   Introduction to I/O ports(Complementary)
; *
; * Created:  3/7/2021 9:11:54 PM
; * Author:   Maryam Saeedmehr
; * Std.NO:   9629373
; */
;
;#include "configuration.h"
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
;// Main Function ----------------------------------------------------------
;void main(void)
; 0000 000D {

	.CSEG
_main:
; .FSTART _main
; 0000 000E     // I/O configuration ---------------------
; 0000 000F     ioConfiguration(portA, input);
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _ioConfiguration
; 0000 0010     ioConfiguration(portB, output);
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R26,LOW(255)
	RCALL _ioConfiguration
; 0000 0011     ioConfiguration(portC, output);
	LDI  R30,LOW(3)
	ST   -Y,R30
	LDI  R26,LOW(255)
	RCALL _ioConfiguration
; 0000 0012     ioConfiguration(portD, inOut);
	LDI  R30,LOW(4)
	ST   -Y,R30
	LDI  R26,LOW(15)
	RCALL _ioConfiguration
; 0000 0013 
; 0000 0014     // flowchart ------------------------------
; 0000 0015     subRoutine1(portB, 2, 400);
	LDI  R30,LOW(2)
	ST   -Y,R30
	ST   -Y,R30
	LDI  R26,LOW(400)
	LDI  R27,HIGH(400)
	RCALL _subRoutine1
; 0000 0016     subRoutine2(4, 3000); // start at PORTB.4
	LDI  R30,LOW(4)
	ST   -Y,R30
	LDI  R26,LOW(3000)
	LDI  R27,HIGH(3000)
	RCALL _subRoutine2
; 0000 0017     subRoutine4(up, segment1);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _subRoutine4
; 0000 0018 
; 0000 0019     while (1)
_0x3:
; 0000 001A     {
; 0000 001B         subRoutine3(portA, portB);
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R26,LOW(2)
	RCALL _subRoutine3
; 0000 001C         subRoutine5(1); // step size = 1*0.1
	LDI  R26,LOW(1)
	RCALL _subRoutine5
; 0000 001D     }
	RJMP _0x3
; 0000 001E }
_0x6:
	RJMP _0x6
; .FEND
;/*
; * test 2:   Introduction to I/O ports(Complementary)
; *
; *
; * Created:  3/7/2021 9:11:54 PM
; * Author:   Maryam Saeedmehr
; * Std.NO:   9629373
; */
;
;#include "configuration.h"
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
;// Global Variables definition ------------------------------------------
;unsigned char i; // for-loop variable
;unsigned char number; /* variable for subRoutine5 -> number = PINA
;and for subRoutine3 used as a temporary variable */
;unsigned char number_digit[4] = {0}; // separated number's digits
;flash unsigned char digit[] = {
;    // to show digits in 7-segments
;    0x3F, // 0
;    0x06, // 1
;    0x5B, // 2
;    0x4F, // 3
;    0x66, // 4
;    0x6D, // 5
;    0x7D, // 6
;    0x07, // 7
;    0x7F, // 8
;    0x6F  // 9
;};
;
;// I/O configuration -----------------------------------------------------
;void ioConfiguration(char portSel, char config){
; 0001 0020 void ioConfiguration(char portSel, char config){

	.CSEG
_ioConfiguration:
; .FSTART _ioConfiguration
; 0001 0021     switch (portSel)
	RCALL SUBOPT_0x0
;	portSel -> Y+1
;	config -> Y+0
; 0001 0022     {
; 0001 0023     case 1:
	BRNE _0x20006
; 0001 0024         DDRA = config;
	LD   R30,Y
	OUT  0x1A,R30
; 0001 0025         break;
	RJMP _0x20005
; 0001 0026     case 2:
_0x20006:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x20007
; 0001 0027         DDRB = config;
	LD   R30,Y
	OUT  0x17,R30
; 0001 0028         break;
	RJMP _0x20005
; 0001 0029     case 3:
_0x20007:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x20008
; 0001 002A         DDRC = config;
	LD   R30,Y
	OUT  0x14,R30
; 0001 002B         break;
	RJMP _0x20005
; 0001 002C     case 4:
_0x20008:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x2000A
; 0001 002D         DDRD = config;
	LD   R30,Y
	OUT  0x11,R30
; 0001 002E         break;
	RJMP _0x20005
; 0001 002F     default:
_0x2000A:
; 0001 0030         return;
	RJMP _0x2000002
; 0001 0031     }
_0x20005:
; 0001 0032 }
	RJMP _0x2000002
; .FEND
;
;// Subroutines Implementation ---------------------------------------------
;void subRoutine1(char portSel, char turningOn, uint16_t delay)
; 0001 0036 {
_subRoutine1:
; .FSTART _subRoutine1
; 0001 0037     switch (portSel)
	ST   -Y,R27
	ST   -Y,R26
;	portSel -> Y+3
;	turningOn -> Y+2
;	delay -> Y+0
	LDD  R30,Y+3
	RCALL SUBOPT_0x1
; 0001 0038     {
; 0001 0039     case 1:
	BRNE _0x2000E
; 0001 003A         for (i = 0; i < turningOn; i++)
	LDI  R30,LOW(0)
	STS  _i,R30
_0x20010:
	RCALL SUBOPT_0x2
	BRSH _0x20011
; 0001 003B         {
; 0001 003C             PORTA = 0xFF; // turn on all LEDs
	LDI  R30,LOW(255)
	OUT  0x1B,R30
; 0001 003D             delay_ms(delay);
	RCALL SUBOPT_0x3
; 0001 003E             PORTA = 0x00; // turn off all LEDs
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0001 003F             delay_ms(delay);
	RCALL SUBOPT_0x3
; 0001 0040         }
	RCALL SUBOPT_0x4
	RJMP _0x20010
_0x20011:
; 0001 0041         break;
	RJMP _0x2000D
; 0001 0042     case 2:
_0x2000E:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x20012
; 0001 0043         for (i = 0; i < turningOn; i++)
	LDI  R30,LOW(0)
	STS  _i,R30
_0x20014:
	RCALL SUBOPT_0x2
	BRSH _0x20015
; 0001 0044         {
; 0001 0045             PORTB = 0xFF; // turn on all LEDs
	LDI  R30,LOW(255)
	OUT  0x18,R30
; 0001 0046             delay_ms(delay);
	RCALL SUBOPT_0x3
; 0001 0047             PORTB = 0x00; // turn off all LEDs
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0001 0048             delay_ms(delay);
	RCALL SUBOPT_0x3
; 0001 0049         }
	RCALL SUBOPT_0x4
	RJMP _0x20014
_0x20015:
; 0001 004A         break;
	RJMP _0x2000D
; 0001 004B     case 3:
_0x20012:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x20016
; 0001 004C         for (i = 0; i < turningOn; i++)
	LDI  R30,LOW(0)
	STS  _i,R30
_0x20018:
	RCALL SUBOPT_0x2
	BRSH _0x20019
; 0001 004D         {
; 0001 004E             PORTC = 0xFF; // turn on all LEDs
	LDI  R30,LOW(255)
	OUT  0x15,R30
; 0001 004F             delay_ms(delay);
	RCALL SUBOPT_0x3
; 0001 0050             PORTC = 0x00; // turn off all LEDs
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0001 0051             delay_ms(delay);
	RCALL SUBOPT_0x3
; 0001 0052         }
	RCALL SUBOPT_0x4
	RJMP _0x20018
_0x20019:
; 0001 0053         break;
	RJMP _0x2000D
; 0001 0054     case 4:
_0x20016:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x2001E
; 0001 0055         for (i = 0; i < turningOn; i++)
	LDI  R30,LOW(0)
	STS  _i,R30
_0x2001C:
	RCALL SUBOPT_0x2
	BRSH _0x2001D
; 0001 0056         {
; 0001 0057             PORTD = 0xFF; // turn on all LEDs
	LDI  R30,LOW(255)
	OUT  0x12,R30
; 0001 0058             delay_ms(delay);
	RCALL SUBOPT_0x3
; 0001 0059             PORTD = 0x00; // turn off all LEDs
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0001 005A             delay_ms(delay);
	RCALL SUBOPT_0x3
; 0001 005B         }
	RCALL SUBOPT_0x4
	RJMP _0x2001C
_0x2001D:
; 0001 005C         break;
; 0001 005D     default:
_0x2001E:
; 0001 005E         return;
; 0001 005F     }
_0x2000D:
; 0001 0060 }
_0x2000003:
	ADIW R28,4
	RET
; .FEND
;
;void subRoutine2(char x, uint16_t duration)
; 0001 0063 {
_subRoutine2:
; .FSTART _subRoutine2
; 0001 0064     for (i = 0; i < 8; i++)
	ST   -Y,R27
	ST   -Y,R26
;	x -> Y+2
;	duration -> Y+0
	LDI  R30,LOW(0)
	STS  _i,R30
_0x20020:
	LDS  R26,_i
	CPI  R26,LOW(0x8)
	BRSH _0x20021
; 0001 0065     {
; 0001 0066         PORTB = 1 << (i + x - 1) % 8; // turn on i'th LED
	CLR  R27
	LDD  R30,Y+2
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	LDI  R26,LOW(7)
	LDI  R27,HIGH(7)
	CALL __MANDW12
	LDI  R26,LOW(1)
	CALL __LSLB12
	OUT  0x18,R30
; 0001 0067         delay_ms(duration/8); // 8*duration/8 ms = duration sec
	LD   R30,Y
	LDD  R31,Y+1
	CALL __LSRW3
	MOVW R26,R30
	CALL _delay_ms
; 0001 0068     }
	RCALL SUBOPT_0x4
	RJMP _0x20020
_0x20021:
; 0001 0069     PORTB = 0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0001 006A }
	ADIW R28,3
	RET
; .FEND
;
;void subRoutine3(char inPort, char outPort)
; 0001 006D {
_subRoutine3:
; .FSTART _subRoutine3
; 0001 006E     switch (inPort)
	RCALL SUBOPT_0x0
;	inPort -> Y+1
;	outPort -> Y+0
; 0001 006F     {
; 0001 0070     case 1:
	BRNE _0x20025
; 0001 0071         number = PINA;
	IN   R30,0x19
	STS  _number,R30
; 0001 0072         break;
	RJMP _0x20024
; 0001 0073     case 2:
_0x20025:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x20026
; 0001 0074         number = PINB;
	IN   R30,0x16
	STS  _number,R30
; 0001 0075         break;
	RJMP _0x20024
; 0001 0076     case 3:
_0x20026:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x20027
; 0001 0077         number = PINC;
	IN   R30,0x13
	STS  _number,R30
; 0001 0078         break;
	RJMP _0x20024
; 0001 0079     case 4:
_0x20027:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x20029
; 0001 007A         number = PIND;
	IN   R30,0x10
	STS  _number,R30
; 0001 007B         break;
	RJMP _0x20024
; 0001 007C     default:
_0x20029:
; 0001 007D         return;
	RJMP _0x2000002
; 0001 007E     }
_0x20024:
; 0001 007F     switch (outPort)
	LD   R30,Y
	RCALL SUBOPT_0x1
; 0001 0080     {
; 0001 0081     case 1:
	BRNE _0x2002D
; 0001 0082         PORTA = number;
	LDS  R30,_number
	OUT  0x1B,R30
; 0001 0083         break;
	RJMP _0x2002C
; 0001 0084     case 2:
_0x2002D:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x2002E
; 0001 0085         PORTB = number;
	LDS  R30,_number
	OUT  0x18,R30
; 0001 0086         break;
	RJMP _0x2002C
; 0001 0087     case 3:
_0x2002E:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x2002F
; 0001 0088         PORTC = number;
	LDS  R30,_number
	OUT  0x15,R30
; 0001 0089         break;
	RJMP _0x2002C
; 0001 008A     case 4:
_0x2002F:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x20031
; 0001 008B         PORTD = number;
	LDS  R30,_number
	OUT  0x12,R30
; 0001 008C         break;
	RJMP _0x2002C
; 0001 008D     default:
_0x20031:
; 0001 008E         return;
	RJMP _0x2000002
; 0001 008F     }
_0x2002C:
; 0001 0090 }
	RJMP _0x2000002
; .FEND
;
;void subRoutine4(char direction, char segment)
; 0001 0093 {
_subRoutine4:
; .FSTART _subRoutine4
; 0001 0094     switch (segment)
	ST   -Y,R26
;	direction -> Y+1
;	segment -> Y+0
	LD   R30,Y
	RCALL SUBOPT_0x1
; 0001 0095     {
; 0001 0096     case 1:
	BRNE _0x20035
; 0001 0097         PORTD = 0X0E; // enable first segment
	LDI  R30,LOW(14)
	OUT  0x12,R30
; 0001 0098         break;
	RJMP _0x20034
; 0001 0099     case 2:
_0x20035:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x20036
; 0001 009A         PORTD = 0X0D; // enable second segment
	LDI  R30,LOW(13)
	OUT  0x12,R30
; 0001 009B         break;
	RJMP _0x20034
; 0001 009C     case 3:
_0x20036:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x20037
; 0001 009D         PORTD = 0X0B; // enable third segment
	LDI  R30,LOW(11)
	OUT  0x12,R30
; 0001 009E         break;
	RJMP _0x20034
; 0001 009F     case 4:
_0x20037:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x20038
; 0001 00A0         PORTD = 0X07; // enable fourth segment
	LDI  R30,LOW(7)
	OUT  0x12,R30
; 0001 00A1         break;
	RJMP _0x20034
; 0001 00A2     case 5:
_0x20038:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x2003A
; 0001 00A3         PORTD = 0X00; // enable all 7-segments
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0001 00A4         break;
	RJMP _0x20034
; 0001 00A5     default:
_0x2003A:
; 0001 00A6         return;
	RJMP _0x2000002
; 0001 00A7     }
_0x20034:
; 0001 00A8 
; 0001 00A9     switch (direction)
	LDD  R30,Y+1
	LDI  R31,0
; 0001 00AA     {
; 0001 00AB     case 0: // up
	SBIW R30,0
	BRNE _0x2003E
; 0001 00AC         for (i = 0; i < 10; i++)
	LDI  R30,LOW(0)
	STS  _i,R30
_0x20040:
	LDS  R26,_i
	CPI  R26,LOW(0xA)
	BRSH _0x20041
; 0001 00AD         {
; 0001 00AE             // in unsigned char : 0x00 - 0x01 = 0xFF
; 0001 00AF             // so stop condition is "i != 0xFF"
; 0001 00B0             PORTC = digit[i];
	RCALL SUBOPT_0x5
; 0001 00B1             delay_ms(1000);
; 0001 00B2         }
	RCALL SUBOPT_0x4
	RJMP _0x20040
_0x20041:
; 0001 00B3         break;
	RJMP _0x2003D
; 0001 00B4     case 1: // down
_0x2003E:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x20046
; 0001 00B5         for (i = 9; i != 0xFF; i--)
	LDI  R30,LOW(9)
	STS  _i,R30
_0x20044:
	LDS  R26,_i
	CPI  R26,LOW(0xFF)
	BREQ _0x20045
; 0001 00B6         {
; 0001 00B7             // in unsigned char : 0x00 - 0x01 = 0xFF
; 0001 00B8             // so stop condition is "i != 0xFF"
; 0001 00B9             PORTC = digit[i];
	RCALL SUBOPT_0x5
; 0001 00BA             delay_ms(1000);
; 0001 00BB         }
	LDS  R30,_i
	SUBI R30,LOW(1)
	STS  _i,R30
	RJMP _0x20044
_0x20045:
; 0001 00BC         break;
; 0001 00BD     default:
_0x20046:
; 0001 00BE         return;
; 0001 00BF     }
_0x2003D:
; 0001 00C0 }
_0x2000002:
	ADIW R28,2
	RET
; .FEND
;
;void subRoutine5(char stepSize)
; 0001 00C3 {
_subRoutine5:
; .FSTART _subRoutine5
; 0001 00C4     number = PINA;
	ST   -Y,R26
;	stepSize -> Y+0
	IN   R30,0x19
	STS  _number,R30
; 0001 00C5     while (number != 0)
_0x20047:
	LDS  R30,_number
	CPI  R30,0
	BRNE PC+2
	RJMP _0x20049
; 0001 00C6     {
; 0001 00C7         // extract decimal digits---------------------------
; 0001 00C8         number_digit[1] = (number) % 10; // ones
	LDS  R26,_number
	CLR  R27
	RCALL SUBOPT_0x6
	__PUTB1MN _number_digit,1
; 0001 00C9         number_digit[2] = (number / 10) % 10; // tens
	LDS  R26,_number
	LDI  R27,0
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	MOVW R26,R30
	RCALL SUBOPT_0x6
	__PUTB1MN _number_digit,2
; 0001 00CA         number_digit[3] = (number / 100) % 10; // hundreds
	LDS  R26,_number
	LDI  R27,0
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL __DIVW21
	MOVW R26,R30
	RCALL SUBOPT_0x6
	__PUTB1MN _number_digit,3
; 0001 00CB 
; 0001 00CC         // set 7-segments ----------------------------------
; 0001 00CD         for (i = 0; i < 20; i++)
	LDI  R30,LOW(0)
	STS  _i,R30
_0x2004B:
	LDS  R26,_i
	CPI  R26,LOW(0x14)
	BRSH _0x2004C
; 0001 00CE         {
; 0001 00CF             PORTD = ~( 1 << i%4 );
	LDS  R30,_i
	LDI  R31,0
	LDI  R26,LOW(3)
	LDI  R27,HIGH(3)
	CALL __MANDW12
	LDI  R26,LOW(1)
	CALL __LSLB12
	COM  R30
	OUT  0x12,R30
; 0001 00D0             /*
; 0001 00D1             * 0b1111_1110 -> set hundreds
; 0001 00D2             * 0b1111_1101 -> set tens
; 0001 00D3             * 0b1111_1011 -> set ones
; 0001 00D4             * 0b1111_0111 -> set one tenth
; 0001 00D5             */
; 0001 00D6             PORTC = i%4 == 2
; 0001 00D7                     ? digit[number_digit[1]] | 0x80 // turn on DP
; 0001 00D8                     : digit[number_digit[3-i%4]];
	LDS  R26,_i
	CLR  R27
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CALL __MODW21
	MOVW R26,R30
	SBIW R30,2
	BRNE _0x2004D
	__GETB1MN _number_digit,1
	LDI  R31,0
	SUBI R30,LOW(-_digit*2)
	SBCI R31,HIGH(-_digit*2)
	LPM  R30,Z
	ORI  R30,0x80
	RJMP _0x2004E
_0x2004D:
	MOVW R30,R26
	LDI  R26,LOW(3)
	LDI  R27,HIGH(3)
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	SUBI R30,LOW(-_number_digit)
	SBCI R31,HIGH(-_number_digit)
	LD   R30,Z
	LDI  R31,0
	SUBI R30,LOW(-_digit*2)
	SBCI R31,HIGH(-_digit*2)
	LPM  R30,Z
_0x2004E:
	OUT  0x15,R30
; 0001 00D9             delay_ms(5);
	LDI  R26,LOW(5)
	LDI  R27,0
	CALL _delay_ms
; 0001 00DA         }
	RCALL SUBOPT_0x4
	RJMP _0x2004B
_0x2004C:
; 0001 00DB         // 20 * 5 = 100ms -> frequency = 100ms
; 0001 00DC 
; 0001 00DD         // reduce 0.1*stepSize ------------------------------
; 0001 00DE         if (stepSize > 10 || stepSize < 1) return;
	LD   R26,Y
	CPI  R26,LOW(0xB)
	BRSH _0x20051
	CPI  R26,LOW(0x1)
	BRSH _0x20050
_0x20051:
	RJMP _0x2000001
; 0001 00DF         if (number_digit[0]<stepSize)
_0x20050:
	LD   R30,Y
	LDS  R26,_number_digit
	CP   R26,R30
	BRSH _0x20053
; 0001 00E0         {
; 0001 00E1             number_digit[0] = 10 + (number_digit[0] - stepSize);
	LD   R26,Y
	LDS  R30,_number_digit
	SUB  R30,R26
	SUBI R30,-LOW(10)
	STS  _number_digit,R30
; 0001 00E2             number--;
	LDS  R30,_number
	SUBI R30,LOW(1)
	STS  _number,R30
; 0001 00E3         }
; 0001 00E4         else
	RJMP _0x20054
_0x20053:
; 0001 00E5         {
; 0001 00E6             number_digit[0] -= stepSize;
	LD   R26,Y
	LDS  R30,_number_digit
	SUB  R30,R26
	STS  _number_digit,R30
; 0001 00E7         }
_0x20054:
; 0001 00E8     }
	RJMP _0x20047
_0x20049:
; 0001 00E9 }
_0x2000001:
	ADIW R28,1
	RET
; .FEND

	.DSEG
_i:
	.BYTE 0x1
_number:
	.BYTE 0x1
_number_digit:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	ST   -Y,R26
	LDD  R30,Y+1
	LDI  R31,0
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	LDI  R31,0
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	LDD  R30,Y+2
	LDS  R26,_i
	CP   R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x3:
	LD   R26,Y
	LDD  R27,Y+1
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x4:
	LDS  R30,_i
	SUBI R30,-LOW(1)
	STS  _i,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x5:
	LDS  R30,_i
	LDI  R31,0
	SUBI R30,LOW(-_digit*2)
	SBCI R31,HIGH(-_digit*2)
	LPM  R0,Z
	OUT  0x15,R0
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21
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

__LSRW3:
	LSR  R31
	ROR  R30
__LSRW2:
	LSR  R31
	ROR  R30
	LSR  R31
	ROR  R30
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__MANDW12:
	CLT
	SBRS R31,7
	RJMP __MANDW121
	RCALL __ANEGW1
	SET
__MANDW121:
	AND  R30,R26
	AND  R31,R27
	BRTC __MANDW122
	RCALL __ANEGW1
__MANDW122:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

;END OF CODE MARKER
__END_OF_CODE:
