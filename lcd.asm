;=============================
;LCD Settings

.equ FN_SET =	0b00101000
.equ DISP_ON =	0b00001111 ; DISPLAY ON, CURSOR ON, BLIKNING ON
;.equ DISP_ON =	0b00001100
.equ LCD_CLR =	0b00000001
.equ E_MODE =	0b00000110

;=============================

LCD_INIT:
	push 	r16

	;0b00000111 signal
	;0b11110000 data
	;0b00001000 backlight

	;Turn on backlight
	; ldi 	r16, 0b00000000
	; ldi 	r16, 0b00000000
	; call 	LCD_WRITE8

	ldi		r16 , $30
	call	LCD_WRITE8
	call	LCD_WRITE8
	call	LCD_WRITE8
	ldi		r16 , $20
	call	LCD_WRITE8

	; --- Now configure display
	;
	; --- Function set : 4 - bit mode , 2 line , 5x8 font
	ldi		r16 , FN_SET
	call	LCD_COMMAND
	; --- Display on , cursor on , cursor blink
	ldi		r16 , DISP_ON
	call	LCD_COMMAND
	; --- Clear display
	ldi		r16 , LCD_CLR
	call	LCD_COMMAND
	; --- Entry mode : Increment cursor , no shift
	ldi		r16 , E_MODE
	call	LCD_COMMAND

	pop 	r16
	ret

LCD_ASCII:
	call	LCD_WRITE8_ASCII
	ret

LCD_COMMAND:
	call	LCD_WRITE8
	ret

 ;write data to LCD from r16
LCD_WRITE8:
	call	LCD_WRITE4
	swap	r16
	call	LCD_WRITE4
	ret

 LCD_WRITE4:
    push    r17
	push 	r18
    ldi     r17,$40
	mov 	r18,r16
	andi 	r16,$F0
	ori 	r16,0b00001000
	call    TWI_SEND
	nop
	nop
	nop
	nop
	mov 	r18,r16
	andi 	r16,$F0
	ori 	r16,0b00001100
	call    TWI_SEND
	nop
	nop
	nop
	nop
	mov 	r16,r18
	andi 	r16,$F0
	ori 	r16,0b00001000
    call    TWI_SEND
	mov 	r16,r18
	call	LCD_WAIT
	pop 	r18
    pop     r17
	ret

LCD_WRITE8_ASCII:
	call	LCD_WRITE4_ASCII
	swap	r16
	call	LCD_WRITE4_ASCII
	ret

 LCD_WRITE4_ASCII:
    push    r17
	push 	r18
    ldi     r17,$40
	mov 	r18,r16
	andi 	r16,$F0
	ori 	r16,0b00001001
	call    TWI_SEND
	nop
	nop
	nop
	nop
	nop
	nop
	mov 	r18,r16
	andi 	r16,$F0
	ori 	r16,0b00001101
	call    TWI_SEND
	nop
	nop
	nop
	nop
	mov 	r16,r18
	andi 	r16,$F0
	ori 	r16,0b00001001
    call    TWI_SEND
	mov 	r16,r18
	call	LCD_WAIT
	pop 	r18
    pop     r17
	ret

LCD_WAIT:
	adiw	r24,1	; ~16ms
	brne	LCD_WAIT
	ret

LCD_CLEAR:
	push	r16
	ldi		r16,0b00000001
	call	LCD_COMMAND
	pop		r16
	ret

LCD_HOME:
	push	r16
	ldi		r16,0b00000010
	call	LCD_COMMAND
	pop		r16
	ret