org 0x100

main:
big:
	mov dx,end
	mov bx,var1
	mov cx,var2
	mov ax,6
	int 0Xf0


print:
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
msg	db 'bx big from cx var',0
point   dd 0
var1	dd 1
var2	dd 0