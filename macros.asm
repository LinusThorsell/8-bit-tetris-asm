.macro _LIT
    st      -Y,r20
    ldi     r20,@0
.endmacro

.macro _LITr16
    st      -Y,r20
    mov     r20,r16
.endmacro

.macro _DROP
    ld      r20,Y+
.endmacro

.macro _DUP
    st      -Y,r20
.endmacro

.macro _SWAP
    mov r3,r20
    ld r20,Y+
    st -Y,r3
.endmacro

    ; stack x=0000 y=0000 0000 0000
    ; x=0000 y=0000
    ; x=0000 y=0000
    ; 69696969
    ;...
    ; Tar ned från stacken
    ; Kolla om de är 6969696969
    ; ritar vi de som är där
    ; slänger till toppen av stacken.