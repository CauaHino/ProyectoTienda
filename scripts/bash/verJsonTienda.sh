#!/bin/bash

ruta=$1

if [[ -d $ruta ]] then
    nombre=$(jq -r '.nombre' "$ruta")
    precio=$(jq -r '.precio'  "$ruta")
    stock=$(jq -r '.stock' "$ruta")
    ml=$(jq -r '.ml' "$ruta")
    descripcion=$(jq -r '.descripcion' "$ruta")

    echo "Nombre: $nombre"
    echo "Precio: $precio"
    echo "Stock: $stock"
    echo "Mililitros: $ml"
    echo "Descripción: $descripcion"

    read -p "Presione (v) si deseas Volver " salir
    if [[ $salir == 'v' || $salir == 'V' ]]; then
        read -p "Estas seguro que quieres salir? [S/N] " opcion
        if [[ $opcion == 'S' || $opcion == 's' ]] then
            exit 0
        fi
    fi
fi

