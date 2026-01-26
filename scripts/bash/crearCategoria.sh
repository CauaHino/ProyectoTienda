#!/bin/bash

clear
path=$1

salir=false
crearCategoria=true
while [!$salir]; do
    read -p "Indica el nombre para la nueva categoria: " nombreCategoria

    for i in $(ls "$path"); do
        if [ "$i" == "$nombreCategoria" ]; then
            clear
            echo -e "\nError: Ya existe una categoria con ese nombre\n"
            salir=true
            crearCategoria=false
            break
        fi
    done

    if [ "$nombreCategoria" == "/" ]; then
        clear
        echo -e "\nSaliendo del script de creacion de categorias...\n"
        exit 0
    fi
    if [ -z "$nombreCategoria" ]; then
        clear
        echo -e "\nError: El nombre de la categoria no puede estar vacio\n"
        continue
    fi

    mkdir "$path/$nombreCategoria"

    if [ $? -eq 0 ]; then
        clear
        echo -e "\nLa carpeta $nombreCategoria se ha creado correctamente en  $path\n"
        exit 0
    else
        clear
        echo -e "\nError: No se ha podido crear la carpeta $nombre en $path\n"
        exit 0
    fi
done
