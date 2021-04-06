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

wait500us:
	push 	r16
	ldi 	r16,166
wait500us_loop:
	dec 	r16
	cpi 	r16,0
	brne 	wait500us_loop

	pop 	r16
	ret