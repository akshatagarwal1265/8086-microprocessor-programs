.model small
.stack 64
.data
    ten db 10
.code
start:
    mov ax, @data
    mov ds, ax    
    ;AL is used as counter from 00 to 99
    mov al, 00
repeat:
    ;print AL
    push ax
    mov cl, 02h
    call printAL
    pop ax
    
    ;Re-position cursor to start of screen (0,0)
    call cursor
    
    ;Increment and check for end
    inc al
    cmp al, 100
    je endProg
    
    ;wait 1 second (1 million microseconds) 
    pusha
    mov cx, 0fh      ;000F4240h = 1,000,000 
    mov dx, 4240h
    mov ah, 86h
    int 15h
    popa
    
    jmp repeat

;CL should be 2
;Prints 2 digits, irrespective of Single Digit
;This is done to print 00,01,02...09 instead of 0,1,2...9
printAL proc
    cmp cl, 00h
    je return
    dec cl
    mov ah, 00h
    div ten
    add ah, 30h
    push ax
    call printAL
    pop ax
    mov dl, ah
    mov ah, 2
    int 21h
    ret
return:
    ret     
printAL endp    

;Take cursor back by 2 spaces without changing the state of any Registers
cursor proc
    pusha
    mov dl, 08h
    mov ah, 2
    int 21h
    mov dl, 08h
    mov ah, 2
    int 21h
    popa
    ret
cursor endp

;Exit
endProg:
    mov ah, 04ch
    int 21h