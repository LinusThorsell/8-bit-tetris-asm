gameover_check:
    push    r16
    push    r18

    ldi     r18,0

    mov     r16,r20
    call    lookup_position_down
    add     r18,r16

    ld      r16,Y
    call    lookup_position_down
    add     r18,r16

    ldd     r16,Y+1
    call    lookup_position_down
    add     r18,r16

    ldd     r16,Y+2
    call    lookup_position_down
    add     r18,r16

    cpi     r18,4
    breq    gameover_not

    lds     r18,GAMEOVER_POSSIBLE
    cpi     r18,1
    breq    gameover_check_possible

    ldi     r18,1
    sts     GAMEOVER_POSSIBLE,r18
    ret

    ; handle game over

gameover_check_possible:

    call    gameengine_cleanup_stack

LOOP_GAME_OVER:
	call	gamestate_draw_stack
	call	damatrix_draw
    ; kalla funktion som kollar knappar wohoo

    ldi 	r16,(ADDR_BUTTON  << 1) | 1
    call 	TWI_READ

	cpi     r16,0b01111111
    breq    LOOP_GAME_OVER

    call    WAIT_LL

    call    gameengine_cleanup_stack
    
    ldi     r16,0
    sts     SCORE,r16

    ldi 	YH,HIGH(STACK)
	ldi 	YL,LOW(STACK)
	
	call 	gameboard_init
	call	gamestate_init
	call	gameengine_init_states
	call	logger_init

gameover_not:
    pop     r18
    pop     r16
    ret