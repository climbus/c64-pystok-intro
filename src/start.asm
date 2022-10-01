BasicUpstart2(Start)

Start:
   rts 

Map:
	.import binary "./assets/map.bin"
MapEnd:

Colors:
	.import binary "./assets/colors.bin"

* = $7000 "Charset"
Chars:
	.import binary "./assets/chars.bin"
CharsEnd:
