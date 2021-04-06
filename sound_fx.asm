BEEP:
    push    r16
    push    r17

	ldi 	r16, $FF
    out     DDRB,r16

    ldi     r17,$FF
BEEP_LOOP:
	sbi     PORTB,PB1
    call    wait500us
    cbi     PORTB,PB1
    call    wait500us
    sbi     PORTB,PB1
    call    wait500us
    cbi     PORTB,PB1
    call    wait500us
    dec     r17
    cpi     r17,0
    brne    BEEP_LOOP

    pop     r17
    pop     r16
    ret