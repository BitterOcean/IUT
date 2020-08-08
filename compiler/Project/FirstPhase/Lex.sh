#!/bin/bash

Command=${1}
FileName=${2}

if [ $Command == "--run" ]
then
	flex LexAnalyzer.l
	echo "lex.yy.c is created"
	gcc lex.yy.c 
	echo "Compiling has finished and execution file is created"
	./a.out $FileName
elif [ $Command == "--remove" ]
then
	rm lex.yy.c a.out Output.out
	echo "All files removed :)"
else
	echo "Unkown command :| "
fi
