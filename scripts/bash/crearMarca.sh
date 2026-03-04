#!/bin/bash

log(){
    bash "scripts/bash/creacionLogs.sh" "$1" "$2" "programa.log"
}

clear
path=$1

if [ -z "$path" ] || [ ! -d "$path" ]; then
    echo "Error: Ruta de marca no valida."
    log "CREACION - MARCA" "Error: Ruta de marca no valida."
    exit 1
fi


while true; do
    clear
    crear=true
    echo "========= CREAR MARCA ========="
    echo -e "Tipo de Perfume => $(basename "$path")"
    read -p "Indica el nombre de la marca (escribe s para salir) => " nombreMarca

    if [  "$nombreMarca" == "s" ]; then
        clear
        echo "Hasta luego..."
        log "CREACION - MARCA" "Usuario no ninguna creo marca."

        sleep 3
        exit 0
    fi

    if [ -z "$nombreMarca" ]; then
        clear
        echo -e "\nError: El nombre de la marca no puede estar vacio."
        log "CREACION - MARCA" "Error: El nombre de la marca no puede estar vacio."
        
        sleep 5
        crear=false
        continue
    fi


    if [[ "$nombreMarca" == .* ]]; then
        clear
        echo -e "\nError: El nombre no puede empezar por punto (.)."
        log "CREACION - MARCA" "Error: El nombre no puede empezar por punto (.)."

        sleep 5
        crear=false
        continue
    fi

    if [[ "$nombreMarca" == *"/"* ]]; then
        clear
        echo -e "\nError: El nombre no puede contener el caracter '/'."
        log "CREACION - MARCA" "Error: El nombre no puede contener el caracter '/'."
        
        sleep 5
        crear=false
        continue
    fi

    if [[ ! "$nombreMarca" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        clear
        echo -e "\nError: Solo se permiten letras, numeros, '-' o '_'."
        log "CREACION - MARCA" "Error: Solo se permiten letras, numeros, '-' o '_'."
        
        sleep 5
        crear=false
        continue
    fi


    if [ -d "$path/$nombreMarca" ]; then
        clear
        echo -e "\nError: Ya existe esta marca ($nombreMarca) en estos tipos de perfumes.\n"
        log "CREACION - MARCA" "Error: Ya existe esta marca ($nombreMarca) en estos tipos de perfumes."

    fi

    if [ $crear = true ]; then
        mkdir "$path/$nombreMarca"
        if [ $? -eq 0 ]; then
            chmod 777 "$path/$nombreMarca"
            clear
            echo -e "\nLa marca $nombreMarca se ha creado correctamente en $path\n"
            log "CREACION - MARCA" "La marca $nombreMarca se ha creado correctamente en $path"

            sleep 4

            while true; do
                clear
                read -p "Desea seguir creando marcas? (pulse Enter para continuar o 's' para salir): " continuar

                if [[ -z $continuar ]]; then
                    log "CREACION - MARCA" "Usuario va a crear otra marca"
                    break
                elif [[ $continuar == "s" || $continuar == "S" ]]; then
                    clear
                    echo "Hasta luego..."
                    log "CREACION - MARCA" "Usuario termino de crear la marca"

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
            echo -e "\nError: No se ha podido crear la marca $nombreMarca en $path\n"
            log "CREACION - MARCA" "Error: No se ha podido crear la marca $nombreMarca en $path"
            
            sleep 5
        fi
    fi
done