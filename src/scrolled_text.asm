Text: {
    scroll: .byte 7
    speed: .byte 0
    frame: .byte 7
    cycle: .byte 0
    fade: .byte $0d, $0d, $03, $03, $0e, $0e, $04, $04, $0b, $0b, $04, $04, $0e, $0e, $03, $03 
    fade_pos: .byte $0f
    .label text_ptr = $04
    .const SCROLL_LINE = 22
    
    Init: {
       Set16Value(text_start, text_ptr) 
       ldx #$10
       ldy #40
    !Row:   
       lda fade,x
       sta VIC.COLOR_RAM + [22 * 40],y
       dex
       bpl !+
       ldx #$10
    !:
       dey
       bpl !Row-
       rts
    }

    DrawNextLetter: {
        ldy #00
        lda (text_ptr),y
        cmp #$5c
        bne !+
        Set16Value(text_start, text_ptr) 
        lda cycle
        eor #01
        sta cycle
        jmp !++
    !:
        asl
        clc
        adc #$9a
        adc cycle
        sta VIC.SCREEN_RAM + [22 * 40] + 38

        lda cycle
        beq !+
        lda text_ptr
        clc
        adc #01
        sta text_ptr
        lda text_ptr + 1
        adc #00
        sta text_ptr + 1
    !:
        lda cycle
        eor #01
        sta cycle
        ldx fade_pos
        lda fade,x
        sta VIC.COLOR_RAM + [SCROLL_LINE * 40] + 38
        dec fade_pos
        bpl !+
        lda #$0f
        sta fade_pos
    !:
        rts
    }

    Scroll: {
        dec frame
        bpl !NextFrame+
        dec scroll
        bpl !+
        lda #$07
        sta scroll
        jsr CopyLine
        jsr DrawNextLetter
    !:
        lda speed
        sta frame
    !NextFrame:
        UpdateYScroll(scroll)
        rts
    }

    CopyLine: {
        ldx #0
    !:
        lda VIC.SCREEN_RAM + 1 + [SCROLL_LINE * 40],x
        sta VIC.SCREEN_RAM + [SCROLL_LINE * 40],x
        inx
        cpx #40
        bne !-
        rts
    }
}

* = $4000 "Text"
text_start:
    .text "the message from the past to modern developers[ don't be afraid of bits and hexes.      and remember[ resources are always limited...       but still, the most important thing is fun...                coding[ climbus          music[ nordischsound       logo by pystok...                   see you on #%.#&.$&$$ in gwint club...                        \n"
text_end:
