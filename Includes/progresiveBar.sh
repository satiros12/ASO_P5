#[head,tail] progresivebar 2,50 [50,49]
#ProgresiveBar:
#	$1 timesleep before increase.
#	$2 after sleep, in what percent is going to be.
#      [$3] Proportion of bar (By defult is in 2 --- 100/2 ... 50 characters of bar.)
function progresiveBar 
{
timeSleep=$1 #Past that time, progress will be pinted
toPercent=$2 #Percent to print.
declare -i MAX=100
if [ "$#" -gt "2" ] 
then
#Select scale
declare -i SER=$3
declare -i result
result=MAX%SER
if [ "$result" -eq "0" ] && [ "$SER" -ne "0" ]
then
	points=$SER
else
	points=2
fi

else
	points=2
fi
#Know when to stop.
declare -i toPercentP=$(($toPercent/$points))

#Wait
sleep $timeSleep


#start print
OUTPUT=" ($toPercent%) |"
declare -i COUNT=$(($MAX/$points))
declare -i IN=0
while [ "$IN" -lt "$COUNT" ]
do
if [ "$IN" -lt "$toPercentP" ]
then
OUTPUT="${OUTPUT}#"
else
OUTPUT="${OUTPUT}."
fi
((IN++))
done
OUTPUT="${OUTPUT}|"
echo -ne "$OUTPUT"'\r'
if [ "$toPercent" -eq "$MAX" ]
then
echo ""
fi
}
