IRQ: {
	.label STABLE_LINE = $10
    .label SCROLL_LINE = $d1

    Setup: {
		sei
		// disable interrupts
        lda #$7f      // 01111111 
        sta $dc0d     // turn off CIA timer interrupt
        sta $dd0d
        lda $dc0d     // cancel any pending IRQs
        lda $dd0d    

        lda #$01
        sta $d01a     // enable VIC-II Raster Beam IRQ
        
        lda $d011     // bit 7 of $d011 is the 9th bit of the raster line.
        and #$7f      // make sure it is set to 0
        sta $d011

        lda #$35      //turn off the BASIC and KERNAL rom here
        sta $01     
		
        lda #music.startSong-1
		jsr music.init

        lda #STABLE_LINE
        sta $d012              // this is the raster line register
        Set16Value(IRQ.StableIRQ, SYSTEM_IRQ_VECTOR)     // set system IRQ vector to our handler
        cli           // enable interupts
        rts
    }

	StableIRQ: {
		IRQStart()
		inc $d020	
        UpdateYScroll($00)
		jsr music.play
		dec $d020
        SetRasterInterrupt(SCROLL_LINE, ScrollIRQ)
		IRQEnd()
	}

    ScrollIRQ: {
        IRQStart()
        inc $d021
        jsr Text.Scroll
        dec $d021
        
        SetRasterInterrupt(STABLE_LINE, StableIRQ)
        IRQEnd()
    }
}
