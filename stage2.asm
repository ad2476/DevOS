bits 16
org 0x0

jmp main

hang: jmp hang

Print:
	lodsb
	or al, al
	jz printdone
	mov ah, 0x0E
	int 0x10
	jmp Print

printdone: ret

main:
	mov ax, cs
	mov ds, ax
	mov es, ax
	
	cli
	mov ss, ax
	mov sp, 0x9C00
	sti
	
	mov ah, 0x00   ; Clear the screen
	mov al, 0x12   ; And put us into 320x200 Graphics Mode
	int 0x10
	
	
	; --- Draw ASCII Art --- ;
	mov si, Art1
	mov bx, 0x000E ; Text is yellow
	call Print
	mov si, Art2
	call Print
	mov si, Art3
	call Print
	mov si, Art4
	call Print
	mov si, Art5
	call Print
	mov si, Art6
	call Print
	; --- End Draw ASCII Art --- ;
	
	mov si, CRLF
	call Print
	
	mov si, ShutdownMSG
	mov bx, 0x0002 ; Text is green
	call Print
	
	mov ah, 0x0
	int 0x16
	
	cli
	hlt

msg db "Welcome to DevOS!", 0x0D, 0x0A, 0
ShutdownMSG db "Press any key to exit." , 0x0D, 0x0A, 0

Art1 db " _______   ___________    ____      ______        _______.", 0x0D, 0x0A, 0
Art2 db "|       \ |   ____\   \  /   /     /  __  \      /       |", 0x0D, 0x0A, 0
Art3 db "|  .--.  ||  |__   \   \/   /     |  |  |  |    |   (----`", 0x0D, 0x0A, 0
Art4 db "|  |  |  ||   __|   \      /      |  |  |  |     \   \    ", 0x0D, 0x0A, 0
Art5 db "|  '--'  ||  |____   \    /       |  `--'  | .----)   |   ", 0x0D, 0x0A, 0
Art6 db "|_______/ |_______|   \__/         \______/  |_______/    ", 0x0D, 0x0A, 0

CRLF db 0x0D, 0x0A, 0

times 511-($-$$) db 0

db 0xAA  ; For DevOS, any executable sectors must end with this
