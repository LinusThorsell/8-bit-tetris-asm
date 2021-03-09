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
    call    gameengine_movedown_line
    call    score_addscore

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

gameengine_movedown_line:
    push    r17
    push    r18
    push    r19
    push    r20
    push    ZH
    push    ZL

    ;TODO: maybe fix

; gameengine_loop_lines:
;     mov     r17,r16

;     ldi     ZH,HIGH(GAMEBOARD)
;     ldi     ZL,LOW(GAMEBOARD)

;     add     ZL,r17
;     ldi     r19,15
;     rjmp    gameengine_loop_line

; gameengine_next_line:
    
;     ldi     ZH,HIGH(GAMEBOARD)
;     ldi     ZL,LOW(GAMEBOARD)

;     mov     r17,r16
;     ldi     r18,$10
;     add     r17,r19
;     inc     r17
;     add     ZL,r17
;     add     r19,r18

; gameengine_loop_line:

;     inc     ZL
;     ld      r18,Z
;     st      -Z,r18
;     ldi     r18,0
;     inc     ZL
;     st      Z,r18
;     inc     r17

;     cp      r17,r19
;     brne    gameengine_loop_line

;     inc     r20
;     cpi     r20,8
;     brne    gameengine_next_line


    mov     r17,r16

    ldi     ZH,HIGH(GAMEBOARD)
    ldi     ZL,LOW(GAMEBOARD)

    add     ZL,r17

gameengine_loop_line0:

    inc     ZL
    ld      r18,Z
    st      -Z,r18
    ldi     r18,0
    inc     ZL
    st      Z,r18
    inc     r17

    cpi     r17,$0F
    brne    gameengine_loop_line0

    ldi     ZH,HIGH(GAMEBOARD)
    ldi     ZL,LOW(GAMEBOARD)

    mov     r17,r16
    ldi     r18,$10
    add     r17,r18
    add     ZL,r17
gameengine_loop_line1:

    inc     ZL
    ld      r18,Z
    st      -Z,r18
    ldi     r18,0
    inc     ZL
    st      Z,r18
    inc     r17

    cpi     r17,$1F
    brne    gameengine_loop_line1

    ldi     ZH,HIGH(GAMEBOARD)
    ldi     ZL,LOW(GAMEBOARD)

    mov     r17,r16
    ldi     r18,$20
    add     r17,r18
    add     ZL,r17

gameengine_loop_line2:

    inc     ZL
    ld      r18,Z
    st      -Z,r18
    ldi     r18,0
    inc     ZL
    st      Z,r18
    inc     r17

    cpi     r17,$2F
    brne    gameengine_loop_line2

    ldi     ZH,HIGH(GAMEBOARD)
    ldi     ZL,LOW(GAMEBOARD)

    mov     r17,r16
    ldi     r18,$30
    add     r17,r18
    add     ZL,r17

gameengine_loop_line3:

    inc     ZL
    ld      r18,Z
    st      -Z,r18
    ldi     r18,0
    inc     ZL
    st      Z,r18
    inc     r17

    cpi     r17,$3F
    brne    gameengine_loop_line3

    ldi     ZH,HIGH(GAMEBOARD)
    ldi     ZL,LOW(GAMEBOARD)

    mov     r17,r16
    ldi     r18,$40
    add     r17,r18
    add     ZL,r17

gameengine_loop_line4:

    inc     ZL
    ld      r18,Z
    st      -Z,r18
    ldi     r18,0
    inc     ZL
    st      Z,r18
    inc     r17

    cpi     r17,$4F
    brne    gameengine_loop_line4

    ldi     ZH,HIGH(GAMEBOARD)
    ldi     ZL,LOW(GAMEBOARD)

    mov     r17,r16
    ldi     r18,$50
    add     r17,r18
    add     ZL,r17

gameengine_loop_line5:

    inc     ZL
    ld      r18,Z
    st      -Z,r18
    ldi     r18,0
    inc     ZL
    st      Z,r18
    inc     r17

    cpi     r17,$5F
    brne    gameengine_loop_line5

    ldi     ZH,HIGH(GAMEBOARD)
    ldi     ZL,LOW(GAMEBOARD)

    mov     r17,r16
    ldi     r18,$60
    add     r17,r18
    add     ZL,r17

gameengine_loop_line6:

    inc     ZL
    ld      r18,Z
    st      -Z,r18
    ldi     r18,0
    inc     ZL
    st      Z,r18
    inc     r17

    cpi     r17,$6F
    brne    gameengine_loop_line6

    ldi     ZH,HIGH(GAMEBOARD)
    ldi     ZL,LOW(GAMEBOARD)

    mov     r17,r16
    ldi     r18,$70
    add     r17,r18
    add     ZL,r17

gameengine_loop_line7:

    inc     ZL
    ld      r18,Z
    st      -Z,r18
    ldi     r18,0
    inc     ZL
    st      Z,r18
    inc     r17

    cpi     r17,$7F
    brne    gameengine_loop_line7

    dec     r16
    pop     ZL
    pop     ZH
    pop     r20
    pop     r19
    pop     r18
    pop     r17
    ret

;     mov     r17,r16

;     ldi     ZH,HIGH(GAMEBOARD)
;     ldi     ZL,LOW(GAMEBOARD)

;     add     ZL,r17

; gameengine_loop_line0:

;     inc     ZL
;     ld      r18,Z
;     st      -Z,r18
;     ldi     r18,0
;     inc     ZL
;     st      Z,r18
;     inc     r17

;     cpi     r17,15
;     brne    gameengine_loop_line0

;     ldi     ZH,HIGH(GAMEBOARD)
;     ldi     ZL,LOW(GAMEBOARD)

;     mov     r17,r16
;     ldi     r18,$10
;     add     r17,r18
;     add     ZL,r17
; gameengine_loop_line1:

;     inc     ZL
;     ld      r18,Z
;     st      -Z,r18
;     ldi     r18,0
;     inc     ZL
;     st      Z,r18
;     inc     r17

;     cpi     r17,31
;     brne    gameengine_loop_line1

;     dec     r16
;     pop     ZL
;     pop     ZH
;     pop     r20
;     pop     r19
;     pop     r18
;     pop     r17
;     ret

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

gamestate_write_score:

    push    r16
    push    r17

    lds     r16,SCORE
    mov     r17,r16
    swap    r17

    andi    r16,$0F

    call    RIGHT8_WRITE
    mov     r16,r17
    andi    r16,$0F
    call    LEFT8_WRITE

    pop     r17
    pop     r16

    ret

score_addscore:

    push    r16

    lds     r16,SCORE
    inc     r16
    sts     SCORE,r16

    pop     r16

    ret