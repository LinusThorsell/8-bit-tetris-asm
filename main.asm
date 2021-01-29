#include "./debug.asm"
#include "./twi.asm"
#include "./gameboard.asm"


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


GAMEBOARD:
	.db "00000000" \
		"00000000" \
		"000YY000" \
		"000YY000" \
		"00000000" \
		"00000000" \
		"00000000" \
		"00000000"

rjmp MAIN

MAIN:

	; init stack
	ldi		r16,HIGH(RAMEND)
	out		SPH,r16
	ldi		r16,LOW(RAMEND)
	out		SPL,r16

	call 	WAIT_L

    ;call    logger_init
	call    SPI_INIT
	call 	WAIT_L
    ; ldi     r16,9
    ; call    RIGHT8_WRITE
    
    ; ldi     r16,9
	; call 	LEFT8_WRITE	
	;	call 	TWI_READ

    ;call    WRITE_RAW

	;ldi		r16,1
	;out		PB2,r16

	ldi 	r16,0b00000000
	; ldi 	r16,0b11111111
	call 	SPI_SEND
	ldi 	r16,0b00000000
	; ldi 	r16,0b11111111
	call 	SPI_SEND
	; ldi 	r16,0b00000000
	ldi 	r16,0b11111111
	call 	SPI_SEND
	ldi 	r16,0b00000000
	call 	SPI_SEND

	; ldi 	r16,0b00000000
	ldi 	r16,0b11111111
	call 	SPI_SEND
	ldi 	r16,0b00000000
	; ldi 	r16,0b11111111
	call 	SPI_SEND
	ldi 	r16,0b00000000
	; ldi 	r16,0b11111111
	call 	SPI_SEND
	ldi 	r16,0b00000000
	call 	SPI_SEND
	
	ldi 	r16,(0 << CS)|(1 << MOSI)|(1 << SCK)
	out 	SPI_DDR,r16

	; ldi		r16,1
	; out		PB2,r16
	; call 	WAIT
	; ldi		r16,0
	; out		PB2,r16
	;call 	PRINT_GAMEBOARD

AGAIN:
    ;ldi     r16,(ADDR_BUTTON  << 1) | 1
	;call	TWI_READ
	;call	logger_skicka
	;ldi 	r16,$0A
	;call 	logger_skicka

	call 	PRINT_GAMEBOARD

	rjmp 	AGAIN



SPI_INIT:
	push 	r16

	ldi 	r16,(1 << CS)|(1 << MOSI)|(1 << SCK)
	out 	SPI_DDR,r16
	ldi 	r16,(1 << SPE)|(1 << MSTR)|(1 << SPR1)|(1 << SPR0)
	out 	SPCR,r16

	pop 	r16
	ret

SPI_SEND:

	push	r17
	push	r18	

	out 	SPDR,r16

SPI_SEND_WAIT:
 	in 		r17,SPSR
 	ldi 	r18,(1<<SPIF)
 	and 	r17,r18

 	cpi 	r17,$00
 	breq 	SPI_SEND_WAIT

	call	WAIT_L

	pop		r18
	pop 	r17
	ret

WAIT:
    push    r16
	ldi 	r16,$B0
WAIT_1:
	inc 	r16
	brne 	WAIT_1
    pop     r16
	ret

WAIT_L:
; 	push 	r16
; 	ldi 	r16,$E0
; WAIT_L_1:
; 	adiw	r24,1	; ~16ms
; 	brne	WAIT_L_1
; 	inc 	r16
; 	brne 	WAIT_L_1
; 	pop 	r16
	ret