import curses
from pathlib import Path

def listarTienda(terminal):
    ruta = Path("/tiendas/PerfumeriaPaco")
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
        elif tecla == ord('\n'): # Entra aqui si has pulsado la tecla ENTER
            if seleccion == 0:
                pass
                
# Cambiar la estructura para mostrar me gusta mas la del main
# Hay que hacer:
# 1. Funcion para listar las marcas, productos
# 2. Posible escript para solo mostrar el contenido de los productos.
