#!/bin/bash
#para escribir en la línea anterior con echo, introducir antes "\e[1A" : echo -ne "\e[1A ...."
#Includes with: $ . /<file to include>
. $(dirname $0)/Includes/Errores.sh #Funciónes de control de errores.
. $(dirname $0)/Includes/Controles.sh #Funciones de control de correcto funcionamiento del script.
. $(dirname $0)/Includes/Fuentes.sh #Funciónes con fuentes gréficas varias.
#Declares of variables:
Seleccion="" # Valriable de datos introducidos.
Seguir="NO"

#Functions:
function menuInicial
{
Fuentes_titulo "ASO 13/14 – Práctica 5"
Fuentes_nomberAlumno "Stanislav Vakaruk"
echo ""
Fuentes_menu "
Herramienta de gestión de prácticas
-----------------------------------
"
Fuentes_titulo "Menú"
Fuentes_menu "
  1) Programar recogida de prácticas
  2) Empaquetar prácticas de una asignatura
  3) Ver tamaño y fecha del fichero de una asignatura
  4) Enviar backup de prácticas a un servidor remoto
  5) Finalizar programa

"
while [ Seguir = "NO" ]
do
	Fuentes_pregunta "  Opción: "
	Fuentes_respuesta_color_start
	read Seleccion
	Fuentes_respuesta_color_end
	if [ Controles_opcion_menu_correcto $Seleccion ]
        then
		Seguir= "SI"
	else
		Error_entrada
		#Fuentes_reescribir_opcion # Hace echo -ne "\e[1A\r" para volver a la línea anterior con esa vacía 
					  # y borrar esa linea \r\033[0K.
	fi
