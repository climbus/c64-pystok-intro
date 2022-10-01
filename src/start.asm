BasicUpstart2(Start)

Start:
    lda $d018
    and #%11110001
    ora #%00001000
    sta $d018

!:
    jmp !-

Map:
	.import binary "./assets/map.bin"
MapEnd:

Colors:
	.import binary "./assets/colors.bin"

* = $2000 "Charset"
Chars:
	.import binary "./assets/chars.bin"
CharsEnd:
