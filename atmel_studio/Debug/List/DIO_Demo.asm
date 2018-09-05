
;CodeVisionAVR C Compiler V3.32 Evaluation
;(C) Copyright 1998-2017 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATxmega128B1
;Program type           : Application
;Clock frequency        : 2.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 2048 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATxmega128B1
	#pragma AVRPART MEMORY PROG_FLASH 139264
	#pragma AVRPART MEMORY EEPROM 2048
	#pragma AVRPART MEMORY INT_SRAM SIZE 8192
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x2000

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU CCP=0x34
	.EQU RAMPD=0x38
	.EQU RAMPX=0x39
	.EQU RAMPY=0x3A
	.EQU RAMPZ=0x3B
	.EQU EIND=0x3C
	.EQU WDT_CTRL=0x80
	.EQU PMIC_CTRL=0xA2
	.EQU NVM_ADDR0=0x01C0
	.EQU NVM_ADDR1=NVM_ADDR0+1
	.EQU NVM_ADDR2=NVM_ADDR1+1
	.EQU NVM_DATA0=NVM_ADDR0+4
	.EQU NVM_CMD=NVM_ADDR0+0xA
	.EQU NVM_CTRLA=NVM_ADDR0+0xB
	.EQU NVM_CTRLB=NVM_ADDR0+0xC
	.EQU NVM_STATUS=NVM_ADDR0+0xF
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIO0=0x00
	.EQU GPIO1=0x01
	.EQU GPIO2=0x02
	.EQU GPIO3=0x03

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

	.EQU __SRAM_START=0x2000
	.EQU __SRAM_END=0x3FFF
	.EQU __DSTACK_SIZE=0x0800
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

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
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

;GPIO0-GPIO3 INITIALIZATION VALUES
	.EQU __GPIO0_INIT=0x00
	.EQU __GPIO1_INIT=0x00
	.EQU __GPIO2_INIT=0x00
	.EQU __GPIO3_INIT=0x00

;GLOBAL REGISTER VARIABLES INITIALIZATION VALUES
	.EQU __R2_INIT=0x00
	.EQU __R3_INIT=0x00
	.EQU __R4_INIT=0x00
	.EQU __R5_INIT=0x00
	.EQU __R6_INIT=0x00
	.EQU __R7_INIT=0x00
	.EQU __R8_INIT=0x00
	.EQU __R9_INIT=0x00
	.EQU __R10_INIT=0x00
	.EQU __R11_INIT=0x00
	.EQU __R12_INIT=0x00
	.EQU __R13_INIT=0x00
	.EQU __R14_INIT=0x00

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
	JMP  _tcc0_overflow_isr
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
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

__RESET:
	CLI
	CLR  R30

;MEMORY MAPPED EEPROM ACCESS IS USED
	LDS  R31,NVM_CTRLB
	ORI  R31,0x08
	STS  NVM_CTRLB,R31

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,0xD8
	OUT  CCP,R31
	STS  PMIC_CTRL,R30

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

	OUT  RAMPZ,R24

;GPIO0-GPIO3 INITIALIZATION
	LDI  R30,__GPIO0_INIT
	OUT  GPIO0,R30
	;__GPIO1_INIT = __GPIO0_INIT
	OUT  GPIO1,R30
	;__GPIO2_INIT = __GPIO0_INIT
	OUT  GPIO2,R30
	;__GPIO3_INIT = __GPIO0_INIT
	OUT  GPIO3,R30

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
	.ORG 0x00

	.DSEG
	.ORG 0x2800

	.CSEG
;/*******************************************************
;This program was created by the CodeWizardAVR V3.32
;Automatic Program Generator
;� Copyright 1998-2017 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 9/4/2018
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATxmega128B1
;Program type            : Application
;AVR Core Clock frequency: 2.000000 MHz
;Memory model            : Small
;Data Stack size         : 2048
;*******************************************************/
;
;// I/O Registers definitions
;#include <xmega128b1.h>
;
;// Standard Input/Output functions
;#include <stdio.h>
;
;// Clock System initialization function
;#include "clock_init.h"
;
;// I/O Ports initialization function
;#include "ports_init.h"
;
;// Timers/Counters initialization functions
;#include "timers_init.h"
;
;// Declare your global variables here
;
;void main(void)
; 0000 0028 {

	.CSEG
_main:
; .FSTART _main
; 0000 0029 // Declare your local variables here
; 0000 002A unsigned char n;
; 0000 002B 
; 0000 002C // Interrupt system initialization
; 0000 002D // Optimize for speed
; 0000 002E #pragma optsize-
; 0000 002F // Make sure the interrupts are disabled
; 0000 0030 #asm("cli")
;	n -> R17
	CLI
; 0000 0031 // Low level interrupt: Off
; 0000 0032 // Round-robin scheduling for low level interrupt: Off
; 0000 0033 // Medium level interrupt: Off
; 0000 0034 // High level interrupt: On
; 0000 0035 // The interrupt vectors will be placed at the start of the Application FLASH section
; 0000 0036 n=(PMIC.CTRL & (~(PMIC_RREN_bm | PMIC_IVSEL_bm | PMIC_HILVLEN_bm | PMIC_MEDLVLEN_bm | PMIC_LOLVLEN_bm))) |
; 0000 0037 	PMIC_HILVLEN_bm;
	LDS  R30,162
	ANDI R30,LOW(0x38)
	ORI  R30,4
	MOV  R17,R30
; 0000 0038 CCP=CCP_IOREG_gc;
	LDI  R30,LOW(216)
	OUT  0x34,R30
; 0000 0039 PMIC.CTRL=n;
	STS  162,R17
; 0000 003A // Set the default priority for round-robin scheduling
; 0000 003B PMIC.INTPRI=0x00;
	LDI  R30,LOW(0)
	STS  161,R30
; 0000 003C // Restore optimization for size if needed
; 0000 003D #pragma optsize_default
; 0000 003E 
; 0000 003F // System clocks initialization
; 0000 0040 system_clocks_init();
	RCALL _system_clocks_init
; 0000 0041 
; 0000 0042 // Ports initialization
; 0000 0043 ports_init();
	RCALL _ports_init
; 0000 0044 
; 0000 0045 // Virtual Ports initialization
; 0000 0046 vports_init();
	RCALL _vports_init
; 0000 0047 
; 0000 0048 // Timer/Counter TCC0 initialization
; 0000 0049 tcc0_init();
	RCALL _tcc0_init
; 0000 004A 
; 0000 004B // Globally enable interrupts
; 0000 004C #asm("sei")
	SEI
; 0000 004D 
; 0000 004E while (1)
_0x3:
; 0000 004F       {
; 0000 0050       // Place your code here
; 0000 0051 
; 0000 0052       }
	RJMP _0x3
; 0000 0053 }
_0x6:
	RJMP _0x6
