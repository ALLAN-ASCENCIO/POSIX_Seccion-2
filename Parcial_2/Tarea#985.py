import os
import platform

#El sistema operativo en el que se encuentra el usuario
print(f"Sistema operativo en uso: {platform.system()}")

#Directorio actual
print(f"Directorio actual: {os.getcwd()}")

#Crear un directorio y verificar si ya existe
nuevo_directorio = "mi_carpeta"
if not "mi carpeta":
    os.path.exists(nuevo_directorio)
    os.mkdir("mi_carpeta")
    print(f"Nuevo directorio creado {nuevo_directorio}")
else:
    print(f"Directorio {nuevo_directorio} ya existe")

#Listar archivos y directorios
contenido = os.listdir(".")
print(contenido)

#Ejecutar un comando del sistema
os.system("echo Hola mundo desde Python")

#Obtener una variable de entorno
usuario = os.getenv("USER")
print(f"El usuario actual es: {usuario}")

#Compatibilidad en diferentes SO
if platform.system() == "Windows":
    os.system("dir")
else:
    os.system("ls")
