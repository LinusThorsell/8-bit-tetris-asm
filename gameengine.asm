    jmp     gameending_private_end

update_gamestate:
    push    r16
    push    r17
    push    r18
    push    r19
    push    ZH
    push    ZL

    ; ldi     r19,0
    ; sts     GAMEBOARD+16,r19
    ; sts     GAMEBOARD+32,r19
    ; sts     GAMEBOARD+48,r19
    ; sts     GAMEBOARD+64,r19
    ; sts     GAMEBOARD+80,r19
    ; sts     GAMEBOARD+96,r19
    ; sts     GAMEBOARD+112,r19
    ; sts     GAMEBOARD+128,r19

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

    ldi     r19,'B'
    sts     GAMEBOARD+0,r19
    sts     GAMEBOARD+16,r19
    sts     GAMEBOARD+32,r19
    sts     GAMEBOARD+48,r19
    sts     GAMEBOARD+64,r19
    sts     GAMEBOARD+80,r19
    sts     GAMEBOARD+96,r19
    sts     GAMEBOARD+112,r19
    sts     GAMEBOARD+128,r19

    ret

gamestate_draw_block: ;r16 = x=0000 y=0000

    ldi     ZH,HIGH(GAMEBOARD)
    ldi     ZL,LOW(GAMEBOARD)

    push    r17
    push    r18

    ;r16=x r17=y

    mov     r17,r16
    andi    r16,$0F
    andi    r17,$F0
    swap    r17

    ldi     r18,16
    mul     r17,r18

    add     r16,r0

    add     ZL,r16
    ldi     r17,'Y'
    st      Z,r17

    pop     r18
    pop     r17
    ret

gamestate_draw_stack:

    push    r17

    ldi     r17,0
gamestate_draw_stack_start:

    mov     r16,r20
    _DROP
    
    cpi     r16,$F0
    breq    gamestate_draw_stack_end
    
    inc     r17

    ; mov     r16,r20
    call    gamestate_draw_block
    push    r16

    rjmp    gamestate_draw_stack_start

gamestate_draw_stack_end:
    
    pop     r16
    _LITr16
    dec     r17
    cpi     r17,0
    brne gamestate_draw_stack_end
    
    pop     r17
    ret

gameending_private_end:
    nop
    nop