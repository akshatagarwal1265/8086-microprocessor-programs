;Check if Prime Number
read:
    mov bl,0fbh
start:
    mov cl,02h
repeat:    
    mov al,bl
    cmp cl,al
    jae stop 
    div cl
    cmp ah,00h
    je factor
    jmp notFactor
factor:
    mov dl,01h
    jmp stop
notFactor:
    inc cl              
    mov ah,00h
    jmp repeat
stop:
    mov ah, 04ch
    int 21h
    hlt
;DL=1, if NOT PRIME
;DL=0, if PRIME