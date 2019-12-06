.model small
.data
    str db '$' 
.code
start:
    mov ax, @data
    mov ds, ax
    mov si, offset str
    mov di, si
pointTo$:
    cmp [di], '$'
    je pointToLast
    inc di
    jmp pointTo$
pointToLast:
    cmp di, si
    je emptyString
    dec di
    jmp check
emptyString:
    mov dx, 1111h
    jmp stop
check:
    mov al, [si]
    cmp [di], al
    jne notPalindrome
    inc si
    dec di
    cmp si, di
    jge palindrome
    jmp check
palindrome:
    mov dx, 0011h
    jmp stop 
notPalindrome:
    mov dx, 1100h
    jmp stop
stop:
    mov ah, 04ch
    int 21h
    hlt
;DX = 0011, PALINDROME
;DX = 1100, NOT PALINDROME
;DX = 1111, Empty String