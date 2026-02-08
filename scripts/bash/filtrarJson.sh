#!/bin/bash

clear

read -p "Indica un filtro: " filtro

python3 ./scripts/Python/busqueda.py $filtro

if [[ -s ./nombres_busqueda.txt ]]; then
    cat ./nombres_busqueda.txt
else
    echo "No se encontraron productos con ese filtro."
    exit 0
fi

read -p "Indica el numero de producto a editar (s para salir): " numero

if [[ "$numero" == "s" ]]; then
    echo "Hasta Luego"
    sleep 2
    exit 0
fi

if [[ "$numero" =~ ^[0-9]+$ ]]; then

    echo "========= MODIFICAR PERFUME ========="

    contenido=$(sed -n "$numero"'p' ./rutas_busqueda.txt)

    if [ -z "$contenido" ] || [ ! -f "$contenido" ]; then
        echo "Error: El número seleccionado no existe."
        exit 1
    fi
    
    nombre=$(jq -r '.nombre' "$contenido")
    precio=$(jq -r '.precio'  "$contenido")
    stock=$(jq -r '.stock' "$contenido")
    ml=$(jq -r '.ml' "$contenido")
    descripcion=$(jq -r '.descripcion' "$contenido")

    read -e -p "Nombre: " -i "$nombre" nombre
    read -e -p "Precio: " -i "$precio" precio
    read -e -p "Stock: " -i "$stock" stock
    read -e -p "Mililitros: " -i "$ml" ml
    read -e -p "Descripción: " -i "$descripcion" descripcion

    jq -n \
      --arg nom "$nombre" \
      --arg pre "$precio" \
      --arg sto "$stock" \
      --arg ml "$ml" \
      --arg des "$descripcion" \
      '{nombre: $nom, precio: $pre, stock: $sto, ml: $ml, descripcion: $des}' > "$contenido"

    echo "Nombre: $nombre"
    echo "Precio: $precio"
    echo "Stock: $stock"
    echo "Mililitros: $ml"
    echo "Descripción: $descripcion"
    
fi
