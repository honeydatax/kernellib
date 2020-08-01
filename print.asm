org 0x100

main:
	mov bx,msg
	mov ax,cs
	mov cx,ax
	mov ax,2
	int 0xF0
	mov si,point
	mov [si],eax
	mov bx,point
	mov ax,1
	int 0xF0



end:
	mov ax,0
	int 0xF0
msg	db 'hello world',0
point   dd 0