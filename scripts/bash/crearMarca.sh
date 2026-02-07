#!/bin/bash

clear
path=$1
salir=true
crear=true

if [ -z "$path" ] || [ ! -d "$path" ]; then
    echo "Error: Ruta de categoría no válida."
    exit 1
fi

while true; do
    clear
    echo "========= CREAR MARCA ========="
    echo ""
    echo "Categoría => $(basename "$path")"
    echo ""
    read -p "Indica el nombre de la nueva marca (escribe s para salir) => " nuevaMarca

    if [  "$path/$nuevaMarca" == "s" ]; then
        clear
        echo "Has luego..."
        sleep 3
        exit 0
    fi

    if [ -z "$nuevaMarca" ]; then
        clear
        echo -e "\nError: El nombre de la marca no puede estar vacío."
        sleep 5
        crear=false
        continue
    fi


    if [[ "$nuevaMarca" == .* ]]; then
        clear
        echo -e "\nError: El nombre no puede empezar por punto (.)."
        sleep 5
        crear=false
        continue
    fi

    if [[ "$nuevaMarca" == *"/"* ]]; then
        clear
        echo -e "\nError: El nombre no puede contener el carácter '/'."
        sleep 5
        crear=false
        continue
    fi

    if [[ ! "$nuevaMarca" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        clear
        echo -e "\nError: Solo se permiten letras, números, '-' o '_'."
        sleep 5
        crear=false
        continue
    fi


    if [ -d "$RUTA_CATEGORIA/$nuevaMarca" ]; then
        clear
        echo -e "\nError: Ya existe esta marca ($nombreMarca) en esta categoria de perfumes.\n"
    fi

    if [ $crear = true ]; then
        mkdir "$path/$nombreMarca"
        if [ $? -eq 0 ]; then
            chmod 777 "$path/$nombreMarca"
            clear
            echo -e "\nLa carpeta $nombreMarca se ha creado correctamente en $path\n"
            salir=false
            sleep 5
        else
            clear
            echo -e "\nError: No se ha podido crear la carpeta $nombreMarca en $path\n"
            sleep 5
        fi
    fi
done