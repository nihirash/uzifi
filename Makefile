all: test.sna

test.sna: *.asm
	sjasmplus main.asm