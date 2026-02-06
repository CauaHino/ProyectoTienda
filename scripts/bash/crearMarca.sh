#!/bin/bash

clear
path=$1
salir=true

<<<<<<< HEAD
if [ -z "$path" ]; then
    echo "Error: Debes especificar una ruta al ejecutar el script."
    echo "Uso: $0 /ruta/destino"
    exit 1
fi

while $salir; do
    read -p "Indica el nombre para la nueva categoría (escribe q para salir): " nombreCategoria

    if [  "$path/$nombreCategoria" == "q" ]; then
=======
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
    read -p "Indica el nombre de la nueva marca (escribe q para salir) => " nuevaMarca

    if [  "$path/$nombreTipoPerfume" == "q" ]; then
>>>>>>> main
        clear
        echo "Has luego..."
        sleep 3
        salir=false
        continue
    fi

    if [ -z "$nuevaMarca" ]; then
        echo -e "\nError: El nombre de la marca no puede estar vacío."
        continue
    fi

    # 2. Validación: No puede contener espacios
    if [[ "$nuevaMarca" == *" "* ]]; then
        echo -e "\nError: El nombre no puede contener espacios en blanco."
        read -p "Indique otro nombre o 's' para salir: " tecla
        [[ "$tecla" == "s" ]] && exit 0
        continue
    fi

    # 3. Validación: No puede empezar por punto (.)
    if [[ "$nuevaMarca" == .* ]]; then
        echo -e "\nError: El nombre no puede empezar por punto (.)."
        read -p "Indique otro nombre o 's' para salir: " tecla
        [[ "$tecla" == "s" ]] && exit 0
        continue
    fi

    # 4. Validación: No puede contener '/'
    if [[ "$nuevaMarca" == *"/"* ]]; then
        echo -e "\nError: El nombre no puede contener el carácter '/'."
        read -p "Indique otro nombre o 's' para salir: " tecla
        [[ "$tecla" == "s" ]] && exit 0
        continue
    fi

    # 5. Validación: Solo letras, números, guion (-) o guion bajo (_)
    if [[ ! "$nuevaMarca" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        echo -e "\nError: Solo se permiten letras, números, '-' o '_'."
        read -p "Indique otro nombre o 's' para salir: " tecla
        [[ "$tecla" == "s" ]] && exit 0
        continue
    fi

    # 6. Validación: Ya existe el directorio
    if [ -d "$RUTA_CATEGORIA/$nuevaMarca" ]; then
        echo -e "\n$nuevaMarca"
        echo "Error, la marca ya existe indique otra"
        read -p "Pulsa una tecla para continuar o s para salir: " tecla
        [[ "$tecla" == "s" ]] && exit 0
        continue
    fi

    # Proceso de creación
    mkdir "$RUTA_CATEGORIA/$nuevaMarca"
    if [ $? -eq 0 ]; then
        chmod 777 "$RUTA_CATEGORIA/$nuevaMarca"
        echo -e "\nMarca creada correctamente"
        read -n 1 -s -r -p "Pulsa una tecla para continuar"
        exit 0
    else
        echo -e "\nError crítico al crear el directorio."
        exit 1
    fi
done