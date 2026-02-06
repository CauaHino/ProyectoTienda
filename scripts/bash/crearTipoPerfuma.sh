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
    clear
    echo "========= CREAR TIPO DE PERFUME ========="
    echo ""
    read -p "Indica el nombre para la nueva categoria de perfume (escribe q para salir) > " nombreTipoPerfume

    if [  "$path/$nombreTipoPerfume" == "q" ]; then
        clear
        echo "Has luego..."
        sleep 3
        salir=false
        continue
    fi

    if [ "$nombreTipoPerfume" == "/" ]; then
        clear
        echo -e "\nError: el nombre de la TipoPerfume no puede contener '/'...\n"
        sleep 3
    fi

    if [ -z "$nombreTipoPerfume" ]; then
        clear
        echo -e "\nError: El nombre de la categoría no puede estar vacío.\n"
        sleep 3
    fi

    if [[ ! "$nombreTipoPerfume" =~ ^[a-zA-Z0-9]+$ ]]; then
        clear
        echo -e "\nError: El nombre contiene caracteres no válidos.\nSolo se permiten letras y números (sin espacios ni símbolos).\n"
        sleep 3
    fi

    if [ -d "$path/$nombreTipoPerfume" ]; then
        clear
        echo -e "\nError: Ya existe una TipoPerfume con ese nombre.\n"
        sleep 3
    fi

    mkdir "$path/$nombreTipoPerfume"

    if [ $? -eq 0 ]; then
        chmod 777 "$path/$nombreTipoPerfume"
        clear
        echo -e "\nLa carpeta $nombreTipoPerfume se ha creado correctamente en $path\n"
        salir=false
    else
        clear
        echo -e "\nError: No se ha podido crear la carpeta $nombreTipoPerfume en $path\n"
    fi
done