bits 16
org 0x0

jmp main

hang: jmp hang

Print:
	lodsb
	or al, al
	jz printdone
	mov ah, 0x0E
	mov bx, 0x00
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
	
	mov si, CRLF
	call Print
	
	mov si, msg
	call Print
	
	mov si, ShutdownMSG
	call Print
	
	mov ah, 0x0
	int 0x16
	
	cli
	hlt

msg db "Welcome to DevOS!", 0x0D, 0x0A, 0
ShutdownMSG db "Press any key to halt." , 0x0D, 0x0A, 0
CRLF db 0x0D, 0x0A, 0

times 511-($-$$) db 0

db 0xAA  ; For DevOS, any executable sectors must end with this
