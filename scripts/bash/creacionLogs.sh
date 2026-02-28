#!/bin/bash

tipo=$1
descripcion=$2

fecha=$(date +"%H:%M-%d/%m/%y")

echo "$fecha | $tipo | $descripcion" >> "../../programan.log"