	.ORIG	x3000
;initialize the stack pointer
	LD	R6,STACK

;set up the keyboard interrupt vector table entry
	LD	R5,A
	STI	R5,B
	
;enable keyboard interrupts
	LD	R1,IE		
	STI	R1,KBSR	

;flag to change state
	AND	R5,R5,#0

;start of actual user program to print the checkerboard	
OUT11	LEA	R2,O11		;a pointer to the string *1
	JSR	OUTPUT
	ADD	R5,R5,#0	;flag to change state
	BRz	OUT12
	BRp	OUT21
OUT12	LEA	R2,O12		;a pointer to the string *2	
	JSR	OUTPUT
	ADD	R5,R5,#0	;flag to change state
	BRz	OUT11
	BRp	OUT21
OUT21	LEA	R2,O21		;a pointer to the string #1
	JSR	OUTPUT
	ADD	R5,R5,#0	;flag to change state
	BRz	OUT11
	BRp	OUT22
OUT22	LEA	R2,O22		;a pointer to the string #2
	JSR	OUTPUT
	ADD	R5,R5,#0	;flag to change state
	BRz	OUT11
	BRp	OUT21

;puts
OUTPUT	LDR	R0,R2,#0	;retrieve the character
	BRz	DELAY		;after puts, delay
LOOP	LDI	R3,DSR		
	BRzp	LOOP
	STI	R0,DDR		;write the character
	ADD	R2,R2,#1	;increment pointer
	BR	OUTPUT
DELAY 	LD 	R4, COUNT1	;delay
REP 	ADD 	R4, R4, #-1
	BRp 	REP
	RET


STACK	.FILL	x3000		;the stack pointer of SSP
A	.FILL	x2000		
B	.FILL	x0180		;x01+vector
IE	.FILL	x4000		;initialize IE

O11	.STRINGZ	"**    **    **    **    **    **    **    **    \n"
O12	.STRINGZ	"   **    **   **    **    **    **    **    \n"  
O21	.STRINGZ	"##    ##    ##    ##    ##    ##    ##    ##   \n"
O22	.STRINGZ	"    ##    ##    ##    ##    ##    ##    ##    ##   \n"

DSR	.FILL	xFE04
DDR	.FILL	xFE06
KBSR	.FILL	xFE00
KBDR	.FILL	xFE02

COUNT1	.FILL 	#32767
	.END