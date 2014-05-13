#Verification Functions.
function Nbt #Number bigger than
{
if numParam $# "2" && [ "$1" -gt "$2" ]
then
		return 0
else
		return 1
fi 
}

function Ne #Number equal to.
{
if numParam $# "2" && [ "$1" -eq "$2" ]
then
		return 0;
else
		return 1;
fi 
}

function isNumber
{
if numParam $# "1" && [ "$1" -eq "$1" ] 2>/dev/null
then
    return 0
else
    return 1
fi
}

function numberInRange
{
if numParam $# 3 && isNumber $1 && [ "$1" -ge "$2" ] && [ "$1" -le "$3" ]
then
	return 0
else 
	return 1
fi
}
function numParam
{
if [ "$1" -lt "$2" ]
then
	echo "There are $1 paramenters and that is less than $2"
	return 1
else
	return 0
fi
}
