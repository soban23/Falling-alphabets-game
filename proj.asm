[org 0x0100]
jmp start

cols: dw 5000,5000,5000,5000,5000
st: dw 2,2,2,2,2
rows: dw 0,0,0,0,0
col_alp: dw 0,0,0,0,0
col_speed: dw 0,0,0,0,0
old: dd 0
box: dw 3920
score: dw 0
fails: dw 0

clrscr1: 
	 pusha
	 ;pushf
	 mov ax, 0xb800
	 mov es, ax ; point es to video base
	 xor di, di ; point di to top left column
	 mov ax, 0x0720 ; space char in normal attribute
	 mov cx, 2000 ; number of screen locations
	 cld ; auto increment mode
	 rep stosw ; clear the whole screen
	mov ah,0x07
	mov al,'G'
	mov word[es:160],ax
	mov al,'a'
	mov word[es:162],ax
	mov al,'m'
	mov word[es:164],ax
	mov al,'e'
	mov word[es:166],ax
	mov al,' '
	mov word[es:168],ax
	mov al,'O'
	mov word[es:170],ax
	mov al,'v'
	mov word[es:172],ax
	mov al,'e'
	mov word[es:174],ax
	mov al,'r'
	mov word[es:176],ax
	mov al,':'
	mov word[es:178],ax
	mov al,'('
	mov word[es:180],ax
	 ;popf
	 popa
	 ret 



clrscr: 
	 pusha
	 ;pushf
	 mov ax, 0xb800
	 mov es, ax ; point es to video base
	 xor di, di ; point di to top left column
	 mov ax, 0x7020 ; space char in normal attribute
	 mov cx, 2000 ; number of screen locations
	 cld ; auto increment mode
	 rep stosw ; clear the whole screen
	 ;popf
	 popa
	 ret 

delay:
	pusha
	;pushf

	mov cx,1000
	mydelay:
	mov bx,100     ;; increase this number if you want to add more delay, and decrease this number if you want to reduce delay.
	mydelay1:
	dec bx
	jnz mydelay1
	loop mydelay

	;popf
	popa
ret

delayx:
	pusha
	;pushf

	mov cx,1000
	mydelayx:
	mov bx,2500    ;; increase this number if you want to add more delay, and decrease this number if you want to reduce delay.
	mydelay1x:
	dec bx
	jnz mydelay1x
	loop mydelayx

	;popf
	popa
ret	 

; a function to generate random number between 0 and n
; input: n, can be accessed using bp+4
; output: random number can be accessed in function using bp+6
rand:
   push bp
   mov bp,sp
   push ax
   push cx
   push dx
   
   MOV AH, 00h  ; interrupts to get system time        
   INT 1AH      ; CX:DX now hold number of clock ticks since midnight      
   mov  ax, dx
   xor  dx, dx
   mov  cx, [bp+4] 
   inc cx   
   div  cx       ; here dx contains the remainder of the division - from 0 to 9
   mov [bp+6], dx
   pop dx
   pop cx
   pop ax
   pop bp   
   ret 2



col1:
push ax
push di

mov di,[st]
add di,3840
mov word[es:di],0x7020


mov ax,30
push 0
push ax
call rand
pop ax
test ax,00000001b
jz a1
add ax,1

a1:
add ax,2
mov [cols],ax
mov [st],ax

mov ax,25
push 0
push ax
call rand
pop ax
add ax,97
mov [col_alp],ax

;mov [rows],0
mov ax,2
push ax
push ax
call rand
pop ax
mov [col_speed],ax

pop di
pop ax
ret

col2:
push ax

push di

mov di,[st+2]
add di,3840
mov word[es:di],0x7020


mov ax,32
push ax
push ax
call rand
pop ax
add ax,32
test ax,00000001b
jz a2
add ax,1

a2:

mov [cols+2],ax
mov [st+2],ax

mov ax,25
push ax
push ax
call rand
pop ax
add ax,97
mov [col_alp+2],ax

