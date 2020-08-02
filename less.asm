org 0x100

main:
less:
	mov dx,end
	mov bx,var1
	mov cx,var2
	mov ax,7
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
msg	db 'bx less from cx var',0
point   dd 0
var1	dd 0
var2	dd 1