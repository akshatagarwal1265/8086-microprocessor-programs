.model small
.stack 64
.data
    askString db "Please enter string: $"
    askKey db 0ah,0ah,0dh,"Please enter key [Key <= 25]: $"
    printEnc db 0ah,0ah,0dh,"Encrypted String: $"
    printDec db 0ah,0ah,0dh,"Decrypted String: $"
    inpString db 20h,?,20h dup("$"),"$"
    inpKey db 03h,?,03h dup(0)
    encString db 1fh dup("$"),"$";One less than 20h (Carriage Return)
    errKey db 0ah,0ah,0dh,"INVALID KEY$"
    errString db 0ah,0ah,0dh,"INVALID STRING: Only Alphabets Allowed$"
.code
start:
    mov ax, @data
    mov ds, ax
    
    ;Prompt for String
    mov dx, offset askString
    mov ah, 09h
    int 21h
    
    ;Input String
    mov dx, offset inpString
    mov ah, 0ah
    int 21h
    
    ;Prompt for Key
    mov dx, offset askKey
    mov ah, 09h
    int 21h
    
    ;Input Key
    mov dx, offset inpKey
    mov ah, 0ah
    int 21h
    
    ;Check if Key is Empty
    mov si, offset inpKey + 2
    mov dh, 00h
    mov dl, [si]
    cmp dl, 0dh
    je invalidKey
    
    
    mov ax, 0000h
    mov bl, 0ah
    
    ;Extract integer Key
    jmp extractNum
    
extractNum:
    ;Check if isDigit
    cmp dl, 30h
    jb invalidKey
    cmp dl, 39h
    ja invalidKey
    
    ;Mult by 10 and Add
    mul bl
    sub dl, 30h
    add ax, dx
    
    ;Loop [will run maximum twice]
    inc si
    mov dl, [si]
    cmp dl, 0dh
    jne extractNum
    
    ;Encrypt String
    jmp encrypt
    
encrypt:
    ;Key shouldn't be greater than 25
    cmp al, 19h
    ja invalidKey
    
    ;Set Pointers
    mov si, offset inpString + 2
    mov di, offset encString
    
    mov bl, al
    mov ax, 0000h
    mov cl, 1ah;Decimal 26 [for mod 26]
    
    ;Shift each Character by Key in a loop
    jmp shiftChar
    
shiftChar:
    ;Char from input String to be encrypted
    mov dl, [si]
    
    ;End of String [Carriage Return encountered]
    cmp dl, 0dh
    je printAns;Display Encrypted and Original String
    
    ;Check Caps or Small Alphabet
    cmp dl, 41h
    jb invalidString
    cmp dl, 5ah
    jbe capAlpha
    cmp dl, 61h
    jb invalidString
    cmp dl, 7ah
    jbe smallAlpha
    jmp invalidString
    
capAlpha:
    ;Shift and take Mod by 26
    sub dl, 41h
    add dl, bl
    mov al, dl
    mov ah, 00h
    div cl
    add ah, 41h
    mov [di], ah
    jmp incrementPointers
    
smallAlpha:
    ;Shift and take Mod by 26
    sub dl, 61h
    add dl, bl
    mov al, dl
    mov ah, 00h
    div cl
    add ah, 61h
    mov [di], ah
    jmp incrementPointers
    
incrementPointers:
    inc si
    inc di
    jmp shiftChar
    
printAns:
    mov dx, offset printEnc
    mov ah, 09h
    int 21h
    
    ;Encrypted String
    mov dx, offset encString
    mov ah, 09h
    int 21h
    
    mov dx, offset printDec
    mov ah, 09h
    int 21h
    
    ;Original String
    mov dx, offset inpString + 2
    mov ah, 09h
    int 21h
    
    jmp endProg            
    
invalidKey:
    mov dx, offset errKey
    mov ah, 09h
    int 21h
    
    jmp endProg

invalidString:
    mov dx, offset errString
    mov ah, 09h
    int 21h
    
    jmp endProg
    
endProg:
    mov ah, 04ch
    int 21h    