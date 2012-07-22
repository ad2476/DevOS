bits 16
org 0x0800

jmp main

hang: jmp hang

Print:
	lodsb
	cmp al, 0
	jz printdone
	mov ah, 0x0E
	xor bh, bh
	mov bl, 0x02 ; Green text!
	int 0x10
	jmp Print

printdone: 
	; Print a newline and return
	mov ah, 0x0E
	mov al, 0x0D
	mov bx, 0x00
	int 0x10
	mov al, 0x0A
	int 0x10
	ret

main:
	mov ax, cs
	mov ds, ax
	mov es, ax
	
	cli
	mov ss, ax
	mov sp, 0x9C00
	sti
	
	mov si, msg
	call Print
	
	mov si, ShutdownMSG
	call Print
	
	cli
	hlt

msg db "Welcome to DevOS!", 0
ShutdownMSG db "Press any key to halt." , 0

times 510-($-$$) db 0

dw 0xAABB  ; For DevOS, any executable sectors must end with this
