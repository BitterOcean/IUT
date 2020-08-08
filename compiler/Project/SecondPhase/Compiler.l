/*
Author  : Maryam Saeedmehr , Sajede Nicknadaf
------------------------
*Problem Defining :
  First-Phase of Compiler's Project (‌‌Matched-with-Parser version)

------------------------
*Compile :
~$ flex Compiler.l
~$ g++ lex.yy.c
~$ ./a,out FILE_NAME
------------------------
*/
%{

	#include <iostream>
	#include <string.h>
	#include "Compiler.tab.h"
	using namespace std;

	/*Error Handling*/
	static void update_loc(){

	  static int CurrentLine = 1;
	  static int CurrentColumn  = 1;

	  yylloc.first_line   = CurrentLine;
	  yylloc.first_column = CurrentColumn;

	  {
			char *s;
			for(s = yytext; *s != '\0'; s++){
		    if(*s == '\n'){
		      CurrentLine++;
		      CurrentColumn = 1;
		    }
				else{
		      CurrentColumn++;
		    }
		 	}
		}

	  yylloc.last_line   = CurrentLine;
	  yylloc.last_column = CurrentColumn-1;
	}

	#define YY_USER_ACTION update_loc();

	/*Global Variables*/
	int startComment = 0;
	int startString = 0;
	char comment[] = "/*";
	char str[] = " ";
	int startCommentLineNO;

%}

%x C_STRING
%x C_COMMENT
%option noyywrap

%%

[+-]?([0-9]+)																							{
																														if(strlen(yytext)>=10)
																															if(yytext < "2147483647" && yytext > "-2147483648")
																																{yylval.s_val= strdup(yytext); return TOKEN_INTCONST;}
																															else
																																{ }
																														else
																															{yylval.s_val= strdup(yytext);return TOKEN_INTCONST;}
																													}
[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?										{yylval.s_val= strdup(yytext);return TOKEN_FLOATCONST;}
"void"																										{return TOKEN_VOIDTYPE;}
"int"																											{return TOKEN_INTTYPE;}
"if"																											{return TOKEN_IFCONDITION;}
"else"																										{return TOKEN_ELSECONDITION;}
"return"																									{return TOKEN_RETURN;}
"foreach"																									{return TOKEN_LOOP;}
"main"																										{return TOKEN_MAINFUNC;}
"double"																									{return TOKEN_DOUBLETYPE;}
"string"																									{return TOKEN_STRINGTYPE;}
"continue"																								{return TOKEN_CONTINUESTMT;}
"float"																										{return TOKEN_FLOATTYPE;}
"char"																										{return TOKEN_CHARTYPE;}
"break"																										{return TOKEN_BREAKSTMT;}
"print"																										{return TOKEN_PRFUNC;}
[a-zA-Z][_a-zA-Z0-9]{0,31}																{yylval.s_val= strdup(yytext); return TOKEN_ID;}
[0-9][_a-zA-Z0-9]+|[a-zA-Z][_a-zA-Z0-9]{32,}							{return 0;}
[\'][a-zA-Z ][\']																					{return TOKEN_CHARCONST;}
[\'][a-zA-Z][^\']																					{return 0;}
[^\'][a-zA-Z][\']																					{return 0;}
"="																												{return TOKEN_ASSIGNOP;}
"+"																												{return TOKEN_PLUS;}
"-"																												{return TOKEN_MINUS;}
"*"																												{return TOKEN_TIMES;}
"/"																												{return TOKEN_DIVISION;}
"^"																												{return TOKEN_POWER;}
"<="																											{return TOKEN_LESSEQUAL;}
">="																											{return TOKEN_GREATEREQUAL;}
"<"																												{return TOKEN_LESS;}
">"																												{return TOKEN_GREATER;}
"=="																											{return TOKEN_EQUAL;}
"!="																											{return TOKEN_NOTEQUAL;}
"!"																												{return TOKEN_NOT;}
"&&"																											{return TOKEN_LOGICAND;}
"&"																												{return TOKEN_BITWISEAND;}
"||"																											{return TOKEN_LOGICOR;}
"|"																												{return TOKEN_BITWISEOR;}
"("																												{return TOKEN_LEFTPAREN;}
")"																												{return TOKEN_RIGHTPAREN;}
"{"																												{return TOKEN_LCB;}
"}"																												{return TOKEN_RCB;}
";"																												{return TOKEN_SEMICOLON;}
","																												{return TOKEN_COMMA;}
".."																											{return TOKEN_UNTIL;}
"["																												{return TOKEN_LB;}
"]"																												{return TOKEN_RB;}
"//".*																										{ }
"/*"     																									{
																														BEGIN(C_COMMENT);
																														startComment=1;
																														startCommentLineNO=yylineno;
				 																									}
"*/"																											{

																														return 0;
																													}
"\""																											{
																														BEGIN(C_STRING);
																														startString=1;
																									        }
<C_COMMENT>"*/" 																					{
																														BEGIN(INITIAL);

																														startComment=0;
																														memset(comment,0,strlen(comment));
																														memset(str,0,strlen(str));
																														strcat(str,"\"");
																													}
<C_COMMENT>.    																					{strcat(comment,yytext);}
<C_COMMENT>[\n]    																				{ }
<C_STRING>[\"]																						{
																														BEGIN(INITIAL);

																														yylval.s_val= strdup(yytext);
																														startString=0;
																														memset(comment,0,strlen(comment));
																														memset(str,0,strlen(str));
																														strcat(str,"\"");
																												 		return TOKEN_STRINGCONST;
																													}
<C_STRING>.																								{strcat(str,yytext);}
<C_STRING>\n																							{return 0;}
[ ]																												{ }
[\t]																											{ }
[\n]																											{ }

%%

/*
int main(int argc, char* argv[]){
	yyin = fopen(argv[1],"r");
	yyout = fopen("Flex_Output.txt","w");
	yylex();
	if(startComment)
		fprintf(yyout,"error in line %d : unclosed comment section\n",startCommentLineNO);
	fflush(yyout);
	fclose(yyout);
	fflush(yyin);
	fclose(yyin);
	return 0;
}
*/
