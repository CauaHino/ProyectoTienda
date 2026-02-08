import curses
import subprocess
from pathlib import Path
from time import sleep
import json


def crear(rutaTienda):
   # Limpiar la pantalla
    terminal.clear()

    opciones = ["Crear Tipo de Perfume", "Crear Marca", "Crear Producto", "Volver"]
    seleccion = 0
    bucleActivo = True
    
    while bucleActivo:
        terminal.clear()
        terminal.addstr(0,0, "CREAR")
        
        for i, opcion in enumerate(opciones):
            if i == seleccion:
                terminal.addstr(i+2, 0, f"> {opcion}", curses.A_REVERSE)
            else:
                terminal.addstr(i+2, 0, f"{opcion}")
        
        terminal.addstr("\n\nElija una opción")
        tecla = terminal.getch()

        if tecla == curses.KEY_DOWN and seleccion < len(opciones) - 1:
            seleccion += 1
        elif tecla == curses.KEY_UP and seleccion > 0:
            seleccion -= 1
        elif tecla == ord('\n'):
            if seleccion == 0:
                curses.endwin()
                terminal.clear()
                
                subprocess.run( ["bash", "scripts/bash/crearTipoPerfume.sh", str(rutaTienda)] )
            elif seleccion == 1:
                curses.endwin()
                terminal.clear()
                
                rutaCompletaM = rutaTipoPerfume(rutaTienda, "marca")
                subprocess.run( ["bash", "scripts/bash/crearMarca.sh", str(rutaCompletaM)] )
            elif seleccion == 2:
                curses.endwin()
                terminal.clear()
                
                rutaCompletaP = rutaMarca(rutaTipoPerfume(rutaTienda, "producto"))
                subprocess.run( ["bash", "scripts/bash/crearProducto.sh", str(rutaCompletaP)] )
            elif seleccion == 3:
                bucleActivo = False
 
def rutaTipoPerfume(rutaTienda, tipo):
    # Limpiar la pantalla
    terminal.clear()

    seleccion = 0
    bucleActivo = True
    
    while bucleActivo:
        terminal.clear()
        if tipo == "marca":
            terminal.addstr(0,0, f"===== Donde deseas crear la {tipo} =====")
        elif tipo == "producto":
            terminal.addstr(0,0, f"===== Donde deseas crear el {tipo} =====")
        
        opciones = sorted([directorios for directorios in rutaTienda.iterdir() if directorios.is_dir()])
        
        if not opciones:
            terminal.addstr(2, 6, f"No hay tipos de perfumes")
        else:
            for i, opcion in enumerate(opciones):
                if i == seleccion:
                    terminal.addstr(i+2, 0, f"> {opcion.name}", curses.A_REVERSE)
                else:
                    terminal.addstr(i+2, 0, f"{opcion.name}")
        
        terminal.addstr(len(opciones) + 4, 0, " [Enter] Seleccionar || [s] Salir")
        tecla = terminal.getch()

        if tecla == curses.KEY_DOWN and seleccion < len(opciones) - 1:
            seleccion += 1
        elif tecla == curses.KEY_UP and seleccion > 0:
            seleccion -= 1
        elif tecla == ord('\n') and opciones:
            terminal.clear()
            curses.endwin()
            return opciones[seleccion] 
        elif tecla == ord('s'):
            terminal.clear()
            curses.endwin()
            return None

def rutaMarca(rutaTienda):
    # Limpiar la pantalla
    terminal.clear()

    seleccion = 0
    bucleActivo = True
    
    while bucleActivo:
        terminal.clear()
        terminal.addstr(0,0, f"===== Donde deseas crear el producto =====")
        
        opciones = sorted([directorios for directorios in rutaTienda.iterdir() if directorios.is_dir()])
        
        if not opciones:
            terminal.addstr(2, 6, f"No hay marcas de perfumes")
        else:
            for i, opcion in enumerate(opciones):
                if i == seleccion:
                    terminal.addstr(i+2, 0, f"> {opcion.name}", curses.A_REVERSE)
                else:
                    terminal.addstr(i+2, 0, f"{opcion.name}")
        
        terminal.addstr(len(opciones) + 4, 0, " [Enter] Seleccionar || [s] Salir")
        tecla = terminal.getch()

        if tecla == curses.KEY_DOWN and seleccion < len(opciones) - 1:
            seleccion += 1
        elif tecla == curses.KEY_UP and seleccion > 0:
            seleccion -= 1
        elif tecla == ord('\n') and opciones:
            terminal.clear()
            curses.endwin()
            return opciones[seleccion] 
        elif tecla == ord('s'):
            terminal.clear()
            curses.endwin()
            return None

