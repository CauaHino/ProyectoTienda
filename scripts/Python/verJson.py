import json
import sys

def verJson():
    try:
        datos = json.load(open("json/datos.json"))
        nombre = datos["nombre"]
        precio = datos["precio"]
        stock = datos["stock"]
        ml = datos["ml"]
        descripcion = datos["descripcion"]
    except FileNotFoundError:
        sys.exit(1)
    