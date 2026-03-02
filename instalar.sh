#!/bin/bash

log(){
    bash "scripts/bash/creacionLogs.sh" "$1" "$2"
}

clear

ruta="/tiendas"
nombreTienda="PerfumeriaPaco"
codigoProducto=100

if [ -d "$ruta/g2" ]; then
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

echo "Carpeta $nombreTienda lista. Iniciando creacion de la estructura..."
sleep 2

cat "EstructuraTienda.json" | jq -c '.[]' | while read -r categoria; do

    tipo=$(echo "$categoria" | jq -r '.TipodePerfume')
    mkdir -p "$ruta/$nombreTienda/$tipo"

    log "INSTALADOR" "Creada categoria: $tipo"

    echo "$categoria" | jq -c '.marcas[]' | while read -r marca; do
    
        nombre_marca=$(echo "$marca" | jq -r '.nombre')
        mkdir -p "$ruta/$nombreTienda/$tipo/$nombre_marca"

        log "INSTALADOR" "Creada marca: $nombre_marca en $tipo"
        
        echo "$marca" | jq -c '.productos[]' | while read -r producto; do

            nombre=$(echo "$producto" | jq -r '.producto.nombre')
            precio=$(echo "$producto" | jq -r '.producto.precio')
            stock=$(echo "$producto" | jq -r '.producto.stock')
            ml=$(echo "$producto" | jq -r '.producto.ml')
            descripcion=$(echo "$producto" | jq -r '.producto.descripcion')

            rutaJson="$ruta/$nombreTienda/$tipo/$nombre_marca/$codigoProducto.json"

            touch $rutaJson
            chmod 777 $rutaJson

            python3 "scripts/Python/guardaDatos.py" "$rutaJson" "$nombre" "$precio" "$stock" "$ml" "$descripcion"
            
            log "INSTALAR" "Producto creado: $nombre en $nombre_marca"
            codigoProducto=$($codigoProducto + 1)
        done
    done
done

log "INSTALAR" "Fin de la instalacion"
