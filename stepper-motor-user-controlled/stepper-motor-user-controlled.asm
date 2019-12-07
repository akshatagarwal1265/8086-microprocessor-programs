#start=stepper_motor.exe#;Display Virtual Stepper Motor
.model small
.stack 64
.data
cwH db 06h,04h,03h,02h   ;Clock-Wise          Half-Step Sequence
ccwH db 03h,01h,06h,02h  ;Counter-Clock-Wise  Half-Step Sequence
.code
start:
mov ax, @data
mov ds, ax

mov bx, offset cwH       
mov si, 00h              

mov cl, 00h              ;Clear IDLE Flag

next_step:

wait:in al, 7            ;Stepper on Port 7, Input 8 states
     test al, 10000000b  ;Test if stepper ready for next input
     jz wait             ;If not ready, keep waiting

mov al, [bx][si]         ;Based Indexed Addressing Mode = DS:[BX]+[SI]
out 7, al                ;Stepper on Port 7, Output 8 states

inc si
cmp si, 04h              ;Check 1 half step completion (clock or counter-clock)
jb next_step             ;Wait for 1 half step completion before reading from keyboard buffer

check_keystroke:

mov ah, 06h              ;Read character from buffer
mov dl, 255              ;And clear it from buffer
int 21h

jz continue              ;Buffer Empty

cmp al, '0'              ;ASCII 0 entered (IDLE)
je idle

mov cl, 00h              ;Clear IDLE Flag (Input not '0')

cmp al, '1'              ;ASCII 1 entered (FORWARD)
je forward

cmp al, '2'              ;ASCII 2 entered (BACKWARD)
je backward

jmp continue             ;If input not 0,1,2 => IGNORE

continue:                
    cmp cl, 01h          ;If IDLE Flag Set
    je check_keystroke   ;WAIT for next keystroke
    mov si, 00h          ;Else continue in SAME DIRECTION
    jmp next_step        

idle:                    
    mov cl, 01h          ;SET IDLE Flag
    jmp check_keystroke  ;Wait for next keystroke

forward:
    mov bx, offset cwH   ;Point to Clock-Wise Half-Step Sequence
    mov si, 00h
    jmp next_step        ;loop clockwise sequence

backward:
    mov bx, offset ccwH  ;Point to Counter-Clock-Wise Half-Step Sequence
    mov si, 00h
    jmp next_step        ;loop counter-clockwise sequence