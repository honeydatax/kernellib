org 0x100
jmp main
msss db '$'
main:
	call message

end:
	mov ax,0
	int 0x21
msg	db 'basic 32 io lib...',13,10,'load ...',13,10,'$'
msgerror	db 'error load file',13,10,'$'
openshell:
	clc
	mov dx,intF0
	mov ah,0x25
	mov al,0xf0
	int 0x21
	mov dx,0x82
	mov al,0
	mov ah,0x3d
	clc
	int 0x21
	jc openshellerror
	mov si,ax
	mov ax,cs
	mov bx,0x1000
	add ax,bx
	mov ds,ax
	mov es,ax
	mov dx,0x100
	mov bx,si
	mov al,0
	mov cx,0xf000
	mov ah,0x3F
	clc
	int 0x21
	jc openshellerror
	mov ah,0x3e
	mov al,0
	mov bx,si
	int 0x21
	jc openshellerror
	mov ax,cs
	mov bx,0x1000
	add ax,bx
	mov ds,ax
	mov es,ax
	push ax
	mov ax,0x100
	push ax
	mov cx,0x100
	mov bx,0
openshell2:
	cs
	mov al,[bx]
	ds
	mov [bx],al
	inc bx
	dec cx
	jnz openshell2
	mov al,0x90
	retf
ret
openshellerror:	
	mov dx,msgerror
	mov ah,0x9
	int 0x21
	mov ax,0
	int 0x21
ret
message:
	mov dx,msg
	mov ah,0x9
	int 0x21
	call getarglist
	call start
	call openshell
ret
getarglist:
	mov bx,0x80
	xor ax,ax
	ds
	mov al,[bx]
	clc
	add bx,ax
	inc bx
	mov al,0
	mov [bx],al
ret
start:
		;start alocate
	mov bx,L18
	mov ax,endf
	mov cx,8
	add ax,cx
	mov [bx],ax
		;end alocate
		;start randomize
	call timer
	mov bx,L20
	xor cx,cx
	mov cl,al
	mov ax,257
	add ax,cx
	mov [bx],ax
		;end randomize
      xor ax,ax
      mov ds,ax
      mov edx,1234567890
      mov ebx,180000h 
      mov eax,[ebx]
      cmp eax,edx
      jz reservemem
      mov eax,4
      clc
      add ebx,eax
      mov eax,100h
      clc                
      add eax,ebx
      mov [ebx],eax
      mov eax,1234567890
      mov ebx,180000h 
      mov [ebx],eax
reservemem:
      mov ebx,180004h 
      mov eax,[ebx]
      mov si,rreservemem
      cs
      mov [si],eax
      mov ax,cs
      mov ds,ax
ret
timer:
	push ebx
	push ds
	mov ax,0x40
	mov ds,ax
	mov bx,0x6c
	mov eax,[bx]
	pop ds
	pop ebx
ret
exit:
      mov si,rreservemem
      mov eax,[si]
	mov ax,0
	mov ds,ax
      mov ebx,180004h 
      mov [ebx],eax
	mov ax,cs
	mov ds,ax
	mov ax,0ffffh
	mov sp,ax
	mov ax,cs
	mov ss,ax
	xor ax,ax
	push ax
	xor ax,ax
	int 0x21
	ret
ret
GOTOXY:                
          push ebx                
          push ecx                
          push edx                
          push esi                
          push edi                
          push ebp                
          mov si,ax
          mov di,bx
          and si,0fffh
          and di,0fffh
          xor cx,cx
          xor dx,dx
          mov ax,si
          mov bx,2                
          clc                
          mul bx                
          mov si,ax
          mov ax,di
          mov bx,160
          clc                
          mul bx                
          mov bx,si
          clc                
          add ax,bx
          and eax,0ffffh
          mov ebx,0b8000h
          clc                
          add eax,ebx
          pop ebp                
          pop edi                
          pop esi                
          pop edx                
          pop ecx                 
          pop ebx                
          RET                
