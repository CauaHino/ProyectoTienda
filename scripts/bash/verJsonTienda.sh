#!/bin/bash
clear
ruta=$1

if [[ -f $ruta ]]; then
    nombre=$(jq -r '.nombre' "$ruta")
    precio=$(jq -r '.precio'  "$ruta")
    stock=$(jq -r '.stock' "$ruta")
    ml=$(jq -r '.ml' "$ruta")
    descripcion=$(jq -r '.descripcion' "$ruta")

    echo "----------------------------"
    echo "Nombre: $nombre"
    echo "Precio: $precio"
    echo "Stock: $stock"
    echo "Mililitros: $ml"
    echo "Descripción: $descripcion"
    echo "----------------------------"

    read -p "Presione (v) si deseas Volver " salir
    if [[ $salir == 'v' || $salir == 'V' ]]; then
        read -p "Estas seguro que quieres salir? [S/N] " opcion
        if [[ $opcion == 'S' || $opcion == 's' ]] then
            exit 0
        fi
    fi
else
    echo "No fue posible acceder a ese producto."
    exit 1
fi

