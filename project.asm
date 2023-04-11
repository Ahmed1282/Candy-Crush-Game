;                              COAL Project
;                                Made by:
;                               Ahmed Baig	     ||  20I-1884
;                             Hasnat Rasool      ||  20I-1833
;                           Muhammad Ibrahim Zia ||  20I-0898
.MODEL SMALL
.STACK 1024H

;---------------------------------------data initialization--------------------------------------

.DATA 

;title page initialization
msg1 db "    '''''    '    '     '  '''''  '     '   '''''  ''''  '   '  ''''  '   ' $"
msg2 db "    '       ' '   ''    '  '    '  '   '    '      '  '  '   '  ''    '   ' $"
msg3 db "    '      '   '  ' '   '  '    '   ' '     '      ' '   '   '  ''    '   ' $"
msg4 db "    '      '''''  '  '  '  '    '    '      '      ''    '   '  ''''  ''''' $"
msg5 db "    '      '   '  '   ' '  '    '    '      '      ' '   '   '    ''  '   ' $"
msg6 db "    '      '   '  '    ''  '    '    '      '      '  '  '   '    ''  '   ' $"
msg7 db "    '''''  '   '  '     '  '''''     '      '''''  '   ' '''''  ''''  '   ' $"
t1 dw 0
t2 dw 0
t3 dw 0
t4 dw 0
t5 dw 0
;------------------------------page 2 instructions-----------------------------------------------
instruction db " When a candy is swapped with another candy, if a combo exists,",13,10,10," the combo is crushed, dropped, and score is updated accordingly.",10,10," Otherwise, the candies are swapped back! The board",10,10," is filled with random candies of different colors and shapes.",13,10,10," It has a color bomb too.",10,10," When a candy is swapped with bomb, all of its occurrences are destroyed.",13,10,10," When candies are crushed, score is awarded.",10,10,10,10,"$"
msg17       db "                    ---- PRESS ENTER BUTTON TO PLAY ----","$"
right_prompt       db "right","$"
username    db " PLEASE ENTER YOUR NAME : " ,"$"
namedisplay db "PLAYER NAME:$"
moves       db "PLAYER MOVES:$"
score       db "PLAYER SCORE:$"
PLAYERSHOW  db "ENTER PLAYER's NAME: $"
name_arr    db 20 DUP('$')
matrix      db 49 DUP(?) ;for GRID
a1 db 0
a2 db 0
a3 db 0
a4 db 0
a5 db 0 
rand        db 0
counter1    db 0
v1           dw 0
pentagon1    dw 0
pentagon2    dw 0
v2           dw 42
diamond1     dw 0
diamond2     dw 0
octagon1     dw 0
octagon2     dw 0
v5           dw 1
v3           dw 42
v4           dw 1
v7           dw 42
x_axis       dw 34  ;coord
y_axis       dw 43  ;coord
counter2     dw 0  ;keeping count cx
storing_Si   dw 0
index        dw 0
s1 db 0
s2 db 0
s3 db 0
s4 db 0
s5 db 0
	
;--------------------------------------------main------------------------------------------------
.CODE
	mov ax,@data		   
	mov ds,ax
	
	mov ah,00h  ;displaying a panel
	mov al,0eh  ;sub function for printing purpose
	int 10h  ;interupt for graphics like int 21h
	
	jmp loop1
	
;---------------------------------------Relevant functions-------------------------------------------------
;vertical lines for grid
vertical proc
mov bl,175
mov dx,bp
L10:
	CMP bl,0
	JE L6
	mov ah,0Ch		;color
	mov al,08h
	mov cx, cx
	mov dx, dx
	int 10h
	dec bl
	inc dx
	JMP L10
L6:    ;;;
ret
vertical endp

;horizontal lines for grid
horizontal proc
mov si,350
mov cx,bp
L7:
	CMP si,0
	JE L8
	mov ah,0Ch
	mov al,08h
	mov cx, cx
	mov dx, dx
	int 10h
	dec si
	inc cx
	JMP L7
L8:
ret
horizontal endp


;
random proc
mov ax,0
mov bx,0
mov dx,0
mov cx,0
mov AH,00h  ;get system time        
int 1AH      ; number of clock ticks       
mov al, dl
mov dl, 0
mov bl, 6    ;number x
div bl       
mov rand,ah

ret 
random endp

;----------> shape procedures
;----->1
rectangle proc
mov bp,00
mov dx,di
rc2:
mov cx,si
mov bx,00
dec dx
inc bp
CMP bp,12
JE EXIT5

