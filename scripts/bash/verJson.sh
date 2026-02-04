#!/bin/bash

read -p "Ingrese el codigo del producto: " codigo
ruta=$(find /tiendas/PerfumeriaPaco/ -name "$codigo.json")

if [[ $ruta = "" ]]; then
    echo "El producto con codigo $codigo no existe."
    exit 1
else 
    echo "Producto encontrado: $ruta"
fi

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

read -e -p "¿Que deseas hacer? Editar(e), Borrar(b), Volver(v): " opcion

if [[ $opcion =~ [^a-zA-Z0-9] ]]; then
		echo "La variable no puede tener caracteres especiales"
        read -n1 -p "Pulsa una tecla para continuar..."
        exit 1
fi

if [[ $opcion -eq 'e' || $opcion -eq 'E' ]]; then
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