;mov [rows+2],0
mov ax,2
push ax
push ax
call rand
pop ax
mov [col_speed+2],ax

pop di
pop ax
ret

col3:

push ax

push di

mov di,[st+4]
add di,3840
mov word[es:di],0x7020

mov ax,32
push ax
push ax
call rand
pop ax
add ax,64
test ax,00000001b
jz a3
add ax,1

a3:

mov [cols+4],ax
mov [st+4],ax

mov ax,25
push ax
push ax
call rand
pop ax
add ax,97
mov [col_alp+4],ax

;mov [rows+4],0
mov ax,2
push ax
push ax
call rand
pop ax
mov [col_speed+4],ax

pop di
pop ax
ret

col4:
push ax

push di

mov di,[st+6]
add di,3840
mov word[es:di],0x7020

mov ax,32
push ax
push ax
call rand
pop ax
add ax,96
test ax,00000001b
jz a4
add ax,1

a4:

mov [cols+6],ax
mov [st+6],ax

mov ax,25
push ax
push ax
call rand
pop ax
add ax,97
mov [col_alp+6],ax

;mov [rows+6],0
mov ax,2
push ax
push ax
call rand
pop ax
mov [col_speed+6],ax

pop di
pop ax
ret

col5:
push ax

push di

mov di,[st+8]
add di,3840
mov word[es:di],0x7020

mov ax,32
push ax
push ax
call rand
pop ax
add ax,126
test ax,00000001b
jz a5
add ax,1

a5:
mov [cols+8],ax
mov [st+8],ax

mov ax,25
push ax
push ax
call rand
pop ax
add ax,97
mov [col_alp+8],ax

;mov [rows+8],0
mov ax,2
push ax
push ax
call rand
pop ax
mov [col_speed+8],ax

pop di
pop ax
ret




flow:



push es
pusha

push 0xb800
pop es

;mov word[es:3920],0x70dc
xxx:
mov di,[box]
mov word[es:di],0x70dc
cmp word[cs:cols],4000
jl nxt1

call delay
call col1

nxt1:
cmp word[cs:cols+2],4000
jl nxt2

call delay
call col2

nxt2:
cmp word[cs:cols+4],4000
jl nxt3

call delay
call col3

nxt3:
cmp word[cs:cols+6],4000
jl nxt4 

call delay
call col4

nxt4:
cmp word[cs:cols+8],4000
jl nxt5

call delay
call col5

nxt5:

push 0xb800
pop es

;1
mov bx,[cs:cols]
mov di,bx
push bx; save prev cols dest
mov bx,[cs:col_speed]

cmp bx,0
je a0

cmp bx,1
je aa1

cmp bx,2
je aa2

a0:


mov bx,[cols]
cmp bx,3840
jb s1
cmp word[box],bx
jne x1

add word[score],1
jmp s1

x1:

add word[fails],1

s1:

pop bx
add bx,160
push 160
jmp nxxt1
aa1:


mov bx,[cols]
;sub bx,160
cmp bx,3840
jb s2
cmp word[box],bx
jne x2

add word[score],1
jmp s2

x2:

add word[fails],1

s2:


pop bx
add bx,320
push 320
jmp nxxt1
aa2:


mov bx,[cols]
;sub bx,320
cmp bx,3840
jb s3
cmp word[box],bx
jne x3

add word[score],1
jmp s3

x3:

add word[fails],1

s3:


pop bx
push 480
add bx,480


nxxt1:


mov [cs:cols],bx
mov bx,[cs:col_alp]
mov ax,bx


mov ah,0x70
mov [es:di],ax

pop bx
sub di,bx

cmp di,0
jl skip1
mov word[es:di],0x7020
skip1:


;2
mov bx,[cs:cols+2]
mov di,bx
push bx; save prev cols dest
mov bx,[cs:col_speed+2]

cmp bx,0
je a00

