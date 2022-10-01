main:
	java -jar /mnt/c/opt/KickAssembler/KickAss.jar -o dist/pystok.prg src/start.asm

debug:
	java -jar /mnt/c/opt/KickAssembler/KickAss.jar -o dist/pystok.prg src/start.asm -debugdump
	C64Debugger.exe dist/pystok.prg

