#!/bin/bash

log(){
    bash "scripts/bash/creacionLogs.sh" "$1" "$2" "programa.log"
}

clear
path=$1

if [ -z "$path" ] || [ ! -d "$path" ]; then
    echo "Error: Ruta del tipo de perfume no valida."
    log "CREACION - TIPO PERFUME" "Error: Ruta del tipo de perfume no valida."
    exit 1
fi

while true; do
    clear
    crear=true
    echo "========= CREAR TIPO DE PERFUME ========="
    read -p "Indica el nombre para la nueva categoria de perfume (escribe s para salir) > " nombreTipoPerfume

    if [  "$nombreTipoPerfume" == "s" ]; then
        clear
        echo "Hasta luego..."
        log "CREACION - TIPO PERFUME" "Usuario no creo ningun tipo de perfume."

        sleep 3
        exit 0
    fi

    if [[ "$nombreTipoPerfume" == *"/"* ]]; then
        clear
        echo -e "\nError: el nombre de la TipoPerfume no puede contener '/'...\n"
        log "CREACION - TIPO PERFUME" "Error: el nombre de la TipoPerfume no puede contener '/'..."

        crear=false
        sleep 5
        continue
    fi

    if [ -z "$nombreTipoPerfume" ]; then
        clear
        echo -e "\nError: El nombre del tipo de perfume no puede estar vacio.\n"
        log "CREACION - TIPO PERFUME" "Error: El nombre del tipo de perfume no puede estar vacio."

        crear=false
        sleep 5
        continue
    fi

    if [[ ! "$nombreTipoPerfume" =~ ^[a-zA-Z0-9]+$ ]]; then
        clear
        echo -e "\nError: El nombre contiene caracteres no validos.\nSolo se permiten letras y numeros (sin espacios ni símbolos).\n"
        log "CREACION - TIPO PERFUME" "Error: El nombre contiene caracteres no validos.\nSolo se permiten letras y numeros (sin espacios ni símbolos)."
        
        crear=false
        sleep 5
        continue
    fi

    if [ -d "$path/$nombreTipoPerfume" ]; then
        clear
        echo -e "\nError: Ya existe un tipo perfume ($nombreTipoPerfume) con ese nombre.\n"
        log "CREACION - TIPO PERFUME" "Error: Ya existe un tipo perfume ($nombreTipoPerfume) con ese nombre.."

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
            log "CREACION - TIPO PERFUME" "El tipo de perfume $nombreTipoPerfume se ha creado correctamente en $path"

            sleep 4

            while true; do
                clear
                read -p "Desea seguir creando tipos de perfumes? (pulse Enter para continuar o 's' para salir): " continuar

                if [[ -z $continuar ]]; then
                    log "CREACION - TIPO PERFUME" "Usuario va a crear otro tipo de perfume"
                    break
                elif [[ $continuar == "s" || $continuar == "S" ]]; then
                    clear
                    echo "Hasta luego..."
                    log "CREACION - TIPO PERFUME" "Usuario termino de crear el tipo de perfume"

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
            echo -e "\nError: No se ha podido crear el tipo de perfume $nombreTipoPerfume en $path\n"
            log "CREACION - TIPO PERFUME" "Error: No se ha podido crear el tipo de perfume $nombreTipoPerfume en $path"

            sleep 5
        fi
    fi
done
