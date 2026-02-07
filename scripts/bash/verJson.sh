#!/bin/bash

clear
echo "========= MODIFICAR PERFUME ========="

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

if [[ $opcion == 'e' || $opcion == 'E' ]]; then
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
      '{nombre: $nom, precio: $pre, stock: $sto, ml: $ml, descripcion: $des}' > "$ruta"

        echo "Nombre: $nombre"
        echo "Precio: $precio"
        echo "Stock: $stock"
        echo "Mililitros: $ml"
        echo "Descripción: $descripcion"

elif [[ $opcion == 'b' || $opcion == 'B' ]]; then
    read -e -p "¿Estás seguro que deseas borrar el producto con codigo $codigo? (s/n): " confirmar
    if [[ $confirmar -eq 's' || $confirmar -eq 'S' ]]; then
        rm "$ruta"
        echo "Producto con codigo $codigo borrado."
        exit 1
    else
        echo "Operación de borrado cancelada."
        exit 1
    fi    
elif [[ $opcion == 'v' || $opcion == 'V' ]]; then
    exit 0
fi
