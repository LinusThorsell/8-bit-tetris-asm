SPI_START:
	push 	r16

	ldi 	r16,(1 << CS)|(1 << MOSI)|(1 << SCK)
	out 	SPI_DDR,r16
	ldi 	r16,(1 << SPE)|(1 << MSTR)|(1 << SPR1)|(1 << SPR0)
	out 	SPCR,r16

	pop 	r16
	ret

SPI_END:
	ldi 	r16,(0 << CS)|(1 << MOSI)|(1 << SCK)
	out 	SPI_DDR,r16
	ret

SPI_SEND:
	;ret
	push	r17
	push	r18	

	out 	SPDR,r16

SPI_SEND_WAIT:
 	in 		r17,SPSR
 	ldi 	r18,(1<<SPIF)
 	and 	r17,r18

 	cpi 	r17,$00
 	breq 	SPI_SEND_WAIT

	pop		r18
	pop 	r17
	ret