org 0x100

main:
	mov bx,integer1
	mov cx,integer2
	mov dx,integer3
	mov si,4
	mov ax,0x8
	int 0xf0


end:
	mov ax,0
	int 0xF0
msg	db 12,'hello world',13,10,0
integer1 dd 1234567890