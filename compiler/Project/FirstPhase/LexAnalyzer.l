/*
Author  : Maryam Saeedmehr
Stud.NO : 9629373
------------------------
*Problem Defining :
  First-Phase of Compiler's Project

------------------------
*Compile :
~$ flex -o LexAnalyzer.c LexAnalyzer.l
~$ gcc -o LexAnalyzer LexAnalyzer.c
~$ ./LexAnalyzer FILE_NAME
------------------------
*Output : Output.txt
*/
%{
	#include <stdio.h>
	int startComment=0;
	int startString=0;
	char comment[] = "/*";
	char str[] = "\"";
	int startCommentLineNO;
%}

%x C_STRING
%x C_COMMENT
%option yylineno
%option noyywrap

%%
[+-]?([0-9]+)																							{
																														if(strlen(yytext)>=10)
																															if(yytext < "2147483647" && yytext > "-2147483648")
																																fprintf(yyout,"TOKEN_INTCONST %s\n",yytext);
																															else
																																{fprintf(yyout,"error in line %d : integer constant is out of range\n",yylineno);return 0;}
																														else
																															fprintf(yyout,"TOKEN_INTCONST %s\n",yytext);
																													}
[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?										{fprintf(yyout,"TOKEN_FLOATCONST %s\n",yytext);}
"void"																										{fprintf(yyout,"‫‪TOKEN_VOIDTYPE‬‬ %s\n",yytext);}
"int"																											{fprintf(yyout,"‫‪TOKEN_INTTYPE‬‬  %s\n",yytext);}
"if"																											{fprintf(yyout,"TOKEN_IFCONDITION %s\n",yytext);}
"else"																										{fprintf(yyout,"TOKEN_ELSECONDITION %s\n",yytext);}
"return"																									{fprintf(yyout,"TOKEN_RETURN %s\n",yytext);}
"foreach"																									{fprintf(yyout,"TOKEN_LOOP %s\n",yytext);}
"main"																										{fprintf(yyout,"TOKEN_MAINFUNC %s\n",yytext);}
"double"																									{fprintf(yyout,"TOKEN_DOUBLETYPE %s\n",yytext);}
"string"																									{fprintf(yyout,"TOKEN_STRINGTYPE %s\n",yytext);}
"continue"																								{fprintf(yyout,"TOKEN_CONTINUESTMT %s\n",yytext);}
"float"																										{fprintf(yyout,"TOKEN_FLOATTYPE %s\n",yytext);}
"char"																										{fprintf(yyout,"TOKEN_CHARTYPE %s\n",yytext);}
"break"																										{fprintf(yyout,"TOKEN_BREAKSTMT %s\n",yytext);}
[a-zA-Z][_a-zA-Z0-9]{0,31}																{fprintf(yyout,"TOKEN_ID %s\n",yytext);}
[0-9][_a-zA-Z0-9]+|[a-zA-Z][_a-zA-Z0-9]{32,}							{fprintf(yyout,"error in line %d : wrong id definition\n",yylineno);return 0;}
[\'][a-zA-Z ][\']																					{fprintf(yyout,"TOKEN_CHARCONST %s\n",yytext);}
[\'][a-zA-Z][^\']																					{fprintf(yyout,"error in line %d : unclosed char constant section\n",yylineno);return 0;}
[^\'][a-zA-Z][\']																					{fprintf(yyout,"error in line %d : unopened char constant section\n",yylineno);return 0;}
"="																												{fprintf(yyout,"TOKEN_ASSIGNOP %s\n",yytext);}
"+"																												{fprintf(yyout,"TOKEN_ARITHMATICOP %s\n",yytext);}
"-"																												{fprintf(yyout,"TOKEN_ARITHMATICOP %s\n",yytext);}
"*"																												{fprintf(yyout,"TOKEN_ARITHMATICOP %s\n",yytext);}
"/"																												{fprintf(yyout,"TOKEN_ARITHMATICOP %s\n",yytext);}
"^"																												{fprintf(yyout,"TOKEN_ARITHMATICOP %s\n",yytext);}
"<="																											{fprintf(yyout,"TOKEN_RELATIONOP %s\n",yytext);}
">="																											{fprintf(yyout,"TOKEN_RELATIONOP %s\n",yytext);}
"<"																												{fprintf(yyout,"TOKEN_RELATIONOP %s\n",yytext);}
">"																												{fprintf(yyout,"TOKEN_RELATIONOP %s\n",yytext);}
"=="																											{fprintf(yyout,"TOKEN_RELATIONOP %s\n",yytext);}
"!="																											{fprintf(yyout,"TOKEN_RELATIONOP %s\n",yytext);}
"!"																												{fprintf(yyout,"TOKEN_LOGICOP %s\n",yytext);}
"&&"																											{fprintf(yyout,"TOKEN_LOGICOP %s\n",yytext);}
"&"																												{fprintf(yyout,"TOKEN_BITWISEOP %s\n",yytext);}
"||"																											{fprintf(yyout,"TOKEN_LOGICOP %s\n",yytext);}
"|"																												{fprintf(yyout,"TOKEN_BITWISEOP %s\n",yytext);}
"("																												{fprintf(yyout,"TOKEN_LEFTPAREN %s\n",yytext);}
")"																												{fprintf(yyout,"TOKEN_RIGHTPAREN %s\n",yytext);}
"{"																												{fprintf(yyout,"TOKEN_LCB %s\n",yytext);}
"}"																												{fprintf(yyout,"TOKEN_RCB %s\n",yytext);}
";"																												{fprintf(yyout,"TOKEN_SEMICOLON %s\n",yytext);}
","																												{fprintf(yyout,"TOKEN_COMMA %s\n",yytext);}
".."																											{fprintf(yyout,"TOKEN_UNTIL %s\n",yytext);}
"["																												{fprintf(yyout,"TOKEN_LB %s\n",yytext);}
"]"																												{fprintf(yyout,"TOKEN_RB %s\n",yytext);}
"//".*																										{fprintf(yyout,"TOKEN_COMMENT %s\n",yytext);}
"/*"     																									{
																														BEGIN(C_COMMENT);
																														startComment=1;
																														startCommentLineNO=yylineno;
				 																									}
"*/"																											{
																														fprintf(yyout,"error in line %d : unopened comment section\n",yylineno);
																														return 0;
																													}
"\""																											{
																														BEGIN(C_STRING);
																														startString=1;
																									        }
<C_COMMENT>"*/" 																					{
																														BEGIN(INITIAL);
																														fprintf(yyout,"TOKEN_COMMENT %s*/\n",comment);
																														startComment=0;
																														memset(comment,0,strlen(comment));
																														memset(str,0,strlen(str));
																														strcat(str,"\"");
																													}
<C_COMMENT>.    																					{strcat(comment,yytext);}
<C_COMMENT>[\n]    																				{ }
<C_STRING>[\"]																						{
																														BEGIN(INITIAL);
																														fprintf(yyout,"TOKEN_STRINGCONST %s\"\n",str);
																														startString=0;
																														memset(comment,0,strlen(comment));
																														memset(str,0,strlen(str));
																														strcat(str,"\"");
																													}
<C_STRING>.																								{strcat(str,yytext);}
<C_STRING>\n																							{fprintf(yyout,"error in line %d : unclosed constant string section\n",yylineno-1);return 0;}
[ ]																												{fprintf(yyout,"TOKEN_WHITESPACE [space]\n");}
[\t]																											{fprintf(yyout,"TOKEN_WHITESPACE \\t\n");}
[\n]																											{fprintf(yyout,"TOKEN_WHITESPACE \\n\n");}
%%

int main(int argc, char* argv[]){
	yyin = fopen(argv[1],"r");
	yyout = fopen("Output.out","w");
	yylex();
	if(startComment)
		fprintf(yyout,"error in line %d : unclosed comment section\n",startCommentLineNO);
	fflush(yyout);
	fclose(yyout);
	fflush(yyin);
	fclose(yyin);
	return 0;
}
