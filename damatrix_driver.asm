jmp damatrix_driver_private_end

damatrix_draw:
    push    r16
    push    r17
    push    r18
    push    r19
    push    r20
    push    r21
    
    ldi     r21,0b00000001
    
    ldi ZH,HIGH(GAMEBOARD*2)
    ldi ZL,LOW(GAMEBOARD*2)

damatrix_draw_loop:
    call    SPI_START

    call    damatrix_translate
    
    push    r19
    push    r18
    push    r17

    call    damatrix_translate

    ;Upper display
	;BLUE
	mov		r16,r19
	call 	SPI_SEND

	;GREEN
	mov		r16,r18
	call 	SPI_SEND

	;RED
	mov		r16,r17
	call 	SPI_SEND

	;ANODE
	mov 	r16,r21
    com     r16
	call 	SPI_SEND

    pop    r17
    pop    r18
    pop    r19
    
    ;Lower display new
	;BLUE
	mov		r16,r19
	call 	SPI_SEND

	;GREEN
	mov		r16,r18
	call 	SPI_SEND

	;RED
	mov		r16,r17
	call 	SPI_SEND

	;ANODE
	mov 	r16,r21
    com     r16
	call 	SPI_SEND
    
    ; ;Lower display
	; ;BLUE
	; ldi		r16,0b11111111
	; call 	SPI_SEND

	; ;GREEN
	; ldi		r16,0b11111111
	; call 	SPI_SEND

	; ;RED
	; ldi		r16,0b11111111
	; call 	SPI_SEND

	; ;ANODE
	; ldi 	r16,0b00000000
    ; com     r16
	; call 	SPI_SEND

    call    SPI_END

    lsl     r21
    cpi     r21,0b00000000
    brne    damatrix_draw_loop

    ; call    SPI_START
    ; ;Lower display
	; ;BLUE
	; ldi		r16,0b00000000
	; call 	SPI_SEND

	; ;GREEN
	; ldi		r16,0b00000000
	; call 	SPI_SEND

	; ;RED
	; ldi		r16,0b00000000
	; call 	SPI_SEND

	; ;ANODE
	; ldi 	r16,0b00000000
    ; com     r16
	; call 	SPI_SEND

    ; call    SPI_END

    pop     r21
    pop     r20
    pop     r19
    pop     r18
    pop     r17
    pop     r16

    ret

damatrix_translate:

    ldi r20,$0

damatrix_translate_loop:

    lsl     r17
    lsl     r18
    lsl     r19

    lpm       r16,Z+

    ;r17 = röd
    ;r18 = grön
    ;r19 = blå


    ; kolla om det är ett R
    cpi     r16,$52
    brne    PRIVATE_GRON
    ori     r17,0b00000001
    
PRIVATE_GRON:
    ; kolla om det är ett G
    cpi     r16,$47
    brne    PRIVATE_BLA
    ori     r18,0b00000001
    
PRIVATE_BLA:
    ; kolla om det är ett B
    cpi     r16,$42
    brne    PRIVATE_GUL
    ori     r19,0b00000001
    
PRIVATE_GUL:
    ; kolla Y
    cpi     r16,$59
    brne    PRIVATE_NOT
    ori     r17,0b00000001
    ori     r18,0b00000001
    
PRIVATE_NOT:

    ; ori r19,0b00000001

    ;shifta alla register


    inc     r20
    cpi     r20,8
    brne    damatrix_translate_loop  

PRIVATE_MATRIX_END:

    ret

; damatrix_loop:
; 	call 	SPI_START

; 	;Upper display
; 	;BLUE
; 	; ldi 	r16,0b00000000
; 	; ldi 	r16,0b11111111
; 	ldi		r16,$0
; 	call 	SPI_SEND

; 	;GREEN
; 	; ldi 	r16,0b00000000
; 	; ldi 	r16,0b11111111
; 	ldi		r16,$FF
; 	call 	SPI_SEND

; 	;RED
; 	; ldi 	r16,0b00000000
; 	; ldi 	r16,0b11111111
; 	ldi		r16,$00
; 	call 	SPI_SEND
; 	;ANODE
; 	ldi 	r16,0b00000000
; 	call 	SPI_SEND

; 	;Lower display
; 	;BLUE
; 	; ldi 	r16,0b00000000
; 	; ldi 	r16,0b11111111
; 	ldi		r16,$0
; 	call 	SPI_SEND

; 	;GREEN
; 	; ldi 	r16,0b00000000
; 	; ldi 	r16,0b11111111
; 	ldi		r16,$FF
; 	call 	SPI_SEND

; 	;RED
; 	; ldi 	r16,0b00000000
; 	; ldi 	r16,0b11111111
; 	ldi		r16,$0
; 	call 	SPI_SEND
; 	;ANODE
; 	ldi 	r16,0b00000000
; 	call 	SPI_SEND
	
; 	call 	SPI_END

; 	call	WAIT_LL

; 	; ldi 	r16,(1 << CS)|(1 << MOSI)|(1 << SCK)
; 	; out 	SPI_DDR,r16

; 	call 	SPI_START
	
; 	;Upper display
; 	;BLUE
; 	; ldi 	r16,0b00000000
; 	; ldi 	r16,0b11111111
; 	ldi		r16,$0
; 	call 	SPI_SEND

; 	;GREEN
; 	; ldi 	r16,0b00000000
; 	; ldi 	r16,0b11111111
; 	ldi		r16,$0
; 	call 	SPI_SEND

; 	;RED
; 	; ldi 	r16,0b00000000
; 	; ldi 	r16,0b11111111
; 	ldi		r16,$FF
; 	call 	SPI_SEND
; 	;ANODE
; 	ldi 	r16,0b00000000
; 	call 	SPI_SEND

; 	;Lower display
; 	;BLUE
; 	; ldi 	r16,0b00000000
; 	; ldi 	r16,0b11111111
; 	ldi		r16,$0
; 	call 	SPI_SEND

; 	;GREEN
; 	; ldi 	r16,0b00000000
; 	; ldi 	r16,0b11111111
; 	ldi		r16,$0
; 	call 	SPI_SEND

; 	;RED
; 	; ldi 	r16,0b00000000
; 	; ldi 	r16,0b11111111
; 	ldi		r16,$FF
; 	call 	SPI_SEND
; 	;ANODE
; 	ldi 	r16,0b00000000
; 	call 	SPI_SEND

; 	call 	SPI_END

; 	call	WAIT_LL

;     jmp damatrix_loop

damatrix_driver_private_end:
    nop
    nop