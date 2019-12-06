;Divisors of given number
.model small
.stack 64
.data
    num db 0fh
    arr db 0ffh dup(00h)
.code
read:
    mov ax, @data
    mov ds, ax
    lea si, arr
    mov [si],01h
    inc si
    mov bl,num
    mov cl,02h
    mov ah,00h
repeat:    
    mov al,bl
    cmp cl,al
    jae last 
    div cl
    cmp ah,00h
    je factor
    jmp notFactor
factor:
    mov [si],cl
    inc si
    inc cl
    jmp repeat
notFactor:
    inc cl              
    mov ah,00h
    jmp repeat
last:
    cmp cl,al
    ja stop
    mov [si],cl
    inc si
    jmp stop
stop:
    mov [si],'$'
    mov ah, 04ch
    int 21h
    hlt