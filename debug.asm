;
; FTDI_Assembler.asm
; 
; Created: 27/01/2021 11:21:07
; Author : Linus Thorsell (linth181)
;
; Description:
; Enkel kommunikation med FTDI->USB adapter 
; för logging av register till dator.
; Använder 9600 Baudrate över USART.
; Notera att TX/RX kablarna bör kopplas ur vid 
; flashning av arduinon för att motverka krockar 
; i kommunikationen.

	.equ freq = 16000000
	.equ BAUD = 74880
	.equ BAUDRATE = freq/(BAUD*16)-1

logger_init:
    push r16
	; Sätt Baudrate
	ldi		r16,HIGH(BAUDRATE)
	sts		UBRR0H,r16
	ldi		r16,LOW(BAUDRATE)
	sts		UBRR0L,r16
	
	; Konfigurera Mode
	ldi		r16,(3<<UCSZ00)
	sts		UCSR0C,r16	; sätt mode till 1 byte ut
	ldi		r16,(1<<TXEN0)
	sts		UCSR0B,r16	; starta som sändare
    
    pop r16
    ret

; Skickar data i r16
logger_skicka:
	push	r17
	lds		r17,UCSR0A
	sbrs	r17,UDRE0	; Väntar på timing att skicka byte
	rjmp	logger_skicka
	sts		UDR0,r16	; Laddar data till utregister
	pop		r17
	call	logger_private_wait
	ret

logger_private_wait:
    adiw    r24,1
    brne    logger_private_wait
    ret