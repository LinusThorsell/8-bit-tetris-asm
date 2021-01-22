# Project Tetris

Tetris på DAvid kort skapat av Linus Thorsell och David Sohl

## Checklista
* Fixa kravspecifikation [x]
* Hämta ut hårdvara []
* Få projekt godkännt []

## Specifikation
En tetris klon. Med display på DAmatrix.

### Krav
* Skapa fallande block på toppen av matrix-displayen.
* Förflyttning och rotation med tryckknappar.
* Ta bort raden då den är fylld. och droppa ned resten av blocken så att utrymmet fylls.
* Väldigt basic ljudeffekter.
* Minst 2 olika block. 2x2 & 1x4

### Önskemål
* Tetris musik
* "Nästa block" på LCD displayen
* Paus meny
* Flashy effekter
* Fler olika tetris block

### Önskad Hårdvara
* DAmatrix (helst x2 men det är förståligt om hårdvaran saknas. Projektet kan utföras på endast x1 matrix)
* LCD Keypad
* LED Strip

### Programflöde - Spelplan
* Själva programmet modifierar en sträng i SRAM. 8x8=64 tecken långt. Där det defineras hur spelplanen ser ut. Ex rad 1: 000RR000.
* En funktion som ritar strängen i SRAm till DAmatrix displayen.
