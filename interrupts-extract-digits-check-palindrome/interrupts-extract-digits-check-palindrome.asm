data1 segment
    getInput db "Enter Registration Number: $"
    setPrint db 0ah,0dh,"Digits in the Number are: $"
    setPalinT db 0ah,0dh,"Last 4 Digits are Palindrome$"
    setPalinF db 0ah,0dh,"Last 4 Digits are NOT Palindrome$"
    digits db 07h dup("$")    ;6 Digits and 1 '$'   
data1 ends

data2 segment
    regNo db 0ah,?,dup 0ah(?) ;Length of Reg No. is 9, 1 for Carriage Return
data2 ends
code segment
start:    
    assume cs: code 
    
    mov dx,data1
    mov ds, dx  
    
    mov ah, 09h
    mov dx, offset getInput   ;Ask for Input
    int 21h
    
    mov ax, data2
    mov ds, ax

    mov ah, 0ah
    mov dx, offset regNo      ;Store Input here 
    int 21h
    
    mov si, offset regno+2    ;Starting point of string

    mov dx, data1
    mov ds, dx

    mov di, offset digits     ;Store extracted digits in different data segment
    dec si 
    
    extract:                  
        mov dx, data2         
        mov ds, dx
        inc si
        cmp [si],0dh          ;Check end of String
        je printDigits
        
        cmp [si],030h
        jb extract
        
        cmp [si],039h
        ja extract
        
        mov bl, [si]          ;If digit, store in GeneralPurposeRegister

        mov dx, data1
        mov ds, dx            ;Change data segment

        mov [di], bl          ;Store from GPR
        inc di
        jmp extract
        
    printDigits:
        mov dx, data1
        mov ds, dx    
        mov ah, 09h
        mov dx, offset setPrint
        int 21h
        mov ah, 09h
        mov dx, offset digits ;Print digits ending with '$'
        int 21h
        jmp palinCheck
    
    palinCheck:  
        mov dx, offset digits+2 ;Starting Point of Last 4 Digits
        mov si, dx
        
        mov di, offset digits+5 ;Ending Point of Last 4 Digits
        
        mov cl, [di]            
        mov ch, [si]
        cmp ch, cl              ;Check 1st and Last
        jne notPalin
        inc si
        dec di
        mov cl, [di]
        mov ch, [si]
        cmp ch, cl              ;Check Middle 2
        jne notPalin
        
        jmp palin
        
    palin:
        mov ah, 09h
        mov dx, offset setPalinT;Print Palindrome
        int 21h         
        jmp endProg   
              
    notPalin:
        mov ah, 09h
        mov dx, offset setPalinF;Print NOT Palindrome
        int 21h
        jmp endProg
                
    endProg:
        mov ah, 04ch
        int 21h

end start
code ends