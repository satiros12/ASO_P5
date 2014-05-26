#!/bin/bash
#Includes with: $ . /<file to include>

#Declares of variables:

#Functions:
function Controles_opcion_menu_correcto
{
	if [ "$1" -ge "1" ] && [ "$1" -le "5" ]
	then
		return 0
	else
		return 1
	fi
}
function Controles_hora_correcta
{
	Hour=$(echo "$1" | cut -d':' -f1)
	Min=$(echo "$1" | cut -d':' -f2)
	if [ "$Hour" -lt "23" ] && [ "$Hour" -ge "0" ] && [ "$Min" -lt "59" ] && [ "$Min" -ge "0" ]
	then 
		return 0
	else 
		return 1
	fi
}
function Controles_directorio_correcto
{
	if [ -d "$1" ]
	then 
		return 0
	else
		return 1
	fi
}
function Controles_confiramcion_correcta
{
	if [ "$1" = "s" ] || [ "$1" = "n" ]
	then
		return 0
	else
		return 1
	fi
}
#Code:

#Is empty.
