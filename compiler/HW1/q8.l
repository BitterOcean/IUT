/*
Author  : Maryam Saeedmehr
Stud.NO : 9629373
------------------------
*Problem Defining :
  This is a program to get a cpp
  file name and remove all of
  its comments.
------------------------
*Compile :
~$ flex -o q8.c q8.l
~$ gcc -o q8 q8.c
~$ ./q8 FILE_NAME.cpp
------------------------
*Output format :
  FILE_NAME.cpp // without comments :)
*/
%{
	#include <stdio.h>
	#include <string.h>
%}

%x C_COMMENT
%option noyywrap

%%
"/*"            { BEGIN(C_COMMENT); }
<C_COMMENT>"*/" { BEGIN(INITIAL); }
<C_COMMENT>.    { }
"//".* 					{ }
%%

int main(int argc,char* argv[])
{
	yyin = fopen(argv[1],"r");
	yyout = fopen(argv[1],"r+");
	yylex();
	return 0;
}
