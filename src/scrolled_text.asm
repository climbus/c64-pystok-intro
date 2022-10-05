Text: {
    text_ptr: .byte 0
    scroll: .byte 7

    DrawNextLetter: {
        rts
    }

    Scroll: {
        dec scroll
        bpl !+
        lda #$07
        sta scroll
    !:
        UpdateYScroll(scroll)
        rts
    }
    .text "the message from the past to modern developers: don't be afraid hex and bits. and remember: resources are always limited..."
}
