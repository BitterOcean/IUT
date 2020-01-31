#!/bin/bash
IP=${1}
PORT=${2}
CliNum=${3}
xterm -e ./OSLab8_Q2_server &
sleep 1
for((i=1;i<=$CliNum;i++));
	do
		xterm -e ./OSLab8_Q2_client $IP $PORT &
	done