rc1:
CMP bx,42
JE rc2
mov ah,0Ch
mov al,02h ;color for rectangle
mov cx,cx
mov dx,dx
int 10h

inc cx
inc bx
JMP rc1
EXIT5:
ret
rectangle endp

;----->2
triangle proc
dec di
tri1:
mov bx,42
mov cx,si
mov dx,di
tri2:
CMP bx,0
JE tri5
mov ah,0Ch
mov al,08h ;color change for triangle
mov cx, cx
mov dx, dx
int 10h
dec bx
inc cx
JMP tri2

tri5:
mov bp,21
mov cx,si
mov v1,si
mov dx,di
mov bx,bp
JMP tri4
tri3:
CMP bp,0
JE tri6
inc si
dec bp
mov bx,bp
mov cx,si
mov dx,di

mov t1,cx
mov cx,500
l1:
add a1,8
sub a2,6

loop l1
mov cx , t1

tri4:
CMP bx,0
JE tri3
mov ah,0Ch
mov al,08h;;color
mov cx,cx
mov dx,dx
int 10h
inc cx
dec dx
dec bx
JMP tri4

tri6:
mov bp,21
mov si,cx
mov di,dx
mov cx,si
mov dx,di

mov bx,bp
JMP tri8
tri7:
CMP bp,0
JE tri9
inc si
dec bp
mov bx,bp
mov cx,si
mov dx,di

tri8:
CMP bx,0
JE tri7
mov ah,0Ch
mov al,01h;;color
mov cx,cx
mov dx,dx
int 10h
dec dx
dec bx
JMP tri8

tri9:
mov bx,21
add cx,10

tri10:
CMP bx,00
JE EXIT2
mov ah,0Ch
mov al,0Fh
mov cx,cx
mov dx,dx
int 21h
dec dx
dec bx
JMP tri10
EXIT2:
ret
triangle endp

;----->3
pentagon proc
mov pentagon1,si
mov pentagon2,di
mov cx, pentagon1
mov dx, pentagon2
mov bx,42
mov bp,10
pent2:
mov bx,42
mov cx, pentagon1
CMP bp,0
JE pent3
dec dx
dec bp

pent:
CMP bx,0
JE pent2
mov ah,0Ch
mov al,0Ch;color chaneg for pentagon
mov cx,cx
mov dx,dx
int 10h
inc cx
dec bx
JMP pent

pent3:
mov si, pentagon1
mov di, pentagon2
sub di,11
mov cx,si
mov dx,di
mov bp, v2
mov bx,11
JMP pent4

mov t2,cx
mov cx,500
l1:
add a3,8
sub a4,6
loop l1
mov cx , t2

pent5:
CMP bx,0
JE EXIT6
dec di
mov bp,v2
sub bp,4
mov v2,bp
add si,2
mov cx,si
mov dx,di
dec bx

pent4:
CMP bp,00
JE pent5
CMP bp,-1
JE pent5
CMP bp,-2
JE pent5
CMP bp,-3
JE pent5
CMP bp,-4
JE pent5

mov ah,0Ch
mov al,0Ch ;
mov cx,cx
mov dx,dx
int 10h
dec bp
inc cx
JMP pent4

EXIT6:
mov v2,42
ret
pentagon endp



;----->4
square proc
mov bp,00
mov dx,di
sh2:
mov cx,si
mov bx,00
dec dx
inc bp
CMP bp,21
JE EXIT5

sh1:
CMP bx,42
JE sh2
mov ah,0Ch
mov al,09h
mov cx,cx
mov dx,dx
int 10h

inc cx
inc bx
JMP sh1
EXIT5:
ret
square endp

;----->5
octagon proc
add si,21
mov octagon1,si
mov octagon2,di
mov cx, octagon1
mov dx, octagon2
mov bx,v5
mov bp,7
JMP oc1

oc2:
CMP bp,00
JE oc5
sub si,3
mov cx,si
mov bx,v5
add bx,6
mov v5,bx
dec dx
dec bp

oc1:
CMP bx,00
JE oc2
mov ah,0Ch
mov al,06h
mov cx,cx
mov dx,dx
int 10h
dec bx
inc cx
JMP oc1

mov t3,cx
mov cx,500
l1:
add a5,8
sub s1,6
loop l1
mov cx , t3


oc5:
mov dx,octagon2
sub dx, 7
mov cx,octagon1
sub cx,21
mov octagon1,cx
mov bx,7


oc3:
mov cx,octagon1
mov bp,42
dec dx
CMP bx,0
JE oc6
dec bx