COPYMEM32:
          push eax                
          push ebx                
          push ecx                
          push edx                
          push esi                
          push edi                
          push ebp                
          push ds                
          mov bp,0                
          mov ds,bp
          cmp edx,0
          JZ COPYMEM326
          COPYMEM3211:
          cmp ecx,0
          JZ COPYMEM326
          COPYMEM321:
                    ds
                    mov al,[esi]
                    ds
                    mov [edi],al
                    clc                
                    add edi,edx
                    inc esi                
                    dec ecx                
                    jnz COPYMEM321
                    COPYMEM326:
                    pop ds                
                    pop ebp                
                    pop edi                
                    pop esi                
                    pop edx                
                    pop ecx                 
                    pop ebx                
                    pop eax                
                    RET                
PRINT32:                
          push eax                
          push ebx                
          push ecx                
          push edx                
          push esi                
          push edi                
          push ebp                
          cmp ecx,0
          JZ PRINT3213
          push esi                
          mov si,x                
          cs                
          mov al,[si]                
          cs                
          mov bl,[si+1]                
          pop esi             
             and ax,0ffh
          and bx,0ffh
          call GOTOXY
          mov edi,eax
          cmp ecx,255
          JB PRINT3212
          mov ebx,255
          PRINT3212:
          mov edx,2
          call COPYMEM32
          push esi                
          mov si,x                
          cs                				
          mov al,[si]          
          cs                				   
          mov bl,[si+1]           
          pop esi                
          and ax,0ffh
          and bx,0ffh
          mov si,bx
          clc                
			
          add ax,cx
          cmp ax,80
          JB PRINT328
          mov bx,80
          sub ax,bx
          xor dx,dx
          xor cx,cx
          mov bx,80
          clc                
          div bx                
          clc                
          add ax,si
          cmp ax,24
          JB PRINT328
          mov ax,24
          PRINT328:
          push esi                
          mov si,x                
          cs                				
          mov al,[si+1]           
          inc al           
          cs                				
          mov [si+1],al           
          mov al,0           
          cs                				
          mov [si],al 
          pop esi                
          PRINT3213:
          pop ebp                
          pop edi                
          pop esi                
          pop edx                
          pop ecx                 
          pop ebx                
          pop eax                
          RET                
len32:
          push ebx                
          push ecx                
          push edx                
          push esi                
          push edi                
          push ebp                
          push ds                
          mov bp,0                
          mov ds,bp
	    mov ecx,0
len321:
	    ds
	    mov al,[esi]
	    cmp al,0
	    jz len323
	    inc esi
	    inc ecx
	    jmp len321
len323:				
		mov eax,ecx				
                    pop ds                
                    pop ebp                
                    pop edi                
                    pop esi                
                    pop edx                
                    pop ecx                 
                    pop ebx                
	ret
ret
MEM32:                
          push esi                
          and eax,0ffffh
          clc                
          shl eax,4
          and esi,0ffffh
          clc                 
          add eax,esi
          pop esi                
          RET                
echo:
          push bp                
          mov ax,ds
          mov es,ax
          xchg si,bp 
          mov bx,bp
          ds
          mov cl,[bx]
          inc bp                
          and cx,0ffh
          mov bx,x
          cs
          mov dx,[bx]
          mov bx,color
          cs
          mov al,[bx]
          mov bl,al
          mov bh,0   
          mov al,0                
          mov ah,13h
          int 10h                
          pop bp                
          IRET   

funcecho:
	mov si,bx
	jmp echo
STR32:                
        push eax                
        push ebx                
        push ecx                
        push edx                
        push edi                
        push esi                
        push ebp                
        push ds                
        mov eax,[si]
        mov ebp,0			
        mov ds,bp                
        mov ebp,1000000000
        STR321:                
                  xor edx,edx
                  xor ecx,ecx
                  mov ebx,ebp
                  clc                 
                  div ebx                
                  mov esi,edx
                  mov ah,'0'
                  clc                
                  add al,ah
                  mov [edi],al
                  inc edi                
                  mov eax,ebp
                  xor edx,edx
                  xor ecx,ecx
                  mov ebx,10
                  clc                
                  div ebx                
                  mov ebp,eax
                  mov eax,esi
                  cmp ebp,0
                  JNZ STR321
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          pop eax                
          RET          
intF0:
	cmp ax,19
	ja intF0_0
	jmp intF0_A20
intF0_0:
iret
ret
intF0_A20:
	cmp ax,0
	jnz intF0_A20_1
	jmp funcend
intF0_A20_1:
	cmp ax,1
	jnz intF0_A20_2
	jmp funcprint32
