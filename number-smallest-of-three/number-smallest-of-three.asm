;Smallest of 3 numbers
read:
    mov ax,0f0ddh
    mov bx,0e30fh
    mov cx,0d00ah
start:
    cmp ax,bx
    jbe ac
    cmp bx,cx
    jbe ansB
    jmp ansC
ac:
    cmp ax,cx
    jbe ansA
    jmp ansC
ansA:
    mov dx,ax
    hlt
ansB:
    mov dx,bx
    hlt
ansC:
    mov dx,cx
    hlt
;Answer in DX