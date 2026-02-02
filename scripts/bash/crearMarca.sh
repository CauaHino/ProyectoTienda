#!/bin/bash

clear
path=$1
salir=true

if [ -z "$path" ]; then
    echo "Error: Debes especificar una ruta al ejecutar el script."
    echo "Uso: $0 /ruta/destino"
    exit 1
fi

while $salir; do
    read -p "Indica el nombre para la nueva categoría (escribe q para salir): " nombreCategoria

    if [  "$path/$nombreCategoria" == "q" ]; then
        clear
        echo "Has luego..."
        sleep 3
        salir=false
        continue
    fi

    if [ "$nombreCategoria" == "/" ]; then
        clear
        echo -e "\nError: el nombre de la categoria no puede contener '/'...\n"
        sleep 3
    fi

    if [ -z "$nombreCategoria" ]; then
        clear
        echo -e "\nError: El nombre de la categoría no puede estar vacío.\n"
        sleep 3
    fi

    if [[ ! "$nombreCategoria" =~ ^[a-zA-Z0-9]+$ ]]; then
        clear
        echo -e "\nError: El nombre contiene caracteres no válidos.\nSolo se permiten letras y números (sin espacios ni símbolos).\n"
        sleep 3
    fi

    if [ -d "$path/$nombreCategoria" ]; then
        clear
        echo -e "\nError: Ya existe una Marca con ese nombre.\n"
        sleep 3
    fi

    mkdir "$path/$nombreCategoria"

    if [ $? -eq 0 ]; then
        chmod 777 "$path/$nombreCategoria"
        clear
        echo -e "\nLa carpeta $nombreCategoria se ha creado correctamente en $path\n"
        salir=false
    else
        clear
        echo -e "\nError: No se ha podido crear la carpeta $nombreCategoria en $path\n"
    fi
done