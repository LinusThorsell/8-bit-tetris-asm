;
; Gameloop.asm
;
; Created: 25/01/2021 09:16:48
; Author : linus
;


//sram
//gameloop_private_board:
//--------
//--------
//--------
//---RR---
//L--RR---
//L-------
//L-------
//L-------
//gameloop_private_piece:
//lowest point 1: x,y
//lowest point 2: x,y


; Replace with your application code
start:
	call gameloop_init

loop:
	call gameloop_dogametick
	rjmp loop

gameloop_init:
	//define gameboard with default values
	ret

gameloop_movepiece:
	//move pieces according to r16 = left/right
	ret

gameloop_dogametick:
	push r17
	push r18
	
	//if canmovedownwards
	//move downwards
	rjmp gameloop_private_finished
	//else
	//getrandom
	//placeblockandupdateindex

	gameloop_private_finished:
	pop r18
	pop r17
	ret

gameloop_private_canmovedownwards:
	ret

gameloop_private_movedownwards:
	ret

gameloop_private_getrandom:
	ret

gameloop_private_placeblockandupdateindex:
	ret