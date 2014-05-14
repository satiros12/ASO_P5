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
	option"$option"
	$0
else
	msjC 2 0 "Opción erronea - $option.\n"
	msjC 2 0 " -- Escriba una opción  entre 1 y 5.\n" 
	Log $(msjC 2 0 "[ERROR] Opción erronea seleccionada : $option \n")
	sleep 2
	$0
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

if ! getDataConfirmation
then
	$0
fi

minEv=$(echo "$timeCollect" | cut -d':' -f2) 
hourEv=$(echo "$timeCollect" | cut -d':' -f1) 
dayEv=$(date +%x | cut -d'/' -f1) 
MoonEv=$(date +%x | cut -d'/' -f2)
WeekDayev=$(date +%u)

sendTaskToCronTab $WeekDayev $MoonEv $dayEv $hourEv $minEv $getStudentsPathDir $getCollectPathDir
}
function option2
{
msjC 7 0 "Menú 2 – Empaquetar prácticas de la asignatura\n"
read -p "Asignatura cuyas prácticas se desea empaquetar: " subjectName
dirPract=""
getStudentsPathDir
echo "Se van a empaquetar las prácticas de la asignatura $subjectName presentes
en el directorio $dirPrac."

if ! getDataConfirmation
then
	$0
fi 

nameOfTarball="$subjectName-$(date +%x | tr -d '\')-$(date +%X | tr -d ':')"
tar -czf "$nameOfTarball.tgz" $dirPrac #In order to not have too much files in main directory, 
				       # that tarballs will be in a Packet folder.

}
function option3
{
declare -a students
MmsjC 7 0 "Menú 3 – Obtener tamaño y fecha del fichero\n\n"
read -p "Asignatura sobre la que queremos información: " subjectName
makePacketDirectory

tgzFile=""
getSuvbjectfileName $subjectName
declare -a datos=$(du ./Packet/$tgzFile -b)
pesoPaquete=${datos[0]}

echo "
El fichero generado es $tgzFile y ocupa $pesoPaquete bytes."
}
function option4
{
Asignatura cuyo backup queremos enviar:

MmsjC 7 0 "Menú 4 – Enviar backup al servidor\n\n"
Aread -p "signatura cuyo backup queremos enviar:" subjectName
tgzFile=""
getSuvbjectfileName $subjectName
declare -a datos=$(du ./Packet/$tgzFile -b)

}
function option5
{
echo "Finalizando el programa..." 
Log "Salida correcta del programa."
sleep 1
exit 0
}
function getTimeCollect
{
read -p "Hora a la que debe realizarse la recogida: " timeCollect
Hour=$(echo $timeCollect | cut -d':' -f1)
	Min=$(echo $timeCollect | cut -d':' -f2)
	if numberInRange $Hour 0 23 && numberInRange $Min 0 59 #<hour>:<min>
	then 
		return 0
	else 
		msjC 2 0 "Se ha introducido mal la hora $timeCollect\n"
		Log $(msjC 2 0 "[ERROR] Se ha introducido mal la hora $timeCollect.\n")
		$0
		return $?
	fi
}
function getStudentsPathDir
{
	read -p "Ruta absoluta con las cuentas de los alumnos: " studentsPathDir
	if [ -d $studentsPathDir ]
	then 
		return 0
	else
		msjC 2 0 "El directorio introducido, no es un directorio $studentsPathDir\n"
		Log $(msjC 2 0 "[ERROR] Se ha introducido mal el directorio $studentsPathDir.\n")
		$0
		return $?
	fi
}
function getCollectPathDir
{
	read -p "Ruta absoluta para almacenar prácticas: " collectPathDir
	if [ -d $collectPathDir ]
	then 
		return 0
	else
		msjC 2 0 "El directorio introducido, no es un directorio $collectPathDir\n"
		Log $(msjC 2 0 "[ERROR] Se ha introducido mal el directorio $collectPathDir.\n")
		$0
		return $?
	fi
}
function getDataConfirmation
{
	read -p "¿Está de acuerdo (s/n)? " dataConfirmation
	if [ "$dataConfirmation" ==  "s" ]
	then 
		return 0
	elif [ "$dataConfirmation" ==  "n" ]	
	then
		return 1
	else
		msjC 2 0 "Ha de introducir n o s, cuando ha introducido $dataConfirmation \n"
		Log $(msjC 2 0 "[ERROR] Ha introducido $dataConfirmation en vez de a o n.\n")
		$0
		return $?
	fi
}
function sendTaskToCronTab
{
min=$5
hour=$4
day=$3
month=$2
dayOfWeek=$1

srcFolder=$6
dstfolder=$7

cronFile="CronTabfile$(data +%X)" #file with time in the name, to don't touch user's files..

touch $cronFile
echo "$(crontab -l)" >> $cronFile #Previous configurations.
echo "$min $hour $day $month $dayOfWeek ./recoge-prac.sh $srcFolder $dstfolder" >> $cronFile #Current configurations add to file.
crontab $cronFilei #Set cron tab job.
rm $cronFile #Deleting the file, in order to not make rabish here.
#-------------------IMPLEMTATION MISS-----------------
}
function getStudentsPathDir
{
	read -p "Ruta absoluta del directorio de prácticas: " dirPract
	if [ -d $dirPract ]
	then 
		return 0
	else
		msjC 2 0 "El directorio introducido, no es un directorio $dirPract.\n"
		Log $(msjC 2 0 "[ERROR] Se ha introducido mal el directorio $dirPract.\n")
		$0
		return $?
	fi
}
function makePacketDirectory
{
	if [ -d "./Packages" ]
	then 
		return 0
	else
		mkdir "./Packet"
		msjC 4 0 "Se ha creado un nuevo directorio ./Packet\n"
		Log $(msjC 4 0 "[INFO] Se ha creado un nuevo directorio ./Packet\n")
	fi
}
function getSuvbjectfileName
{
packetdir="./Packet"
subjectName=$1
ficheros=$(ls ${packetdir}/${subjectName} | egrep "${subjectName}-"[0-9]\{6\}"-"[0-9]\{4\})".tgz"
declare -a students=($(echo $ficheros))
tgzFile="${packetdir}/${students[0]}"
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
MainMenu
exit 0

