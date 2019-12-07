.model small
.stack 64
.data
    askInp db "Input Password:$"
    lineGap db 0ah,0ah,0dh,"$"
    pass db "Yes, valid$"
    fail db "No, Not valid$"
    buffer db 20h,?,20h dup(0)   
.code
start:
    mov ax, @data
    mov ds, ax
    
    ;Display message asking for input
    mov dx, offset askInp
    mov ah, 09h
    int 21h
    
    call dispLineGap
    
    ;Get input password
    mov dx, offset buffer
    mov ah, 0ah
    int 21h
    
    ;Check 2nd Byte of BUFFER to check number of input characters
    mov si, offset buffer + 1
    cmp [si], 06h
    jne dispFail;Must Be Exact 6 Characters
    
    ;cl for numbers
    ;ch for alphabets
    mov cx, 0000h
    
    ;bh flag for checkNum or checkAlpha
    
    ;First Character should be Number
    inc si
    mov dl, [si]
    call checkNum
    cmp bh, 00h
    je dispFail;First Char should be Number
    
    jmp checkRemaining
    
checkRemaining:
    inc si
    cmp [si], 0dh
    je validate
    
    mov dl, [si]
    call checkNum
    cmp bh, 01h
    je checkRemaining;Number Found

    cmp dl, 41h
    jb dispFail;Neither Num nor Alpha
    cmp dl, 5ah
    jbe gotAlpha;Capital Alphabet
    
    cmp dl, 61h
    jb dispFail;Neither Num nor Alpha
    cmp dl, 7ah
    jbe gotAlpha;Small Alphabet
    
    jmp dispFail;Neither Num nor Alpha
    
gotAlpha:
    inc ch
    jmp checkRemaining    

;Checks if ASCII in DL is Number or not    
checkNum:
    mov bh, 00h;Failure Flag for checkNum

    cmp dl, 30h
    jb return
    cmp dl, 39h
    ja return
    
    inc cl
    mov bh, 01h;Success Flag for checkNum
    ret

return:
    ret
    
validate:
    cmp ch, 04h
    jne dispFail
    cmp cl, 02h
    jne dispFail
    jmp dispPass
    
dispPass:
    call dispLineGap

    ;Display Validation Passed Message
    mov dx, offset pass
    mov ah, 09h
    int 21h
    
    jmp endProg
    
dispFail:
    call dispLineGap

    ;Display Validation Failed Message
    mov dx, offset fail
    mov ah, 09h
    int 21h
    
    jmp endProg
    
dispLineGap:
    ;Display one Line Gap
    mov dx, offset lineGap
    mov ah, 09h
    int 21h
    ret
    
endProg:
    mov ah, 04ch
    int 21h