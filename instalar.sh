#!/bin/bash


ruta="/tiendas"
nombreTienda="PerfumeriaPaco"
json="EstructuraTienda.json"
codigoProducto=100

log() {
    bash "scripts/bash/creacionLogs.sh" "$1" "$2" "programa.log"
}

# Configuración del Separador (IMPORTANTE para que el for no se rompa con espacios)
IFS_BAK=$IFS
IFS=$'\n'

clear


if [ -d "$/g2" ]; then
    echo "Carpeta g2 encontrada, renombrando a $nombreTienda"
    mv "$ruta/g2" "$ruta/$nombreTienda"
    sleep 4

    log "INSTALAR" "Carpeta g2 encontrada, renombrando a $nombreTienda"
elif [ ! -d "$ruta/$nombreTienda" ]; then
    echo "Error: No se ha podido encontrar $nombreTienda en $ruta"
    log "INSTALAR" "Error: No se ha podido encontrar $nombreTienda en $ruta"

    sleep 4
    exit 1
fi

echo "Tienda $nombreTienda lista. Iniciando creacion de la estructura..."

sleep 2

for cat_data in $(jq -c '.[]' "./$json"); do
    tipo=$(echo "$cat_data" | jq -r '.TipodePerfume')
    mkdir -p "$ruta/$nombreTienda/$tipo"
    log "INSTALAR" "Categoría creada: $tipo"

    for marca_data in $(echo "$cat_data" | jq -c '.marcas[]'); do
        marca=$(echo "$marca_data" | jq -r '.nombre')
        rutaMarca="$ruta/$nombreTienda/$tipo/$marca"
        mkdir -p "$rutaMarca"
        log "INSTALAR" "Marca creada: $marca"


        for prod_data in $(echo "$marca_data" | jq -c '.productos[]'); do
            
            # Extraer datos para Python
            nombre=$(echo "$prod_data" | jq -r '.producto.nombre')
            precio=$(echo "$prod_data" | jq -r '.producto.precio')
            stock=$(echo "$prod_data" | jq -r '.producto.stock')
            ml=$(echo "$prod_data" | jq -r '.producto.ml')
            descripcion=$(echo "$prod_data" | jq -r '.producto.descripcion')

            archivo="$rutaMarca/$codigoProducto.json"

            python3 "scripts/Python/guardaDatos.py" "$archivo" "$nombre" "$precio" "$stock" "$ml" "$descripcion"
            chmod 777 "$archivo"
            
            log "INSTALAR" "Producto $codigoProducto creado: $nombre"
            
            codigoProducto=$((codigoProducto + 1))
        done
    done
done

# Restaurar el separador original
IFS=$IFS_BAK

log "INSTALAR" "Fin de la instalacion"