org 0x100

main:
	mov bx,integer1
	mov cx,integer2
	mov dx,integer3
	mov si,5
	mov ax,0x9
	int 0xf0
	mov bx,integer1
	mov ax,0x8
	int 0xf0


end:
	mov ax,0
	int 0xF0
msg	db 12,'hello world',13,10,0
integer1 dd 0
integer2 dd 2
integer3 dd 2