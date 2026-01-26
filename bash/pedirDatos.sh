#!/bin/bash

clear

nombre=$1
edad=$2

read -e -p "Introduce tu nombre: " -i "$nombre" nombre
read -e -p "Introduce tu edad: " -i "$edad" edad

python3 ../python/guardarJSON.py "$nombre" "$edad"