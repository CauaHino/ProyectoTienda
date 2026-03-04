#!/bin/bash

tipo=$1
descripcion=$2
rutaLog=$3

fecha=$(date +"%H:%M-%d/%m/%y")

echo "$fecha | $tipo | $descripcion" >> "$rutaLog"

if [ "$descripcion" == "Fin de programa" ]; then
    echo "" >> "$rutaLog"
fi