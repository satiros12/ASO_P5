#This script needs 2 parameters.
#	$1: Directory from what this script gets practices.
#	$2: Directory where script puts practices.

#----------Includes-------------

#----------Declarations---------
#---Variables---
getPath=$1
putPath=$2
declare -a students
#---Functions---
#---Code----
#Checking paramenters and data
if [ "$#" -lt "2" ]
then
	exit 1
fi
if ! [ -d "$getPath" ] || ! [ -d "$putPath" ]
then
	exit 2
fi
#Check OK.

stuDirs=$(ls $getPath)
students=($(echo $stuDirs))
for index in ${students[@]}
do
	if [ -d "${getPath}/${index}" ] && [ -r "${getPath}/${index}/prac.sh" ]
	then
		cp "${getPath}/${index}/prac.sh" "${putPath}/${index}.sh"
	fi
done
exit 0
