section .data
    num1           dw 9
    num2           dw 0
    num3           dw 2
    rpta           dw 0
    resi           dw 0
    msgDivxCero    db "Error!!! Division por Cero.", 10, 0
    msgDivNoExacta db "La division no es exacta.", 10, 0
    msgDivExacta   db "LA DIVISION ES EXACTA.", 10, 0

section .bss
    ; No se necesita para este ejemplo

section .text
global  _start

_start:
    ; Inicializar los segmentos
    ; En Linux, el segmento de datos ya está configurado correctamente

    ; Comprobar si num3 es cero
    cmp word [num3], 0
    je  eIFCERO
    
    ; Si no es cero, continua con la división
    mov ax,     [num1]
    add ax,     [num2]
    mov dx,     0
    mov bx,     [num3]
    div bx
    mov [rpta], ax
    mov [resi], dx
    
    ; Comprobar si la división es exacta
    cmp dx, 0
    je  eIFEXACTA
    
    ; Si no es exacta, muestra el mensaje correspondiente
    mov rax, 1                ; syscall: sys_write
    mov rdi, 1                ; file descriptor: stdout
    lea rsi, [msgDivNoExacta]
    mov rdx, 24               ; longitud del mensaje
    syscall
    jmp FIN

eIFCERO:
    ; Mensaje de error por división entre cero
    mov rax, 1             ; syscall: sys_write
    mov rdi, 1             ; file descriptor: stdout
    lea rsi, [msgDivxCero]
    mov rdx, 26            ; longitud del mensaje
    syscall
    jmp FIN

eIFEXACTA:
    ; Mensaje de división exacta
    mov rax, 1              ; syscall: sys_write
    mov rdi, 1              ; file descriptor: stdout
    lea rsi, [msgDivExacta]
    mov rdx, 24             ; longitud del mensaje
    syscall

FIN:
    ; Terminar el programa
    mov rax, 60  ; syscall: sys_exit
    xor rdi, rdi ; estado de salida: 0
    syscall