cmp bx,1
je a11

cmp bx,2
je a22

a00:

mov bx,[cols+2]
cmp bx,3840
jb s11
cmp word[box],bx
jne x11

add word[score],1
jmp s11

x11:

add word[fails],1

s11:

pop bx
add bx,160
push 160
jmp nxt11
a11:

mov bx,[cols+2]
;sub cx,160
cmp bx,3840
jb s22
cmp word[box],bx
jne x22

add word[score],1
jmp s22

x22:

add word[fails],1

s22:

pop bx
add bx,320
push 320
jmp nxt11
a22:


mov bx,[cols+2]
;sub cx,320
cmp bx,3840
jb s33
cmp word[box],bx
jne x33

add word[score],1
jmp s33

x33:

add word[fails],1

s33:
pop bx
push 480
add bx,480


nxt11:


mov [cs:cols+2],bx
mov bx,[cs:col_alp+2]
mov ax,bx


mov ah,0x70
mov [es:di],ax

pop bx
sub di,bx

cmp di,0
jl skip11
mov word[es:di],0x7020
skip11:

;3
mov bx,[cs:cols+4]
mov di,bx
push bx; save prev cols dest
mov bx,[cs:col_speed+4]

cmp bx,0
je a000

cmp bx,1
je a111

cmp bx,2
je a222

a000:

mov bx,[cols+4]

cmp bx,3840
jb s111
cmp word[box],bx
jne x111

add word[score],1
jmp s111

x111:

add word[fails],1

s111:


pop bx
add bx,160
push 160
jmp nxt111
a111:

mov bx,[cols+4]
;sub cx,160
cmp bx,3840
jb s222
cmp word[box],bx
jne x222

add word[score],1
jmp s222

x222:

add word[fails],1

s222:

pop bx
add bx,320
push 320
jmp nxt111
a222:


mov bx,[cols+4]
;sub cx,320
cmp bx,3840
jb s333
cmp word[box],bx
jne x333

add word[score],1
jmp s333

x333:

add word[fails],1

s333:
pop bx
push 480
add bx,480


nxt111:


mov [cs:cols+4],bx
mov bx,[cs:col_alp+4]
mov ax,bx


mov ah,0x70
mov [es:di],ax

pop bx
sub di,bx

cmp di,0
jl skip111
mov word[es:di],0x7020
skip111:


;4
mov bx,[cs:cols+6]
mov di,bx
push bx; save prev cols dest
mov bx,[cs:col_speed+6]

cmp bx,0
je a0000

cmp bx,1
je a1111

cmp bx,2
je a2222

a0000:

mov bx,[cols+6]

cmp bx,3840
jb s1111
cmp word[box],bx
jne x1111

add word[score],1
jmp s1111

x1111:

add word[fails],1

s1111:


pop bx
add bx,160
push 160
jmp nxt1111
a1111:

mov bx,[cols+6]
;sub bx,160
cmp bx,3840
jb s2222
cmp word[box],bx
jne x2222

add word[score],1
jmp s2222

x2222:

add word[fails],1

s2222:

pop bx
add bx,320
push 320
jmp nxt1111
a2222:

mov bx,[cols+6]
;sub bx,320
cmp bx,3840
jb s3333
cmp word[box],bx
jne x3333

add word[score],1
jmp s3333

x3333:

add word[fails],1

s3333:

pop bx
push 480
add bx,480


nxt1111:


mov [cs:cols+6],bx
mov bx,[cs:col_alp+6]
mov ax,bx


mov ah,0x70
mov [es:di],ax

pop bx
sub di,bx

cmp di,0
jl skip1111
mov word[es:di],0x7020
skip1111:


;5
mov bx,[cs:cols+8]
mov di,bx
push bx; save prev cols dest
mov bx,[cs:col_speed+8]

cmp bx,0
je a00000

cmp bx,1
je a11111

cmp bx,2
je a22222

a00000:

