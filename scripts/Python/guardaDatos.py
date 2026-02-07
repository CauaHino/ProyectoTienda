import json
import sys

ruta = sys.argv[1]
nombre = sys.argv[2]
precio = sys.argv[3]
stock = sys.argv[4]
ml = sys.argv[5]
descripcion = sys.argv[6]

datos = json.load(open(ruta))

datos_nuevos = {
    "nombre": nombre,
    "precio": precio,
    "stock": stock,
    "ml": ml,
    "descripcion": descripcion
}

json.dump(datos_nuevos, open(ruta, "w"))
