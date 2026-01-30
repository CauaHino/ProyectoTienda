#!/bin/bash

clear
path=$1

if [ -z "$path" ]; then
    echo "Error: Debes especificar una ruta al ejecutar el script."
    echo "Uso: $0 /ruta/destino"
    exit 1
fi

while true; do
    read -p "Indica el nombre para la nueva categoría (escribe q para salir): " nombreCategoria

    if [ "$nombreCategoria" == "/" ]; then
        clear
        echo -e "\nSaliendo del script de creación de categorías...\n"
        exit 0
    fi

    if [ -z "$nombreCategoria" ]; then
        clear
        echo -e "\nError: El nombre de la categoría no puede estar vacío.\n"
        continue
    fi

    if [[ ! "$nombreCategoria" =~ ^[a-zA-Z0-9]+$ ]]; then
        clear
        echo -e "\nError: El nombre contiene caracteres no válidos.\nSolo se permiten letras y números (sin espacios ni símbolos).\n"
        continue
    fi

    if [ -d "$path/$nombreCategoria" ]; then
        clear
        echo -e "\nError: Ya existe una categoría con ese nombre.\n"
        continue
    fi

    if [  "$path/$nombreCategoria" == "q" ]; then
        clear
        echo -e "\nError: Ya existe una categoría con ese nombre.\n"
        continue
    fi


    mkdir "$path/$nombreCategoria"

    if [ $? -eq 0 ]; then
        clear
        echo -e "\nLa carpeta $nombreCategoria se ha creado correctamente en $path\n"
        exit 0
    else
        clear
        echo -e "\nError: No se ha podido crear la carpeta $nombreCategoria en $path\n"
        exit 1
    fi
done