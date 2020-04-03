/*
Author  : Maryam Saeedmehr
Stud.NO : 9629373
------------------------
*Problem Defining :
  This is a program to get a cpp
  file name and extract its variables
  and print them in the standard output
------------------------
*compile :
~$ flex -o q9.cpp q9.l
~$ g++ -o q9 q9.cpp
~$ ./q9 FILE_NAME.cpp
------------------------
*Output format :
  VARIABLE_1
  VARIABLE_2
  .
  .
  .
*/
%{
  #include <iostream>
  #include <vector>
  using namespace std;
  vector<string> sample;
%}

%option noyywrap

prototype      "int"|"float"|"char"|"bool"|"string"
sample_regex   ({prototype})[\t\ ]+[^";"\n]+";"

%%
{sample_regex}     { sample.push_back(yytext); }
.                  ;
\n                 ;
%%

int main(int argc,char* argv[])
{
  // argv[1] is a file name
  yyin = fopen(argv[1],"r");
  yylex();
  for(int i=0;i<sample.size();i++)
  {
    if(sample[i].find("int")<=sample[i].size())
      sample[i].erase(0,3);
    else if(sample[i].find("float")<=sample[i].size())
      sample[i].erase(0,5);
    else if(sample[i].find("char")<=sample[i].size() || sample[i].find("bool")<=sample[i].size())
      sample[i].erase(0,4);
    else if(sample[i].find("string")<=sample[i].size())
      sample[i].erase(0,6);

    int new_id=0;
    int value=0;
    int limit=sample[i].size();
    for(int j=0;j<limit;j++)
    {
      if(sample[i].find(" ")==0)
        {
          sample[i].erase(0,1);
        }
      else if(sample[i].find("=")==0)
        {
          sample[i].erase(0,1);
          value=1;
        }
      else if(sample[i].find(",")==0)
        {
          sample[i].erase(0,1);
          value=0;
          new_id=1;
        }
      else if(sample[i].find(";")==0)
        {
          value=0;
          cout << endl;
          break;
        }
      else if(value)
        {
          sample[i].erase(0,1);
        }
      else
        {
          if(new_id)
          {
            cout << endl;
            new_id=0;
          }
          cout << sample[i][0];
          sample[i].erase(0,1);
        }
     }
  }
  return 0;
}
