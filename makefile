all:
	nasm -f bin boot.asm -o boot.bin
	nasm -f bin loader.asm -o loader.bin

clean:
	rm -f DevOS.img

img: clean
	mkfs -t msdos -C DevOS.img 1440
	dd if=boot.bin of=DevOS.img bs=512 count=1
	dd if=loader.bin of=DevOS.img seek=1 obs=512 count=1

disk:	
	sudo dd if=DevOS.img of=/dev/sdb count=1
