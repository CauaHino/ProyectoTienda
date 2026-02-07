#!/bin/bash

clear
path=$1

if [ -z "$path" ] || [ ! -d "$path" ]; then
    echo "Error: Ruta de marca no válida."
    exit 1
fi

while true; do
    clear
    crear=true
    echo "========= CREAR MARCA ========="
    echo ""
    echo "Tipo de Perfume => $(basename "$path")"
    echo ""
    read -p "Indica el nombre de la nombre marca (escribe s para salir) => " nombreMarca

    if [  "$path/$nombreMarca" == "s" ]; then
        clear
        echo "Has luego..."
        sleep 3
        exit 0
    fi

    if [ -z "$nombreMarca" ]; then
        clear
        echo -e "\nError: El nombre de la marca no puede estar vacío."
        sleep 5
        crear=false
        continue
    fi


    if [[ "$nombreMarca" == .* ]]; then
        clear
        echo -e "\nError: El nombre no puede empezar por punto (.)."
        sleep 5
        crear=false
        continue
    fi

    if [[ "$nombreMarca" == *"/"* ]]; then
        clear
        echo -e "\nError: El nombre no puede contener el carácter '/'."
        sleep 5
        crear=false
        continue
    fi

    if [[ ! "$nombreMarca" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        clear
        echo -e "\nError: Solo se permiten letras, números, '-' o '_'."
        sleep 5
        crear=false
        continue
    fi


    if [ -d "$path/$nombreMarca" ]; then
        clear
        echo -e "\nError: Ya existe esta marca ($nombreMarca) en esta categoria de perfumes.\n"
    fi

    if [ $crear = true ]; then
        mkdir "$path/$nombreMarca"
        if [ $? -eq 0 ]; then
            chmod 777 "$path/$nombreMarca"
            clear
            echo -e "\nLa marca $nombreMarca se ha creado correctamente en $path\n" 
            sleep 4

            while true; do
                clear
                read -p "Desea seguir creando marcas? (pulse Enter para continuar o 's' para salir): " continuar

                if [[ -z $continuar ]]; then
                    break
                elif [[ $continuar == "s" || $continuar == "S" ]]; then
                    clear
                    echo "Hasta luego..."
                    sleep 3
                    exit 0
                else
                    clear
                    echo -e "\nIngrese la tecla indicada\n"
                    sleep 3
                fi                    
            done
        else
            clear
            echo -e "\nError: No se ha podido crear la carpeta $nombreMarca en $path\n"
            sleep 5
        fi
    fi
done