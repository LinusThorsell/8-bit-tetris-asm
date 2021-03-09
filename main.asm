jmp MAIN
#include "./macros.asm"
#include "./lcd.asm"
#include "./debug.asm"
#include "./twi.asm"
#include "./spi.asm"
#include "./gameboard.asm"
#include "./damatrix_driver.asm"
#include "./waits.asm"
#include "./gameengine_line.asm"
#include "./gameengine.asm"


.equ  ADDR_RIGHT8 = $25
.equ  ADDR_LEFT8 = $24
.equ  ADDR_BUTTON = $27
.equ  ADDR_LCD = $20
.equ  SLA_W         = (ADDR_RIGHT8  << 1) | 0
.equ  SLA_R         = (ADDR_RIGHT8  << 1) | 1
.equ SCL = PC5
.equ SDA = PC4
.equ DATA = 0b01010101

.equ SPI_DDR = DDRB
.equ CS = PINB2
.equ MOSI = PINB3
.equ MISO = PINB4
.equ SCK = PINB5
; r23 current color
.dseg
GAMEBOARD:
	.byte 128
	
	    ; "YY000000","0000YY00", \
		; "00YY0000","00YY0000", \
		; "0000Y0BB","0Y0000BB", \
		; "0000Y000","0Y000000", \
		; "0000Y000","0Y000000", \
		; "0000Y0BB","0Y0000BB", \
		; "00YY0000","00YY0000", \
		; "YY000000","0000YY00"

MOVEMENT_DIRECTION:
	.byte 1

SCORE:
	.byte 2

.org $500
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
	
	call 	gameboard_init
	call	gamestate_init
	call	logger_init


	; call 	LCD_INIT

	; First in stack
	_LIT $F0
	
	; _LIT $51
	; _LIT $52
	; _LIT $61
	; _LIT $62
	
	; _LIT $31
	; _LIT $32
	; _LIT $33
	; _LIT $34
	ldi 	r23,'Y'
	_LIT $E0

	_LIT $1A
	_LIT $0B
	_LIT $0A
	_LIT $1B

	ldi 	r16,0
	sts 	SCORE,r16
	call 	gamestate_write_score
	
;backlight
	; push 	r16
	; push  	r17
	; ldi 	r17,$40
	; ldi 	r16,8
	; ; ldi 	r16,0
	; call 	TWI_SEND
	; pop 	r17
	; pop 	r16

	; ldi 	r16,0b00001000
	; ldi 	r16,0b00000000
	; call 	WRITE_RAW

	ldi 	r16,50
AGAIN:

	; call 	LCD_INIT

	; call 	LCD_HOME
	; ldi 	r16, $42
	; call 	LCD_ASCII

	; get input
	; handle input
	; update board

	; call 	damatrix_clear
	call	damatrix_draw
	call	gamestate_draw_stack
	call 	read_keys
	
	dec 	r16
	cpi 	r16,0
	brne 	AGAIN
	call 	gamestate_update_board
	call 	gamestate_write_score
	ldi 	r16,1
	
	jmp 	AGAIN