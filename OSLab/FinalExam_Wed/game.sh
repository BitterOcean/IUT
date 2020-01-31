#!/bin/bash

gcc ./Server.c -o Server -lpthread
gcc ./Player.c -o Player

Player=${1}
Stone=${2}

xterm -e ./Server $Player $Stone &
sleep 1
for (( c=1; c<=$Player ; c++ ));
do
        xterm -e ./Player &
done
