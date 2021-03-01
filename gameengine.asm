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

    ldi     r19,'W'
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
    mov     r17,r23
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
    
    cpi     r16,$E0
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
    push    r16 
    ldi     r16,0 
    sts     MOVEMENT_DIRECTION,r16
    pop     r16
    call    can_block_move
    ; FORTSÄTTER
    cpi     r22,1
    breq    gamestate_update_board_to_move
    ; ANNARS
    call	gameengine_check_lines
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

lookup_position_down: ; r16 x & y
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
	dec		ZL

    ld      r16,Z

    cpi     r16,0

    brne    lookup_position_end_down
    ldi     r16,1

lookup_position_end_down:
    pop     r17
    pop     r18
    ret

lookup_position_left: ; r16 x & y
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
	
    ldi     r16,16
    sub		ZL,r16

    ld      r16,Z

    cpi     r16,0

    brne    lookup_position_end_left
    ldi     r16,1

lookup_position_end_left:
    pop     r17
    pop     r18
    ret

lookup_position_right: ; r16 x & y
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
	
    ldi     r16,16
    add		ZL,r16

    ld      r16,Z

    cpi     r16,0

    brne    lookup_position_end_right
    ldi     r16,1

lookup_position_end_right:
    pop     r17
    pop     r18
    ret

move_downwards_checks:
    mov     r16,r20

    call    lookup_position_down
    add     r18,r16

    ldi     r16,3
    add     YL,r16
    ld      r16,-Y
    call    lookup_position_down
    add     r18,r16

    ld      r16,-Y
    call    lookup_position_down
    add     r18,r16

    ld      r16,-Y
    call    lookup_position_down
    add     r18,r16
    ret

move_right_checks:
    mov     r16,r20

    call    lookup_position_right
    add     r18,r16

    ldi     r16,3
    add     YL,r16
    ld      r16,-Y
    call    lookup_position_right
    add     r18,r16

    ld      r16,-Y
    call    lookup_position_right
    add     r18,r16

    ld      r16,-Y
    call    lookup_position_right
    add     r18,r16
    ret

move_left_checks:
    mov     r16,r20

    call    lookup_position_left
    add     r18,r16

    ldi     r16,3
    add     YL,r16
    ld      r16,-Y
    call    lookup_position_left
    add     r18,r16

    ld      r16,-Y
    call    lookup_position_left
    add     r18,r16

    ld      r16,-Y
    call    lookup_position_left
    add     r18,r16
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

    push    r21
    lds     r21,MOVEMENT_DIRECTION

    cpi     r21,0
    brne    can_block_move_checks_left
    call    move_downwards_checks
    rjmp    can_block_move_checks_done
can_block_move_checks_left:
    cpi     r21,1
    brne    can_block_move_checks_right
    call    move_left_checks
    rjmp    can_block_move_checks_done
can_block_move_checks_right:
    cpi     r21,2
    brne    can_block_move_checks_done
    call    move_right_checks
can_block_move_checks_done:
    pop     r21

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
can_block_move_start_addback:
    ; ta bort alla från sram
    
    mov     r16,r20
    _DROP

    cpi     r16,$E0
    breq    can_block_move_fix_addback

    inc     r17
    call    gamestate_draw_block
    push    r16

    rjmp    can_block_move_start_addback

can_block_move_fix_addback:

    inc     r17
    push    r16

can_block_move_finished_addback:
    pop     r16
    _LITr16
    dec     r17
    cpi     r17,0
    brne    can_block_move_finished_addback

    pop     r18
    pop     r17
    ret

make_new_block:

    push    r17
    ldi     r17,4 ; blocken är alltid 4 pixlar
    call    move_endstop_down
    pop     r17

    call    add_new_block

    ret

move_endstop_down:
    mov     r16,r20
    _DROP

    cpi     r16,$E0
    breq    move_endstop_down_back

    push    r16
    rjmp move_endstop_down

move_endstop_down_back:
    pop     r16
    _LITr16

    dec     r17
    cpi     r17,0
    brne    move_endstop_down_back

    ldi     r16,$E0
    _LITr16

    ret

; add_new_block:

;     cpi     r23,'Y'
;     breq    set_color_purple
;     ldi     r23,'Y'

;     rjmp set_color_finished
; set_color_purple:
;     ldi     r23,'P'
; set_color_finished:

;     _LIT $5E
; 	_LIT $5F
; 	_LIT $6E
; 	_LIT $6F
;     ret

add_new_block:

    call    gameengine_cleanup_stack

	cpi 	r23,'R'
	breq	set_color_red
	cpi 	r23,'G'
	breq	set_color_green
	cpi 	r23,'B'
	breq	set_color_blue
	cpi 	r23,'P'
	breq	set_color_purple
	; cpi 	r23,'Y'
	; breq	set_color_yellow
	