mov bx,[cols+8]

cmp bx,3840
jb s11111
cmp word[box],bx
jne x11111

add word[score],1
jmp s11111

x11111:

add word[fails],1

s11111:

pop bx
add bx,160
push 160
jmp nxt11111
a11111:

mov bx,[cols+8]
;sub bx,160
cmp bx,3840
jb s22222
cmp word[box],bx
jne x22222

add word[score],1
jmp s22222

x22222:

add word[fails],1

s22222:

pop bx
add bx,320
push 320
jmp nxt11111
a22222:

mov bx,[cols+8]
;sub bx,320
cmp bx,3840
jb s33333
cmp word[box],bx
jne x33333

add word[score],1
jmp s33333

x33333:

add word[fails],1

s33333:

pop bx
push 480
add bx,480


nxt11111:


mov [cs:cols+8],bx
mov bx,[cs:col_alp+8]
mov ax,bx


mov ah,0x70
mov [es:di],ax

pop bx
sub di,bx

cmp di,0
jl skip11111
mov word[es:di],0x7020
skip11111:

mov di,[box]
mov word[es:di],0x70dc

;mov cx,80
;mov di,3840
;mov ax,0x0720
;rep stosw
;mov word[es:3680],0x720

mov di,[box]
mov word[es:di],0x70dc

;pop ax
;jmp far [cs:old]

;mov al,0x20
;out 0x20,al

;mov bx,[cols]
;cmp word[box],bx



mov ax,[score]
push ax
call printnumz
;add ax,0x30
;mov ah,01110000b
;mov word[es:158],ax

mov ax,[fails]
add ax,0x30
mov ah,0x07
mov word[es:0],ax

cmp word[fails],10
jge endd

call delayx







jmp xxx


endd:
call clrscr1



;mov ax, 0x4c00 ; terminate program
;int 21h

popa
pop es
ret

shift:

push ax
push es
push 0xb800
pop es

in al,0x60
cmp al,0x4b
jne go1
cmp word[box],3840
je go3

mov di,[box]
sub word[box],2
mov word[es:di],0x7020
mov di,[box]
mov word[es:di],0x70dc


go1:

cmp al,0x4d
jne go2

cmp word[box],3998
je go3
mov di,[box]
add word[box],2
mov word[es:di],0x7020
mov di,[box]
mov word[es:di],0x70dc


go2:

cmp al,0x01
jne go3

;jmp ext

call clrscr1
push 0
pop es
mov ax,[old]
mov bx,[old+2]
cli
mov [es:9*4],ax
mov [es:9*4+2],bx

sti


mov al,0x20
out 0x20,al


pop es
pop ax



mov ax, 0x4c00 ; terminate program
int 21h


go3:

mov al,0x20
out 0x20,al


pop es
pop ax






iret


printnumz:

push bp
mov bp,sp
push es
push ax
push bx
push cx
push dx
push di
mov ax,0xb800
mov es,ax
mov ax,[bp+4]
mov bx,10
mov cx,0

nxtdigit:

mov dx,0
div bx
add dl,0x30
push dx
inc cx
cmp ax,0
jnz nxtdigit

mov dx,cx
shl dx,1
mov di,160
sub di,dx

nextpoz:

pop dx
mov dh,0x07
mov [es:di],dx
add di,2
loop nextpoz

pop di
pop dx
pop cx
pop bx
pop ax
pop es
pop bp
ret 2



start:

	call clrscr
	;call drop
	xor ax,ax
	mov es,ax

	mov ax,[es:24h]
	mov [old],ax
	mov ax,[es:26h]
	mov [old+2],ax

	cli
	mov word[es:24h],shift
	mov word[es:26h],cs
	sti
	call flow
	
	push 0
pop es
mov ax,[old]
mov bx,[old+2]
cli
mov [es:9*4],ax
mov [es:9*4+2],bx


sti
mov ax, 0x4c00 ; terminate program
int 21h


