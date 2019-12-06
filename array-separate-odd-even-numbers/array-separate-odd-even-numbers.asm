;Separate Odd and Even Numbers
.model small
.data
    arr db 0dah, 9fh, 0dfh, 00h, 0ffh, '$'
    ev db 0ffh dup (00h)
    od db 0ffh dup (00h)
.code
start:
    mov ax, @data
    mov ds, ax
    lea si, arr
    lea di, ev
    lea bp, od
EndCheck:
    mov al, [si]
    cmp al, '$'
    jne EveOddCheck
    jmp stop
EveOddCheck: 
    mov ah, al
    and ah, 01h
    cmp ah, 01h
    je AppendOdd
    jmp AppendEven
AppendOdd:
    mov [bp], al
    inc bp
    jmp jump
AppendEven:     
    mov [di], al
    inc di
    jmp jump
Jump:
    inc si
    jmp EndCheck       
stop:
    mov [bp], '$'
    mov [di], '$'
    mov ah, 04ch
    int 21h
    hlt