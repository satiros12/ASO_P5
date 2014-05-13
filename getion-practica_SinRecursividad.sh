#! /bin/bash
#Here we are going to manage practices.
#----------Includes----------
. $(dirname $0)/Includes/utiles.include #Format is .include becouse thtat include oter files.
					#Only work if executed from here.
#----------Declarations----------
#---Variables
readonly LogFile="/var/log/informe-prac.log"
#---Functions
function MainMenu
{
$cls #Clear terminal. #!!---------------------------------------------------------------------------!

msjC 2 0 "ASO 13/14 – Práctica 5\n" #!!-------------------------------------------------------------!
msjC 5 0 "Stanislav Vakark - GCT31 - bi0175\n"
echo "

Herramienta de gestión de prácticas
-----------------------------------
"
msjC 7 0 "Menú\n"
echo "
   1) Programar recogida de prácticas
   2) Empaquetar prácticas de una asignatura
   3) Ver tamaño y fecha del fichero de una asignatura
   4) Enviar backup de prácticas a un servidor remoto
   5) Finalizar programa
"
msjC 4 0 "   Opción:"; read option


if numberInRange $option 1 5 #!!-----------------------------------------------------------------!
then
	Log "Opción $option seleccionada."
	return option"$option"
else
	msjC 2 0 "Opción erronea - $option.\n"
	msjC 2 0 " -- Escriba una opción  entre 1 y 5.\n" 
	Log $(msjC 2 0 "[ERROR] Opción erronea seleccionada : $option \n")
	sleep 2
	return 1
fi
}
function option1
{
msjC 7 0 "Menú 1 – Programar recogida de prácticas\n"

read -p "Asignatura cuyas prácticas desea recoger: " subjectName
timeCollect=""
getTimeCollect #Insert value in declared variable.
studentsPathDir=""
getStudentsPathDir
collectPathDir=""
getCollectPathDir
echo "Se va a programar la recogida de las prácticas de $subjectName a las
$timeCollect. Origen: $getStudentsPathDir. Destino: $getCollectPathDir"

¿Está de acuerdo (s/n)?

}
function option2
{
}
function option3
{
}
function option4
{
}
function option5
{
	echo "Finalizando el programa." 
	Log "Salida correcta del programa."
	sleep 1
	retun 0
}
function getTimeCollect
{
ended=1
while ! [ "$ended" -eq "0" ]
do
	read -p "Hora a la que debe realizarse la recogida: " timeCollect
	Hour=$(echo $timeCollect | cut -d':' -f1)
	Min=$(echo $timeCollect | cut -d':' -f2)
	if numberInRange $Hour 0 23 && numberInRange $Min 0 59 #<hour>:<min>
	then 
		ended=0
		return 0
fi
msjC 2 0 "Se ha introducido mal la hora $timeCollect\n"
Log $(msjC 2 0 "[ERROR] Se ha introducido mal la hora $timeCollect.\n")
done
}
function getStudentsPathDir
{
ended=1
while ! [ "$ended" -eq "0" ]
do
	read -p "Ruta absoluta con las cuentas de los alumnos: " studentsPathDir
	if [ -d $studentsPathDir ]
	then 
		ended=0
		return 0
fi
msjC 2 0 "El directorio introducido, no es un directorio $studentsPathDir\n"
Log $(msjC 2 0 "[ERROR] Se ha introducido mal el directorio $studentsPathDir.\n")
done
}
function getCollectPathDir
{
ended=1
while ! [ "$ended" -eq "0" ]
do
	read -p "Ruta absoluta para almacenar prácticas: " collectPathDir
	if [ -d $collectPathDir ]
	then 
		ended=0
		return 0
fi
msjC 2 0 "El directorio introducido, no es un directorio $collectPathDir\n"
Log $(msjC 2 0 "[ERROR] Se ha introducido mal el directorio $collectPathDir.\n")
done
}
function getDataConfirmation
{
ended=1
while ! [ "$ended" -eq "0" ]
do
	read -p "¿Está de acuerdo (s/n)? " dataConfirmation
	if [ $dataConfirmation ]
	then 
		ended=0
		return 0
fi
msjC 2 0 "El directorio introducido, no es un directorio $collectPathDir\n"
Log $(msjC 2 0 "[ERROR] Se ha introducido mal el directorio $collectPathDir.\n")
done
}
function Log
{
	date=$(date +%x)
	time=$(date +%X)
	Message=$1
	echo "$date $time $Message" >> $LogFile
}
#----------Executable code----------
Log "Comenzo del programa."
while ! MainMenu #In that way, we dont use System resources in recursive programing after each option or error, 
		 #if the system reserve resources for each function.
do
	#Repeat MainMenu untl it end.
done
exit 0

