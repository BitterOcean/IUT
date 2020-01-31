#!/bin/bash

if [ $1 == "-r" ];then		
		cat $2			
fi

if [ $1 == "-m" ];then

	mkdir $2	

	for (( c=$5; c<=$6; c++))
	do
	
			temp=$3
			temp=$temp"$c"
			temp=$temp".$4"
			temp="$2/"$temp
			touch $temp
	
	done

fi

