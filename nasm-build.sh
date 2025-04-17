#!/bin/bash

if [ -z "$1" ]; then
    echo "Uso: $0 archivo.s [-g]"
    exit 1
fi

if ! command -v nasm &> /dev/null; then
    echo "Error: 'nasm' no está instalado."
    exit 1
fi

if ! command -v ld &> /dev/null; then
    echo "Error: 'ld' no está instalado."
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Error: El archivo '$1' no existe."
    exit 1
fi

fileName="${1%%.*}"

echo "Compilando ${fileName}.s..."
nasm -f elf64 "${fileName}.s" -o "${fileName}.o"
if [ $? -ne 0 ]; then
    echo "Error al compilar con NASM."
    exit 1
fi

echo "Enlazando ${fileName}.o..."
ld "${fileName}.o" -o "${fileName}"
if [ $? -ne 0 ]; then
    echo "Error al enlazar con LD."
    exit 1
fi

echo "Ejecutable '${fileName}' creado exitosamente."

if [ "$2" == "-g" ]; then
    echo "Abriendo en GDB..."
    gdb -q "${fileName}"
else
    echo "Ejecutando..."
    ./"${fileName}"
fi
