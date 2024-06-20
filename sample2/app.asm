; section .data
;     num1 dw -99
;     num2 dw -13
;     msg1 db "Num1 > Num2.",10,0
;     msg2 db "Num1 <= Num2",10,0

; section .bss
;     ; No se necesita para este ejemplo

; section .text
; global  _start

; _start:
;     mov ax, num1
;     cmp ax, num2
;     jg  eIF_N1_MAYOR_N2
;     jle eIF_N1_MENORIGUAL_N2
;     syscall

;     eIF_N1_MAYOR_N2:
;     mov ah, 09h
;     mov dx, [msg1]
;     int 21h
;     syscall
;     jmp FIN

;     eIF_N1_MENORIGUAL_N2:
;     mov ah, 09h
;     mov dx, [msg2]
;     int 21h
;     syscall
    
;     FIN:
;     mov ah, 4ch
;     mov al, 00h
;     int 21h
;     syscall
section .data
    num1 dw -99
    num2 dw -13
    msg1 db "Num1 > Num2.",10,0
    msg2 db "Num1 <= Num2",10,0

section .bss
    ; No se necesita para este ejemplo

section .text
global  _start

_start:
    mov ax, [num1]
    cmp ax, [num2]
    jg  eIF_N1_MAYOR_N2
    jle eIF_N1_MENORIGUAL_N2

eIF_N1_MAYOR_N2:
    mov rax, 1      ; syscall: sys_write
    mov rdi, 1      ; file descriptor: stdout
    lea rsi, [msg1]
    mov rdx, 12     ; longitud del mensaje
    syscall
    jmp FIN

eIF_N1_MENORIGUAL_N2:
    mov rax, 1      ; syscall: sys_write
    mov rdi, 1      ; file descriptor: stdout
    lea rsi, [msg2]
    mov rdx, 14     ; longitud del mensaje
    syscall
    
FIN:
    mov rax, 60  ; syscall: sys_exit
    xor rdi, rdi ; estado de salida: 0
    syscall

