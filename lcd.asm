;=============================
;LCD Settings

.equ FN_SET =	0b00101000
.equ DISP_ON =	0b00001111 ; DISPLAY ON, CURSOR ON, BLIKNING ON
;.equ DISP_ON =	0b00001100
.equ LCD_CLR =	0b00000001
.equ E_MODE =	0b00000110

;=============================

;=============================

;LCD Functions:
;-PRINT_LINE
;-FILL_LINE
;-PRINT_LINE
;LCD_ASCII (LCD_WIRTE8 -> LCD_WRITE4)
;LCD_COMMAND (LCD_WIRTE8 -> LCD_WRITE4)
;LCD_CLEAR
;LCD_HOME

;=============================

LCD_INIT:
    push    r16
	; ldi		r16,0b00000111
	; out		DDRB,r16 ;Data direction pin 2-0

	; ldi		r16,0b11110000
	; out		DDRD,r16 ;Data direction pin 7-4

	; --- Turn backlight on
	ldi     r16,0b00000000
    ; andi    r16,0b00010000
    call    LCD_WRITE8
	;
	; --- First initiate 4- bit mode
	;
	; ldi		r16 , $30
	; call	LCD_WRITE8
	; call	LCD_WRITE8
	; call	LCD_WRITE8
	; ldi		r16 , $20
	; call	LCD_WRITE8
	;
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
    pop     r16
	ret

LCD_WAIT:
	adiw	r24,1	; ~16ms
	brne	LCD_WAIT
	ret

; PRINT_LINE:
; 	call	LCD_HOME
; 	ldi		YH,HIGH(LINE)
; 	ldi		YL,LOW(LINE)
; PRINT_LINE_1:
; 	ld		r16,Y+
; 	cpi		r16,0
; 	breq	PRINT_LINE_2
; 	call	LCD_ASCII
; 	jmp		PRINT_LINE_1
; PRINT_LINE_2:
; 	ret

; FILL_LINE:
; 	ldi		YH,HIGH(LINE)
; 	ldi		YL,LOW(LINE)
; 	ldi		r16,0
; 	ldi		r17,$30
; FILL_LINE_1:
; 	st		Y+,r16
; 	cpi		r17,$3F
; 	breq	FILL_LINE_2
; 	inc		r17
; 	jmp		FILL_LINE_1
; FILL_LINE_2:
; 	ret

; LCD_WRITE4:
; 	out		PORTD,r16
; 	sbi		PORTB,1
; 	nop
; 	nop
; 	nop
; 	nop
; 	cbi		PORTB,1
; 	call	LCD_WAIT
; 	ret
 LCD_WRITE4:
    ; push    r17
    ; ldi     r17,$40
	; call    TWI_SEND
	; ori		r16,0b00100000
	; nop
	; nop
	; nop
	; nop
	; andi	r16,0b11011111
    ; call    TWI_SEND
	; call	LCD_WAIT
    ; pop     r17
	ret

LCD_WRITE8:
	push    r17
    ldi     r17,$40
	call    TWI_SEND
	ori		r16,0b00100000
	nop
	nop
	nop
	nop
	andi	r16,0b11011111
    call    TWI_SEND
	call	LCD_WAIT
    pop     r17
	ret

LCD_ASCII:
	ori		r16,0b10000000
	call	LCD_WRITE8
	ret

LCD_COMMAND:
    andi	r16,0b011111111
	call	LCD_WRITE8
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