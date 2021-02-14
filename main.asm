#include "./macros.asm"
#include "./debug.asm"
#include "./twi.asm"
#include "./spi.asm"
#include "./gameboard.asm"
#include "./damatrix_driver.asm"
#include "./waits.asm"
#include "./gameengine.asm"
#include "./variable_stack.asm"


.equ  ADDR_RIGHT8 = $25
.equ  ADDR_LEFT8 = $24
.equ  ADDR_BUTTON = $27
;.equ  SLA_W         = (ADDR_RIGHT8  << 1) | 0
;.equ  SLA_R         = (ADDR_RIGHT8  << 1) | 1
.equ SCL = PC5
.equ SDA = PC4
.equ DATA = 0b01010101

.equ SPI_DDR = DDRB
.equ CS = PINB2
.equ MOSI = PINB3
.equ MISO = PINB4
.equ SCK = PINB5


rjmp MAIN

.dseg
GAMEBOARD:
	.byte 64
	
	    ; "YY000000","0000YY00", \
		; "00YY0000","00YY0000", \
		; "0000Y0BB","0Y0000BB", \
		; "0000Y000","0Y000000", \
		; "0000Y000","0Y000000", \
		; "0000Y0BB","0Y0000BB", \
		; "00YY0000","00YY0000", \
		; "YY000000","0000YY00"

.org $400
STACK:

.cseg

MAIN:

	; init stack
	ldi		r16,HIGH(RAMEND)
	out		SPH,r16
	ldi		r16,LOW(RAMEND)
	out		SPL,r16

	ldi 	YH,HIGH(STACK)
	ldi 	YL,LOW(STACK)

	ldi 	r16,100

	call 	gameboard_init
	call	gamestate_init
	call	logger_init

	; First in stack
	_LIT $F0
	
	_LIT $54
	_LIT $55
	_LIT $64
	_LIT $65
	
	_LIT $38
	_LIT $37
	_LIT $36
	_LIT $35


AGAIN:
	; get input
	; handle input
	; update board

	call	damatrix_draw
	call	gamestate_draw_stack
	
	dec 	r16
	cpi 	r16,0
	brne 	AGAIN
	;call 	update_gamestate
	;ldi		r16,0b01001010
	;call	gamestate_draw_block
	ldi 	r16,100

	jmp 	AGAIN