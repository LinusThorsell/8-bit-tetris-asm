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

gamestate_clear_block: ;r16 = x=0000 y=0000

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
    ldi     r17,0
    st      Z,r17

    pop     r18
    pop     r17
    ret

gamestate_draw_stack:
    push    r16
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

    inc     r17
    push    r16

gamestate_draw_stack_end_loop:
    
    pop     r16
    _LITr16
    dec     r17
    cpi     r17,0
    brne gamestate_draw_stack_end_loop
    
    pop     r17
    pop     r16
    ret

gamestate_update_board:

    ; OM BLOCKET KAN FLYTTAS 
    call    can_block_move
    ; FORTSÄTTER
    cpi     r22,1
    breq    gamestate_update_board_to_move
    ; ANNARS
    call    make_new_block
    ; SPAWNA NYTT BLOCK SEN FORTSÄTT

gamestate_update_board_to_move:

    push    r16
    push    r17
    ldi     r17,0

gamestate_update_board_start:
    mov     r16,r20
    _DROP

    cpi     r16,$E0
    breq    gamestate_update_board_end

    inc     r17
    call    gamestate_move_block
    push    r16

    rjmp    gamestate_update_board_start


gamestate_update_board_end:

    inc     r17
    push    r16
    
gamestate_update_board_end_loop:
    pop     r16
    _LITr16
    dec     r17
    cpi     r17,0
    brne    gamestate_update_board_end_loop

    pop     r17
    pop     r16
    ret

lookup_position: ; r16 x & y
    push    r18
    push    r17

    ldi     ZH,HIGH(GAMEBOARD)
    ldi     ZL,LOW(GAMEBOARD)

    mov     r17,r16
    andi    r16,$0F
    andi    r17,$F0
    swap    r17

    ldi     r18,16
    mul     r17,r18

    add     r16,r0

    add     ZL,r16

    ld      r16,Z

    cpi     r16,'B'

    breq    lookup_position_end
    ldi     r16,1

lookup_position_end:
    pop     r17
    pop     r18
    ret

gamestate_move_block:
    call    gamestate_clear_block
    dec     r16
    call    gamestate_draw_block
    ret

can_block_move:
    push    r17
can_block_move_start:
    ; ta bort alla från sram
    
    mov     r16,r20
    _DROP

    cpi     r16,$E0
    breq    can_block_move_fix

    inc     r17
    call    gamestate_clear_block
    push    r16

    rjmp    can_block_move_start

can_block_move_fix:

    inc     r17
    push    r16

can_block_move_finished:
    pop     r16
    _LITr16
    dec     r17
    cpi     r17,0
    brne    can_block_move_finished

    ; kolla om alla block kan flyttas
    push    r18
    ldi     r18,0

    mov     r16,r20

    call    lookup_position
    add     r18,r16

    ldi     r16,3
    add     YL,r16
    ld      r16,-Y
    call    lookup_position
    add     r18,r16

    ld      r16,-Y
    call    lookup_position
    add     r18,r16

    ld      r16,-Y
    call    lookup_position
    add     r18,r16

    cpi     r18,4
    brne    can_not_move

    ; Logik om vi kan flytta oss
    ldi     r22,1

    rjmp    can_block_move_end
can_not_move:
    ;logik om vi inte kan flytta oss
    ldi     r22,0
can_block_move_end:
    ; lägg tillbaka i sram på samma positioner


    ldi     r17,0
can_block_move_start_2:
    ; ta bort alla från sram
    
    mov     r16,r20
    _DROP

    cpi     r16,$E0
    breq    can_block_move_fix_2

    inc     r17
    call    gamestate_draw_block
    push    r16

    rjmp    can_block_move_start_2

can_block_move_fix_2:

    inc     r17
    push    r16

can_block_move_finished_2:
    pop     r16
    _LITr16
    dec     r17
    cpi     r17,0
    brne    can_block_move_finished_2

    pop     r18
    pop     r17
    ret

make_new_block:

    ; TODO: Flytta $E0 längst ner på stacken och lägg till nytt block.

    ret