def buscar():
    # Limpiar la pantalla
    terminal.clear()

    opciones = ["Buscar por Codigo", "Buscar por filtro", "Volver"]
    seleccion = 0
    bucleActivo = True
    
    while bucleActivo:
        terminal.clear()
        terminal.addstr(0,0, "BUSCAR")
        
        for i, opcion in enumerate(opciones):
            if i == seleccion:
                terminal.addstr(i+2, 0, f"> {opcion}", curses.A_REVERSE)
            else:
                terminal.addstr(i+2, 0, f"{opcion}")
        
        terminal.addstr("\n\nElija una opción")
        tecla = terminal.getch()

        if tecla == curses.KEY_DOWN and seleccion < len(opciones) - 1:
            seleccion += 1
        elif tecla == curses.KEY_UP and seleccion > 0:
            seleccion -= 1
        elif tecla == ord('\n'):
            if seleccion == 0:
                curses.endwin()
                subprocess.run( ["bash", "scripts/bash/codigoJson.sh"] )
            elif seleccion == 1:
                curses.endwin()
                subprocess.run( ["bash", "scripts/bash/filtrarJson.sh"] )
            elif seleccion == 2:
                bucleActivo = False
        
# Vamos a crear ver tienda en un archivo a parte y lo importamos aca para que no se haga tan largo es archivo
# def verTienda():
#     ruta = Path("/tiendas/PerfumeriaPaco")
#     seleccion = 0
#     while True:
#         terminal.clear()
#         terminal.addstr(0, 0, f"===== PERFUMERIA PACO: {ruta.name} =====")
#         elementos = [ruta.parent] + sorted(ruta.iterdir())

#         for i, elemento in enumerate(elementos):
#             nombre = elemento.name
#             if elemento == ruta.parent:
#                 nombre = "Volver"
#             if seleccion == i:
#                 terminal.addstr(i + 2, 0, nombre, curses.A_REVERSE)
#             else:
#                 terminal.addstr(i + 2, 0, nombre)

def salir():
    opciones = ["Si", "No"]
    seleccion = 0
    bucleActivo = True

    while bucleActivo:
        terminal.clear()
        terminal.addstr(0, 0, "¿Deseas Salir?")

        for i, opcion in enumerate(opciones):
            if i == seleccion:
                terminal.addstr(4, i*8, f"> {opcion}", curses.A_REVERSE)
            else:
                terminal.addstr(4, i*8, f"{opcion}")

        tecla = terminal.getch()

        if tecla == curses.KEY_RIGHT and seleccion < len(opciones) - 1:
            seleccion += 1
        elif tecla == curses.KEY_LEFT and seleccion > 0:
            seleccion -= 1
        elif tecla == ord('\n'): 
            if seleccion == 0:
                return False   
            elif seleccion == 1:
                return True


def menu(terminal):
    opciones = ["Crear","Buscar", "Ver la tienda", "Salir"]
    seleccion = 0
    bucleActivo = True
    
    rutaTienda = Path("/tiendas/PerfumeriaPaco/").resolve()

    while bucleActivo:
        # Limpiar la pantalla
        terminal.clear()

        # Escribir por pantalla
        terminal.addstr("MENÚ PRINCIPAL")

        #Pintar las opciones en la terminal
        for i, opcion in enumerate(opciones):
            if i == seleccion:
                terminal.addstr( i+2 , 0, f"> {opcion}", curses.A_REVERSE)
            else:
                terminal.addstr( i+2 , 0, f"{opcion}")

        terminal.addstr("\n\nElija una opción")

        # Espera a que el usuario pulse una tecla
        tecla = terminal.getch()


        if tecla == curses.KEY_DOWN and seleccion < len(opciones) - 1:
            seleccion += 1
        elif tecla == curses.KEY_UP and seleccion > 0:
            seleccion -= 1
        elif tecla == ord('\n'): # Entra aqui si has pulsado la tecla ENTER
            if seleccion == 0:
                crear(rutaTienda)
            elif seleccion == 1:
                buscar()
            elif seleccion == 2:
                # verTienda()
                pass
            elif seleccion == 3:
                bucleActivo = salir()
                             

if __name__ == '__main__':
    # Inicializa curses y obtiene la pantalla (terminal)
    terminal = curses.initscr()

    # Activar detección de teclas especiales (flechas, enter, etc)
    terminal.keypad(True)

    # Desactiva el eco del teclado
    # Las teclas pulsadas no se muestran
    curses.noecho()

    # Activar modo lectura inmediata de teclas (no espera Enter)
    curses.cbreak()

    # Oculta el cursor
    curses.curs_set(0)

    try:
        menu(terminal)
    finally:
        # Libera los recursos de la terminal
        curses.nocbreak()
        terminal.keypad(False)
        curses.echo()
        curses.endwin()