org 0x7c00 ; Loaded by BIOS at 0x7c00
bits 16 ; Still 16-bit mode

main: jmp loader ; Skip the first stuff and jump straight to loader

bpbOEM db "DevOS   "

bpbBytesPerSector DW 512
bpbSectorsPerCluster DB 1
bpbReservedSectors DW 1
bpbNumberOfFATs: DB 2
bpbRootEntries: DW 224
bpbTotalSectors: DW 2880
bpbMedia: DB 0xF0
bpbSectorsPerFAT: DW 9
bpbSectorsPerTrack: DW 18
bpbHeadsPerCylinder: DW 2
bpbHiddenSectors: DD 0
bpbTotalSectorsBig: DD 0
bsDriveNumber: DB 0
bsUnused: DB 0
bsExtBootSignature DB 0x29
bsVolumeLabel: DB "OS      "
bsFileSystem: DB "FAT12   "

msg_w db "Welcome to DevOS!", 0
msg_s db " ", 0
msg_d db "This is a very basic OS", 0

print:
	lodsb ; Load next byte from string from si to al
	or al, al ; Does al=0?
	jz print_done ; If yes, string is over
	mov ah, 0x0e ; Otherwise, move the move the char into ah
	int 0x10 ; Call the BIOS video interrupt
	jmp print ; Repeat

print_done:
	ret ; return

loader:
	xor ax, ax ; Setup segments to ensure they are 0x0
	mov ds, ax
	mov es, ax

	mov si, msg_w ; move our message into si
	call print

	mov si, msg_s
	call print

	mov si, msg_d
	call print

	xor ax, ax 
	int 0x12 ; BIOS interrupt->amount of RAM (kB)

	cli ; Clear all interrupts
	hlt ; Halt the system

times 510-($-$$) db 0 ; Fill the rest of the sector with zeros
dw 0xAA55  ; Boot signature