set_color_red:
	ldi 	r23,'G'
	
	; _LIT $5F
	; _LIT $4F
	; _LIT $4E
	; _LIT $3E
	_LIT $0F
	_LIT $1F
	_LIT $0E
	_LIT $1E
	
	rjmp 	set_color_finished
set_color_green:
	ldi 	r23,'B'
	
	; _LIT $3F
	; _LIT $4F
	; _LIT $5F
	; _LIT $5E
	_LIT $2F
	_LIT $3F
	_LIT $2E
	_LIT $3E

	rjmp 	set_color_finished
set_color_blue:
	ldi 	r23,'P'
	
	; _LIT $3F
	; _LIT $4F
	; _LIT $5F
	; _LIT $4E
	_LIT $4F
	_LIT $5F
	_LIT $4E
	_LIT $5E
	
	rjmp 	set_color_finished
set_color_purple:
	ldi 	r23,'R'
	
	; _LIT $3F
	; _LIT $4F
	; _LIT $3E
	; _LIT $4E
	_LIT $6F
	_LIT $7F
	_LIT $6E
	_LIT $7E
	
; 	rjmp 	set_color_finished
; set_color_yellow:
; 	ldi 	r23,'R'
	
; 	; _LIT $3F
; 	; _LIT $4F
; 	; _LIT $4E
; 	; _LIT $5E
; 	_LIT $6F
; 	_LIT $7F
; 	_LIT $6E
; 	_LIT $7E
	
	rjmp 	set_color_finished
	
set_color_finished:
	ret

read_keys:
    push 	r16
	ldi 	r16,(ADDR_BUTTON  << 1) | 1
	cpi     r18,0b01111111
    brne    read_keys_end
    call 	TWI_READ
	; call 	RIGHT8_WRITE

    ;code for moving left and right
    mov     r18,r16
    cpi     r16, 0b01111101 ; move right
    breq    read_keys_end_right
    cpi     r16, 0b01111011 ; move left
    breq    read_keys_end_left

    rjmp    read_keys_end
read_keys_end_right:
    call    move_gamestate_update_board_right
    rjmp    read_keys_end
read_keys_end_left:
    call    move_gamestate_update_board_left
read_keys_end:	
    ldi 	r16,(ADDR_BUTTON  << 1) | 1
    call 	TWI_READ
    mov     r18,r16
	pop 	r16
    ret

move_gamestate_update_board_left:

    ; OM BLOCKET KAN FLYTTAS
    push    r16 
    ldi     r16,1 
    sts     MOVEMENT_DIRECTION,r16
    pop     r16
    call    can_block_move
    ; FORTSÄTTER
    cpi     r22,1
    breq    move_gamestate_update_board_to_move_left
    ; ANNARS
    ret
    ; SPAWNA NYTT BLOCK SEN FORTSÄTT

move_gamestate_update_board_to_move_left:

    push    r16
    push    r17
    ldi     r17,0

move_gamestate_update_board_start_left:
    mov     r16,r20
    _DROP

    cpi     r16,$E0
    breq    move_gamestate_update_board_end

    inc     r17
    call    move_gamestate_move_block_left
    push    r16

    rjmp    move_gamestate_update_board_start_left

move_gamestate_update_board_right:

    ; OM BLOCKET KAN FLYTTAS
    push    r16 
    ldi     r16,2 
    sts     MOVEMENT_DIRECTION,r16
    pop     r16
    call    can_block_move
    ; FORTSÄTTER
    cpi     r22,1
    breq    move_gamestate_update_board_to_move_right
    ; ANNARS
    ret
    ; SPAWNA NYTT BLOCK SEN FORTSÄTT

move_gamestate_update_board_to_move_right:

    push    r16
    push    r17
    ldi     r17,0

move_gamestate_update_board_start_right:
    mov     r16,r20
    _DROP

    cpi     r16,$E0
    breq    move_gamestate_update_board_end

    inc     r17
    call    move_gamestate_move_block_right
    push    r16

    rjmp    move_gamestate_update_board_start_right

move_gamestate_update_board_end:

    inc     r17
    push    r16
    
move_gamestate_update_board_end_loop:
    pop     r16
    _LITr16
    dec     r17
    cpi     r17,0
    brne    move_gamestate_update_board_end_loop

    pop     r17
    pop     r16
    ret

move_gamestate_move_block_right:
    call    gamestate_clear_block
    swap    r16
    inc     r16
    swap    r16
    call    gamestate_draw_block
    ret

move_gamestate_move_block_left:
    call    gamestate_clear_block
    swap    r16
    dec     r16
    swap    r16
    call    gamestate_draw_block
    ret