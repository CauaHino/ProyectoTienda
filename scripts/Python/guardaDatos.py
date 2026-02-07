import json
import sys

ruta = sys.argv[1]
nombre = sys.argv[2]
precio = sys.argv[3]
stock = sys.argv[4]
ml = sys.argv[5]
descripcion = sys.argv[6]

datos = json.load(open(ruta))
print(datos)

# datos["nombre"] = nombre
# datos["precio"] = precio
# datos["stock"] = stock
# datos["ml"] = ml
# datos["descripcion"] = descripcion

# json.dump(datos, open(ruta, "w"))