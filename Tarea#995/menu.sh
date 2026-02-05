#!/bin/bash

#Este es un menu para ejecutar cualquiera de los scripts de esta carpeta

opcion=0

while [ $opcion -ne 4 ]; do
	clear
	echo "=============================="
	echo "         Tarea #996           "
	echo "=============================="
	echo "1) Crear arbol de directorio"
	echo "2) Script Hola Mundo"
	echo "3) Saludo con variable"
	echo "4) Salir"
	echo "=============================="
	echo -n "Seleccione una opcion: "
	read opcion

	case $opcion in
		1)
			bash arbol.sh
			read -p "Presione ENTER para continuar>>"
			;;
		2)
			bash holamundo.sh
			read -p "Presione ENTER para continuar>>"
			;;
		3)
			bash saludo.sh
			read -p "Presione ENTER para continuar>>"
			;;
		4)
			echo "Saliendo del menu..."
			;;
		*)
			echo "Opcion invalida"
			read -p "Presione ENTER para continuar..."
			;;
	esac
done
