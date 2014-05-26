#!/bin/bash
#include to manage Errors and warnings.
#Includes with: $ . /<file to include>
. $(dirname $0)/Includes/colores.sh
. $(dirname $0)/Includes/Log.sh #Funciónes para enviar mensajes al archivo de log.
#Declares of variables:

#Functions:
function Error_entrada
{
	output=$(msjC 2 0 "Ha introducido mal el dato!\n")
	Log_error $output
	echo $output
}
function Warn_cancel
{
	output=$(msjC 4 0 "Ha cancelado.\n")
	Log_warning $output
	echo $output
}
function Warn_gen
{
	output=$(msjC 4 0 "$1\n")
	Log_warning $output
	echo $output
}
#Code:

#Is empty.
echo "2"
