#!/bin/bash
#Includes with: $ . /<file to include>
. $(dirname $0)/Includes/colores.sh
. $(dirname $0)/Includes/Log.sh #Funciónes para enviar mensajes al archivo de log.

#There are:
#		0) Default
#		1) Black
#		2) Red
#		3) Green
#		4) Yellow
#		5) Blue
#		6) Magenta
#		7) Cyan
#		8) Light gray


#Declares of variables:
output=""
#Functions:
function Fuentes_titulo
{
	output=$(msjC 5 0 "$1\n")
	Log_info $output
	echo $output
}
function Fuentes_nomberAlumno
{
	output=$(msjC 3 0 "$1\n")
	Log_info $output
	echo $output
}
function Fuentes_menu
{
	output=$(msjC 0 0 "$1\n")
	Log_info $output
	echo $output
}
function Fuentes_pregunta
{
	output=$(msjC 4 0 "$1\n")
	Log_info $output
	echo $output
}
function Fuentes_respuesta_color_start
{
	colorB 1
}
function Fuentes_respuesta_color_end
{
	colorB 0
}
#Code:

#Is empty.






