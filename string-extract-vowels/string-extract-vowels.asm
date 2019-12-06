.model small
.data
    str1 db 'eiasuoda$'
    str2 db 0fh dup('0')
.code
start:
    mov ax, @data
    mov ds, ax
    mov si, offset str1
    mov di, offset str2
repeat:
    mov al, [si]
    cmp al, '$'
    je stop
    cmp al, 'a'
    je append
    cmp al, 'e'
    je append
    cmp al, 'i'
    je append
    cmp al, 'o'
    je append
    cmp al, 'u'
    je append
    inc si
    jmp repeat
append:
    mov [di], al
    inc di
    inc si
    jmp repeat
stop:
    mov [di], '$'
    mov ah, 04ch
    int 21h
    hlt