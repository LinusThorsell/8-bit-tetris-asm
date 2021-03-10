; .block_type 0 = O-block, 1 = I-block, 2 = T-block, 3 = J-block, 4 = L-block, 5 = S-block, 6 = Z-block,
; .rotation_state = 0

; .mov_down
; .mov_right
; .mov_left

; .states
;   o block
;     $E4, $E5, $E6, $E7,
;     $E4, $E5, $E6, $E7,
;     $E4, $E5, $E6, $E7,
;     $E4, $E5, $E6, $E7
; ;   I block
;     $E4, $E5, $E6, $E7,
;     $E4, $E5, $E6, $E7,
;     $E4, $E5, $E6, $E7,
;     $E4, $E5, $E6, $E7
; ;   T block
    

gameengine_init_states:
    push    ZH
    push    ZL
    push    r16
    
    ldi     ZH,HIGH(STATES)
    ldi     ZL,LOW(STATES)

; O BLOCKET
    ;STATE 1
    ldi     r16,$3F
    st      Z+,r16
	ldi     r16,$4F
    st      Z+,r16
	ldi     r16,$3E
    st      Z+,r16
	ldi     r16,$4E
    st      Z+,r16

    ;STATE 2
    ldi     r16,$3F
    st      Z+,r16
	ldi     r16,$4F
    st      Z+,r16
	ldi     r16,$3E
    st      Z+,r16
	ldi     r16,$4E
    st      Z+,r16
    ;STATE 3
    ldi     r16,$3F
    st      Z+,r16
	ldi     r16,$4F
    st      Z+,r16
	ldi     r16,$3E
    st      Z+,r16
	ldi     r16,$4E
    st      Z+,r16
    ;STATE 4
    ldi     r16,$3F
    st      Z+,r16
	ldi     r16,$4F
    st      Z+,r16
	ldi     r16,$3E
    st      Z+,r16
	ldi     r16,$4E
    st      Z+,r16

;   I BLOCKET!
        ;STATE 1
    ldi     r16,$2F
    st      Z+,r16
	ldi     r16,$3F
    st      Z+,r16
	ldi     r16,$4F
    st      Z+,r16
	ldi     r16,$5F
    st      Z+,r16

    ;STATE 2
    ldi     r16,$4F
    st      Z+,r16
	ldi     r16,$4E
    st      Z+,r16
	ldi     r16,$4D
    st      Z+,r16
	ldi     r16,$4C
    st      Z+,r16

        ;STATE 3
    ldi     r16,$2F
    st      Z+,r16
	ldi     r16,$3F
    st      Z+,r16
	ldi     r16,$4F
    st      Z+,r16
	ldi     r16,$5F
    st      Z+,r16

        ;STATE 4
    ldi     r16,$4F
    st      Z+,r16
	ldi     r16,$4E
    st      Z+,r16
	ldi     r16,$4D
    st      Z+,r16
	ldi     r16,$4C
    st      Z+,r16

; T BLOCKET
    ; STATE 1
    ldi     r16,$3F
    st      Z+,r16
    ldi     r16,$4F
    st      Z+,r16
    ldi     r16,$5F
    st      Z+,r16
    ldi     r16,$4E
    st      Z+,r16

    ; STATE 2
    ldi     r16,$4F
    st      Z+,r16
    ldi     r16,$4E
    st      Z+,r16
    ldi     r16,$4D
    st      Z+,r16
    ldi     r16,$5E
    st      Z+,r16

    ; STATE 3
    ldi     r16,$3E
    st      Z+,r16
    ldi     r16,$4F
    st      Z+,r16
    ldi     r16,$5E
    st      Z+,r16
    ldi     r16,$4E
    st      Z+,r16

    ; STATE 4
    ldi     r16,$4F
    st      Z+,r16
    ldi     r16,$4E
    st      Z+,r16
    ldi     r16,$3E
    st      Z+,r16
    ldi     r16,$4D
    st      Z+,r16

