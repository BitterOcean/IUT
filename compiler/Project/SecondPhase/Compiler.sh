#!/bin/bash

Command=${1}
FileName=${2}

if [ $Command == "--run" ]
then
	bison -d Compiler.y
	echo "Compiler.tab.h is created"
	echo "Compiler.tab.c is created"
	flex Compiler.l
	echo "lex.yy.c is created"
	g++ lex.yy.c Compiler.tab.c
	echo "Compiling has finished and execution file is created"
	./a.out $FileName
elif [ $Command == "--remove" ]
then
	rm Compiler.tab.c Compiler.tab.h lex.yy.c a.out
	echo "All files removed :)"
else
	echo "Unkown command :| "
fi
