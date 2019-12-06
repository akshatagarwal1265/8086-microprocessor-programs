.model small
.stack 64
.data
    arr db 0f0h, '$'
.code
;stack = outer loop index
;di = current minimum index
;ah = current minimum 
;si = traversal index
start:
    mov ax, @data
    mov ds, ax
    lea si, arr
EndCheck:
    push si
    mov di, si
    mov ah, [si]
    cmp ah, '$'
    jne InnerLoop
    jmp Stop
InnerLoop:
    inc si
    mov bh, [si]
    cmp bh, '$'
    je FinalSwap
    cmp ah, bh
    ja NewMin
    jmp InnerLoop
NewMin:
    mov ah, bh
    mov di, si
    jmp InnerLoop
FinalSwap:
    pop si        
    mov bh, [si]
    mov [si], ah
    mov [di], bh
    inc si
    jmp EndCheck       
Stop:
    mov ah, 04ch
    int 21h
    hlt;