intF0_A20_2:
	cmp ax,2
	jnz intF0_A20_3
	jmp funcmem32
intF0_A20_3:
	cmp ax,3
	jnz intF0_A20_4
	jmp funcecho
intF0_A20_4:
	cmp ax,4
	jnz intF0_A20_5
	jmp funclike
intF0_A20_5:
	cmp ax,5
	jnz intF0_A20_6
	jmp funcdiferent
intF0_A20_6:
	cmp ax,6
	jnz intF0_A20_7
	jmp funcbig
intF0_A20_7:
	cmp ax,7
	jnz intF0_A20_8
	jmp funcless
intF0_A20_8:
	cmp ax,8
	jnz intF0_A20_9
	jmp funcstr
intF0_A20_9:
	cmp ax,9
	jnz intF0_A20_10
	jmp funcmath
intF0_A20_10:

iret
funcend:
	jmp exit
iret	
funcmem32:
	mov ax,cx
	mov si,bx
	call MEM32
iret	
funcprint32:
	ds
	mov esi,[bx]
	call len32
	mov ecx,eax
	call PRINT32
iret	
funclike:
	mov si,bx
	ds
	mov eax,[si]
	mov si,cx
	ds
	mov ebx,[si]
	cmp eax,ebx
	jnz funclike2
	iret
funclike2:
	pop eax
	inc sp
	push ds
	push dx
	retf
funcdiferent:
	mov si,bx
	ds
	mov eax,[si]
	mov si,cx
	ds
	mov ebx,[si]
	cmp eax,ebx
	jz funcdiferent2
	iret
funcdiferent2:
	pop eax
	inc sp
	push ds
	push dx
	retf
funcbig:
	mov si,bx
	ds
	mov eax,[si]
	mov si,cx
	ds
	mov ebx,[si]
	cmp eax,ebx
	jle funcbig2
	iret
funcbig2:
	pop eax
	inc sp
	push ds
	push dx
	retf
funcless:
	mov si,bx
	ds
	mov eax,[si]
	mov si,cx
	ds
	mov ebx,[si]
	cmp eax,ebx
	jae funcless2
	iret
funcless2:
	pop eax
	inc sp
	push ds
	push dx
	retf
funcstr:
	push bx
	mov si,L17
	mov ax,cs
	call MEM32
	mov edi,eax
	pop bx
	mov si,bx
	call STR32
	mov si,L17
	mov ax,cs
	call MEM32
	mov esi,eax
	call len32
	mov ecx,eax
	call PRINT32
iret
funcmath:
	mov ax,si
	cmp ax,0
	jz funcadd
	cmp ax,1
	jz funcsub
	cmp ax,2
	jz funcmul
	cmp ax,3
	jz funcdiv
	cmp ax,4
	jz funcremain
	cmp ax,5
	jz funcupto
	cmp ax,6
	jz funcor
	cmp ax,7
	jz funcand
	cmp ax,8
	jz funcnot
	cmp ax,9
	jz funcxor
	jmp funcmath2 
iret
funcadd:
	mov si,cx
	ds
	mov eax,[si]
	mov si,dx
	ds
	mov ecx,[si]
	add eax,ecx
	mov si,bx
	ds
	mov [si],eax
	iret
funcsub:
	mov si,cx
	ds
	mov eax,[si]
	mov si,dx
	ds
	mov ecx,[si]
	sub eax,ecx
	mov si,bx
	ds
	mov [si],eax
	iret
funcmul:
	push bx
	mov si,cx
	ds
	mov eax,[si]
	mov si,dx
	ds
	mov ebx,[si]
	mov ecx,0
	mov edx,0
	mul ebx
	pop si
	ds
	mov [si],eax
	iret
funcdiv:
	push bx
	mov si,cx
	ds
	mov eax,[si]
	mov si,dx
	ds
	mov ebx,[si]
	mov ecx,0
	mov edx,0
	div ebx
	pop si
	ds
	mov [si],eax
	iret
funcremain:
	push bx
	mov si,cx
	ds
	mov eax,[si]
	mov si,dx
	ds
	mov ebx,[si]
	mov ecx,0
	mov edx,0
	div ebx
	pop si
	ds
	mov [si],edx
	iret
