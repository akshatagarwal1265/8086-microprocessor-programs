.model small
.stack 64
.data
    askName db "Please enter your Name: $"
    askAge db 0ah,0ah,0dh,"Please enter your Age: $"
    askReg db 0ah,0ah,0dh,"Please enter your Reg: $"
    printName db "Name: $"
    printAge db 0ah,0ah,"Age: $"
    printReg db 0ah,0ah,"Reg: $"
    inpName db 20h,?,20h dup("$"),"$"
    inpAge db 04h,?,04h dup("$"),"$"
    inpReg db 0ah,?,0ah dup("$"),"$"
.code
start:
    mov ax, @data
    mov ds, ax
    
    mov dx, offset askName
    mov ah, 09h
    int 21h
    
    mov dx, offset inpName
    mov ah, 0ah
    int 21h
    
    mov dx, offset askAge
    mov ah, 09h
    int 21h
    
    mov dx, offset inpAge
    mov ah, 0ah
    int 21h
    
    mov dx, offset askReg
    mov ah, 09h
    int 21h
    
    mov dx, offset inpReg
    mov ah, 0ah
    int 21h
    
    ;Clear Screen
    mov ax, 03h
    int 10h
    
    mov dx, offset printName
    mov ah, 09h
    int 21h
    
    mov dx, offset inpName + 2
    mov ah, 09h
    int 21h
    
    mov dx, offset printAge
    mov ah, 09h
    int 21h
    
    mov dx, offset inpAge + 2
    mov ah, 09h
    int 21h
    
    mov dx, offset printReg
    mov ah, 09h
    int 21h
    
    mov dx, offset inpReg + 2
    mov ah, 09h
    int 21h
    
    mov ah, 04ch
    int 21h 