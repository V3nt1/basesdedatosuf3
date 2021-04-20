#!/bin/bash

DEBUG="1"

clear

echo "Esto es el gestor de Among MEME"
echo "==================================="

echo "¿Qué quieres hacer?"
echo "-------------------"

echo "1.- Mostrar personajes"
echo "2.- Mostrar inventario de un personaje"
echo "3.- Crear personaje"
echo "4.- Crear item"
echo "5.- Dar item a personaje"
echo "6.- Eliminar personaje"
echo "Q.- Salir"

read INPUT

if [ "$INPUT" == "Q" ] || [ "$INPUT" == "q" ] || [ "$INPUT" == "" ]; then
	echo "Pos hasta luego"
	exit 0
fi

if [ "$INPUT" == "1" ]; then
	echo "Personajes:"
	echo "SELECT id_character, name FROM characters" | mysql -u root
elif [ "$INPUT" == "2" ]; then
	echo "Inventario:"
	echo "==========="
	echo"¿De qué personaje quieres ver el inventario?"

	read INPUT

	if [ "$INPUT" == "" ]; then
	echo "Has de introducir algun valor"
	exit 1
	fi
	
	QUERY="select * from characters_items_summary where id_character=$INPUT" 
	echo $QUERY | mysql -u root amongmeme | cut -d $'\t' -f 4
elif [ "$INPUT" == "3" ]; then
echo "Inserción de personaje"
echo "======================"

echo -n "Nombre: "
read NOMBRE

echo -n "Edad: "
read EDAD

echo -n "HP: "
read HP

echo -n "Mana: "
read MANA

echo -n "Gender (M/F): "
read GENDER

echo -n "Style (P/L): "
read STYLE

echo -n "Class (Wa/Wi/Ar): "
read CLASS

echo -n "Race (Or/El/Hu/Ro): "
read RACE

echo -n "Exp: "
read EXP

echo -n "Level: "
read LEVEL

echo -n "Height: "
read HEIGHT

QUERY="INSERT INTO characters (name, age, hp, gender, style, mana, class, race, xp, level, height)"
QUERY="$QUERY VALUES ('$NOMBRE', $EDAD, $HP, '$GENDER', '$STYLE', $MANA, '$CLASS', '$RACE', $EXP, $LEVEL, $HEIGHT)"

echo $QUERY | mysql -u gestor amongmeme

if [ "$DEBUG" == "1" ]; then
	echo $QUERY
fi

elif [ "$INPUT" == "6" ]; then
echo -n "Pon al menos las 4 primeras letras del nombre del pj que desees borrar:"
read CHAR
NCHAR=`echo -n "$CHAR" | wc -c`

if [ $NCHAR -lt 4 ]; then
	echo "No hay suficientes letras."
	exit 1
else
	DELETE="DELETE FROM characters WHERE name LIKE '%$CHAR%'"
	echo $DELETE | mysql -u gestor amongmeme
	
fi

else
	echo "Opción incorrecta"
fi
