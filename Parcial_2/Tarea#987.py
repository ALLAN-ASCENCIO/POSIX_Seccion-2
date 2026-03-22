#!/usr/bin/env python3
import subprocess
import re

PROMPT = "Jail >> "

def correrCMD(cmd):
    try:
        result = subprocess.run(
            cmd.split(), #Usar lista para evitar problemas
            capture_output=True,
            text=True,
            timeout=10
        )
        return result.stdout + result.stderr #Se muestra tanto salida estándar como errores
    except Exception as e:
        return f"Error ejecutando comando: {e}"

def checar(cmd):
    pattern = r'[a-zA-Z0-9]+'  #Se bloquea el espacio y caracteres especiales
    
    if not cmd.strip():
        print("Comando vacío")
        return
    
    if not re.fullmatch(pattern, cmd):
        print("Caracteres inválidos detectados")
        return
    
    output = correrCMD(cmd)
    print(output)

def mostrar_ayuda():
    print("""
Comandos disponibles:
  help  >> mostrar ayuda
  exit  >> salir
  clear >> limpiar pantalla

Solo se permiten caracteres: letras, números, espacio, . - /
""")

while True:
    try:
        cmd = input(PROMPT).strip()
        
        if cmd == "exit":
            print("Saliendo del Jail...")
            break
        
        elif cmd == "help":
            mostrar_ayuda()
        
        elif cmd == "clear":
            print("\033c", end="")
        
        else:
            checar(cmd)
    
    except KeyboardInterrupt:
        print("\nUsa 'exit' para salir")
    except EOFError:
        break
