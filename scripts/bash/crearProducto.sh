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
    echo "Tipo de perfume => $(basename "$(dirname "$path")")"
    echo "Tipo de marca => $(basename "$path")"
    read -p "Indica el nombre de la nombre marca (escribe s para salir) => " nombreMarca
done