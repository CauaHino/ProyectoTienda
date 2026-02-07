#!/bin/bash

clear
path=$1

if [ -z "$path" ]; then
    echo "Error: Debes especificar una ruta al ejecutar el script."
    echo "Uso: $0 /ruta/destino"
    exit 1
fi

while true; do
    clear
    crear=true
    echo "========= CREAR TIPO DE PERFUME ========="
    echo ""
    read -p "Indica el nombre para la nueva categoria de perfume (escribe s para salir) > " nombreTipoPerfume

    if [  "$nombreTipoPerfume" == "s" ]; then
        clear
        echo "Hasta luego..."
        sleep 3
        exit 0
    fi

    if [[ "$nombreTipoPerfume" == *"/"* ]]; then
        clear
        echo -e "\nError: el nombre de la TipoPerfume no puede contener '/'...\n"
        crear=false
        sleep 5
        continue
    fi

    if [ -z "$nombreTipoPerfume" ]; then
        clear
        echo -e "\nError: El nombre de la categoría no puede estar vacío.\n"
        crear=false
        sleep 5
        continue
    fi

    if [[ ! "$nombreTipoPerfume" =~ ^[a-zA-Z0-9]+$ ]]; then
        clear
        echo -e "\nError: El nombre contiene caracteres no válidos.\nSolo se permiten letras y números (sin espacios ni símbolos).\n"
        crear=false
        sleep 5
        continue
    fi

    if [ -d "$path/$nombreTipoPerfume" ]; then
        clear
        echo -e "\nError: Ya existe un tipo perfume ($nombreTipoPerfume) con ese nombre.\n"
        crear=false
        sleep 5
        continue
    fi
    
    if [ $crear = true ]; then
        mkdir "$path/$nombreTipoPerfume"
        if [ $? -eq 0 ]; then
            chmod 777 "$path/$nombreTipoPerfume"
            clear
            echo -e "\nEl tipo de perfume $nombreTipoPerfume se ha creado correctamente en $path\n"
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
            echo -e "\nError: No se ha podido crear la carpeta $nombreTipoPerfume en $path\n"
            sleep 5
        fi
    fi
done
