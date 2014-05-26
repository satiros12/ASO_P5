#!/bin/bash
#Includes with: $ . /<file to include>

#Declares of variables:
LogFile="/var/log/informe-prac.log"
#Functions:
function Log_info
{
	Message=$1
	date=$(date +%x)
	time=$(date +%X)
	echo "$date $time [INFO] $Message " >> $LogFile
}
function Log_warning
{
	Message=$1
	date=$(date +%x)
	time=$(date +%X)
	echo "$date $time [WARN] $Message " >> $LogFile
}
function Log_error
{
	Message=$1
	date=$(date +%x)
	time=$(date +%X)
	echo "$date $time [ERROR] $Message " >> $LogFile
}
#Code:

#Is empty.
