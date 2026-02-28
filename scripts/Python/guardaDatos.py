import json
import subprocess
import sys
from time import sleep

ruta = sys.argv[1]
nombre = sys.argv[2]
precio = sys.argv[3]
stock = sys.argv[4]
ml = sys.argv[5]
descripcion = sys.argv[6]

# datos = json.load(open(ruta))

datos_nuevos = {
    "nombre": nombre,
    "precio": precio,
    "stock": stock,
    "ml": ml,
    "descripcion": descripcion
}

try:
    with open(ruta, "w") as archivo:
        json.dump(datos_nuevos, archivo, indent=4)
except FileNotFoundError as e:
    print(f"Error el archivo no ha podido ser encontrado: {e}")
    subprocess.run( ["bash", "scripts/bash/creacionLogs.sh", str("GUARDAR"), str(f"Error el archivo no ha podido ser encontrado: {e}")] )
    sleep(4)
except Exception as e:
    print(f"Error al guardar los datos: {e}")
    subprocess.run( ["bash", "scripts/bash/creacionLogs.sh", str("GUARDAR"), str(f"Error al guardar los datos: {e}")] )
    sleep(4)

