BasicUpstart2(Start)

#import "macros.asm"
#import "vic.asm"
#import "screen.asm"

Start:

    // Set character memory to $2000
    lda VIC.MEMORY_SETUP_REGISTER
    and #%11110001
    ora #%00001000
    sta VIC.MEMORY_SETUP_REGISTER
    
    jsr Screen.Draw
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
