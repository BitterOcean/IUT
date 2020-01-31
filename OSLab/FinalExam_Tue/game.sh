#!/bin/bash

gcc server.c -o server.out -lpthread
gcc client.c -o client.out

gnome-terminal -- ./server.out $1 $2
#n = "$1"

arg=("$@")
for((i=0;i<arg[0];i++)); do
  gnome-terminal -- ./client.out
done
