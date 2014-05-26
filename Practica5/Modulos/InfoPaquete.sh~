#!/bin/bash
#Includes with: $ . /<file to include>

#Declares of variables:

#Functions:

#Code:
ficheros=$(ls $1 | egrep "*-"[0-9]\{6\}"-"[0-9]\{4\}".tgz")
declare -a students=($(echo $ficheros))
tgzFile="$1/${students[0]}"
echo " ${tgzFile##*/} :"
if ! [ -f $tgzFile ]
then
	echo "Nada"
	exit 1
fi
echo "$(du -b $tgzFile | cut -f1)" #Obtengo el peso del archivo de forma legible
exit 0
