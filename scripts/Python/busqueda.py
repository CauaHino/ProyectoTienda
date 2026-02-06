import json
import sys
from pathlib import Path

def buscar():
	ruta = Path.cwd() / "tiendas" # Cambiar por la ruta de la tiedna 
	filtro = sys.argv[1].lower()# Filtro que pasamos al script 
	rutas = open("rutas_busqueda.txt", "w", encoding="utf-8")# Archivo para almacenar rutas 
	nombres = open("nombres_busqueda.txt", "w", encoding="utf-8")# Archivo para almacenar nombres 
	i = 1# variable para numerar elementos encontrados en la busqueda 
	for archivo in ruta.rglob("*.json"):
		# Cargar objeto json
		datos = json.load(open(archivo))
		descripcion = datos.get("descripcion")
		# Comprobar si descripcion tiene parte del filtro
		# Independientemente mayusculas de minusculas
		# En caso de coincidencia meter a la lista
		if filtro in descripcion.lower():
			rutas.write(str(archivo)+"\n") # almacenar ruta en txt 
			nombres.write(f"{i}. {datos.get('nombre')}\n")# almacenar nombre en txt con numeracion 
		i+=1

	# Cerrar archivos por seguridad		
	nombres.close()
	rutas.close()

if __name__ == "__main__":
	buscar()
