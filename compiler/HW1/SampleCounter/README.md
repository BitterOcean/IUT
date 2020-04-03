# Sample Finder
![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)
![Builed](https://img.shields.io/azure-devops/build/totodem/8cf3ec0e-d0c2-4fcd-8206-ad204f254a96/2?style=flat)
![License](https://img.shields.io/packagist/l/doctrine/orm)
![language](https://img.shields.io/badge/language-Bison-orange)

Author : Maryam Saeedmehr  
Language : Bison/Flex

<p align="center">
<img src="https://user-images.githubusercontent.com/60509979/78401785-bb2b0580-760e-11ea-9594-7973b762aa0c.png">
</p>
</br>  

## **Solution** :metal::sunglasses:   
```bison
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

```

## **SUPPOERT**

Reach out to me at one of the following places!

- Telegram at <a href="https://t.me/BitterOcean" target="_blank">@BitterOcean</a>
- Gmail at <a href="mailto:maryamsaeedmehr@gmail.com" target="_blank">maryamsaeedmehr@gmail.com</a>