done
"opcion$Seleccion"
}
function opcion1
{
Seguir="NO"
Seleccion=""
Fuentes_titulo "Menú 1 – Programar recogida de prácticas"
echo ""

Fuentes_pregunta "Asignatura cuyas prácticas desea recoger: "
Fuentes_respuesta_color_start
read Seleccion
Fuentes_respuesta_color_end

Asignatura=$Seleccion

while [ $Seguir = "NO" ]
do
	Fuentes_pregunta "Hora a la que debe realizarse la recogida: "
	Fuentes_respuesta_color_start
	read Seleccion
	Fuentes_respuesta_color_end
	if [ Controles_hora_correcta $Seleccion ]
        then
		Seguir= "SI"
	else
		Error_entrada
		#Fuentes_reescribir_opcion
	fi
done

Hora=$Seleccion
Seguir= "NO"

while [ $Seguir = "NO" ]
do
	Fuentes_pregunta "Ruta absoluta con las cuentas de los alumnos: "
	Fuentes_respuesta_color_start
	read Seleccion
	Fuentes_respuesta_color_end
	if [ Controles_directorio_correcto $Seleccion ]
        then
		Seguir= "SI"
	else
		Error_entrada
		#Fuentes_reescribir_opcion
	fi
done

RutaCuenta=$Seleccion
Seguir= "NO"

while [ $Seguir = "NO" ]
do
	Fuentes_pregunta "Ruta absoluta para almacenar prácticas: "
	Fuentes_respuesta_color_start
	read Seleccion
	Fuentes_respuesta_color_end
	if [ Controles_directorio_correcto $Seleccion ]
        then
		Seguir= "SI"
	else
		Error_entrada		
		#Fuentes_reescribir_opcion
	fi
done

RutaAlmacenar=$Seleccion
Seguir= "NO"

Fuentes_menu "
Se va a programar la recogida de las prácticas de $Asignatura a las
$Hora. Origen: $RutaCuenta. Destino: $RutaAlmacenar
"

while [ $Seguir = "NO" ]
do
	Fuentes_pregunta "¿Está de acuerdo (s/n)? "
	Fuentes_respuesta_color_start
	read Seleccion
	Fuentes_respuesta_color_end
	if [ Controles_confiramcion_correcta $Seleccion ]
        then
		Seguir= "SI"
	else
		Error_entrada
		#Fuentes_reescribir_opcion
	fi
done

if [ $Seleccion = "n" ] 
then
	warn_cancel "-- Datos rechazados --"
	#echo "-- Datos rechazados --"
	return 0;
fi

#With answer 's', it will coninue here.

echo "-- Datos aceptados --"

minEv=$(echo "$Hora" | cut -d':' -f2) 
hourEv=$(echo "$Hora" | cut -d':' -f1) 
dayEv=$(date +%x | cut -d'/' -f1) 
MoonEv=$(date +%x | cut -d'/' -f2)
WeekDayev=$(date +%u)

cronFile="CronTabfile$(data +%X)" #file with time in the name, to don't touch user's files..

touch $cronFile
echo "$(crontab -l)" >> $cronFile #Previous configurations.
echo "$minEv $hourEv $dayEv $MoonEv $WeekDayev $(dirname $0)/Modulos/Recogida.sh $RutaCuenta $RutaAlmacenar" >> $cronFile #Current configurations add to file.
crontab $cronFile #Set cron tab job.
rm $cronFile #Deleting the file, in order to not make rabish here.

echo "-- Completado --"

return 0;

}
function opcion2
{
Seguir="NO"
Seleccion=""
Fuentes_titulo "Menú 2 – Empaquetar prácticas de la asignatura"
echo ""

Fuentes_pregunta "Asignatura cuyas prácticas se desea empaquetar: "
Fuentes_respuesta_color_start
read Seleccion
Fuentes_respuesta_color_end

Asignatura=$Seleccion

while [ $Seguir = "NO" ]
do
	Fuentes_pregunta "Ruta absoluta para almacenar prácticas: "
	Fuentes_respuesta_color_start
	read Seleccion
	Fuentes_respuesta_color_end
	if [ Controles_directorio_correcto $Seleccion ]
        then
		Seguir= "SI"
	else
		Error_entrada		
		#Fuentes_reescribir_opcion
	fi
done

RutaPracticas=$Seleccion
Seguir= "NO"

Fuentes_menu "
Se van a empaquetar las prácticas de la asignatura ASO presentes
en el directorio $RutaPracticas.
"

while [ $Seguir = "NO" ]
do
	Fuentes_pregunta "¿Está de acuerdo (s/n)? "
	Fuentes_respuesta_color_start
	read Seleccion
	Fuentes_respuesta_color_end
	if [ Controles_confiramcion_correcta $Seleccion ]
        then
		Seguir= "SI"
	else
		Error_entrada
		#Fuentes_reescribir_opcion
	fi
done

if [ $Seleccion = "n" ] 
then
	#echo "-- Datos rechazados --"
	warn_cancel "-- Datos rechazados --"	
	return 0;
fi

$(dirname $0)/Modulos/Empaquetar.sh $RutaPracticas

echo "-- Completado --"

return 0;

}
function opcion3
{
Seguir="NO"
Seleccion=""
Fuentes_titulo "Menú 3 – Obtener tamaño y fecha del fichero"
echo ""

Fuentes_pregunta "Asignatura cuyas prácticas desea recoger: "
Fuentes_respuesta_color_start
read Seleccion
Fuentes_respuesta_color_end

Asignatura=$Seleccion

while [ $Seguir = "NO" ]
do
	Fuentes_pregunta "Ruta absoluta de la asignatura: "
	Fuentes_respuesta_color_start
	read Seleccion
	Fuentes_respuesta_color_end
	if [ Controles_directorio_correcto $Seleccion ]
        then
		Seguir= "SI"
	else
		Error_entrada
		#Fuentes_reescribir_opcion
	fi
done

RutaPracticas=$Seleccion
Seguir= "NO"

SalidaInfo=$($(dirname $0)/Modulos/InfoPaquete.sh)

if [ $SalidaInfo != "Nada" ]
then
	Fuentes_menu "$SalidaInfo"
else
	Fuentes_noPaquete "No hay paquetes en éste direcotio."	
fi

}
function opcion4
{
Seguir="NO"
Seleccion=""
Fuentes_titulo "Menú 4 – Enviar backup al servidor"
echo ""

Fuentes_pregunta "Asignatura cuyo backup queremos enviar: "
Fuentes_respuesta_color_start
read Seleccion
Fuentes_respuesta_color_end

Asignatura=$Seleccion

while [ $Seguir = "NO" ]
do
	Fuentes_pregunta "Ruta absoluta de la asignatura: "
	Fuentes_respuesta_color_start
	read Seleccion
	Fuentes_respuesta_color_end
	if [ Controles_directorio_correcto $Seleccion ]
        then
		Seguir= "SI"
	else
		Error_entrada
		#Fuentes_reescribir_opcion
	fi
done

RutaPracticas=$Seleccion
Seguir= "NO"

Fuentes_pregunta "Asignatura cuyo backup queremos enviar: "
Fuentes_respuesta_color_start
read Seleccion
Fuentes_respuesta_color_end

DireccionServidor=$Seleccion

$(dirname $0)/Modulos/EnviarPaquete.sh $RutaPracticas $DireccionServidor

return 0

}
function opcion5
{

echo "-- Finalizando --"
exit 0


}
#Code:

menuInicial

