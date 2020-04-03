# Comment Remover
![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)
![Builed](https://img.shields.io/azure-devops/build/totodem/8cf3ec0e-d0c2-4fcd-8206-ad204f254a96/2?style=flat)
![License](https://img.shields.io/packagist/l/doctrine/orm)
![language](https://img.shields.io/badge/language-Bison-orange)

Author : Maryam Saeedmehr  
Language : Bison/Flex

<p align="center">
<img src="https://user-images.githubusercontent.com/60509979/78402261-84092400-760f-11ea-8f57-b15b85210ad5.png">
</p>
</br>  

## **Solution** :metal::sunglasses:   
```bison

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

```

## **SUPPOERT**

Reach out to me at one of the following places!

- Telegram at <a href="https://t.me/BitterOcean" target="_blank">@BitterOcean</a>
- Gmail at <a href="mailto:maryamsaeedmehr@gmail.com" target="_blank">maryamsaeedmehr@gmail.com</a>
