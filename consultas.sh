#!/bin/bash

clear

echo "Esto es el inventario de Among MEME"
echo "==================================="

echo "¿Qué quieres hacer?"
echo "-------------------"

echo "1.- Mostrar personajes"
echo "2.- Mostrar inventario de un personaje"
echo "3.- Salir"

read INPUT

if [ "$INPUT" == "3" ] || [ "$INPUT" == "" ]; then
	echo "Pos hasta luego"
	exit 0
fi

if [ "$INPUT" == "1" ]; then
	echo "Personajes:"
	echo "SELECT id_character, name FROM characters" | mysql -u consulta amongmeme
elif [ "$INPUT" == "2" ]; then
	echo "Inventario:"
else
	echo "Opción incorrecta"
fi
