/*
Author  : Maryam Saeedmehr
Stud.NO : 9629373
------------------------
*Problem Defining :
  This is a program to get a
  file name and a sample world
  and find the sample in the
  file and also count the number
  of matching appearance
------------------------
*compile :
~$ flex -o q7.cpp q7.l
~$ g++ -o q7 q7.cpp
~$ ./q7 FILE_NAME PATTERN
------------------------
*Output format :
  NUMBER_OF_MATCHING_APPEARANCE
  LINE_NUMBER : LINE_TEXT
  .
  .
  [and so on...]
*/
%{
    #include <iostream>
    #include <string.h>
    #include <vector>
    using namespace std;

    // Global Variables
    int count=0;
    string pattern;
    vector<string> output;
%}

%option noyywrap

line      .*
newline   \n

%%
{line}     {
            if(string(yytext).find(pattern)!= string::npos)
              {
                char str[100];
                sprintf(str,"%d : %s",yylineno,yytext);
                output.push_back(str);
                count++;
              }
            }

{newline}   {yylineno++;}
%%

int main(int argc, char* argv[])
{
  // argv[1] is a file name
  // argv[2] is a pattern
  extern FILE* yyin;
  yyin = fopen(argv[1],"r");
  pattern = argv[2];
  yylex();
  cout << count << endl;
  for(int i=0;i<output.size();i++)
    cout << output[i] << endl;
  return 0;
}
