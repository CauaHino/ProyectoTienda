import curses
import subprocess
from pathlib import Path
from time import sleep
import json

# Permite controlar la terminal (capturar teclas, redibujar pantalla, ...)
import requests


def opcion1():
    # 1. Limpiar la pantalla
    terminal.clear()
    
    datos = json.load(open("json/datos.json"))
    nombre = datos["nombre"]
    edad = datos["edad"]
    terminal.addstr(0,0, "El nombre es: " + nombre)
    terminal.addstr(1,0, "La edad es: " + str(edad))
    terminal.getch()
    
    curses.endwin()
    retorno = subprocess.run( ["./pedirDatos.sh", str(nombre), str(edad) ] )
   

def opcion2():
     # Limpiar la pantalla
    terminal.clear()

    # Escribir por pantalla
    terminal.addstr(0, 0, "Has elegido la opción 2")
    terminal.addstr(1, 0, "Pulsa una tecla para volver al menu")

     # Una pausa
    terminal.getch()


def opcion3():
    # Limpiar la pantalla
    terminal.clear()

    # Escribir por pantalla
    terminal.addstr(0, 0, "Has elegido la opción 3")
    terminal.addstr(1, 0, "Pulsa una tecla para volver al menu")

    # Una pausa
    terminal.getch()

def opcion4():
    opciones = ["Si", "No"]
    seleccion = 0
    # CORRECCIÓN 1: Debe ser True para que el bucle arranque
    bucleActivo = True

    while bucleActivo:
        terminal.clear()
        terminal.addstr(0, 0, "¿Deseas Salir?")

        for i, opcion in enumerate(opciones):
            # Estética: Agregué un espacio " i*5 " para que no estén tan pegados
            if i == seleccion:
                terminal.addstr(4, i*5, opcion, curses.A_REVERSE)
            else:
                terminal.addstr(4, i*5, opcion)

        tecla = terminal.getch()

        if tecla == curses.KEY_RIGHT and seleccion < len(opciones) - 1:
            seleccion += 1
        elif tecla == curses.KEY_LEFT and seleccion > 0:
            seleccion -= 1
        elif tecla == 10: # Enter
            if seleccion == 0:
                return False   # Confirmamos la salida
            elif seleccion == 1:
                # Eligió "No"
                return True

def menu(terminal):
    opciones = ["Editar JSON","Opción 2", "Opción 3", "Listar", "Salir"]
    seleccion = 0
    bucleActivo = True

    while bucleActivo:
        # Limpiar la pantalla
        terminal.clear()

        # Escribir por pantalla
        terminal.addstr("MENÚ PRINCIPAL")

        #Pintar las opciones en la terminal
        for i, opcion in enumerate(opciones):
            if i == seleccion:
                terminal.addstr( i+2 , 0, opcion, curses.A_REVERSE)
            else:
                terminal.addstr( i+2 , 0, opcion)

        terminal.addstr("\n\nElija una opción")

        # Espera a que el usuario pulse una tecla
        tecla = terminal.getch()


        if tecla == curses.KEY_DOWN and seleccion < len(opciones) - 1:
            seleccion += 1
        elif tecla == curses.KEY_UP and seleccion > 0:
            seleccion -= 1
        elif tecla == ord('\n'): # Entra aqui si has pulsado la tecla ENTER
            if seleccion == 0:
                opcion1()
            elif seleccion == 1:
                opcion2()
            elif seleccion == 2:
                opcion3()
            elif seleccion == 3:
                continue
            elif seleccion == 4:
                bucleActivo = opcion4()




if __name__ == '__main__':
    print("inicio")
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
