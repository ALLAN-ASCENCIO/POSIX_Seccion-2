#!/bin/bash

#Script de arbol de directorio

echo "Escribe un nombre a tu nuevo directorio: "
read nombre_directorio

if [ -d $nombre_directorio ]; then
	echo "Ya existe un directorio con ese nombre..."
	echo "Por favor, escribe un nombre diferente."
	exit 1
else
	mkdir -p "$nombre_directorio"/{src,docs,bin,photos}
fi

echo "Nuevo directorio creado: "
echo $nombre_directorio

