import curses
# Permite controlar la terminal (capturar teclas, redibujar pantalla, ...)
import requests


def opcion1():
    # 1. Limpiar la pantalla
    strscr.clear()

    # 2. Escribir por pantalla (Feedback visual inmediato)
    strscr.addstr(0, 0, "Has elegido la opción 1")
    strscr.addstr(1, 0, "Enviando mensaje a Discord...", curses.A_DIM)
    strscr.refresh()  # Importante para ver los cambios antes del request

 
    # 4. Finalizar
    strscr.addstr(5, 0, "Pulsa una tecla para volver al menú")
    strscr.refresh()  # Refrescar de nuevo para mostrar el resultado
    strscr.getch()

def opcion2():
     # Limpiar la pantalla
    strscr.clear()

    # Escribir por pantalla
    strscr.addstr(0, 0, "Has elegido la opción 2")
    strscr.addstr(1, 0, "Pulsa una tecla para volver al menu")

     # Una pausa
    strscr.getch()


def opcion3():
    # Limpiar la pantalla
    strscr.clear()

    # Escribir por pantalla
    strscr.addstr(0, 0, "Has elegido la opción 3")
    strscr.addstr(1, 0, "Pulsa una tecla para volver al menu")

    # Una pausa
    strscr.getch()

def opcion4():
    opciones = ["Si", "No"]
    seleccion = 0

    while True:  # 1. Agregamos el bucle infinito para mantener la pantalla
        strscr.clear()
        strscr.addstr(0, 0, "Deseas Salir?")

        # Tu lógica de dibujo exacta
        for i, opcion in enumerate(opciones):
            if i == seleccion:
                strscr.addstr(i + 2, 0, opcion, curses.A_REVERSE)
            else:
                strscr.addstr(i + 2, 0, opcion)

        tecla = strscr.getch()

        # Tu lógica de movimiento exacta
        if tecla == curses.KEY_RIGHT and seleccion < len(opciones) - 1:
            seleccion += 1
        elif tecla == curses.KEY_LEFT and seleccion > 0:
            seleccion -= 1
        elif tecla == 10:
            if seleccion == 0:
                break
            elif seleccion == 1:
                return False



def menu(strscr):
    opciones = ["Opción 1","Opción 2", "Opción 3", "Salir"]
    seleccion = 0
    while True:
        # Limpiar la pantalla
        strscr.clear()

        # Escribir por pantalla
        strscr.addstr("MENÚ PRINCIPAL")

        #Pintar las opciones en la terminal
        for i, opcion in enumerate(opciones):
            if i == seleccion:
                strscr.addstr( i+2 , 0, opcion, curses.A_REVERSE)
            else:
                strscr.addstr( i+2 , 0, opcion)

        strscr.addstr("\n\nElija una opción")

        # Espera a que el usuario pulse una tecla
        tecla = strscr.getch()


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
                opcion4()



if __name__ == '__main__':
    print("inicio")
    # Inicializa curses y obtiene la pantalla (terminal)
    strscr = curses.initscr()

    # Activar detección de teclas especiales (flechas, enter, etc)
    strscr.keypad(True)

    # Desactiva el eco del teclado
    # Las teclas pulsadas no se muestran
    curses.noecho()

    # Activar modo lectura inmediata de teclas (no espera Enter)
    curses.cbreak()

    # Oculta el cursor
    curses.curs_set(0)

    try:
        menu(strscr)
    finally:
        # Libera los recursos de la terminal
        curses.nocbreak()
        strscr.keypad(False)
        curses.echo()
        curses.endwin()
