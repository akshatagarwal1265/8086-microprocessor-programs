;Check if number  Positive/Negative/Zero
read:
    mov al,0ffh
start:
    cmp al,00h
    jg positive
    cmp al,00h
    je zero
    jmp negative
positive:
    mov bl,02h
    hlt
zero:
    mov bl,01h
    hlt
negative:
    mov bl,00h
    hlt
;BL=2, If +ve
;BL=1, If  0
;BL=0, If -ve