; J BLOCKET
    ; STATE 1
    ldi     r16,$3F
    st      Z+,r16
    ldi     r16,$3E
    st      Z+,r16
    ldi     r16,$4E
    st      Z+,r16
    ldi     r16,$5E
    st      Z+,r16

        ; STATE 2
    ldi     r16,$4F
    st      Z+,r16
    ldi     r16,$4E
    st      Z+,r16
    ldi     r16,$4D
    st      Z+,r16
    ldi     r16,$3D
    st      Z+,r16

        ; STATE 3
    ldi     r16,$3F
    st      Z+,r16
    ldi     r16,$4F
    st      Z+,r16
    ldi     r16,$5F
    st      Z+,r16
    ldi     r16,$5E
    st      Z+,r16

        ; STATE 4
    ldi     r16,$4F
    st      Z+,r16
    ldi     r16,$4E
    st      Z+,r16
    ldi     r16,$4D
    st      Z+,r16
    ldi     r16,$5F
    st      Z+,r16

; L BLOCKET
    ; STATE 1
    ldi     r16,$3E
    st      Z+,r16
    ldi     r16,$4E
    st      Z+,r16
    ldi     r16,$5E
    st      Z+,r16
    ldi     r16,$5F
    st      Z+,r16

        ; STATE 2
    ldi     r16,$3F
    st      Z+,r16
    ldi     r16,$4F
    st      Z+,r16
    ldi     r16,$4E
    st      Z+,r16
    ldi     r16,$4D
    st      Z+,r16

        ; STATE 3
    ldi     r16,$3E
    st      Z+,r16
    ldi     r16,$3F
    st      Z+,r16
    ldi     r16,$4F
    st      Z+,r16
    ldi     r16,$5F
    st      Z+,r16

        ; STATE 4
    ldi     r16,$4F
    st      Z+,r16
    ldi     r16,$4E
    st      Z+,r16
    ldi     r16,$4D
    st      Z+,r16
    ldi     r16,$5D
    st      Z+,r16

; S BLOCKET
    ; STATE 1
    ldi     r16,$3E
    st      Z+,r16
    ldi     r16,$4E
    st      Z+,r16
    ldi     r16,$4F
    st      Z+,r16
    ldi     r16,$5F
    st      Z+,r16

    ; STATE 2
    ldi     r16,$3F
    st      Z+,r16
    ldi     r16,$3E
    st      Z+,r16
    ldi     r16,$4E
    st      Z+,r16
    ldi     r16,$4D
    st      Z+,r16

    ; STATE 3
    ldi     r16,$3E
    st      Z+,r16
    ldi     r16,$4E
    st      Z+,r16
    ldi     r16,$4F
    st      Z+,r16
    ldi     r16,$5F
    st      Z+,r16

    ; STATE 4
    ldi     r16,$3F
    st      Z+,r16
    ldi     r16,$3E
    st      Z+,r16
    ldi     r16,$4E
    st      Z+,r16
    ldi     r16,$4D
    st      Z+,r16

; Z BLOCKET
    ; STATE 1
    ldi     r16,$3F
    st      Z+,r16
    ldi     r16,$4F
    st      Z+,r16
    ldi     r16,$4E
    st      Z+,r16
    ldi     r16,$5E
    st      Z+,r16

    ; STATE 2
    ldi     r16,$5F
    st      Z+,r16
    ldi     r16,$5E
    st      Z+,r16
    ldi     r16,$4E
    st      Z+,r16
    ldi     r16,$4D
    st      Z+,r16

    ; STATE 3
    ldi     r16,$3F
    st      Z+,r16
    ldi     r16,$4F
    st      Z+,r16
    ldi     r16,$4E
    st      Z+,r16
    ldi     r16,$5E
    st      Z+,r16

    ; STATE 4
    ldi     r16,$5F
    st      Z+,r16
    ldi     r16,$5E
    st      Z+,r16
    ldi     r16,$4E
    st      Z+,r16
    ldi     r16,$4D
    st      Z+,r16

    pop     r16
    pop     ZL
    pop     ZH
    ret

