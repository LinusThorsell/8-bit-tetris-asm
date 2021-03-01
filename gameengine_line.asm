gameengine_check_lines:
    push    r16
    push    r17
    push    r18
    push    r19
    push    r20
    push    ZH
    push    ZL

; loopa rad för rad, om inte 0 addera till r18
; om r16 = 8 calla ta bort line funktionen
; annars loopa nästa rad

    ldi     r16,1
lines_loop_y:
    ldi     ZH,HIGH(GAMEBOARD)
    ldi     ZL,LOW(GAMEBOARD)
    add     ZL,r16
    ldi     r17,8
    ldi     r18,0
lines_loop_x:
    ; ldi     r20,$0F
    ld      r19,Z
    adiw    ZH:ZL,$10
    ; ld      r19,Z+
    cpi     r19,0
    breq    lines_loop_x_is0

    inc     r18

lines_loop_x_is0:
    dec     r17
    cpi     r17,0
    brne    lines_loop_x

    cpi     r18,8
    brne    lines_loop_x_not8

    push    r16
    mov     r16,r17
    call    WRITE_RAW
    pop     r16

    call    gameengine_remove_line

lines_loop_x_not8:
    inc     r16
    cpi     r16,16
    brne    lines_loop_y

    pop     ZL
    pop     ZH
    pop     r20
    pop     r19
    pop     r18
    pop     r17
    pop     r16

    ret

gameengine_remove_line:
; ta bort raden från sram
; flytta ned allt över raden 1 steg
    push    r17
    push    r18

    sbiw    ZH:ZL,56
    sbiw    ZH:ZL,56
    sbiw    ZH:ZL,16

    ldi     r17,8

gameengine_remove_line_loop:
    ldi     r18,0
    st      Z,r18
    adiw    ZH:ZL,16
    dec     r17
    cpi     r17,0
    brne    gameengine_remove_line_loop

    pop     r18
    pop     r17
    ret

gameengine_cleanup_stack:
    push    r16
gameengine_cleanup_loop:

    mov     r16,r20
    _DROP

    cpi     r16,$F0
    brne gameengine_cleanup_loop

    _LIT    $F0
    _LIT    $E0
    pop     r16
    ret