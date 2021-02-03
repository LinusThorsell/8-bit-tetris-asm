    jmp     gameending_private_end

update_gamestate:
    push    r16
    push    r17
    push    r18
    push    r19
    push    ZH
    push    ZL

    ldi     ZH,HIGH(GAMEBOARD)
    ldi     ZL,LOW(GAMEBOARD)

    ldi     r18,128
gamestate_rulla:
    ld      r16,Z+
    ld      r17,Z+

    subi    ZL,2
    st      Z,r17

    ldi     r19,1
    add     ZL,r19

    dec     r18
    cpi     r18,0
    brne    gamestate_rulla


    pop     ZL
    pop     ZH
    pop     r19
    pop     r18
    pop     r17
    pop     r16
    ret

gamestate_init:

    ldi     ZH,HIGH(GAMEBOARD)
    ldi     ZL,LOW(GAMEBOARD)

    ldi     r18,$42
    ldi     r17,15
    add     ZL,r17
    st      Z,r18 

    ldi     ZH,HIGH(GAMEBOARD)
    ldi     ZL,LOW(GAMEBOARD)

    ldi     r18,$42
    ldi     r17,31
    add     ZL,r17
    st      Z,r18 

    ldi     ZH,HIGH(GAMEBOARD)
    ldi     ZL,LOW(GAMEBOARD)

    ldi     r18,$42
    ldi     r17,47
    add     ZL,r17
    st      Z,r18 
    
    ldi     ZH,HIGH(GAMEBOARD)
    ldi     ZL,LOW(GAMEBOARD)

    ldi     r18,$42
    ldi     r17,63
    add     ZL,r17
    st      Z,r18 

    ret

gameending_private_end:
    nop
    nop