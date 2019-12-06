;Check Odd or Even
read:
    mov ax,0feeh
start:
    mov bx,ax
    and bx,0001h
    cmp bx,0001h
    je odd
    jmp even
odd:
    hlt
even:
    hlt
;BX=1, If Odd
;BX=0, If Even