funcupto:
	push bx
	mov si,cx
	ds
	mov eax,[si]
	mov si,dx
	ds
	mov ebx,[si]
	cmp ebx,0
	jz funcupto3
	dec ebx
	mov esi,eax
	mov edi,ebx
	mov ebx,eax
	cmp edi,0
	jz funcupto2
	jmp funcupto1
funcupto3:
	mov eax,0
	jmp funcupto2
funcupto1:
	mov ebx,esi
	mov ecx,0
	mov edx,0
	mul ebx
	dec edi
	cmp edi,0
	jnz funcupto1
funcupto2:
	pop si
	ds
	mov [si],eax
	iret
funcor:
	mov si,cx
	ds
	mov eax,[si]
	mov si,dx
	ds
	mov ecx,[si]
	or eax,ecx
	mov si,bx
	ds
	mov [si],eax
	iret
funcand:
	mov si,cx
	ds
	mov eax,[si]
	mov si,dx
	ds
	mov ecx,[si]
	and eax,ecx
	mov si,bx
	ds
	mov [si],eax
	iret
funcnot:
	mov si,cx
	ds
	mov eax,[si]
	mov si,dx
	not eax
	mov si,bx
	ds
	mov [si],eax
	iret
funcxor:
	mov si,cx
	ds
	mov eax,[si]
	mov si,dx
	ds
	mov ecx,[si]
	xor eax,ecx
	mov si,bx
	ds
	mov [si],eax
	iret
funcmath2:
	cmp ax,10
	jz funcset
	cmp ax,11
	jz funcreset
	cmp ax,12
	jz funcreget
	cmp ax,13
	jz funcretrogle
iret 
funcset:
	push cx
	push bx
	mov si,dx
	mov eax,1
	ds
	mov ebx,[si]
	cmp ebx,0
	jz funcset2
	mov edi,ebx
	mov esi,2
funcset1:
	mov ebx,esi
	mov ecx,0
	mov edx,0
	mul ebx
	dec edi
	cmp edi,0
	jnz funcset1
funcset2:
	pop si
	pop di
	ds
	mov ebx,[di]
	or eax,ebx
	ds
	mov [si],eax
iret
funcreset:
	push cx
	push bx
	mov si,dx
	mov eax,1
	ds
	mov ebx,[si]
	cmp ebx,0
	jz funcreset2
	mov edi,ebx
	mov esi,2
funcreset1:
	mov ebx,esi
	mov ecx,0
	mov edx,0
	mul ebx
	dec edi
	cmp edi,0
	jnz funcreset1
funcreset2:
	pop si
	pop di
	ds
	mov ebx,[di]
	not eax
	and eax,ebx
	ds
	mov [si],eax
	iret
funcreget:
	push cx
	push bx
	mov si,dx
	mov eax,1
	ds
	mov ebx,[si]
	cmp ebx,0
	jz funcreget2
	mov edi,ebx
	mov esi,2
funcreget1:
	mov ebx,esi
	mov ecx,0
	mov edx,0
	mul ebx
	dec edi
	cmp edi,0
	jnz funcreget1
funcreget2:
	pop si
	pop di
	ds
	mov ebx,[di]
	and eax,ebx
	cmp eax,0
	jz funcreget5
	mov eax,1
funcreget5:
	ds
	mov [si],eax
	iret
funcretrogle:
	push bx
	push cx
	push cx
	mov si,dx
	mov eax,1
	ds
	mov ebx,[si]
	cmp ebx,0
	jz funcretrogle2
	mov edi,ebx
	mov esi,2
funcretrogle1:
	mov ebx,esi
	mov ecx,0
	mov edx,0
	mul ebx
	dec edi
	cmp edi,0
	jnz funcretrogle1
funcretrogle2:
	pop di
	ds
	mov ebx,[di]
	push eax
	and eax,ebx
	cmp eax,0
	jz funcretrogle5
	pop ebx
	pop si
	ds
	mov eax,[si]
	not ebx
	and eax,ebx
	jmp funcretrogle6
funcretrogle5:
	pop ebx
	pop si
	ds
	mov eax,[si]
	or eax,ebx
funcretrogle6:
	pop si
	ds
	mov [si],eax
	iret

L18 dd 0
L20 dd 0
L17 db "0000000000",0,0,0,0,0,0,0,0
x dw 1
y dw 1
color db 7
var dd 0
rreservemem dd 0
endf dd 0
