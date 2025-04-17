# NASM Build & Exec Script

Este repositorio contiene un script Bash que automatiza el proceso de compilación, enlace y ejecución de archivos de Assembly (`.s`) usando NASM y LD.

## ¿Qué hace este script?

- Compila archivos `.s` en formato ELF64 usando `nasm`
- Enlaza los archivos objeto `.o` generados usando `ld`
- Ejecuta el programa o lo abre directamente en GDB si se solicita
- Verifica errores comunes como archivos inexistentes o dependencias no instaladas

## Uso

```bash
./nasm-build.sh archivo.s
```
- Compila y ejecuta el programa.

```bash
./nasm-build.sh archivo.s -g
```
- Compila y abre el ejecutable en GDB para depuración.

## Requisitos

- **nasm** (Netwide Assembler)
- **ld** (GNU Linker)
- Sistema operativo basado en Linux (x86_64)

Instala NASM si no lo tienes:

```bash
sudo apt install nasm
```

## Ejemplo rápido

1. Crea un archivo `hello.s`:

```assembly
section .data
    msg db 'Hello, World!', 0xA    ; Define el mensaje a imprimir seguido de un salto de línea (0xA)
    len equ $-msg                  ; Calcula la longitud del mensaje

section .text
    global _start                  ; Hace que la etiqueta _start sea visible para el linker (punto de entrada)

_start:
    ; --- Escribir en pantalla ---
    mov rax, 1         ; syscall número 1: write (escribir datos)
    mov rdi, 1         ; file descriptor 1: stdout (salida estándar, pantalla)
    mov rsi, msg       ; dirección del mensaje a imprimir
    mov rdx, len       ; longitud del mensaje
    syscall            ; realizar la llamada al sistema (escribir en pantalla)

    ; --- Salir del programa ---
    mov rax, 60        ; syscall número 60: exit (salir del programa)
    xor rdi, rdi       ; exit code 0 (código de salida exitoso)
    syscall            ; realizar la llamada al sistema (terminar el programa)
```

2. Ejecuta el script:

```bash
./nasm-build.sh hello.s
```

Resultado:

```
Hello, World!
```

---
