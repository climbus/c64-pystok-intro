#importonce

VIC: {
    .label SCREEN_COLOR = $d020
    .label FRAME_COLOR = $d021

    .label COLOR_RAM = $d800

    .label SCREEN_RAM = $0400
    .label SCREEN_MSB = $04

    .label ENABLE_SPRITE_REGISTER = $d015
    .label SCROLL_REGISTER = $d011
    .label MEMORY_SETUP_REGISTER = $d018

    .label temp = $13

    WaitForFrame: { 
        lda $d012
        sty temp
        cmp temp
        bne WaitForFrame
        rts
    }
}
