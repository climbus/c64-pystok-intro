.var music = LoadSid("assets/openyoureyes.sid")	
BasicUpstart2(Start)

#import "macros.asm"
#import "vic.asm"
#import "screen.asm"
#import "irq.asm"
#import "scrolled_text.asm"

Start:
    // Set character memory to $2000
    lda VIC.MEMORY_SETUP_REGISTER
    and #%11110001
    ora #%00001000
    sta VIC.MEMORY_SETUP_REGISTER
    
    jsr Screen.Draw
    jsr IRQ.Setup
!:
    jmp !-

*=music.location "Music"
    .fill music.size, music.getData(i)

* = $2000 "Charset"
Chars:
	.import binary "./assets/chars.bin"
CharsEnd:

