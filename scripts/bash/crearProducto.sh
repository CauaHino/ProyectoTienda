#!/bin/bash

clear
path=$1

if [ -z "$path" ] || [ ! -d "$path" ]; then
    echo "Error: Ruta de categoría no válida."
    exit 1
fi

while true; do
    clear
    crear=true
    echo "========= CREAR PRODUCTO ========="
    echo ""
    echo "Tipo de perfume => $(basename "$path")"
    echo ""
    read -p "Indica el nombre de la nombre marca (escribe s para salir) => " nombreMarca