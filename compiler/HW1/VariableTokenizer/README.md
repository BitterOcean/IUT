# C like Variable Tokenizer
![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)
![Builed](https://img.shields.io/azure-devops/build/totodem/8cf3ec0e-d0c2-4fcd-8206-ad204f254a96/2?style=flat)
![License](https://img.shields.io/packagist/l/doctrine/orm)
![language](https://img.shields.io/badge/language-Bison-orange)

Author : Maryam Saeedmehr  
Language : Bison/Flex

<p align="center">
<img src="https://user-images.githubusercontent.com/60509979/78402597-17daf000-7610-11ea-991b-d2d73844670f.png">
</p>
</br>  

## **Solution** :metal::sunglasses:   
```bison
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

```

## **SUPPOERT**

Reach out to me at one of the following places!

- Telegram at <a href="https://t.me/BitterOcean" target="_blank">@BitterOcean</a>
- Gmail at <a href="mailto:maryamsaeedmehr@gmail.com" target="_blank">maryamsaeedmehr@gmail.com</a>
