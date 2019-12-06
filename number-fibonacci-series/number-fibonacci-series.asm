;Fibonacci Series
.model small
.data
    arrSize db 0eh
    arr db arrSize dup(00h) ;Array Size = Length of Series Generated
.code                       ;Constraint Minimum Size = 2, Logical Maximum Size = 14
start:
    mov ax, @data
    mov ds, ax
    lea si, arr
    inc si
    mov [si],01h
    mov ah, 01h
    mov al, 00h
    mov cl, arrSize
    sub cl, 02h   
repeat:    
    cmp cl, 00h
    je stop
    mov dl, ah
    add ah, al
    mov al, dl
    inc si
    mov [si], ah
    dec cl
    jmp repeat
stop:
    mov ah, 04ch
    int 21h
    hlt