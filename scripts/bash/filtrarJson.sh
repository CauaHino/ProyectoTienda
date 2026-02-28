#!/bin/bash

log(){
    bash "creacionLogs.sh" "$1" "$2"
}
clear

read -p "Indica un filtro: " filtro

python3 ./scripts/Python/busqueda.py $filtro

if [[ -s ./nombres_busqueda.txt ]]; then
    cat ./nombres_busqueda.txt
else
    clear
    echo "Error: No se encontraron productos con ese filtro."
    log "BUSQUEDA - REFERENCIA" "Error: No se encontraron productos con ese filtro."
    
    sleep 3
    exit 0
fi

read -p "Indica el numero de producto a editar (s para salir): " numero

if [[ "$numero" == "s" ]]; then
    clear
    echo "Hasta Luego"
    log "BUSQUEDA - REFERENCIA" "El usuario se retiro de la busqueda con filtro."

    sleep 2
    exit 0
fi

if [[ "$numero" =~ ^[0-9]+$ ]]; then

    clear
    echo "========= MODIFICAR PERFUME ========="

    contenido=$(sed -n "$numero"'p' ./rutas_busqueda.txt)

    if [ -z "$contenido" ] || [ ! -f "$contenido" ]; then
        clear
        echo "Error: El número seleccionado no existe."
        log "BUSQUEDA - REFERENCIA" "Error: El número seleccionado no existe."

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

    python3 ./scripts/Python/guardaDatos.py "$contenido" "$nombre" "$precio" "$stock" "$ml" "$descripcion"

    log "BUSQUEDA - REFERENCIA" "Se ha modificado el $contenido"

    echo "Nombre: $nombre"
    echo "Precio: $precio"
    echo "Stock: $stock"
    echo "Mililitros: $ml"
    echo "Descripción: $descripcion"
    
fi
