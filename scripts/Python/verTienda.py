import curses
from pathlib import Path
import subprocess

def listarTienda(terminal):
    ruta = Path("/tiendas/PerfumeriaPaco")
    seleccion = 0
    while True:
        terminal.clear()
        opciones = sorted([directorios for directorios in ruta.iterdir() if directorios.is_dir()])
        opciones.append("Volver")

        for i, opcion in enumerate(opciones):
            if(opcion != "Volver"):
                nombre = opcion.name
            else:
                nombre = opcion
            if seleccion == i:
                terminal.addstr(i + 2, 0, f"> {nombre}", curses.A_REVERSE)
            else:
                terminal.addstr(i + 2, 0, f"{nombre}")
        
        tecla = terminal.getch()


        if tecla == curses.KEY_DOWN and seleccion < len(opciones) - 1:
            seleccion += 1
        elif tecla == curses.KEY_UP and seleccion > 0:
            seleccion -= 1
        elif tecla == ord('\n'):
            if opciones[seleccion] == 'Volver':
                return None
            else:
                listarMarca(terminal, opciones[seleccion])
             
def listarMarca(terminal, ruta):
    seleccion = 0
    while True:
        terminal.clear()
        terminal.addstr(0, 0, f"===== PERFUMERIA PACO: {ruta.name} =====")
        opciones = sorted([directorios for directorios in ruta.iterdir() if directorios.is_dir()])
        opciones.append("Volver")

        for i, opcion in enumerate(opciones):
            if(opcion != "Volver"):
                nombre = opcion.name
            else:
                nombre = opcion
            if seleccion == i:
                terminal.addstr(i + 2, 0, f"> {nombre}", curses.A_REVERSE)
            else:
                terminal.addstr(i + 2, 0, f"{nombre}")
        
        tecla = terminal.getch()


        if tecla == curses.KEY_DOWN and seleccion < len(opciones) - 1:
            seleccion += 1
        elif tecla == curses.KEY_UP and seleccion > 0:
            seleccion -= 1
        elif tecla == ord('\n'):
            if opciones[seleccion] == 'Volver':
                return None
            else:
                listarProducto(terminal, opciones[seleccion])

def listarProducto(terminal, ruta):
    seleccion = 0
    while True:
        terminal.clear()
        terminal.addstr(0, 0, f"===== PERFUMERIA PACO: {ruta.name} =====")
        opciones = sorted([archivos for archivos in ruta.iterdir() if archivos.is_file()])
        opciones.append("Volver")

        for i, opcion in enumerate(opciones):
            if(opcion != "Volver"):
                nombre = opcion.name
            else:
                nombre = opcion
            if seleccion == i:
                terminal.addstr(i + 2, 0, f"> {nombre}", curses.A_REVERSE)
            else:
                terminal.addstr(i + 2, 0, f"{nombre}")
        
        tecla = terminal.getch()

        if tecla == curses.KEY_DOWN and seleccion < len(opciones) - 1:
            seleccion += 1
        elif tecla == curses.KEY_UP and seleccion > 0:
            seleccion -= 1
        elif tecla == ord('\n'):
            if opciones[seleccion] == 'Volver':
                return None
            else:
                terminal.clear()
                curses.endwin()
                subprocess.run( ["bash", "scripts/bash/verJsonTienda.sh", str(opciones[seleccion])] )
