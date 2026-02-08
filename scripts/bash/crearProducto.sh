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
    read -p "Indica el codigo del producto (escribe s para salir) => " codigoPerfume

    if [  "$codigoPerfume" == "s" ]; then
        clear
        echo "Hasta luego..."
        sleep 3
        exit 0
    fi

    if [ -z "$codigoPerfume" ]; then
        clear
        echo -e "\nError: El nombre de la marca no puede estar vacío."
        sleep 5
        crear=false
        continue
    fi


    if [[ "$codigoPerfume" == .* ]]; then
        clear
        echo -e "\nError: El nombre no puede empezar por punto (.)."
        sleep 5
        crear=false
        continue
    fi

    if [[ "$codigoPerfume" == *"/"* ]]; then
        clear
        echo -e "\nError: El nombre no puede contener el caracter '/'."
        sleep 5
        crear=false
        continue
    fi

    if [[ ! "$codigoPerfume" =~ ^[a-zA-Z0-9]+$ ]]; then
        clear
        echo -e "\nError: Solo se permiten letras y numeros."
        sleep 5
        crear=false
        continue
    fi

    perfumeEncontrado=$(find /tiendas/PerfumeriaPaco/ -name "$codigoPerfume.json")

    if [ -n $perfumeEncontrado ]; then
        clear
        echo -e "\nError: Ya existe un perfume ($codigoPerfume) con este codigo en la tienda.\n"
        sleep 5
        crear=false
        continue
    fi

    clear
    echo "Va a proceder a crearse le producto $codigoPerfume"
    read -p "La entrada es correcta? [S/N]: " confirmacion

    if [[ $confirmacion == "N" || $confirmacion == "n" ]]; then
        crear=false
    fi

    while true; do
        clear
        echo "Indicame las caracteriscas del producto $codigoPerfume"

        read -e -p "Nombre: " -i "$nombre" nombre
        read -e -p "Precio: " -i "$precio" precio
        read -e -p "Stock: " -i "$stock" stock
        read -e -p "Descripción: " -i "$descripcion" descripcion

        while true; do
            echo -e "\n\t1.50 ml\n\t2.100 ml\n\t3.150 ml\n\t4.200ml"
            read -p "Ml: " opcionMl

            case $opcionMl in
                1) ml="50 ml"; break;;
                2) ml="100 ml"; break;;
                3) ml="150 ml"; break;;
                4) ml="200 ml"; break;;
                *) echo tiene que elegir una opcion correcta ;;
            esac
        done

        clear
        echo "Vas a proceder a crear el producto con codigo $codigoPerfume. Revisa los campos"

        echo -e "Nombre: $nombre"
        echo -e "Precio: $precio"
        echo -e "Stock: $stock"
        echo -e "Descripcion: $descripcion"
        echo -e "Ml: $ml"

        read -p "La informacion es correcta? [S/N]: " confirmacion2

        if [[ $confirmacion2 == "S" || $confirmacion2 == "s" ]]; then
            break
        fi
    done

    if [ $crear = true ]; then
        jq -n '{
            "nombre": "",
            "precio": "",
            "stock": "",
            "ml": "",
            "categoria": ""
        }' > "$path/$codigoPerfume.json"

        if [ $? -eq 0 ]; then
            chmod 777 "$path/$codigoPerfume.json"
            python3 ../Python/guardaDatos.py "$path/$codigoPerfume.json" "$nombre" "$precio" "$stock" "$ml" "$descripcion"

            clear
            echo -e "\nLa archivo json $codigoPerfume.json se ha creado correctamente en $path\n" 
            sleep 4

            while true; do
                clear
                read -p "Desea seguir creando perfumes? (pulse Enter para continuar o 's' para salir): " continuar

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
            echo -e "\nError: No se ha podido crear el perfume dentro de la tienda $codigoPerfume en $path\n"
            sleep 5
        fi
    fi
done