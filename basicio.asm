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
	jnz intF0_A20_2
	jmp funcmem32
intF0_A20_3:
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


L18 dd 0
L20 dd 0
x dw 0
rreservemem dd 0
endf dd 0
