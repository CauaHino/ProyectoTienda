#!/bin/bash

log(){
    bash "creacionLogs.sh" "$1" "$2"
}

clear

echo "Bienvenido a nuestro sistema publicitario"

read -p "Introduce un correo electronico: " correo
read -p "Introduce un codigo de producto: " codigo

ruta=$(find /tiendas/PerfumeriaPaco/ -name "$codigo.json")

if [[ -z "$ruta" ]]; then
    echo "Error: No se ha encontrado el archivo $codigo.json en el Escritorio"
    log "IA / ENVIAR CORREO - ERROR" "Error: No se ha encontrado el archivo $codigo.json en el Escritorio"
    exit 1
else
    nombre=$(jq -r '.nombre' "$ruta")
    precio=$(jq -r '.precio' "$ruta")
    stock=$(jq -r '.stock' "$ruta")
    ml=$(jq -r '.ml' "$ruta")
    descripcion=$(jq -r '.descripcion' "$ruta")

    echo "Enviando datos del producto: $nombre..."

    curl -s -X POST "http://10.0.0.78:5678/webhook-test/correo" \
    -H "Content-Type: application/json" \
    -d "{
        \"email\": \"$correo\",
        \"codigo\": \"$codigo\",
        \"nombre\": \"$nombre\",
        \"precio\": \"$precio\",
        \"stock\": \"$stock\",
        \"ml\" : \"$ml\",
        \"descripcion\": \"$descripcion\"
    }"

    echo -e "\n¡Datos enviados correctamente!"
fi