gameengine_rotate_block:
    ; pushar allt wohooo
    push    XL
    push    XH
    push    r16
    push    r17
    push    r18
    push    r19

;   set y pekare på states
    ldi     XH,HIGH(STATES)
    ldi     XL,LOW(STATES)

    ; hoppa fram till rätt block
    ; i block type * 16 frammåt i minnet
    lds     r16,BLOCK_TYPE
    ldi     r17,16

    mul     r16,r17

    mov     r16,r0

    add     XL,r16
    ; gå till nästa block state
    lds     r17,ROTATION_STATE
    cpi     r17,4
    brne    gameengine_rotate_block_normal
    ldi     r17,$00
    sts     ROTATION_STATE,r17

gameengine_rotate_block_normal:

    lds     r16,ROTATION_STATE
    inc     r16
    sts     ROTATION_STATE,r16

    ; hoppa fram till rätt rotationsstate av blocket
    lds     r16,ROTATION_STATE
    ldi     r17,4

    mul     r16,r17

    mov     r16,r0

    add     XL,r16
; x pekaren sitter nu på rätt rad (förhoppningsvis)

; ta bort blocket från sram för att kunna kolla kollision
gameengine_rotate_block_remove_old_loop:
    mov     r16,r20
    _DROP

    cpi     r16,$E0
    breq    gameengine_rotate_block_remove_old_loop_finished
    call    gamestate_clear_block
    push    r16
    rjmp    gameengine_rotate_block_remove_old_loop

gameengine_rotate_block_remove_old_loop_finished:
;   kolla om blocket kan rotera
    ldi     r18,0
    ldi     r19,4
    subi    XL,4
gameengine_rotate_block_check:
    ld      r16,X+
    lds     r17,MOV_DOWN
    sub     r16,r17
    
    swap    r16
    lds     r17,MOV_RIGHT
    sub     r16,r17
    swap    r16

    inc     r16
    call    lookup_position_down
    add     r18,r16

    dec     r19
    cpi     r19,0
    brne    gameengine_rotate_block_check

    cpi     r18,4
    brne    gameengine_rotate_block_end_norotation
    ; här ska de roteras
    ; lägg tillbaka i variabelstack
    ldi     r17,4
gameengine_rotate_block_add_old_loop:
    pop     r16
    _LITr16 
    dec     r17
    cpi     r17,0
    brne    gameengine_rotate_block_add_old_loop

    ; rotera skiten
    subi    XL,4

    call    gameengine_cleanup_stack

    ldi     r19,4
gameengine_rotate_block_place:
    ld      r16,X+
    lds     r17,MOV_DOWN ; fixa offset nedåt
    sub     r16,r17
    
    swap    r16
    lds     r17,MOV_RIGHT ; fixa offset sidleds
    sub     r16,r17
    swap    r16

    _LITr16

    dec     r19
    cpi     r19,0
    brne    gameengine_rotate_block_place

    rjmp    gameengine_rotate_block_end
gameengine_rotate_block_end_norotation:
    ldi     r17,4
    call    gameengine_cleanup_stack
gameengine_rotate_block_add_old_loop2:
    pop     r16
    _LITr16
    dec     r17
    cpi     r17,0
    brne    gameengine_rotate_block_add_old_loop2

gameengine_rotate_block_end:
    pop     r19
    pop     r18
    pop     r17
    pop     r16
    pop     XH
    pop     XL
    ret


    ; placera ut 4 block från pekaren
    ; tabort nuvarande block från sram
    ; kolla efter kollision på nya platsen

    ; om vi kan rotera = rotera och ta bort alla block från stacken
    ; annars
    ; lägga tillbaka originalblocket i sram

        ;skaffa blocktype

    ; switch case till olika block

    ; switch case rotation:
    ; case 1:
    ; check rotatin state < 5 
    ;   rotation state++
    ; else rotation state = 0
    ;
    ; pekare på states_I_Block
    ; pekare+rotationstate+rotationstate+rotationstate+rotationstate (+rotationstate*4)