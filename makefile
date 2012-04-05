all: boot.asm
	nasm -f bin boot.asm -o boot.bin

clean:
	rm boot.bin

install: 
	sudo dd if=boot.bin of=/dev/sdb bs=512 count=1
