#Need to include verificationFunctions.sh
#Color of characters.
function colorL
{
if [ "$#" -gt "0" ] && [ "$1" -ge "0" ] && [ "$1" -le "8" ]
then
	if [ "$1" -gt "0" ]
	then
		sel=$((${1}-1))
	else
		sel=9
	fi

	echo -en "\e[3${sel}m"
	return 0

else
	echo "Wrong color: $1"
	echo "There are:"
	echo "		0) Default"
	echo "		1) Black"
	echo "		2) Red"
	echo "		3) Green"
	echo "		4) Yellow"
	echo "		5) Blue"
	echo "		6) Magenta"
	echo "		7) Cyan"
	echo "		8) Light gray"


fi
return 1
}

#Color of background
function colorB
{
if [ "$#" -gt "0" ] && [ "$1" -ge "0" ] && [ "$1" -le "8" ]
then
	if [ "$1" -gt "0" ]
	then
		sel=$((${1}-1))
	else
		sel=9
	fi

	echo -en "\e[4${sel}m"
	return 0
else
	echo "Wrong color: $1"
	echo "There are:"
	echo "		0) Default"
	echo "		1) Black"
	echo "		2) Red"
	echo "		3) Green"
	echo "		4) Yellow"
	echo "		5) Blue"
	echo "		6) Magenta"
	echo "		7) Cyan"
	echo "		8) Light gray"
	#return 1


fi
return 1
}

#Messeges with color
function msjC
{
#Nbt $# 2 #Num of par.
if [ $# -le 2 ]; then echo "Error"; return 1; fi
fondo=$2 
letras=$1
mensaje=$3
colorL $letras
if [ $? -ne 0 ]; then return 2; fi
#Ne $? 0
colorB $fondo
if [ $? -ne 0 ]; then return 3; fi
#Ne $? 0
echo -ne "$mensaje"
colorL 0
colorB 0 
}
