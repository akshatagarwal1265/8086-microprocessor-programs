.model small
.stack 64
.data
    enterN db 'Enter the value of n [<=8]: $'
    enterR db 0ah,0dh,'Enter the value of r [<=n]: $'
    outNPR db 0ah,0ah,0dh,'nPr: $'
    outNCR db 0ah,0dh,'nCr: $'
    errNotDigit db 0ah,0dh,'The Character is not a Digit$'
    errInvalid db 0ah,0dh,'Invalid Input, Adhere to Constraints$'
    ten dw 10
    n db ?
    r db ?
    nFact dw ?
    rFact dw ?
    nMrFact dw ?
    nPr dw ?
    nCr dw ?
.code
start:
    mov ax, @data
    mov ds, ax
    
    ;Ask N
    mov dx, offset enterN
    mov ah, 09h
    int 21h
        
    ;Get N in AL
    mov ah, 1
    int 21h
    
    ;Check if, ASCII AL (N) <= AH (Digit 8)
    mov ah, 08h
    call isALDigitLessThanEqualAH
    
    ;Move AL to memory, AL will be used for Interrupts
    sub al, 30h                  ;get value from ascii
    mov n, al
    
    ;Ask R
    mov dx, offset enterR
    mov ah, 09h
    int 21h
    
    ;Get R in AL
    mov ah, 1
    int 21h
    
    ;Check if, ASCII AL (R) <= AH (N)
    mov ah, n
    call isALDigitLessThanEqualAH
    
    ;Move AL to memory, AL will be used for Interrupts
    sub al, 30h                  ;get value from ascii
    mov r, al
    
    ;Store n Factorial in memory
    mov bl, n
    mov bh, 00h
    call factBXinAX
    mov nFact, ax
    
    ;Store r Factorial in memory
    mov bl, r
    mov bh, 00h
    call factBXinAX
    mov rFact, ax
    
    ;Store n-r Factorial in memory
    mov bl, n
    sub bl, r
    mov bh, 00h
    call factBXinAX
    mov nMrFact, ax
    
    ;Calculate nPr in AX and store in memory
    mov ax, nFact
    mov bx, nMrFact
    mov dx, 00h
    div bx
    mov nPr, ax
    
    ;nPr Output Statement
    mov dx, offset outNPR
    mov ah, 09h
    int 21h
    
    ;Print nPr
    mov ax, nPr
    mov dx, 00h
    call printAX
    
    ;Calculate nCr in AX and store in memory
    mov ax, nPr
    mov bx, rFact
    mov dx, 00h
    div bx
    mov nCr, ax
    
    ;nCr Output Statement
    mov dx, offset outNCR
    mov ah, 09h
    int 21h
    
    ;Print nCr
    mov ax, nCr
    mov dx, 00h
    call printAX
    
    ;Terminate Program
    jmp endProg

;Check if AL is Digit, else PRINT_ERROR
;Check if Ascii in AL <= (Digit) AH, else PRINT_ERROR
isALDigitLessThanEqualAH proc
    cmp al, 30h
    jb notDigit
    cmp al, 39h
    jg notDigit
    add ah, 30h
    cmp al, ah
    ja notValid
    ret
isALDigitLessThanEqualAH endp

;RECURSIVE Function Print Decimal Value of AX
;DX should be 00h
printAX proc
    cmp ax, 00h
    je return
    mov dx, 00h
    div ten
    add dl, 30h
    push dx
    call printAX
    pop dx
    mov ah, 2
    int 21h
    ret     
return:
    cmp dx, 00h
    je print0 
    ret     
print0:
    mov dl, 30h
    mov ah, 2
    int 21h
    ret     
printAX endp    

;RECURSIVE Factorial of BX stored in AX
factBXinAX proc
    cmp bx, 00h
    je return1
    push bx
    dec bx
    call factBXinAX
    pop bx
    mul bx
    ret
return1:
    mov dx, 00h
    mov ax, 01h
    ret        
factBXinAX endp    
    
;Print ERROR, Exit
notDigit:
    mov dx, offset errNotDigit
    mov ah, 09h
    int 21h
    jmp endProg

;Print ERROR, Exit
notValid:
    mov dx, offset errInvalid
    mov ah, 09h
    int 21h
    jmp endProg

;EXIT
endProg:
    mov ah, 04ch
    int 21h    