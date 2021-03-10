jmp MAIN
#include "./macros.asm"
#include "./lcd.asm"
#include "./debug.asm"
#include "./twi.asm"
#include "./spi.asm"
#include "./gameboard.asm"
#include "./damatrix_driver.asm"
#include "./waits.asm"
#include "./gameengine_gameover.asm"
#include "./gameengine_rotate.asm"
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
	.byte 2

SCORE:
	.byte 2

BLOCK_TYPE:
	.byte 2

ROTATION_STATE:
	.byte 2

MOV_DOWN:
	.byte 2
MOV_RIGHT:
	.byte 2

STATES:
	.byte 150

.org $800
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
	call	gameengine_init_states
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
	_LIT 	$E0

	ldi 	r23,0
	sts 	MOV_DOWN,r23
	sts 	MOV_RIGHT,r23
	ldi		r23,1
	sts 	ROTATION_STATE,r23
	ldi 	r23,4
	sts 	BLOCK_TYPE,r23

	ldi 	r23,'B'
	call 	add_new_block

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

	; buzzer code
	; ldi 	r16, $FF
    ; out     DDRB,r16
	; sbi     PORTB,PB1

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
	call	gamestate_draw_stack
	call	damatrix_draw
	call 	read_keys
	
	dec 	r16
	cpi 	r16,0
	brne 	AGAIN
	call 	gamestate_update_board
	call 	gamestate_write_score
	push 	r17
	ldi 	r16,100
	lds 	r17,SCORE
	sub 	r16,r17	
	pop 	r17
	jmp 	AGAIN