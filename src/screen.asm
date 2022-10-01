Screen: {
    .label ScreenPtr = $04
    .label MapPtr = $06
    .label ColorPtr = $08
    .label ColorMapPtr = $0a
    Row: .byte 25

    Draw: {
        Set16Value(VIC.SCREEN_RAM, ScreenPtr)
        Set16Value(Map, MapPtr)
    !Rows:
        ldy #00
    !Cols:
        lda (MapPtr),y
        sta (ScreenPtr),y
        
        iny
        tya
        cmp #40
        bne !Cols-

        Add16Value(ScreenPtr, 40, ScreenPtr)
        Add16Value(MapPtr, 40, MapPtr)

        dec Row
        bne !Rows-

        rts
    }

    Map:
        .import binary "./assets/map.bin"
    MapEnd:

    Colors:
        .import binary "./assets/colors.bin"

}
