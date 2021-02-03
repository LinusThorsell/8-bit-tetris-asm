jmp waits_private_end

WAIT:
    push    r16
	ldi 	r16,$B0
WAIT_1:
	inc 	r16
	brne 	WAIT_1
    pop     r16
	ret

WAIT_L:
 	adiw	r24,1	; ~16ms
 	brne	WAIT_L
	ret

WAIT_LL:
 	push 	r16
 	ldi 	r16,$E0
 WAIT_LL_1:
 	adiw	r24,1	; ~16ms
 	brne	WAIT_LL_1
 	inc 	r16
 	brne 	WAIT_LL_1
 	pop 	r16
	ret

waits_private_end:
    nop
    nop