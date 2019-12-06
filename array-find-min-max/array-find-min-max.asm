.model small
.stack 64
.data
    arr db 0f1h, '$'
.code
start:
    mov ax, @data
    mov ds, ax
    lea si, arr
    mov dh, [si]
    mov dl, [si]
    inc si
EndCheck:
    mov al, [si]
    cmp al, '$'
    jne Check
    jmp Stop
Check: 
    cmp al, dh
    ja NewMax
    cmp al, dl
    jb NewMin
    jmp Next
NewMax:
    mov dh, al
    jmp Next
NewMin:     
    mov dl, al
    jmp Next
Next:
    inc si
    jmp EndCheck       
Stop:
    mov ah, 04ch
    int 21h
    hlt;