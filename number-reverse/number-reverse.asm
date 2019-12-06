;Reverse given number
read:
    mov al,4eh
start:
    mov bl,10h
    div bl
    mov bh,al
    mov al,ah 
    mov ah,00h
    mul bl
    add al,bh
;Answer in AL