oc4:
CMP bp,00
JE oc3
mov ah,0Ch
mov al,06h
mov cx,cx
mov dx,dx
int 10h
inc cx
dec bp
JMP oc4

oc6:

mov cx, octagon1
mov dx, octagon2
sub dx,14
mov bx,v5
mov bp,7
JMP oc8

oc7:
CMP bp,00
JE EXIT8
add si,3
mov cx,si
mov bx,v5
sub bx,6
mov v5,bx
dec dx
dec bp

oc8:
CMP bx,00
JE oc7
mov ah,0Ch
mov al,06h
mov cx,cx
mov dx,dx
int 10h
dec bx
inc cx
JMP oc8



EXIT8:
ret
octagon endp

;----->6
diamond proc
add si,21
mov diamond1,si
mov diamond2,di
mov cx, diamond1
mov dx, diamond2
mov bx,v4
mov bp,10
JMP dai1

dai2:
CMP bp,00
JE dai3
sub si,2
mov cx,si
mov bx,v4
add bx,4
mov v4,bx
dec dx
dec bp

dai1:


CMP bx,00
JE dai2
mov ah,0Ch
mov al,04h;color
mov cx,cx
mov dx,dx
int 10h
dec bx
inc cx
JMP dai1

mov t4,cx
mov cx,500
l1:
add s2,8
sub s3,6
loop l1
mov cx , t4



dai3:

mov si, diamond1
sub si,21
mov di, diamond2
sub di,11
mov cx,si
mov dx,di
mov bp, v3
mov bx,11
JMP dai4

dai5:
CMP bx,0
JE EXIT7
dec di
mov bp,v3
sub bp,4
mov v3,bp
add si,2
mov cx,si
mov dx,di
dec bx


dai4:
CMP bp,00
JLE dai5
mov ah,0Ch
mov al,04h;color
mov cx,cx
mov dx,dx
int 10h
dec bp
inc cx
JMP dai4

EXIT7:
mov si,00
mov diamond1,00
mov diamond2,00
mov v3,42
mov v4,1
ret
diamond endp

;---others
;colors
color proc
mov dx,di
mov bp,00
color2:
mov cx,si
mov bx,00
dec dx
inc bp
CMP bp,21
JE EXIT9

color1:
CMP bx,42
JE color2

.If v5<=125
JMP RED    ;for red color

.Elseif v5>=126 && v5<=251
JMP blue	;for blue

.Elseif v5>=252 && v5<=377
JMP YELLOW	;for yellow

.Elseif v5>=378 && v5<=503
JMP GREEN	;for green

.Elseif v5>=504 && v5<=629
JMP BROWN	;for brown

.Elseif v5>=630 && v5<=755
JMP BLUE	;for blue

.Else
JMP RED		;for red

.endif

BLUE:
mov ah,0Ch
mov al,01h
mov cx,cx
mov dx,dx
int 10h
JMP NEXTCOLOR

YELLOW:
mov ah,0Ch
mov al,0Eh
mov cx,cx
mov dx,dx
int 10h
JMP NEXTCOLOR

RED:
mov ah,0Ch
mov al,04h
mov cx,cx
mov dx,dx
int 10h
JMP NEXTCOLOR

GREEN:
mov ah,0Ch
mov al,02h
mov cx,cx
mov dx,dx
int 10h
JMP NEXTCOLOR

BROWN:
mov ah,0Ch
mov al,06h
mov cx,cx
mov dx,dx
int 10h
JMP NEXTCOLOR

NEXTCOLOR:
inc v5
inc cx
inc bx
JMP color1
EXIT9:
ret
color endp

;intentional delay
delay proc
mov cx,100
 l1:
	mov dx,300  ;;/////////1200
 l2:
	dec dx
	cmp dx,0
	jne l2
	
	loop l1
ret	
delay endp

;------------------------------------------main procedure----------------------------------------

loop1:

;
;dipslay
mov ah,0bh
mov bh,00h	;changing background color
mov bl,05h	;colour 13
int 10h

;printing game name
call delay
	mov dl,10
	mov ah,02h
	int 21h				;empty line
call delay
	mov dl,10
	mov ah,02h
	int 21h				;empty line
call delay
	mov dl,10
	mov ah,02h
	int 21h				;empty line
call delay
	mov dl,10
	mov ah,02h
	int 21h				;empty line
call delay
	mov dl,10
	mov ah,02h
	int 21h				;empty line	
call delay
	mov dl,10
	mov ah,02h
	int 21h	
