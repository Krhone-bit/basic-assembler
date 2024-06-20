section .data
    num             dw 5                                       ; Número a comprobar
    msgEsMultiplo   db "El numero es multiplo de 3.", 10, 0
    msgNoEsMultiplo db "El numero no es multiplo de 3.", 10, 0

section .bss
    ; No se necesita para este ejemplo

section .text
global  _start

_start:
    ; Cargar el número en AX
    mov ax, [num]
    ; Inicializar DX en 0 (necesario para la división)
    xor dx, dx
    ; Cargar 3 en BX (divisor)
    mov bx, 3
    ; Dividir AX por BX
    div bx
    ; Comprobar el resto en DX
    cmp dx, 0
    ; Si el resto es 0, es múltiplo de 3
    je  esMultiplo
    ; Si no, no es múltiplo de 3
    jne noEsMultiplo

esMultiplo:
    ; Escribir el mensaje "El numero es multiplo de 3."
    mov rax, 1               ; syscall: sys_write
    mov rdi, 1               ; file descriptor: stdout
    lea rsi, [msgEsMultiplo]
    mov rdx, 28              ; longitud del mensaje
    syscall
    jmp FIN

noEsMultiplo:
    ; Escribir el mensaje "El numero no es multiplo de 3."
    mov rax, 1                 ; syscall: sys_write
    mov rdi, 1                 ; file descriptor: stdout
    lea rsi, [msgNoEsMultiplo]
    mov rdx, 31                ; longitud del mensaje
    syscall

FIN:
    ; Terminar el programa
    mov rax, 60  ; syscall: sys_exit
    xor rdi, rdi ; estado de salida: 0
    syscall
