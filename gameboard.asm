rjmp gameboard_end

; PRINT_GAMEBOARD:
; 	push 	r16
; 	push 	r17
; 	push 	r18

; 	ldi 	r16,$0A
; 	call 	logger_skicka
; 	call 	logger_skicka
; 	call 	logger_skicka

; 	ldi 	ZH,HIGH(GAMEBOARD*2)
; 	ldi 	ZL,LOW(GAMEBOARD*2)

; 	ldi 	r18,8
; 	ldi 	r17,8
; LOOP_X:
; 	lpm 	r16,Z+
; 	call 	logger_skicka
; 	dec 	r17
; 	cpi 	r17,0
; 	brne 	LOOP_X
; LOOP_Y:
; 	ldi 	r17,8
; 	ldi 	r16,$0A
; 	call 	logger_skicka
; 	dec 	r18
; 	cpi 	r18,0
; 	brne 	LOOP_X

; 	pop 	r18
; 	pop 	r17
; 	pop 	r16
; 	ret

; y=0000 x=0000 x2=0000 y2=0000
; y=5 x=2 load displacement Z=2+5*16 = gul z+ (if golv dont) st gul 

gameboard_init:
	
	push	r16
	push 	r17

    ldi     ZH,HIGH(GAMEBOARD)
    ldi     ZL,LOW(GAMEBOARD)

	ldi 	r16,0
	ldi 	r17,128

gameboard_private_loop:
	st		Z+,r16
	dec 	r17
	cpi 	r17,0
	brne 	gameboard_private_loop

	pop 	r17
	pop 	r16
	ret	

gameboard_end:
    nop
    nop