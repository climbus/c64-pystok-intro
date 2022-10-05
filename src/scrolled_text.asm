Text: {
    text_ptr: .byte 0
    scroll: .byte 7
    speed: .byte 0
    frame: .byte 7

    .const SCROLL_LINE = 22

    DrawNextLetter: {
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
        lda $0401 + [SCROLL_LINE * 40],x
        sta $0400 + [SCROLL_LINE * 40],x
        inx
        cpx #40
        bne !-
        rts
    }

    .text "the message from the past to modern developers: don't be afraid hex and bits. and remember: resources are always limited..."
}