; .FEND
;/*******************************************************
;System clock initialization created by the
;CodeWizardAVR V3.32 Automatic Program Generator
;� Copyright 1998-2017 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;*******************************************************/
;
;// I/O Registers definitions
;#include <xmega128b1.h>
;
;// Standard definitions
;#include <stddef.h>
;
;// System Clocks initialization
;void system_clocks_init(void)
; 0001 0012 {

	.CSEG
_system_clocks_init:
; .FSTART _system_clocks_init
; 0001 0013 unsigned char n,s;
; 0001 0014 
; 0001 0015 // Optimize for speed
; 0001 0016 #pragma optsize-
; 0001 0017 // Save interrupts enabled/disabled state
; 0001 0018 s=SREG;
	ST   -Y,R17
	ST   -Y,R16
;	n -> R17
;	s -> R16
	IN   R16,63
; 0001 0019 // Disable interrupts
; 0001 001A #asm("cli")
	CLI
; 0001 001B 
; 0001 001C // Internal 2 MHz RC oscillator initialization
; 0001 001D // Enable the internal 2 MHz RC oscillator
; 0001 001E OSC.CTRL|=OSC_RC2MEN_bm;
	LDS  R30,80
	ORI  R30,1
	STS  80,R30
; 0001 001F // Wait for the internal 2 MHz RC oscillator to stabilize
; 0001 0020 while ((OSC.STATUS & OSC_RC2MRDY_bm)==0);
_0x20003:
	LDS  R30,81
	ANDI R30,LOW(0x1)
	BREQ _0x20003
; 0001 0021 
; 0001 0022 // Disable the auto-calibration of the internal 2 MHz RC oscillator
; 0001 0023 DFLLRC2M.CTRL=0<<DFLL_ENABLE_bp;
	LDI  R30,LOW(0)
	STS  104,R30
; 0001 0024 
; 0001 0025 // System Clock prescaler A division factor: 1
; 0001 0026 // System Clock prescalers B & C division factors: B:1, C:1
; 0001 0027 // ClkPer4: 2000.000 kHz
; 0001 0028 // ClkPer2: 2000.000 kHz
; 0001 0029 // ClkPer:  2000.000 kHz
; 0001 002A // ClkCPU:  2000.000 kHz
; 0001 002B n=(CLK.PSCTRL & (~(CLK_PSADIV_gm | CLK_PSBCDIV1_bm | CLK_PSBCDIV0_bm))) |
; 0001 002C 	CLK_PSADIV_1_gc | CLK_PSBCDIV_1_1_gc;
	LDS  R30,65
	ANDI R30,LOW(0x80)
	MOV  R17,R30
; 0001 002D CCP=CCP_IOREG_gc;
	LDI  R30,LOW(216)
	OUT  0x34,R30
; 0001 002E CLK.PSCTRL=n;
	STS  65,R17
; 0001 002F 
; 0001 0030 // Select the system clock source: 2 MHz Internal RC Osc.
; 0001 0031 n=(CLK.CTRL & (~CLK_SCLKSEL_gm)) | CLK_SCLKSEL_RC2M_gc;
	LDS  R30,64
	ANDI R30,LOW(0xF8)
	MOV  R17,R30
; 0001 0032 CCP=CCP_IOREG_gc;
	LDI  R30,LOW(216)
	OUT  0x34,R30
; 0001 0033 CLK.CTRL=n;
	STS  64,R17
; 0001 0034 
; 0001 0035 // Disable the unused oscillators: 32 kHz, 32 MHz, external clock/crystal oscillator, PLL
; 0001 0036 OSC.CTRL&= ~(OSC_RC32KEN_bm | OSC_RC32MEN_bm | OSC_XOSCEN_bm | OSC_PLLEN_bm);
	LDS  R30,80
	ANDI R30,LOW(0xE1)
	STS  80,R30
; 0001 0037 
; 0001 0038 // ClkPer output disabled
; 0001 0039 PORTCFG.CLKEVOUT&= ~(PORTCFG_CLKOUTSEL_gm | PORTCFG_CLKOUT_gm);
	LDS  R30,180
	ANDI R30,LOW(0xF0)
	STS  180,R30
; 0001 003A // Restore interrupts enabled/disabled state
; 0001 003B SREG=s;
	OUT  0x3F,R16
; 0001 003C // Restore optimization for size if needed
; 0001 003D #pragma optsize_default
; 0001 003E }
	RJMP _0x2060001
; .FEND
;
;/*******************************************************
;I/O Ports initialization created by the
;CodeWizardAVR V3.32 Automatic Program Generator
;� Copyright 1998-2017 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;*******************************************************/
;
;// I/O Registers definitions
;#include <xmega128b1.h>
;
;// Ports initialization
;void ports_init(void)
; 0002 000F {

	.CSEG
_ports_init:
; .FSTART _ports_init
; 0002 0010 // PORTA initialization
; 0002 0011 // OUT register
; 0002 0012 PORTA.OUT=0xF0;
	LDI  R30,LOW(240)
	STS  1540,R30
; 0002 0013 // Pin0: Input
; 0002 0014 // Pin1: Input
; 0002 0015 // Pin2: Input
; 0002 0016 // Pin3: Input
; 0002 0017 // Pin4: Output
; 0002 0018 // Pin5: Output
; 0002 0019 // Pin6: Output
; 0002 001A // Pin7: Output
; 0002 001B PORTA.DIR=0xF0;
	STS  1536,R30
; 0002 001C // Pin0 Output/Pull configuration: Totempole/No
; 0002 001D // Pin0 Input/Sense configuration: Sense both edges
; 0002 001E // Pin0 Inverted: Off
; 0002 001F PORTA.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	LDI  R30,LOW(0)
	STS  1552,R30
; 0002 0020 // Pin1 Output/Pull configuration: Totempole/No
; 0002 0021 // Pin1 Input/Sense configuration: Sense both edges
; 0002 0022 // Pin1 Inverted: Off
; 0002 0023 PORTA.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1553,R30
; 0002 0024 // Pin2 Output/Pull configuration: Totempole/No
; 0002 0025 // Pin2 Input/Sense configuration: Sense both edges
; 0002 0026 // Pin2 Inverted: Off
; 0002 0027 PORTA.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1554,R30
; 0002 0028 // Pin3 Output/Pull configuration: Totempole/No
; 0002 0029 // Pin3 Input/Sense configuration: Sense both edges
; 0002 002A // Pin3 Inverted: Off
; 0002 002B PORTA.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1555,R30
; 0002 002C // Pin4 Output/Pull configuration: Totempole/No
; 0002 002D // Pin4 Input/Sense configuration: Sense both edges
; 0002 002E // Pin4 Inverted: Off
; 0002 002F PORTA.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1556,R30
; 0002 0030 // Pin5 Output/Pull configuration: Totempole/No
; 0002 0031 // Pin5 Input/Sense configuration: Sense both edges
; 0002 0032 // Pin5 Inverted: Off
; 0002 0033 PORTA.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1557,R30
; 0002 0034 // Pin6 Output/Pull configuration: Totempole/No
; 0002 0035 // Pin6 Input/Sense configuration: Sense both edges
; 0002 0036 // Pin6 Inverted: Off
; 0002 0037 PORTA.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1558,R30
; 0002 0038 // Pin7 Output/Pull configuration: Totempole/No
; 0002 0039 // Pin7 Input/Sense configuration: Sense both edges
; 0002 003A // Pin7 Inverted: Off
; 0002 003B PORTA.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1559,R30
; 0002 003C // Interrupt 0 level: Disabled
; 0002 003D // Interrupt 1 level: Disabled
; 0002 003E PORTA.INTCTRL=(PORTA.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
; 0002 003F 	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1545
	ANDI R30,LOW(0xF0)
	STS  1545,R30
; 0002 0040 // Pin0 Pin Change interrupt 0: Off
; 0002 0041 // Pin1 Pin Change interrupt 0: Off
; 0002 0042 // Pin2 Pin Change interrupt 0: Off
; 0002 0043 // Pin3 Pin Change interrupt 0: Off
; 0002 0044 // Pin4 Pin Change interrupt 0: Off
; 0002 0045 // Pin5 Pin Change interrupt 0: Off
; 0002 0046 // Pin6 Pin Change interrupt 0: Off
; 0002 0047 // Pin7 Pin Change interrupt 0: Off
; 0002 0048 PORTA.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1546,R30
; 0002 0049 // Pin0 Pin Change interrupt 1: Off
; 0002 004A // Pin1 Pin Change interrupt 1: Off
; 0002 004B // Pin2 Pin Change interrupt 1: Off
; 0002 004C // Pin3 Pin Change interrupt 1: Off
; 0002 004D // Pin4 Pin Change interrupt 1: Off
; 0002 004E // Pin5 Pin Change interrupt 1: Off
; 0002 004F // Pin6 Pin Change interrupt 1: Off
; 0002 0050 // Pin7 Pin Change interrupt 1: Off
; 0002 0051 PORTA.INT1MASK=0x00;
	STS  1547,R30
; 0002 0052 
; 0002 0053 // PORTB initialization
; 0002 0054 // OUT register
; 0002 0055 PORTB.OUT=0x00;
	STS  1572,R30
; 0002 0056 // Pin0: Input
; 0002 0057 // Pin1: Input
; 0002 0058 // Pin2: Input
; 0002 0059 // Pin3: Input
; 0002 005A // Pin4: Input
; 0002 005B // Pin5: Input
; 0002 005C // Pin6: Input
; 0002 005D // Pin7: Input
; 0002 005E PORTB.DIR=0x00;
	STS  1568,R30
; 0002 005F // Pin0 Output/Pull configuration: Totempole/No
; 0002 0060 // Pin0 Input/Sense configuration: Sense both edges
; 0002 0061 // Pin0 Inverted: Off
; 0002 0062 PORTB.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1584,R30
; 0002 0063 // Pin1 Output/Pull configuration: Totempole/No
; 0002 0064 // Pin1 Input/Sense configuration: Sense both edges
; 0002 0065 // Pin1 Inverted: Off
; 0002 0066 PORTB.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1585,R30
; 0002 0067 // Pin2 Output/Pull configuration: Totempole/No
; 0002 0068 // Pin2 Input/Sense configuration: Sense both edges
; 0002 0069 // Pin2 Inverted: Off
; 0002 006A PORTB.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1586,R30
; 0002 006B // Pin3 Output/Pull configuration: Totempole/No
; 0002 006C // Pin3 Input/Sense configuration: Sense both edges
; 0002 006D // Pin3 Inverted: Off
; 0002 006E PORTB.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1587,R30
; 0002 006F // Pin4 Output/Pull configuration: Totempole/No
; 0002 0070 // Pin4 Input/Sense configuration: Sense both edges
; 0002 0071 // Pin4 Inverted: Off
; 0002 0072 PORTB.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1588,R30
; 0002 0073 // Pin5 Output/Pull configuration: Totempole/No
; 0002 0074 // Pin5 Input/Sense configuration: Sense both edges
; 0002 0075 // Pin5 Inverted: Off
; 0002 0076 PORTB.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1589,R30
; 0002 0077 // Pin6 Output/Pull configuration: Totempole/No
; 0002 0078 // Pin6 Input/Sense configuration: Sense both edges
; 0002 0079 // Pin6 Inverted: Off
; 0002 007A PORTB.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1590,R30
; 0002 007B // Pin7 Output/Pull configuration: Totempole/No
; 0002 007C // Pin7 Input/Sense configuration: Sense both edges
; 0002 007D // Pin7 Inverted: Off
; 0002 007E PORTB.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1591,R30
; 0002 007F // Interrupt 0 level: Disabled
; 0002 0080 // Interrupt 1 level: Disabled
; 0002 0081 PORTB.INTCTRL=(PORTB.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
; 0002 0082 	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1577
	ANDI R30,LOW(0xF0)
	STS  1577,R30
; 0002 0083 // Pin0 Pin Change interrupt 0: Off
; 0002 0084 // Pin1 Pin Change interrupt 0: Off
; 0002 0085 // Pin2 Pin Change interrupt 0: Off
; 0002 0086 // Pin3 Pin Change interrupt 0: Off
; 0002 0087 // Pin4 Pin Change interrupt 0: Off
; 0002 0088 // Pin5 Pin Change interrupt 0: Off
; 0002 0089 // Pin6 Pin Change interrupt 0: Off
; 0002 008A // Pin7 Pin Change interrupt 0: Off
; 0002 008B PORTB.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1578,R30
; 0002 008C // Pin0 Pin Change interrupt 1: Off
; 0002 008D // Pin1 Pin Change interrupt 1: Off
; 0002 008E // Pin2 Pin Change interrupt 1: Off
; 0002 008F // Pin3 Pin Change interrupt 1: Off
; 0002 0090 // Pin4 Pin Change interrupt 1: Off
; 0002 0091 // Pin5 Pin Change interrupt 1: Off
; 0002 0092 // Pin6 Pin Change interrupt 1: Off
; 0002 0093 // Pin7 Pin Change interrupt 1: Off
; 0002 0094 PORTB.INT1MASK=0x00;
	STS  1579,R30
; 0002 0095 
; 0002 0096 // PORTC initialization
; 0002 0097 // OUT register
; 0002 0098 PORTC.OUT=0x00;
	STS  1604,R30
; 0002 0099 // Pin0: Input
; 0002 009A // Pin1: Input
; 0002 009B // Pin2: Input
; 0002 009C // Pin3: Input
; 0002 009D // Pin4: Input
; 0002 009E // Pin5: Input
; 0002 009F // Pin6: Input
; 0002 00A0 // Pin7: Input
; 0002 00A1 PORTC.DIR=0x00;
	STS  1600,R30
; 0002 00A2 // Pin0 Output/Pull configuration: Totempole/No
; 0002 00A3 // Pin0 Input/Sense configuration: Sense both edges
; 0002 00A4 // Pin0 Inverted: Off
; 0002 00A5 PORTC.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1616,R30
; 0002 00A6 // Pin1 Output/Pull configuration: Totempole/No
; 0002 00A7 // Pin1 Input/Sense configuration: Sense both edges
; 0002 00A8 // Pin1 Inverted: Off
; 0002 00A9 PORTC.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1617,R30
; 0002 00AA // Pin2 Output/Pull configuration: Totempole/No
; 0002 00AB // Pin2 Input/Sense configuration: Sense both edges
; 0002 00AC // Pin2 Inverted: Off
; 0002 00AD PORTC.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1618,R30
; 0002 00AE // Pin3 Output/Pull configuration: Totempole/No
; 0002 00AF // Pin3 Input/Sense configuration: Sense both edges
; 0002 00B0 // Pin3 Inverted: Off
; 0002 00B1 PORTC.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1619,R30
; 0002 00B2 // Pin4 Output/Pull configuration: Totempole/No
; 0002 00B3 // Pin4 Input/Sense configuration: Sense both edges
; 0002 00B4 // Pin4 Inverted: Off
; 0002 00B5 PORTC.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1620,R30
; 0002 00B6 // Pin5 Output/Pull configuration: Totempole/No
; 0002 00B7 // Pin5 Input/Sense configuration: Sense both edges
; 0002 00B8 // Pin5 Inverted: Off
; 0002 00B9 PORTC.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1621,R30
; 0002 00BA // Pin6 Output/Pull configuration: Totempole/No
; 0002 00BB // Pin6 Input/Sense configuration: Sense both edges
; 0002 00BC // Pin6 Inverted: Off
; 0002 00BD PORTC.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1622,R30
; 0002 00BE // Pin7 Output/Pull configuration: Totempole/No
; 0002 00BF // Pin7 Input/Sense configuration: Sense both edges
; 0002 00C0 // Pin7 Inverted: Off
; 0002 00C1 PORTC.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1623,R30
; 0002 00C2 // PORTC Peripheral Output Remapping
; 0002 00C3 // OC0A Output: Pin 0
; 0002 00C4 // OC0B Output: Pin 1
; 0002 00C5 // OC0C Output: Pin 2
; 0002 00C6 // OC0D Output: Pin 3
; 0002 00C7 // USART0 XCK: Pin 1
; 0002 00C8 // USART0 RXD: Pin 2
; 0002 00C9 // USART0 TXD: Pin 3
; 0002 00CA // SPI MOSI: Pin 5
; 0002 00CB // SPI SCK: Pin 7
; 0002 00CC PORTC.REMAP=(0<<PORT_SPI_bp) | (0<<PORT_USART0_bp) | (0<<PORT_TC0D_bp) | (0<<PORT_TC0C_bp) | (0<<PORT_TC0B_bp) | (0<<POR ...
	STS  1614,R30
; 0002 00CD // Interrupt 0 level: Disabled
; 0002 00CE // Interrupt 1 level: Disabled
; 0002 00CF PORTC.INTCTRL=(PORTC.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
; 0002 00D0 	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1609
	ANDI R30,LOW(0xF0)
	STS  1609,R30
; 0002 00D1 // Pin0 Pin Change interrupt 0: Off
; 0002 00D2 // Pin1 Pin Change interrupt 0: Off
; 0002 00D3 // Pin2 Pin Change interrupt 0: Off
; 0002 00D4 // Pin3 Pin Change interrupt 0: Off
; 0002 00D5 // Pin4 Pin Change interrupt 0: Off
; 0002 00D6 // Pin5 Pin Change interrupt 0: Off
; 0002 00D7 // Pin6 Pin Change interrupt 0: Off
; 0002 00D8 // Pin7 Pin Change interrupt 0: Off
; 0002 00D9 PORTC.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1610,R30
; 0002 00DA // Pin0 Pin Change interrupt 1: Off
; 0002 00DB // Pin1 Pin Change interrupt 1: Off
; 0002 00DC // Pin2 Pin Change interrupt 1: Off
; 0002 00DD // Pin3 Pin Change interrupt 1: Off
; 0002 00DE // Pin4 Pin Change interrupt 1: Off
; 0002 00DF // Pin5 Pin Change interrupt 1: Off
; 0002 00E0 // Pin6 Pin Change interrupt 1: Off
; 0002 00E1 // Pin7 Pin Change interrupt 1: Off
; 0002 00E2 PORTC.INT1MASK=0x00;
	STS  1611,R30
; 0002 00E3 
; 0002 00E4 // PORTD initialization
; 0002 00E5 // OUT register
; 0002 00E6 PORTD.OUT=0x00;
	STS  1636,R30
; 0002 00E7 // Pin0: Input
; 0002 00E8 // Pin1: Input
; 0002 00E9 // Pin2: Input
; 0002 00EA PORTD.DIR=0x00;
	STS  1632,R30
; 0002 00EB // Pin0 Output/Pull configuration: Totempole/No
; 0002 00EC // Pin0 Input/Sense configuration: Sense both edges
; 0002 00ED // Pin0 Inverted: Off
; 0002 00EE PORTD.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1648,R30
; 0002 00EF // Pin1 Output/Pull configuration: Totempole/No
; 0002 00F0 // Pin1 Input/Sense configuration: Sense both edges
; 0002 00F1 // Pin1 Inverted: Off
; 0002 00F2 PORTD.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1649,R30
; 0002 00F3 // Pin2 Output/Pull configuration: Totempole/No
; 0002 00F4 // Pin2 Input/Sense configuration: Sense both edges
; 0002 00F5 // Pin2 Inverted: Off
; 0002 00F6 PORTD.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1650,R30
; 0002 00F7 // Interrupt 0 level: Disabled
; 0002 00F8 // Interrupt 1 level: Disabled
; 0002 00F9 PORTD.INTCTRL=(PORTD.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
; 0002 00FA 	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1641
	ANDI R30,LOW(0xF0)
	STS  1641,R30
; 0002 00FB // Pin0 Pin Change interrupt 0: Off
; 0002 00FC // Pin1 Pin Change interrupt 0: Off
; 0002 00FD // Pin2 Pin Change interrupt 0: Off
; 0002 00FE PORTD.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1642,R30
; 0002 00FF // Pin0 Pin Change interrupt 1: Off
; 0002 0100 // Pin1 Pin Change interrupt 1: Off
; 0002 0101 // Pin2 Pin Change interrupt 1: Off
; 0002 0102 PORTD.INT1MASK=0x00;
	STS  1643,R30
; 0002 0103 
; 0002 0104 // PORTE initialization
; 0002 0105 // OUT register
; 0002 0106 PORTE.OUT=0x00;
	STS  1668,R30
; 0002 0107 // Pin0: Input
; 0002 0108 // Pin1: Input
; 0002 0109 // Pin2: Input
; 0002 010A // Pin3: Input
; 0002 010B // Pin4: Input
; 0002 010C // Pin5: Output
; 0002 010D // Pin6: Input
; 0002 010E // Pin7: Input
; 0002 010F PORTE.DIR=0x20;
	LDI  R30,LOW(32)
	STS  1664,R30
; 0002 0110 // Pin0 Output/Pull configuration: Totempole/No
; 0002 0111 // Pin0 Input/Sense configuration: Sense both edges
; 0002 0112 // Pin0 Inverted: Off
; 0002 0113 PORTE.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	LDI  R30,LOW(0)
	STS  1680,R30
; 0002 0114 // Pin1 Output/Pull configuration: Totempole/No
; 0002 0115 // Pin1 Input/Sense configuration: Sense both edges
; 0002 0116 // Pin1 Inverted: Off
; 0002 0117 PORTE.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1681,R30
; 0002 0118 // Pin2 Output/Pull configuration: Totempole/No
; 0002 0119 // Pin2 Input/Sense configuration: Sense both edges
; 0002 011A // Pin2 Inverted: Off
; 0002 011B PORTE.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1682,R30
; 0002 011C // Pin3 Output/Pull configuration: Totempole/No
; 0002 011D // Pin3 Input/Sense configuration: Sense both edges
; 0002 011E // Pin3 Inverted: Off
; 0002 011F PORTE.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1683,R30
; 0002 0120 // Pin4 Output/Pull configuration: Totempole/No
; 0002 0121 // Pin4 Input/Sense configuration: Sense both edges
; 0002 0122 // Pin4 Inverted: Off
; 0002 0123 PORTE.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1684,R30
; 0002 0124 // Pin5 Output/Pull configuration: Totempole/No
; 0002 0125 // Pin5 Input/Sense configuration: Sense both edges
; 0002 0126 // Pin5 Inverted: Off
; 0002 0127 PORTE.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1685,R30
; 0002 0128 // Pin6 Output/Pull configuration: Totempole/No
; 0002 0129 // Pin6 Input/Sense configuration: Sense both edges
; 0002 012A // Pin6 Inverted: Off
; 0002 012B PORTE.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1686,R30
; 0002 012C // Pin7 Output/Pull configuration: Totempole/No
; 0002 012D // Pin7 Input/Sense configuration: Sense both edges
; 0002 012E // Pin7 Inverted: Off
; 0002 012F PORTE.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1687,R30
; 0002 0130 // PORTE Peripheral Output Remapping
; 0002 0131 // OC0A Output: Pin 0
; 0002 0132 // OC0B Output: Pin 1
; 0002 0133 // OC0C Output: Pin 2
; 0002 0134 // OC0D Output: Pin 3
; 0002 0135 // USART0 XCK: Pin 1
; 0002 0136 // USART0 RXD: Pin 2
; 0002 0137 // USART0 TXD: Pin 3
; 0002 0138 // SPI MOSI: Pin -1
; 0002 0139 // SPI SCK: Pin -1
; 0002 013A PORTE.REMAP=(0<<PORT_SPI_bp) | (0<<PORT_USART0_bp) | (0<<PORT_TC0D_bp) | (0<<PORT_TC0C_bp) | (0<<PORT_TC0B_bp) | (0<<POR ...
	STS  1678,R30
; 0002 013B // Interrupt 0 level: Disabled
; 0002 013C // Interrupt 1 level: Disabled
; 0002 013D PORTE.INTCTRL=(PORTE.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
; 0002 013E 	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1673
	ANDI R30,LOW(0xF0)
	STS  1673,R30
; 0002 013F // Pin0 Pin Change interrupt 0: Off
; 0002 0140 // Pin1 Pin Change interrupt 0: Off
; 0002 0141 // Pin2 Pin Change interrupt 0: Off
; 0002 0142 // Pin3 Pin Change interrupt 0: Off
; 0002 0143 // Pin4 Pin Change interrupt 0: Off
; 0002 0144 // Pin5 Pin Change interrupt 0: Off
; 0002 0145 // Pin6 Pin Change interrupt 0: Off
; 0002 0146 // Pin7 Pin Change interrupt 0: Off
; 0002 0147 PORTE.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1674,R30
; 0002 0148 // Pin0 Pin Change interrupt 1: Off
; 0002 0149 // Pin1 Pin Change interrupt 1: Off
; 0002 014A // Pin2 Pin Change interrupt 1: Off
; 0002 014B // Pin3 Pin Change interrupt 1: Off
; 0002 014C // Pin4 Pin Change interrupt 1: Off
; 0002 014D // Pin5 Pin Change interrupt 1: Off
; 0002 014E // Pin6 Pin Change interrupt 1: Off
; 0002 014F // Pin7 Pin Change interrupt 1: Off
; 0002 0150 PORTE.INT1MASK=0x00;
	STS  1675,R30
; 0002 0151 
; 0002 0152 // PORTG initialization
; 0002 0153 // OUT register
; 0002 0154 PORTG.OUT=0x00;
	STS  1732,R30
; 0002 0155 // Pin0: Input
; 0002 0156 // Pin1: Input
; 0002 0157 // Pin2: Input
; 0002 0158 // Pin3: Input
; 0002 0159 // Pin4: Input
; 0002 015A // Pin5: Input
; 0002 015B // Pin6: Input
; 0002 015C // Pin7: Input
; 0002 015D PORTG.DIR=0x00;
	STS  1728,R30
; 0002 015E // Pin0 Output/Pull configuration: Totempole/No
; 0002 015F // Pin0 Input/Sense configuration: Sense both edges
; 0002 0160 // Pin0 Inverted: Off
; 0002 0161 PORTG.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1744,R30
; 0002 0162 // Pin1 Output/Pull configuration: Totempole/No
; 0002 0163 // Pin1 Input/Sense configuration: Sense both edges
; 0002 0164 // Pin1 Inverted: Off
; 0002 0165 PORTG.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1745,R30
; 0002 0166 // Pin2 Output/Pull configuration: Totempole/No
; 0002 0167 // Pin2 Input/Sense configuration: Sense both edges
; 0002 0168 // Pin2 Inverted: Off
; 0002 0169 PORTG.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1746,R30
; 0002 016A // Pin3 Output/Pull configuration: Totempole/No
; 0002 016B // Pin3 Input/Sense configuration: Sense both edges
; 0002 016C // Pin3 Inverted: Off
; 0002 016D PORTG.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1747,R30
; 0002 016E // Pin4 Output/Pull configuration: Totempole/No
; 0002 016F // Pin4 Input/Sense configuration: Sense both edges
; 0002 0170 // Pin4 Inverted: Off
; 0002 0171 PORTG.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1748,R30
; 0002 0172 // Pin5 Output/Pull configuration: Totempole/No
; 0002 0173 // Pin5 Input/Sense configuration: Sense both edges
; 0002 0174 // Pin5 Inverted: Off
; 0002 0175 PORTG.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1749,R30
; 0002 0176 // Pin6 Output/Pull configuration: Totempole/No
; 0002 0177 // Pin6 Input/Sense configuration: Sense both edges
; 0002 0178 // Pin6 Inverted: Off
; 0002 0179 PORTG.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1750,R30
; 0002 017A // Pin7 Output/Pull configuration: Totempole/No
; 0002 017B // Pin7 Input/Sense configuration: Sense both edges
; 0002 017C // Pin7 Inverted: Off
; 0002 017D PORTG.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1751,R30
; 0002 017E // Interrupt 0 level: Disabled
; 0002 017F // Interrupt 1 level: Disabled
; 0002 0180 PORTG.INTCTRL=(PORTG.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
; 0002 0181 	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1737
	ANDI R30,LOW(0xF0)
	STS  1737,R30
; 0002 0182 // Pin0 Pin Change interrupt 0: Off
; 0002 0183 // Pin1 Pin Change interrupt 0: Off
; 0002 0184 // Pin2 Pin Change interrupt 0: Off
; 0002 0185 // Pin3 Pin Change interrupt 0: Off
; 0002 0186 // Pin4 Pin Change interrupt 0: Off
; 0002 0187 // Pin5 Pin Change interrupt 0: Off
; 0002 0188 // Pin6 Pin Change interrupt 0: Off
; 0002 0189 // Pin7 Pin Change interrupt 0: Off
; 0002 018A PORTG.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1738,R30
; 0002 018B // Pin0 Pin Change interrupt 1: Off
; 0002 018C // Pin1 Pin Change interrupt 1: Off
; 0002 018D // Pin2 Pin Change interrupt 1: Off
; 0002 018E // Pin3 Pin Change interrupt 1: Off
; 0002 018F // Pin4 Pin Change interrupt 1: Off
; 0002 0190 // Pin5 Pin Change interrupt 1: Off
; 0002 0191 // Pin6 Pin Change interrupt 1: Off
; 0002 0192 // Pin7 Pin Change interrupt 1: Off
; 0002 0193 PORTG.INT1MASK=0x00;
	STS  1739,R30
; 0002 0194 
; 0002 0195 // PORTM initialization
; 0002 0196 // OUT register
; 0002 0197 PORTM.OUT=0x00;
	STS  1892,R30
; 0002 0198 // Pin0: Input
; 0002 0199 // Pin1: Input
; 0002 019A // Pin2: Input
; 0002 019B // Pin3: Input
; 0002 019C // Pin4: Input
; 0002 019D // Pin5: Input
; 0002 019E // Pin6: Input
; 0002 019F // Pin7: Input
; 0002 01A0 PORTM.DIR=0x00;
	STS  1888,R30
; 0002 01A1 // Pin0 Output/Pull configuration: Totempole/No
; 0002 01A2 // Pin0 Input/Sense configuration: Sense both edges
; 0002 01A3 // Pin0 Inverted: Off
; 0002 01A4 PORTM.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1904,R30
; 0002 01A5 // Pin1 Output/Pull configuration: Totempole/No
; 0002 01A6 // Pin1 Input/Sense configuration: Sense both edges
; 0002 01A7 // Pin1 Inverted: Off
; 0002 01A8 PORTM.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1905,R30
; 0002 01A9 // Pin2 Output/Pull configuration: Totempole/No
; 0002 01AA // Pin2 Input/Sense configuration: Sense both edges
; 0002 01AB // Pin2 Inverted: Off
; 0002 01AC PORTM.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1906,R30
; 0002 01AD // Pin3 Output/Pull configuration: Totempole/No
; 0002 01AE // Pin3 Input/Sense configuration: Sense both edges
; 0002 01AF // Pin3 Inverted: Off
; 0002 01B0 PORTM.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1907,R30
; 0002 01B1 // Pin4 Output/Pull configuration: Totempole/No
; 0002 01B2 // Pin4 Input/Sense configuration: Sense both edges
; 0002 01B3 // Pin4 Inverted: Off
; 0002 01B4 PORTM.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1908,R30
; 0002 01B5 // Pin5 Output/Pull configuration: Totempole/No
; 0002 01B6 // Pin5 Input/Sense configuration: Sense both edges
; 0002 01B7 // Pin5 Inverted: Off
; 0002 01B8 PORTM.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1909,R30
; 0002 01B9 // Pin6 Output/Pull configuration: Totempole/No
; 0002 01BA // Pin6 Input/Sense configuration: Sense both edges
; 0002 01BB // Pin6 Inverted: Off
; 0002 01BC PORTM.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1910,R30
; 0002 01BD // Pin7 Output/Pull configuration: Totempole/No
; 0002 01BE // Pin7 Input/Sense configuration: Sense both edges
; 0002 01BF // Pin7 Inverted: Off
; 0002 01C0 PORTM.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1911,R30
; 0002 01C1 // Interrupt 0 level: Disabled
; 0002 01C2 // Interrupt 1 level: Disabled
; 0002 01C3 PORTM.INTCTRL=(PORTM.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
; 0002 01C4 	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1897
	ANDI R30,LOW(0xF0)
	STS  1897,R30
; 0002 01C5 // Pin0 Pin Change interrupt 0: Off
; 0002 01C6 // Pin1 Pin Change interrupt 0: Off
; 0002 01C7 // Pin2 Pin Change interrupt 0: Off
; 0002 01C8 // Pin3 Pin Change interrupt 0: Off
; 0002 01C9 // Pin4 Pin Change interrupt 0: Off
; 0002 01CA // Pin5 Pin Change interrupt 0: Off
; 0002 01CB // Pin6 Pin Change interrupt 0: Off
; 0002 01CC // Pin7 Pin Change interrupt 0: Off
; 0002 01CD PORTM.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1898,R30
; 0002 01CE // Pin0 Pin Change interrupt 1: Off
; 0002 01CF // Pin1 Pin Change interrupt 1: Off
; 0002 01D0 // Pin2 Pin Change interrupt 1: Off
; 0002 01D1 // Pin3 Pin Change interrupt 1: Off
; 0002 01D2 // Pin4 Pin Change interrupt 1: Off
; 0002 01D3 // Pin5 Pin Change interrupt 1: Off
; 0002 01D4 // Pin6 Pin Change interrupt 1: Off
; 0002 01D5 // Pin7 Pin Change interrupt 1: Off
; 0002 01D6 PORTM.INT1MASK=0x00;
	STS  1899,R30
; 0002 01D7 
; 0002 01D8 // PORTR initialization
; 0002 01D9 // OUT register
; 0002 01DA PORTR.OUT=0x00;
	STS  2020,R30
; 0002 01DB // Pin0: Input
; 0002 01DC // Pin1: Input
; 0002 01DD PORTR.DIR=0x00;
	STS  2016,R30
; 0002 01DE // Pin0 Output/Pull configuration: Totempole/No
; 0002 01DF // Pin0 Input/Sense configuration: Sense both edges
; 0002 01E0 // Pin0 Inverted: Off
; 0002 01E1 PORTR.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  2032,R30
; 0002 01E2 // Pin1 Output/Pull configuration: Totempole/No
; 0002 01E3 // Pin1 Input/Sense configuration: Sense both edges
; 0002 01E4 // Pin1 Inverted: Off
; 0002 01E5 PORTR.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  2033,R30
; 0002 01E6 // Interrupt 0 level: Disabled
; 0002 01E7 // Interrupt 1 level: Disabled
; 0002 01E8 PORTR.INTCTRL=(PORTR.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
; 0002 01E9 	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,2025
	ANDI R30,LOW(0xF0)
	STS  2025,R30
; 0002 01EA // Pin0 Pin Change interrupt 0: Off
; 0002 01EB // Pin1 Pin Change interrupt 0: Off
; 0002 01EC PORTR.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  2026,R30
; 0002 01ED // Pin0 Pin Change interrupt 1: Off
; 0002 01EE // Pin1 Pin Change interrupt 1: Off
; 0002 01EF PORTR.INT1MASK=0x00;
	STS  2027,R30
; 0002 01F0 }
	RET
; .FEND
;
;// Virtual Ports initialization
;void vports_init(void)
; 0002 01F4 {
_vports_init:
; .FSTART _vports_init
; 0002 01F5 // PORTA mapped to VPORT0
; 0002 01F6 // PORTB mapped to VPORT1
; 0002 01F7 PORTCFG.VPCTRLA=PORTCFG_VP13MAP_PORTB_gc | PORTCFG_VP02MAP_PORTA_gc;
	LDI  R30,LOW(16)
	STS  178,R30
; 0002 01F8 // PORTC mapped to VPORT2
; 0002 01F9 // PORTD mapped to VPORT3
; 0002 01FA PORTCFG.VPCTRLB=PORTCFG_VP13MAP_PORTD_gc | PORTCFG_VP02MAP_PORTC_gc;
	LDI  R30,LOW(50)
	STS  179,R30
; 0002 01FB }
	RET
; .FEND
;
;/*******************************************************
;Timers/Counters initialization created by the
;CodeWizardAVR V3.32 Automatic Program Generator
;� Copyright 1998-2017 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;*******************************************************/
;
;// I/O Registers definitions
;#include <xmega128b1.h>
;
;// Disable a Timer/Counter type TC0
;void tc0_disable(TC0_t *ptc)
; 0003 000F {

	.CSEG
_tc0_disable:
; .FSTART _tc0_disable
; 0003 0010 // Timer/Counter off
; 0003 0011 ptc->CTRLA=TC_CLKSEL_OFF_gc;
	ST   -Y,R17
	ST   -Y,R16
	MOVW R16,R26
;	*ptc -> R16,R17
	LDI  R30,LOW(0)
	ST   X,R30
; 0003 0012 // Issue a reset command
; 0003 0013 ptc->CTRLFSET=TC_CMD_RESET_gc;
	ADIW R26,9
	LDI  R30,LOW(12)
	ST   X,R30
; 0003 0014 }
	RJMP _0x2060001
; .FEND
;
;// Timer/Counter TCC0 initialization
;void tcc0_init(void)
; 0003 0018 {
_tcc0_init:
; .FSTART _tcc0_init
; 0003 0019 unsigned char s;
; 0003 001A unsigned char n;
; 0003 001B 
; 0003 001C // Note: The correct PORTC direction for the Compare Channels
; 0003 001D // outputs is configured in the ports_init function.
; 0003 001E 
; 0003 001F // Save interrupts enabled/disabled state
; 0003 0020 s=SREG;
	ST   -Y,R17
	ST   -Y,R16
;	s -> R17
;	n -> R16
	IN   R17,63
; 0003 0021 // Disable interrupts
; 0003 0022 #asm("cli")
	CLI
; 0003 0023 
; 0003 0024 // Disable and reset the timer/counter just to be sure
; 0003 0025 tc0_disable(&TCC0);
	LDI  R26,LOW(2048)
	LDI  R27,HIGH(2048)
	RCALL _tc0_disable
; 0003 0026 // Clock source: ClkPer/1
; 0003 0027 TCC0.CTRLA=TC_CLKSEL_DIV1_gc;
	LDI  R30,LOW(1)
	STS  2048,R30
; 0003 0028 // Mode: Normal Operation, Overflow Int./Event on TOP
; 0003 0029 // Compare/Capture on channel A: Off
; 0003 002A // Compare/Capture on channel B: Off
; 0003 002B // Compare/Capture on channel C: Off
; 0003 002C // Compare/Capture on channel D: Off
; 0003 002D TCC0.CTRLB=(0<<TC0_CCDEN_bp) | (0<<TC0_CCCEN_bp) | (0<<TC0_CCBEN_bp) | (0<<TC0_CCAEN_bp) |
; 0003 002E 	TC_WGMODE_NORMAL_gc;
	LDI  R30,LOW(0)
	STS  2049,R30
; 0003 002F // Capture event source: None
; 0003 0030 // Capture event action: None
; 0003 0031 TCC0.CTRLD=TC_EVACT_OFF_gc | TC_EVSEL_OFF_gc;
	STS  2051,R30
; 0003 0032 
; 0003 0033 // Set Timer/Counter in Normal mode
; 0003 0034 TCC0.CTRLE=TC_BYTEM_NORMAL_gc;
	STS  2052,R30
; 0003 0035 
; 0003 0036 // Overflow interrupt: High Level
; 0003 0037 // Error interrupt: Disabled
; 0003 0038 TCC0.INTCTRLA=TC_ERRINTLVL_OFF_gc | TC_OVFINTLVL_HI_gc;
	LDI  R30,LOW(3)
	STS  2054,R30
; 0003 0039 
; 0003 003A // Compare/Capture channel A interrupt: Disabled
; 0003 003B // Compare/Capture channel B interrupt: Disabled
; 0003 003C // Compare/Capture channel C interrupt: Disabled
; 0003 003D // Compare/Capture channel D interrupt: Disabled
; 0003 003E TCC0.INTCTRLB=TC_CCDINTLVL_OFF_gc | TC_CCCINTLVL_OFF_gc | TC_CCBINTLVL_OFF_gc | TC_CCAINTLVL_OFF_gc;
	LDI  R30,LOW(0)
	STS  2055,R30
; 0003 003F 
; 0003 0040 // High resolution extension: Off
; 0003 0041 HIRESC.CTRLA&= ~HIRES_HREN0_bm;
	LDS  R30,2192
	ANDI R30,0xFE
	STS  2192,R30
; 0003 0042 
; 0003 0043 // Advanced Waveform Extension initialization
; 0003 0044 // Optimize for speed
; 0003 0045 #pragma optsize-
; 0003 0046 // Disable locking the AWEX configuration registers just to be sure
; 0003 0047 n=MCU.AWEXLOCK & (~MCU_AWEXCLOCK_bm);
	LDS  R30,153
	ANDI R30,0xFE
	MOV  R16,R30
; 0003 0048 CCP=CCP_IOREG_gc;
	LDI  R30,LOW(216)
	OUT  0x34,R30
; 0003 0049 MCU.AWEXLOCK=n;
	STS  153,R16
; 0003 004A // Restore optimization for size if needed
; 0003 004B #pragma optsize_default
; 0003 004C 
; 0003 004D // Pattern generation: Off
; 0003 004E // Dead time insertion: Off
; 0003 004F AWEXC.CTRL=(0<<AWEX_PGM_bp) | (0<<AWEX_CWCM_bp) | (0<<AWEX_DTICCDEN_bp) | (0<<AWEX_DTICCCEN_bp) |
; 0003 0050 	(0<<AWEX_DTICCBEN_bp) | (0<<AWEX_DTICCAEN_bp);
	LDI  R30,LOW(0)
	STS  2176,R30
; 0003 0051 
; 0003 0052 // Fault protection initialization
; 0003 0053 // Fault detection on OCD Break detection: On
; 0003 0054 // Fault detection restart mode: Latched Mode
; 0003 0055 // Fault detection action: None (Fault protection disabled)
; 0003 0056 AWEXC.FDCTRL=(AWEXC.FDCTRL & (~(AWEX_FDDBD_bm | AWEX_FDMODE_bm | AWEX_FDACT_gm))) |
; 0003 0057 	(0<<AWEX_FDDBD_bp) | (0<<AWEX_FDMODE_bp) | AWEX_FDACT_NONE_gc;
	LDS  R30,2179
	ANDI R30,LOW(0xE8)
	STS  2179,R30
; 0003 0058 // Fault detect events:
; 0003 0059 // Event channel 0: Off
; 0003 005A // Event channel 1: Off
; 0003 005B // Event channel 2: Off
; 0003 005C // Event channel 3: Off
; 0003 005D // Event channel 4: Off
; 0003 005E // Event channel 5: Off
; 0003 005F // Event channel 6: Off
; 0003 0060 // Event channel 7: Off
; 0003 0061 AWEXC.FDEMASK=0b00000000;
	LDI  R30,LOW(0)
	STS  2178,R30
; 0003 0062 // Make sure the fault detect flag is cleared
; 0003 0063 AWEXC.STATUS|=AWEXC.STATUS & AWEX_FDF_bm;
	LDI  R26,LOW(2180)
	LDI  R27,HIGH(2180)
	MOV  R0,R26
	LD   R26,X
	LDS  R30,2180
	ANDI R30,LOW(0x4)
	OR   R30,R26
	MOV  R26,R0
	ST   X,R30
; 0003 0064 
; 0003 0065 // Clear the interrupt flags
; 0003 0066 TCC0.INTFLAGS=TCC0.INTFLAGS;
	LDS  R30,2060
	STS  2060,R30
; 0003 0067 // Set Counter register
; 0003 0068 TCC0.CNT=0x0000;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  2080,R30
	STS  2080+1,R31
; 0003 0069 // Set Period register
; 0003 006A TCC0.PER=0x07CF;
	LDI  R30,LOW(1999)
	LDI  R31,HIGH(1999)
	STS  2086,R30
	STS  2086+1,R31
; 0003 006B // Set channel A Compare/Capture register
; 0003 006C TCC0.CCA=0x0000;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  2088,R30
	STS  2088+1,R31
; 0003 006D // Set channel B Compare/Capture register
; 0003 006E TCC0.CCB=0x0000;
	STS  2090,R30
	STS  2090+1,R31
; 0003 006F // Set channel C Compare/Capture register
; 0003 0070 TCC0.CCC=0x0000;
	STS  2092,R30
	STS  2092+1,R31
; 0003 0071 // Set channel D Compare/Capture register
; 0003 0072 TCC0.CCD=0x0000;
	STS  2094,R30
	STS  2094+1,R31
; 0003 0073 
; 0003 0074 // Restore interrupts enabled/disabled state
; 0003 0075 SREG=s;
	OUT  0x3F,R17
; 0003 0076 }
_0x2060001:
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;
;// Timer/Counter TCC0 Overflow/Underflow interrupt service routine
;interrupt [TCC0_OVF_vect] void tcc0_overflow_isr(void)
; 0003 007A {
_tcc0_overflow_isr:
; .FSTART _tcc0_overflow_isr
; 0003 007B // Write your code here
; 0003 007C 
; 0003 007D }
	RETI
; .FEND
;

	.CSEG

	.CSEG

	.CSEG

	.CSEG
;RUNTIME LIBRARY

	.CSEG
;END OF CODE MARKER
__END_OF_CODE:
