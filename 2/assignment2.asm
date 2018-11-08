	.ORIG	x3000
	LEA	R1,NAME		;load the address of NAME entered to R1
	AND	R6,R6,#0	;FLAG to count the required name found in directory

;printf the Prompt 
	LEA	R0,PROMPT	;load the address of the Prompt to R0
	TRAP 	x22		;puts the prompt

;Input	the NAME: store every character in 2's complement in men[NAME]
	LD	R2,NEGENTER	;load the 2's complement of the ASCII of 'Enter' to R2
AGAIN	TRAP	x20		;getc
	TRAP	x21		;outc
	NOT 	R0,R0
	ADD	R0,R0,#1
	STR	R0,R1,#0	;store the character entered
	ADD	R1,R1,#1
	ADD	R3,R0,R2	
	BRz	SEARCH		;finish the input process
	BRnp	AGAIN		;continue to input process

;SEARCH the FIRSTNAME in directory
SEARCH	LD	R2,HEADN
SEARCHF	LEA	R1,NAME	
	ADD	R3,R2,#2	;load the address of Firstname's node
	LDR	R4,R3,#0
CHECKF	AND	R5,R5,#0
	LDR	R5,R4,#0	;load the ASCII of Firstname's character
	BRz	OUTPUTF		;if test to the last character of Firstname, OUTPUTF
	LDR	R0,R1,#0	
	ADD	R5,R0,R5
	BRnp	SEARCH2		;if the character don't match, move to the lastlname's node
	ADD	R4,R4,#1	;continue to test 
	ADD	R1,R1,#1
	BR	CHECKF
OUTPUTF LDR	R0,R1,#0	;check if the NAME entered is also end
	ADD	R0,R0,#10
	BRnp	SEARCH2		;if not, move to test the lastname's node
	ADD	R6,R6,#1	
	LDR	R4,R2,#3	;outputs the lastname
	AND	R0,R0,#0
	ADD	R0,R0,R4
	TRAP	x22
	LD	R0,SP		;output ' '
	TRAP	x21
	LDR	R4,R2,#2	;outputs the Firstname
	AND	R0,R0,#0
	ADD	R0,R0,R4
	TRAP	x22
	LD	R0,SP		;output ' '
	TRAP	x21
	LDR	R4,R2,#1	;outputs the room's number
	AND	R0,R0,#0
	ADD	R0,R0,R4
	TRAP	x22
	LD	R0,CR		;return
	TRAP	x21
	BR	NEXTF		;move to the next node
	
SEARCH2 LEA	R1,NAME		
	ADD	R3,R2,#3	;load the address of Lastname's node
	LDR	R4,R3,#0
CHECKL	AND	R5,R5,#0
	LDR	R5,R4,#0	;load the ASCII of Lastname's character
	BRz	OUTPUTL		;if test to the last character of Lastname, OUTPUTF
	LDR	R0,R1,#0
	ADD	R5,R0,R5
	BRnp	NEXTF		;if the character don't match, move to the Next node
	ADD	R4,R4,#1	;continue to test
	ADD	R1,R1,#1
	BR	CHECKL
OUTPUTL LDR	R0,R1,#0	;check if the NAME entered is also end
	ADD	R0,R0,#10
	BRnp	NEXTF		;if not, move to test NEXTF
	ADD	R6,R6,#1
	LDR	R4,R2,#3	;outputs the Lastname
	AND	R0,R0,#0
	ADD	R0,R0,R4
	TRAP	x22
	LD	R0,SP		;output ' '
	TRAP	x21
	LDR	R4,R2,#2	;outputs the Lastname
	AND	R0,R0,#0
	ADD	R0,R0,R4
	TRAP	x22
	LD	R0,SP		;output ' '
	TRAP	x21
	LDR	R4,R2,#1	;outputs the room's number
	AND	R0,R0,#0
	ADD	R0,R0,R4
	TRAP	x22
	LD	R0,CR		;return
	TRAP	x21
	
NEXTF	LDR	R2,R2,#0	;check if the end of directory
	BRz	END		
	BRnp	SEARCHF		;if not the end, continue the loop
END	ADD	R6,R6,#0	
	BRz	OUTPUTN		;none required data found in directory
	TRAP	x25		;halt
OUTPUTN	LEA	R0,NONE		;outputs 'No Entry'
	TRAP	x22
	TRAP	x25

PROMPT	.STRINGZ	"Type a name and press Enter:"
NONE	.STRINGZ	"No Entry"
NEGENTER .FILL 	x000A		;the ASCII of 'Enter'		
NAME	.BLKW 	#16		;the address space for NAME entered
HEADN	.FILL	x4000
SP	.FILL	x20
CR	.FILL	x0D
	.END