#!/bin/bash

clear

read -p "Indica un filtro: " filtro

python3 ./scripts/Python/busqueda.py $filtro
cat ./nombres_busqueda.txt
read -p "Indica el numero de producto a editar, s para salir" numero

if [ "$numero" == "s" ]; then
    exit 0
fi

if [[ "$numero" =~ ^[0-9]+$ ]]; then

    contenido=$(sed -n "$numero"'p' ./rutas_busqueda.txt)
       
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

    echo "Nombre: $nombre"
    echo "Precio: $precio"
    echo "Stock: $stock"
    echo "Mililitros: $ml"
    echo "Descripción: $descripcion"
    
fi
