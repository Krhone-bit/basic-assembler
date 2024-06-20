section .data
    msgInput1   db "Ingrese el primer lado: ", 0  ; Mensaje para solicitar el primer lado
    msgInput2   db "Ingrese el segundo lado: ", 0 ; Mensaje para solicitar el segundo lado
    msgInput3   db "Ingrese el tercer lado: ", 0  ; Mensaje para solicitar el tercer lado
    msgExiste   db "EXISTE", 10, 0                ; Mensaje a mostrar si el triángulo existe
    msgNoExiste db "NO EXISTE", 10, 0             ; Mensaje a mostrar si el triángulo no existe

; Teorema
; c + b > a
; a + c > b
; a + b > c

section .bss
    lado1 resb 4 ; Reservar espacio para el primer lado
    lado2 resb 4 ; Reservar espacio para el segundo lado
    lado3 resb 4 ; Reservar espacio para el tercer lado

section .text
global  _start

_start:
    ; Solicitar y leer el primer lado
    mov     rax, 1           ; syscall: sys_write
    mov     rdi, 1           ; file descriptor: stdout
    lea     rsi, [msgInput1] ; cargar la dirección del mensaje en rsi
    mov     rdx, 23          ; longitud del mensaje
    syscall                  ; llamar al sistema para escribir

    mov     rax, 0       ; syscall: sys_read
    mov     rdi, 0       ; file descriptor: stdin
    lea     rsi, [lado1] ; cargar la dirección del buffer de entrada en rsi
    mov     rdx, 4       ; longitud máxima a leer
    syscall              ; llamar al sistema para leer

    ; Solicitar y leer el segundo lado
    mov     rax, 1           ; syscall: sys_write
    mov     rdi, 1           ; file descriptor: stdout
    lea     rsi, [msgInput2] ; cargar la dirección del mensaje en rsi
    mov     rdx, 24          ; longitud del mensaje
    syscall                  ; llamar al sistema para escribir

    mov     rax, 0       ; syscall: sys_read
    mov     rdi, 0       ; file descriptor: stdin
    lea     rsi, [lado2] ; cargar la dirección del buffer de entrada en rsi
    mov     rdx, 4       ; longitud máxima a leer
    syscall              ; llamar al sistema para leer

    ; Solicitar y leer el tercer lado
    mov     rax, 1           ; syscall: sys_write
    mov     rdi, 1           ; file descriptor: stdout
    lea     rsi, [msgInput3] ; cargar la dirección del mensaje en rsi
    mov     rdx, 23          ; longitud del mensaje
    syscall                  ; llamar al sistema para escribir

    mov     rax, 0       ; syscall: sys_read
    mov     rdi, 0       ; file descriptor: stdin
    lea     rsi, [lado3] ; cargar la dirección del buffer de entrada en rsi
    mov     rdx, 4       ; longitud máxima a leer
    syscall              ; llamar al sistema para leer

    ; Convertir los lados de ASCII a números
    mov  rsi, lado1 ; cargar la dirección del primer lado en rsi
    call atoi       ; llamar a la función atoi para convertir a entero
    mov  ebx, eax   ; almacenar el resultado en ebx (lado1)

    mov  rsi, lado2 ; cargar la dirección del segundo lado en rsi
    call atoi       ; llamar a la función atoi para convertir a entero
    mov  ecx, eax   ; almacenar el resultado en ecx (lado2)

    mov  rsi, lado3 ; cargar la dirección del tercer lado en rsi
    call atoi       ; llamar a la función atoi para convertir a entero
    mov  edx, eax   ; almacenar el resultado en edx (lado3)

    ; Comprobar si el triángulo existe
    mov eax, ebx ; mover lado1 a eax
    add eax, ecx ; sumar lado1 y lado2
    cmp eax, edx ; comparar la suma con lado3
    jl  NoExiste ; si la suma es menor o igual, no existe

    mov eax, ebx ; mover lado1 a eax
    add eax, edx ; sumar lado1 y lado3
    cmp eax, ecx ; comparar la suma con lado2
    jl  NoExiste ; si la suma es menor o igual, no existe

    mov eax, ecx ; mover lado2 a eax
    add eax, edx ; sumar lado2 y lado3
    cmp eax, ebx ; comparar la suma con lado1
    jl  NoExiste ; si la suma es menor o igual, no existe

    ; Si pasa todas las comprobaciones, el triángulo existe
    mov     rax, 1           ; syscall: sys_write
    mov     rdi, 1           ; file descriptor: stdout
    lea     rsi, [msgExiste] ; cargar la dirección del mensaje en rsi
    mov     rdx, 8           ; longitud del mensaje
    syscall                  ; llamar al sistema para escribir
    jmp     Fin              ; saltar a la etiqueta Fin

NoExiste:
    ; Mostrar mensaje de que no existe
    mov     rax, 1             ; syscall: sys_write
    mov     rdi, 1             ; file descriptor: stdout
    lea     rsi, [msgNoExiste] ; cargar la dirección del mensaje en rsi
    mov     rdx, 10            ; longitud del mensaje
    syscall                    ; llamar al sistema para escribir

Fin:
    ; Terminar el programa
    mov     rax, 60  ; syscall: sys_exit
    xor     rdi, rdi ; estado de salida: 0
    syscall          ; llamar al sistema para salir

; Convertir ASCII a entero
atoi:
    xor rax, rax ; resultado a 0
    xor rcx, rcx ; contador a 0

convertir:
    movzx rbx, byte [rsi + rcx] ; cargar el byte en rbx
    cmp   rbx, 0xA              ; comprobar salto de línea
    je    fin_convertir         ; si es salto de línea, terminar
    sub   rbx, '0'              ; convertir de ASCII a número
    imul rax, rax, 10       ; multiplicar el resultado por 10
    add   rax, rbx              ; agregar el dígito al resultado
    inc   rcx                   ; incrementar el contador
    jmp   convertir             ; repetir para el siguiente dígito

fin_convertir:
    ret ; retornar el resultado en rax
