#!/bin/bash
#Includes with: $ . /<file to include>

#Declares of variables:

#Functions:

#Code:
ficheros=$(ls $1 | egrep "*-"[0-9]\{6\}"-"[0-9]\{4\}".tgz")
declare -a students=($(echo $ficheros))
tgzFile="$1/${students[0]}"
if ! [ -f $tgzFile ]
then
	echo "Nada"
	exit 1
fi
scp $tgzFile "$2"".eui.upm.es":~/Backup/.
exit 0
