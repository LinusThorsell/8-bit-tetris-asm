SRAM_CONVERTER_DATA:
    .db $3F,$06,$5B,$4F,$66,$6D,$7D,$07,$7F,$6F,$77,$7C,$39,$5E,$79,$71;.db 0b00000000,0b00000001,0b00000010,0b00110011,0b01111011,0b11111111,0b11111110,0b11111101,0b11111100,0b00000000,0b00000001,0b00000010,0b00110011,0b01111011,0b11111111,0b11111110,0b11111101,0b11111100

TWI_READ: ; r16=adress read to r16

    call 	START
    
    call 	SEND_8

	call 	CLK
    call 	CLK

    call 	READ_8

    call 	STOP

    ret

WRITE_RAW: ; Skriv ut data i r16 på höger 7seg
    push    r17
    
    ldi     r17,(ADDR_RIGHT8  << 1) | 0
    ; ldi     r17,(ADDR_LCD  << 1) | 0
    call    TWI_SEND

    pop     r17
    ret

READ_8: ; Läs en byte från bussen
    push    r17
    push    r18

    ldi 	r16,0
    ldi 	r17,8
READ_8_LOOP:

    sbi      DDRC ,SCL
    call     WAIT
    
	in		r18,PINC
    lsr     r18
    lsr     r18
    lsr     r18
    lsr     r18

    lsl     r16
    or      r16,r18

	cbi      DDRC ,SCL
    call     WAIT

    dec     r17
    cpi     r17,0
    brne    READ_8_LOOP

    lsr     r16

    pop     r18
    pop     r17
    ret

RIGHT8_WRITE:
    push    r17
    ldi     r17,(ADDR_RIGHT8  << 1) | 0
    rjmp    BOTH_WRITE
LEFT8_WRITE:
    push    r17
    ldi     r17,(ADDR_LEFT8  << 1) | 0
BOTH_WRITE:
    call    SRAM_CONVERTER
    call    TWI_SEND
    pop     r17
    ret

SRAM_CONVERTER:
    push    ZH
    push    ZL

    ldi     ZH,HIGH(SRAM_CONVERTER_DATA*2)
    ldi     ZL,LOW(SRAM_CONVERTER_DATA*2)

    add     ZL,r16
    lpm     r16,Z

    pop     ZL
    pop     ZH
    ret

TWI_SEND: ; r16 data, r17 adress
    push    r18

    mov     r18,r16 ; Spara indata

	call 	START ; Starta TWI Linjen

    mov     r16,r17 ; ladda adress
	call    SEND_8 ; skicka adress

	call	CLK ; Vänta på Ack

    mov     r16,r18 ; Ladda tillbaka indata
    call    SEND_8 ; Skicka indata

	call	CLK ; Vänta på Ack

	call 	STOP ; Stoppa TWI Länken

    mov     r16,r18 ; Ladda tillbaka indata

    pop     r18
	ret

SEND_8: ; Skicka 8 bitar som finns i r16 till Bussen

    push    r17
    push    r18

    ldi     r17,8
	
SEND_8_LOOP: ; Loopa över alla bitar
	mov 	r18,r16
	andi 	r18,0b10000000
	cpi 	r18,0b10000000
	brne 	SEND_8_NOLLA
	rjmp 	SEND_8_ETTA

SEND_8_NOLLA: ; Skicka nolla om 
    call 	SDL
	rjmp 	SEND_8_INTE_ETTA
SEND_8_ETTA:
    call 	SDH
SEND_8_INTE_ETTA:

    lsl     r16

    dec     r17
    cpi     r17,0
    brne    SEND_8_LOOP

    pop     r18
    pop     r17

    ret

START:
    sbi      DDRC ,SDA
    call     WAIT
    sbi      DDRC ,SCL
    call     WAIT
    ret
STOP:
    sbi      DDRC ,SDA
    call     WAIT
    cbi      DDRC ,SCL
    call     WAIT
    cbi      DDRC ,SDA
    call     WAIT
    ret
SDL:
    sbi      DDRC ,SDA
    call     WAIT
    cbi      DDRC ,SCL
    call     WAIT
    sbi      DDRC ,SCL
    call     WAIT
    ret
SDH:
    cbi      DDRC ,SDA
    call     WAIT
    cbi      DDRC ,SCL
    call     WAIT
    sbi      DDRC ,SCL
    call     WAIT
    ret

CLK:
	cbi      DDRC ,SCL
    call     WAIT
    sbi      DDRC ,SCL
    call     WAIT
    ret

TWI_STARTV2:
	
    ldi r16,0b00000111
    sts TWBR,r16

	ldi r16, (1<<TWINT)|(1<<TWSTA)|(1<<TWEN)
	sts TWCR, r16

	ret

TWI_ENDV2:

	ldi r16,(1<<TWINT)|(1<<TWEN)|(1<<TWSTO)
	sts TWCR, r16 

	ret

TWI_SENDV2:
    push    r18
    push    r19

    mov     r19,r17
    mov     r18,r16

	call TWI_STARTV2

TWI_WAIT1V2:
	lds r16,TWCR
	sbrs r16,TWINT
	rjmp TWI_WAIT1V2

	mov r16, r19
	sts TWDR, r16
	ldi r16, (1<<TWINT) | (1<<TWEN)
	sts TWCR, r16

TWI_WAIT2V2:
	lds r16,TWCR
	sbrs r16,TWINT
	rjmp TWI_WAIT2V2

	mov r16, r18
	sts TWDR, r16
	ldi r16, (1<<TWINT) | (1<<TWEN)
	sts TWCR, r16	

TWI_WAIT3V2:
	lds r16,TWCR
	sbrs r16,TWINT
	rjmp TWI_WAIT3V2

	call TWI_ENDV2

    pop    r19
    pop    r18

	ret