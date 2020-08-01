org 0x100

main:
	mov dx,msg
	mov ah,0x9
	int 0x21


end:
	mov ax,0
	int 0xF0
msg	db 'hello world',13,10,'$'