;
mov si,offset msg1
mov dx,si
mov ah,09h
int 21h
mov dl,10				
mov ah,02h
int 21h
call delay
mov si,offset msg2
mov dx,si
mov ah,09h
int 21h
mov dl,10				
mov ah,02h
int 21h
call delay
mov si,offset msg3
mov dx,si
mov ah,09h
int 21h
mov dl,10			
mov ah,02h
int 21h
call delay
mov si,offset msg4
mov dx,si
mov ah,09h
int 21h
mov dl,10			
mov ah,02h
int 21h
call delay
mov si,offset msg5
mov dx,si
mov ah,09h
int 21h
mov dl,10
mov ah,02h				
int 21h
call delay
mov si,offset msg6
mov dx,si
mov ah,09h
int 21h
mov dl,10
mov ah,02h
int 21h
call delay
;mov si,offset msg7
mov si,offset msg7
	mov dx,si
	mov ah,09h
	int 21h
	mov dl,10			;printing game name
	mov ah,02h
	int 21h
;
call delay
	mov dl,10
	mov ah,02h
	int 21h				;empty line
	
	mov dl,10
	mov ah,02h				;empty line
	int 21h	

	mov dl,10
	mov ah,02h				;empty line
	int 21h		
;

mov t5,cx
mov cx,500
l1:
add s4,8
sub s5,6
loop l1
mov cx , t5

mov si,offset username
mov dx,si						
mov ah,09h
int 21h

mov si,offset name_arr
input: 
mov ah,1
int 21h	;input name
cmp al,13
je exitloop
mov [si],al  ;offset
inc si
jmp input

exitloop:
mov ah,00h
mov al,0eh
int 10h


;--------------------------------------------page 2-----------------------------------------------


mov dx,offset instruction
mov ah,09h	;display
int 21h
mov dx,offset msg17
mov ah,09h						;;;;;;;;;;;;;;change
int 21h

mov ah,0bh
mov bh,00h	;bavkground color
mov bl,09h  ;colour
int 10h

mov ah,1
int 21h	;enter to proceed command
cmp al,13
je page3



page3:
;-----------------------------------------------page3--------------------------------------------
mov ah,00h
mov al,0eh
int 10h
mov ah,0bh
mov bh,00h	;changing background color
mov bl,11h  ;colour
int 10h


mov di,8
mov cx,30
mov bp,20
Vert:
CMP di,0
JE Hor
call vertical 
dec di
add cx,50
JMP Vert

Hor:
mov di,8
mov bp,30
mov dx,20
Horz:
CMP di,0
JE RRRRR
call horizontal
dec di
add dx,25
JMP Horz

RRRRR:
mov counter1,49
mov bx,offset matrix
Randomfiller:
mov si,x_axis
mov di,y_axis
cmp counter1,0
je text
call random

call delay

mov ax,00
mov bx,00
mov cx,00
mov dx,00


.if rand == 0
mov bx ,offset rand
mov index,bx
mov bx,0

call rectangle			

mov bx,index
.elseif rand==1
mov bx,offset rand
mov index,bx
mov bx,0

call triangle       

mov bx,index
.elseif rand == 2
mov bx,offset rand
mov index,bx
mov bx,0

call pentagon

mov bx,index
.elseif rand == 3
mov bx,offset rand
mov index,bx
mov bx,0

call octagon	

mov bx,index
.elseif rand == 4
mov bx,offset rand
mov index,bx
mov bx,0

call diamond	

mov bx,index
.else

mov bx,offset rand
mov index,bx
mov bx,0

call square		

mov bx,index
.endif

.if x_axis >= 334
mov x_axis,34
add y_axis,25
.else
add x_axis,50
.endif 

call delay



inc bx   
dec counter1

jmp Randomfiller



TEXT:


mov ah,02h
mov bx,0
mov dh,3
mov dl,50
int 10h

mov dx,00
mov dx,offset namedisplay
mov ah,09h
int 21h

mov ah,01h
mov bx,0
mov dh,4
mov dl,50
int 10h



mov si, offset name_arr
mov dx,si
mov ah,09h
int 21h




NEXT2:
mov ah,02h
mov bx,0
mov dh,6
mov dl,50
int 10h


mov dx,00
mov dx,offset moves
mov ah,09h
int 21h


mov dx,0
mov ah,02h
int 21h

mov ah,02h
mov bx,0
mov dh,9
mov dl,50
int 10h


mov dx,00
mov dx,offset score
mov ah,09h
int 21h

mov dx,10
mov ah,02h
int 21h



exit:
mov ah,04ch
int 021h
end