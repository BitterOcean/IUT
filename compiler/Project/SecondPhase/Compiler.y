/*
Author  : Maryam Saeedmehr , Sajede Nicknadaf
------------------------
*Problem Defining :
  Second-Phase of Compiler's Project (Grammar and simple Semantic Actions)
------------------------
*Compile :
~$ bison -d Compiler.y
~$ flex Compiler.l
~$ g++ lex.yy.c Compiler.tab.c
~$ ./a.out ‫‪printByTokenName‬‬Mode FILE_NAME

Note :
  * printByTokenName‬‬Mode==1 : ‫‪print by Token-Name
  * printByTokenName‬‬Mode==0 : print by Token-Value
------------------------
*Output : Output.asm
*/
%{

  #include <iostream>
  #include <string.h>
	#include <stdlib.h>
	#include <math.h>
  #include <vector>
  using namespace std;

  /*Function Declaration*/
	extern int yylex();
  void yyerror(const char*);
  void preOrder(struct Node *node,int PrintByTokenNameMode,int count);

/* for type cheking */
  char symbol_type(char* symbol,string scope);
  struct Symbol* search_symbol(char* symbol,string scope);
  void add_symbol(char* symbol,char type,string scope);
  struct Symbol{
    char* symbol;
    char type;
    string scope;
  };
  vector <Symbol*> symbols;
  string currentScop="global";
  char hereType='n';

  /*Global Variables and Structures*/
  extern FILE* yyin;

  struct Node{
    char* name;
    char* value;
    char type='n';
    struct Node* sister=NULL;
    struct Node* child=NULL;
  };
  struct Node *root=new Node();
  struct Node* child1;
  struct Node* child2;
  struct Node* child3;
  struct Node* child4;
  struct Node* child5;
  struct Node* child6;
  struct Node* child7;

%}

/*Error Handling*/
%define parse.error verbose
%locations

%union {
        struct Node* node;
        char* s_val;
       }

/************Priarity************/
%left TOKEN_LCB TOKEN_RCB
%left TOKEN_ASSIGNOP
%left TOKEN_LESSEQUAL TOKEN_GREATEREQUAL TOKEN_LESS TOKEN_GREATER
%left TOKEN_EQUAL TOKEN_NOTEQUAL
%left TOKEN_MINUS TOKEN_PLUS
%left TOKEN_TIMES TOKEN_DIVISION
%right TOKEN_POWER
%left TOKEN_LOGICAND TOKEN_LOGICOR
%left TOKEN_BITWISEAND TOKEN_BITWISEOR
%left TOKEN_NOT
%left TOKEN_LEFTPAREN TOKEN_RIGHTPAREN
%left TOKEN_LB TOKEN_RB

/************TOKENS************/
%token <s_val> TOKEN_INTCONST
%token <s_val> TOKEN_FLOATCONST
%token <s_val>TOKEN_CHARCONST
%token <s_val> TOKEN_STRINGCONST
%token <s_val> TOKEN_ID
%token <node> TOKEN_VOIDTYPE /* void */
%token <node> TOKEN_INTTYPE /* int */
%token <node> TOKEN_IFCONDITION /* if */
%token <node> TOKEN_ELSECONDITION /* else */
%token <node> TOKEN_RETURN /* return */
%token <node> TOKEN_LOOP /* foreach */
%token <node> TOKEN_MAINFUNC /* main */
%token <node> TOKEN_DOUBLETYPE /* double */
%token <node> TOKEN_STRINGTYPE /* string */
%token <node> TOKEN_CONTINUESTMT /* continue */
%token <node> TOKEN_FLOATTYPE /* float */
%token <node> TOKEN_CHARTYPE /* char */
%token <node> TOKEN_BREAKSTMT /* break */
%token <node> TOKEN_PRFUNC /* print */
%token <node> TOKEN_ASSIGNOP /* = */
%token <node> TOKEN_PLUS /* + */
%token <node> TOKEN_MINUS /* - */
%token <node> TOKEN_TIMES /* * */
%token <node> TOKEN_DIVISION /* / */
%token <node> TOKEN_POWER /* ^ */
%token <node> TOKEN_LESSEQUAL /* <= */
%token <node> TOKEN_GREATEREQUAL /* >= */
%token <node> TOKEN_LESS /* < */
%token <node> TOKEN_GREATER /* > */
%token <node> TOKEN_EQUAL /* == */
%token <node> TOKEN_NOTEQUAL /* != */
%token <node> TOKEN_NOT /* ! */
%token <node> TOKEN_LOGICAND /* && */
%token <node> TOKEN_BITWISEAND /* & */
%token <node> TOKEN_LOGICOR /* || */
%token <node> TOKEN_BITWISEOR /* | */
%token <node> TOKEN_LEFTPAREN /* ( */
%token <node> TOKEN_RIGHTPAREN /* ) */
%token <node> TOKEN_RCB /* } */
%token <node> TOKEN_LCB /* { */
%token <node> TOKEN_SEMICOLON /* ; */
%token <node> TOKEN_COMMA /* , */
%token <node> TOKEN_UNTIL /* .. */
%token <node> TOKEN_LB /* [ */
%token <node> TOKEN_RB /* ] */

/********NON-TERMINALS*********/
%nterm <node> PROGRAM
%nterm <node> GLOBAL_DECLARE
%nterm <node> PGM
%nterm <node> F_ARG
%nterm <node> ARG
%nterm <node> STMTS
%nterm <node> STMT
%nterm <node> PRINTFUNC
%nterm <node> EXP
%nterm <node> LOOP
%nterm <node> CONDITION
%nterm <node> SCOPE
%nterm <node> STMT_RETURN
%nterm <node> STMT_DECLARE
%nterm <node> STMT_DEFINE
%nterm <node> ARRAY_VAR
%nterm <node> IDS
%nterm <node> CALL
%nterm <node> ARGS
%nterm <node> STMT_ASSIGN
%nterm <node> TYPE
%start PROGRAM

/********Grammar Rules*********/
%%

PROGRAM : GLOBAL_DECLARE PGM{root->name=strdup("PROGRAM");root->child=$1;($1)->sister=($2);};

GLOBAL_DECLARE : GLOBAL_DECLARE TYPE TOKEN_ID TOKEN_ASSIGNOP EXP TOKEN_SEMICOLON
                  {
                    child1=new Node();
                    child1->name=strdup("TOKEN_ID");
                    child1->value=$3;
                    add_symbol($3,($2)->type,currentScop);
                    child2=new Node();
                    child2->name=strdup("TOKEN_ASSIGNOP");
                    child2->value=strdup("=");
                    child3=new Node();
                    child3->name=strdup("TOKEN_SEMICOLON");
                    child3->value=strdup(";");
                    $$=new Node();
                    ($$)->name=strdup("GLOBAL_DECLARE");
                    ($$)->child=$1;
                    ($1)->sister=$2;
                    ($2)->sister=child1;
                    child1->sister=child2;
                    child2->sister=$5;
                    ($5)->sister=child3;
                  }
                 |/*epsilon*/{$$=new Node();($$)->name=strdup("GLOBAL_DECLARE");}
                 ;

PGM : TYPE TOKEN_ID TOKEN_LEFTPAREN {currentScop=currentScop+" "+string($2);} F_ARG TOKEN_RIGHTPAREN TOKEN_LCB STMTS{currentScop.erase(currentScop.size()-(string($2).size()+1),string($2).size()+1);} TOKEN_RCB PGM
      {
        child1=new Node();
        child1->name=strdup("TOKEN_ID");
        child1->value=$2;
        child2=new Node();
        child2->name=strdup("TOKEN_LEFTPAREN");
        child2->value=strdup("(");
        child3=new Node();
        child3->name=strdup("TOKEN_RIGHTPAREN");
        child3->value=strdup(")");
        child4=new Node();
        child4->name=strdup("TOKEN_LCB");
        child4->value=strdup("{");
        child5=new Node();
        child5->name=strdup("TOKEN_RCB");
        child5->value=strdup("}");
        $$=new Node();
        ($$)->name=strdup("PGM");
        ($$)->child=$1;
        ($1)->sister=child1;
        child1->sister=child2;
        child2->sister=$5;
        ($5)->sister=child3;
        child3->sister=child4;
        child4->sister=$8;
        ($8)->sister=child5;
        child5->sister=$11;
      }
      | TOKEN_INTTYPE TOKEN_MAINFUNC TOKEN_LEFTPAREN TOKEN_RIGHTPAREN TOKEN_LCB {currentScop=currentScop+" "+"main";} STMTS {currentScop.erase(currentScop.size()-(string("main").size()+1),string("main").size()+1);} TOKEN_RCB
      {
        child1=new Node();
        child1->name=strdup("TOKEN_INTTYPE");
        child1->value=strdup("int");
        child2=new Node();
        child2->name=strdup("TOKEN_MAINFUNC");
        child2->value=strdup("main");
        child3=new Node();
        child3->name=strdup("TOKEN_LEFTPAREN");
        child3->value=strdup("(");
        child4=new Node();
        child4->name=strdup("TOKEN_RIGHTPAREN");
        child4->value=strdup(")");
        child5=new Node();
        child5->name=strdup("TOKEN_LCB");
        child5->value=strdup("{");
        child6=new Node();
        child6->name=strdup("TOKEN_RCB");
        child6->value=strdup("}");
        $$=new Node();
        ($$)->name=strdup("PGM");
        ($$)->child=child1;
        child1->sister=child2;
        child2->sister=child3;
        child3->sister=child4;
        child4->sister=child5;
        child5->sister=$7;
        ($7)->sister=child6;
      };

F_ARG : ARG TOKEN_COMMA ARG TOKEN_COMMA ARG TOKEN_COMMA ARG
        {
          child1=new Node();
          child1->name=strdup("TOKEN_COMMA");
          child1->value=strdup(",");
          child2=new Node();
          child2->name=strdup("TOKEN_COMMA");
          child2->value=strdup(",");
          child3=new Node();
          child3->name=strdup("TOKEN_COMMA");
          child3->value=strdup(",");
          $$=new Node();
          ($$)->name=strdup("F_ARG");
          ($$)->child=$1;
          ($1)->sister=child1;
          child1->sister=$3;
          ($3)->sister=child2;
          child2->sister=$5;
          ($5)->sister=child3;
          child3->sister=$7;
        }
        | ARG TOKEN_COMMA ARG TOKEN_COMMA ARG
        {
          child1=new Node();
          child1->name=strdup("TOKEN_COMMA");
          child1->value=strdup(",");
          child2=new Node();
          child2->name=strdup("TOKEN_COMMA");
          child2->value=strdup(",");
          $$=new Node();
          ($$)->name=strdup("F_ARG");
          ($$)->child=$1;
          ($1)->sister=child1;
          child1->sister=$3;
          ($3)->sister=child2;
          child2->sister=$5;
        }
        | ARG TOKEN_COMMA ARG
        {
          child1=new Node();
          child1->name=strdup("TOKEN_COMMA");
          child1->value=strdup(",");
          $$=new Node();
          ($$)->name=strdup("F_ARG");
          ($$)->child=$1;
          ($1)->sister=child1;
          child1->sister=$3;
        }
        | ARG
        {
          $$=new Node();
          ($$)->name=strdup("F_ARG");
          ($$)->child=$1;
        }
        | /*epsilon*/{$$=new Node();($$)->name=strdup("F_ARG");}
        ;

ARG : TYPE TOKEN_ID ARRAY_VAR
      {
        add_symbol($2,($1)->type,currentScop);
        child1=new Node();
        child1->name=strdup("TOKEN_ID");
        child1->value=$2;
        $$=new Node();
        ($$)->name=strdup("ARG");
        ($$)->child=$1;
        ($1)->sister=child1;
        child1->sister=$3;
      };

STMTS : STMT STMTS
        {
          $$=new Node();
          ($$)->name=strdup("STMTS");
          ($$)->child=$1;
          ($1)->sister=$2;
        }
        | /*epsilon*/{$$=new Node();($$)->name=strdup("STMTS");}
        ;

STMT : STMT_DECLARE TOKEN_SEMICOLON
       {
         child1=new Node();
         child1->name=strdup("TOKEN_SEMICOLON");
         child1->value=strdup(";");
         $$=new Node();
         ($$)->name=strdup("STMT");
         ($$)->child=$1;
         ($1)->sister=child1;
       }
       | STMT_ASSIGN TOKEN_SEMICOLON
       {
         child1=new Node();
         child1->name=strdup("TOKEN_SEMICOLON");
         child1->value=strdup(";");
         $$=new Node();
         ($$)->name=strdup("STMT");
         ($$)->child=$1;
         ($1)->sister=child1;
       }
       | STMT_RETURN TOKEN_SEMICOLON
       {
         child1=new Node();
         child1->name=strdup("TOKEN_SEMICOLON");
         child1->value=strdup(";");
         $$=new Node();
         ($$)->name=strdup("STMT");
         ($$)->child=$1;
         ($1)->sister=child1;
       }
       | LOOP{$$=new Node();($$)->name=strdup("STMT");($$)->child=$1;}
       | CONDITION{$$=new Node();($$)->name=strdup("STMT");($$)->child=$1;}
       | CALL TOKEN_SEMICOLON
       {
         child1=new Node();
         child1->name=strdup("TOKEN_SEMICOLON");
         child1->value=strdup(";");
         $$=new Node();
         ($$)->name=strdup("STMT");
         ($$)->child=$1;
         ($1)->sister=child1;
       }
       | EXP TOKEN_SEMICOLON
       {
         child1=new Node();
         child1->name=strdup("TOKEN_SEMICOLON");
         child1->value=strdup(";");
         $$=new Node();
         ($$)->name=strdup("STMT");
         ($$)->child=$1;
         ($1)->sister=child1;
       }
       | PRINTFUNC TOKEN_SEMICOLON
       {
         child1=new Node();
         child1->name=strdup("TOKEN_SEMICOLON");
         child1->value=strdup(";");
         $$=new Node();
         ($$)->name=strdup("STMT");
         ($$)->child=$1;
         ($1)->sister=child1;
       };

PRINTFUNC : TOKEN_PRFUNC TOKEN_LEFTPAREN EXP TOKEN_RIGHTPAREN
            {
              child1=new Node();
              child1->name=strdup("TOKEN_PRFUNC");
              child1->value=strdup("print");
              child2=new Node();
              child2->name=strdup("TOKEN_LEFTPAREN");
              child2->value=strdup("(");
              child3=new Node();
              child3->name=strdup("TOKEN_RIGHTPAREN");
              child3->value=strdup(")");
              $$=new Node();
              ($$)->name=strdup("PRINTFUNC");
              ($$)->child=child1;
              child1->sister=child2;
              child2->sister=$3;
              ($3)->sister=child3;
            };

EXP : EXP TOKEN_LESS EXP
      {
        if(($1)->type!=($3)->type)
          yyerror("Different Type For LESS Operation Not Allowed");
        child1=new Node();
        child1->name=strdup("TOKEN_LESS");
        child1->value=strdup("<");
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type='i';
        ($$)->child=$1;
        ($1)->sister=child1;
        child1->sister=$3;
      }
      | EXP TOKEN_LESSEQUAL EXP
      {
        if(($1)->type!=($3)->type)
          yyerror("Different Type For LESSEQUAL Operation Not Allowed");
        child1=new Node();
        child1->name=strdup("TOKEN_LESSEQUAL");
        child1->value=strdup("<=");
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type='i';
        ($$)->child=$1;
        ($1)->sister=child1;
        child1->sister=$3;
      }
      | EXP TOKEN_GREATER EXP
      {
        if(($1)->type!=($3)->type)
          yyerror("Different Type For GREATER Operation Not Allowed");
        child1=new Node();
        child1->name=strdup("TOKEN_GREATER");
        child1->value=strdup(">");
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type='i';
        ($$)->child=$1;
        ($1)->sister=child1;
        child1->sister=$3;
      }
      | EXP TOKEN_GREATEREQUAL EXP
      {
        if(($1)->type!=($3)->type)
          yyerror("Different Type For GREATEREQUAL Operation Not Allowed");
        child1=new Node();
        child1->name=strdup("TOKEN_GREATEREQUAL");
        child1->value=strdup(">=");
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type='i';
        ($$)->child=$1;
        ($1)->sister=child1;
        child1->sister=$3;
      }
      | EXP TOKEN_NOTEQUAL EXP
      {
        if(($1)->type!=($3)->type)
          yyerror("Different Type For NOTEQUAL Operation Not Allowed");
        child1=new Node();
        child1->name=strdup("TOKEN_NOTEQUAL");
        child1->value=strdup("!=");
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type='i';
        ($$)->child=$1;
        ($1)->sister=child1;
        child1->sister=$3;
      }
      | EXP TOKEN_EQUAL EXP
      {
        if(($1)->type!=($3)->type)
          yyerror("Different Type For EQUAL Operation Not Allowed");
        child1=new Node();
        child1->name=strdup("TOKEN_EQUAL");
        child1->value=strdup("==");
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type='i';
        ($$)->child=$1;
        ($1)->sister=child1;
        child1->sister=$3;
      }
      | EXP TOKEN_PLUS EXP
      {
        if(($1)->type!=($3)->type)
          if((($1)->type=='i'&&($3)->type=='c')||(($1)->type=='c'&&($3)->type=='i'));
          else
            yyerror("Different Type For PLUS Operation Not Allowed");
        child1=new Node();
        child1->name=strdup("PLUS");
        child1->value=strdup("+");
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type=($1)->type;
        ($$)->child=$1;
        ($1)->sister=child1;
        child1->sister=$3;
      }
      | EXP TOKEN_MINUS EXP
      {
        if(($1)->type!=($3)->type)
          if((($1)->type=='i'&&($3)->type=='c')||(($1)->type=='c'&&($3)->type=='i'));
          else
            yyerror("Different Type For MINUS Operation Not Allowed");
        if(($1)->type=='s') yyerror("String Type For MINUS Operation Not Allowed");
        child1=new Node();
        child1->name=strdup("TOKEN_MINUS");
        child1->value=strdup("-");
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type=($1)->type;
        ($$)->child=$1;
        ($1)->sister=child1;
        child1->sister=$3;
      }
      | EXP TOKEN_TIMES EXP
      {
        if(($1)->type!=($3)->type)
          if((($1)->type=='i'&&($3)->type=='c')||(($1)->type=='c'&&($3)->type=='i'));
          else
            yyerror("Different Type For TIMES Operation Not Allowed");
        if(($1)->type=='s') yyerror("String Type For TIMES Operation Not Allowed");
        child1=new Node();
        child1->name=strdup("TOKEN_TIMES");
        child1->value=strdup("*");
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type=($1)->type;
        ($$)->child=$1;
        ($1)->sister=child1;
        child1->sister=$3;
      }
      | EXP TOKEN_DIVISION EXP
      {
        if(($1)->type!=($3)->type)
          if((($1)->type=='i'&&($3)->type=='c')||(($1)->type=='c'&&($3)->type=='i'));
          else
            yyerror("Different Type For TIMES Operation Not Allowed");
        if(($1)->type=='s') yyerror("String Type For DIVISION Operation Not Allowed");
        child1=new Node();
        child1->name=strdup("TOKEN_DIVISION");
        child1->value=strdup("/");
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type=($1)->type;
        ($$)->child=$1;
        ($1)->sister=child1;
        child1->sister=$3;
      }
      | EXP TOKEN_LOGICAND EXP
      {
        if(($1)->type!='i'||($3)->type!='i')yyerror("Just Int Type For LOGICAND Operation Allowed");
        child1=new Node();
        child1->name=strdup("TOKEN_LOGICAND");
        child1->value=strdup("&&");
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type=($1)->type;
        ($$)->child=$1;
        ($1)->sister=child1;
        child1->sister=$3;
      }
      | EXP TOKEN_LOGICOR EXP
      {
        if(($1)->type!='i'||($3)->type!='i')yyerror("Just Int Type For LOGICOR Operation Allowed");
        child1=new Node();
        child1->name=strdup("TOKEN_LOGICOR");
        child1->value=strdup("||");
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type=($1)->type;
        ($$)->child=$1;
        ($1)->sister=child1;
        child1->sister=$3;
      }
      | EXP TOKEN_BITWISEOR EXP
      {
        if(($1)->type!='i'||($3)->type!='i')yyerror("Just Int Type For BITWISEOR Operation Allowed");
        child1=new Node();
        child1->name=strdup("TOKEN_BITWISEOR");
        child1->value=strdup("|");
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type=($1)->type;
        ($$)->child=$1;
        ($1)->sister=child1;
        child1->sister=$3;
      }
      | EXP TOKEN_BITWISEAND EXP
      {
        if(($1)->type!='i'||($3)->type!='i')yyerror("Just Int Type For BITWISEAND Operation Allowed");
        child1=new Node();
        child1->name=strdup("TOKEN_BITWISEAND");
        child1->value=strdup("&");
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type=($1)->type;
        ($$)->child=$1;
        ($1)->sister=child1;
        child1->sister=$3;
      }
      | EXP TOKEN_POWER EXP
      {
        if(($3)->type!='i') yyerror("Wrong Power Type");
        if(($1)->type=='s') yyerror("String Type For POWER Operation Not Allowed");
        child1=new Node();
        child1->name=strdup("TOKEN_POWER");
        child1->value=strdup("^");
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type=($1)->type;
        ($$)->child=$1;
        ($1)->sister=child1;
        child1->sister=$3;
      }
      | TOKEN_MINUS EXP
      {
        if(($1)->type=='s') yyerror("String Type For POWER Operation Not Allowed");
        child1=new Node();
        child1->name=strdup("TOKEN_MINUS");
        child1->value=strdup("-");
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type=($2)->type;
        ($$)->child=child1;
        child1->sister=$2;
      }
      | TOKEN_ID TOKEN_LB EXP TOKEN_RB
      {
        child1=new Node();
        child1->name=strdup("TOKEN_ID");
        child1->value=$1;
        child2=new Node();
        child2->name=strdup("TOKEN_LB");
        child2->value=strdup("[");
        child3=new Node();
        child3->name=strdup("TOKEN_RB");
        child3->value=strdup("]");
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type=symbol_type($1,currentScop);
        ($$)->child=child1;
        child1->sister=child2;
        child2->sister=$3;
        ($3)->sister=child3;
      }
      | TOKEN_NOT EXP
      {
        if(($1)->type!='i') yyerror("Just Int Type For POWER Operation Allowed");
        child1=new Node();
        child1->name=strdup("TOKEN_NOT");
        child1->value=strdup("!");
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type=($2)->type;
        ($$)->child=child1;
        child1->sister=$2;
      }
      | TOKEN_LEFTPAREN EXP TOKEN_RIGHTPAREN
      {
        child1=new Node();
        child1->name=strdup("TOKEN_LEFTPAREN");
        child1->value=strdup("(");
        child2=new Node();
        child2->name=strdup("TOKEN_RIGHTPAREN");
        child2->value=strdup(")");
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type=($2)->type;
        ($$)->child=child1;
        child1->sister=$2;
        ($2)->sister=child2;
      }
      | TOKEN_ID
      {
        child1=new Node();
        child1->name=strdup("TOKEN_ID");
        child1->value=$1;
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type=symbol_type($1,currentScop);
        //cout<<"EXP type "<<($$)->name<<endl;
        ($$)->child=child1;
      }
      | TOKEN_INTCONST
      {
        child1=new Node();
        child1->name=strdup("TOKEN_INTCONST");
        child1->value=$1;
        $$=new Node();
        ($$)->name=strdup("EXP");
        //cout<<"EXP name "<<($$)->name<<endl;
        ($$)->type='i';
        ($$)->child=child1;
      }
      | TOKEN_FLOATCONST
      {
        child1=new Node();
        child1->name=strdup("TOKEN_FLOATCONST");
        child1->value=$1;
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type='f';
        ($$)->child=child1;
      }
      | TOKEN_CHARCONST
      {
        child1=new Node();
        child1->name=strdup("TOKEN_CHARCONST");
        child1->value=$1;
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type='c';
        ($$)->child=child1;
      }
      | TOKEN_STRINGCONST
      {
        child1=new Node();
        child1->name=strdup("TOKEN_STRINGCONST");
        child1->value=$1;
        $$=new Node();
        ($$)->name=strdup("EXP");
        ($$)->type='s';
        ($$)->child=child1;
      };

LOOP : TOKEN_LOOP TOKEN_ID{currentScop=currentScop+" "+"loop";add_symbol($2,'i',currentScop);}
        TOKEN_LEFTPAREN EXP TOKEN_UNTIL EXP TOKEN_RIGHTPAREN TOKEN_LCB STMTS {currentScop.erase(currentScop.size()-(string("loop").size()+1),string("loop").size()+1);} TOKEN_RCB
      {
        //cout<<($1)<<endl;
        //cout<<($2)<<endl;
        /* cout<<"hello"<<endl;
        cout<<($5)->name<<endl;
        cout<<"hello2"<<endl; */

        if(($5)->type!='i') yyerror("Wrong Type for Loop. Just INT allowed");
        if(($7)->type!='i') yyerror("Wrong Type for Loop. Just INT allowed");
        child1=new Node();
        child1->name=strdup("TOKEN_LOOP");
        child1->value=strdup("foreach");
        child2=new Node();
        child2->name=strdup("TOKEN_ID");
        child2->type='i';
        child2->value=$2;
        child3=new Node();
        child3->name=strdup("TOKEN_LEFTPAREN");
        child3->value=strdup("(");
        child4=new Node();
        child4->name=strdup("TOKEN_UNTIL");
        child4->value=strdup("..");
        child5=new Node();
        child5->name=strdup("TOKEN_RIGHTPAREN");
        child5->value=strdup(")");
        child6=new Node();
        child6->name=strdup("TOKEN_LCB");
        child6->value=strdup("{");
        child7=new Node();
        child7->name=strdup("TOKEN_RCB");
        child7->value=strdup("}");
        $$=new Node();
        ($$)->name=strdup("LOOP");
        ($$)->child=child1;
        child1->sister=child2;
        child2->sister=child3;
        child3->sister=$5;
        ($5)->sister=child4;
        child4->sister=$7;
        ($7)->sister=child5;
        child5->sister=child6;
        child6->sister=$10;
        ($10)->sister=child7;
      };

CONDITION : TOKEN_IFCONDITION TOKEN_LEFTPAREN EXP TOKEN_RIGHTPAREN{currentScop=currentScop+" "+"if";} SCOPE{currentScop.erase(currentScop.size()-(string("if").size()+1),string("if").size()+1);}
            {
              if(($3)->type!='i') yyerror("Wrong Type for CONDITION. Just INT allowed");
              child1=new Node();
              child1->name=strdup("TOKEN_IFCONDITION");
              child1->value=strdup("if");
              child2=new Node();
              child2->name=strdup("TOKEN_LEFTPAREN");
              child2->value=strdup("(");
              child3=new Node();
              child3->name=strdup("TOKEN_RIGHTPAREN");
              child3->value=strdup(")");
              $$=new Node();
              ($$)->name=strdup("CONDITION");
              ($$)->child=child1;
              child1->sister=child2;
              child2->sister=$3;
              ($3)->sister=child3;
              child3->sister=$6;
            };

SCOPE : TOKEN_LCB STMTS TOKEN_RCB
        {
          child1=new Node();
          child1->name=strdup("TOKEN_LCB");
          child1->value=strdup("{");
          child2=new Node();
          child2->name=strdup("TOKEN_RCB");
          child2->value=strdup("}");
          $$=new Node();
          ($$)->name=strdup("SCOPE");
          ($$)->child=child1;
          child1->sister=$2;
          ($2)->sister=child2;
        }
        | TOKEN_LCB STMTS TOKEN_RCB TOKEN_ELSECONDITION TOKEN_LCB {currentScop.erase(currentScop.size()-(string("if").size()+1),string("if").size()+1);currentScop=currentScop+" "+"else";} STMTS {currentScop.erase(currentScop.size()-(string("else").size()+1),string("else").size()+1);} TOKEN_RCB
        {
          child1=new Node();
          child1->name=strdup("TOKEN_LCB");
          child1->value=strdup("{");
          child2=new Node();
          child2->name=strdup("TOKEN_RCB");
          child2->value=strdup("}");
          child3=new Node();
          child3->name=strdup("TOKEN_ELSECONDITION");
          child3->value=strdup("else");
          child4=new Node();
          child4->name=strdup("TOKEN_LCB");
          child4->value=strdup("{");
          child5=new Node();
          child5->name=strdup("TOKEN_RCB");
          child5->value=strdup("}");
          $$=new Node();
          ($$)->name=strdup("SCOPE");
          ($$)->child=child1;
          child1->sister=$2;
          ($2)->sister=child2;
          child2->sister=child3;
          child3->sister=child4;
          child4->sister=$7;
          ($7)->sister=child5;
        };

STMT_RETURN : TOKEN_RETURN EXP
              {
                child1=new Node();
                child1->name=strdup("TOKEN_RETURN");
                child1->value=strdup("return");
                $$=new Node();
                ($$)->name=strdup("STMT_RETURN");
                ($$)->child=child1;
                child1->sister=$2;
              };

STMT_DECLARE : TYPE TOKEN_ID ARRAY_VAR{hereType=($1)->type;} STMT_DEFINE IDS
              {
                //cout<<"right hand "<<($1)->type<<endl;
                //cout<<"left hand "<<($4)->type<<endl;
                //cout<<"IDS "<<($5)->type<<endl;
                hereType='n';
                add_symbol($2,($1)->type,currentScop);
                //if(($4)->type!='n'&&($1)->type!=($4)->type) yyerror("Wrong Assignment Type");
                //if(($5)->type!='n'&&($1)->type!=($5)->type) yyerror("Wrong Assignment Type");
                child1=new Node();
                child1->name=strdup("TOKEN_ID");
                child1->value=$2;
                $$=new Node();
                ($$)->name=strdup("STMT_DECLARE");
                ($$)->child=$1;
                ($1)->sister=child1;
                child1->sister=$3;
                ($3)->sister=$5;
                ($5)->sister=$6;
              };

ARRAY_VAR : TOKEN_LB EXP TOKEN_RB
            {
              if(($2)->type!='i') yyerror("Wrong Array Index");
              child1=new Node();
              child1->name=strdup("TOKEN_LB");
              child1->value=strdup("[");
              child2=new Node();
              child2->name=strdup("TOKEN_RB");
              child2->value=strdup("]");
              $$=new Node();
              ($$)->name=strdup("ARRAY_VAR");
              ($$)->child=child1;
              child1->sister=$2;
              ($2)->sister=child2;
            }
            | TOKEN_LB TOKEN_RB
            {
              child1=new Node();
              child1->name=strdup("TOKEN_LB");
              child1->value=strdup("[");
              child2=new Node();
              child2->name=strdup("TOKEN_RB");
              child2->value=strdup("]");
              $$=new Node();
              ($$)->name=strdup("ARRAY_VAR");
              ($$)->child=child1;
              child1->sister=child2;
            }
            |/*epsilon*/{$$=new Node();($$)->name=strdup("ARRAY_VAR");}
            ;

STMT_DEFINE  :  TOKEN_ASSIGNOP EXP
              {
                if(($2)->type!=hereType) yyerror("Wrong Assignment Type");
                child1=new Node();
                child1->name=strdup("TOKEN_ASSIGNOP");
                child1->value=strdup("=");
                $$=new Node();
                ($$)->name=strdup("STMT_DEFINE");
                ($$)->child=child1;
                ($$)->type=($2)->type;
                child1->sister=$2;
              }
              |/*epsilon*/{$$=new Node();($$)->name=strdup("STMT_DEFINE");}
              ;

IDS : TOKEN_COMMA TOKEN_ID ARRAY_VAR STMT_DEFINE IDS
      {
        add_symbol($2,hereType,currentScop);
        //if(($4)->type!='n'&&($5)->type!='n'&&($5)->type!=($4)->type) yyerror("Wrong Assignment Type");
        child1=new Node();
        child1->name=strdup("TOKEN_COMMA");
        child1->value=strdup(",");
        child2=new Node();
        child2->name=strdup("TOKEN_ID");
        child2->value=$2;
        $$=new Node();
        ($$)->name=strdup("IDS");
        //if(($4)->type!='n') ($$)->type=($4)->type;
        //if(($5)->type!='n') ($$)->type=($5)->type;
        ($$)->child=child1;
        child1->sister=child2;
        child2->sister=$3;
        ($3)->sister=$4;
        ($4)->sister=$5;
      }
      |/*epsilon*/{$$=new Node();($$)->name=strdup("IDS");}
      ;

CALL : TOKEN_ID TOKEN_LEFTPAREN ARGS TOKEN_RIGHTPAREN
        {
          child1=new Node();
          child1->name=strdup("TOKEN_ID");
          child1->value=$1;
          child2=new Node();
          child2->name=strdup("TOKEN_LEFTPAREN");
          child2->value=strdup("(");
          child3=new Node();
          child3->name=strdup("TOKEN_RIGHTPAREN");
          child3->value=strdup(")");
          $$=new Node();
          ($$)->name=strdup("CALL");
          ($$)->child=child1;
          child1->sister=child2;
          child2->sister=$3;
          ($3)->sister=child3;
        };

ARGS : EXP TOKEN_COMMA EXP TOKEN_COMMA EXP TOKEN_COMMA EXP
      {
        child1=new Node();
        child1->name=strdup("TOKEN_COMMA");
        child1->value=strdup(",");
        child2=new Node();
        child2->name=strdup("TOKEN_COMMA");
        child2->value=strdup(",");
        child3=new Node();
        child3->name=strdup("TOKEN_COMMA");
        child3->value=strdup(",");
        $$=new Node();
        ($$)->name=strdup("ARGS");
        ($$)->child=$1;
        ($1)->sister=child1;
        child1->sister=$3;
        ($3)->sister=child2;
        child2->sister=$5;
        ($5)->sister=child3;
        child3->sister=$7;
      }
       | EXP TOKEN_COMMA EXP TOKEN_COMMA EXP
       {
         child1=new Node();
         child1->name=strdup("TOKEN_COMMA");
         child1->value=strdup(",");
         child2=new Node();
         child2->name=strdup("TOKEN_COMMA");
         child2->value=strdup(",");
         $$=new Node();
         ($$)->name=strdup("ARGS");
         ($$)->child=$1;
         ($1)->sister=child1;
         child1->sister=$3;
         ($3)->sister=child2;
         child2->sister=$5;
       }
       | EXP TOKEN_COMMA EXP
       {
         child1=new Node();
         child1->name=strdup("TOKEN_COMMA");
         child1->value=strdup(",");
         $$=new Node();
         ($$)->name=strdup("ARGS");
         ($$)->child=$1;
         ($1)->sister=child1;
         child1->sister=$3;
       }
       | EXP
       {
         $$=new Node();
         ($$)->name=strdup("ARGS");
         ($$)->child=$1;
       }
       |/*epsilon*/{$$=new Node();($$)->name=strdup("ARGS");}
       ;

STMT_ASSIGN : TOKEN_ID ARRAY_VAR TOKEN_ASSIGNOP EXP
              {
                if(symbol_type($1,currentScop)!=($4)->type) yyerror("Assignment With Different DataType Not Allowed");
                child1=new Node();
                child1->name=strdup("TOKEN_ID");
                child1->value=$1;
                child2=new Node();
                child2->name=strdup("TOKEN_ASSIGNOP");
                child2->value=strdup("=");
                $$=new Node();
                ($$)->name=strdup("STMT_ASSIGN");
                ($$)->child=child1;
                child1->sister=$2;
                ($2)->sister=child2;
                child2->sister=$4;
              };

TYPE : TOKEN_VOIDTYPE
      {
        child1=new Node();
        child1->name=strdup("TOKEN_VOIDTYPE");
        child1->value=strdup("void");
        $$=new Node();
        ($$)->name=strdup("TYPE");
        ($$)->type='v';
        ($$)->child=child1;
      }
       | TOKEN_INTTYPE
       {
         child1=new Node();
         child1->name=strdup("TOKEN_INTTYPE");
         child1->value=strdup("int");
         $$=new Node();
         ($$)->name=strdup("TYPE");
         ($$)->type='i';
         ($$)->child=child1;
       }
       | TOKEN_FLOATTYPE
       {
         child1=new Node();
         child1->name=strdup("TOKEN_FLOATTYPE");
         child1->value=strdup("float");
         $$=new Node();
         ($$)->name=strdup("TYPE");
         ($$)->type='f';
         ($$)->child=child1;
       }
       | TOKEN_STRINGTYPE
       {
         child1=new Node();
         child1->name=strdup("TPKEN_STRINGTYPE");
         child1->value=strdup("string");
         $$=new Node();
         ($$)->name=strdup("TYPE");
         ($$)->type='s';
         ($$)->child=child1;
       }
       | TOKEN_CHARTYPE
       {
         child1=new Node();
         child1->name=strdup("TPKEN_CHARTYPE");
         child1->value=strdup("char");
         $$=new Node();
         ($$)->name=strdup("TYPE");
         ($$)->type='c';
         ($$)->child=child1;
       };

%%

/********Main Function*********/
int main(int argc, char*argv[])
{
  /*Input File*/
  yyin = fopen(argv[2], "r");
	if(yyin == 0){
		cout << "Unable to open the file" << endl;
    return 0;
	}

  //symbol_type(strdup("skdjsk"),"global main loop");
  yyparse();
  preOrder(root,atoi(argv[1]),0);
  cout<<endl;
  return 0;
}

/******Function Definition******/
void yyerror(const char *Message){
  cout<<"Parser Err "<<Message<<" at line "<<yylloc.first_line<<" at column "<<yylloc.first_column<<endl;
  exit(-1);
}

void preOrder(struct Node *node,int PrintByTokenNameMode,int count){
  for(int i=0;i<count;i++) cout<<"\t";
  if(PrintByTokenNameMode)
    cout<<node->name<<" ";
  else{
    if(strstr(node->name,"TOKEN"))
      cout<<node->value<<" ";
    else
      cout<<node->name<<" ";
  }
  cout<<endl;

  if(node->child!=NULL) preOrder(node->child,PrintByTokenNameMode,count+1);
  if(node->sister!=NULL) preOrder(node->sister,PrintByTokenNameMode,count);
  return;
}

char symbol_type(char* symbol,string scope){
  for(int i=0;i<symbols.size();i++)
  {
    if (strcmp(symbol,symbols[i]->symbol)==0&&scope==symbols[i]->scope){
      return symbols[i]->type;
    }
  }
  int m=scope.find_last_of(" ");
  while(m!=-1){
    string newscope=scope.substr(0,m);
    for(int i=0;i<symbols.size();i++)
    {
      string newscope=scope.substr(0,m);
      if (strcmp(symbol,symbols[i]->symbol)==0&&newscope==symbols[i]->scope){
        return symbols[i]->type;
      }
    }
    m=newscope.find_last_of(" ");
  }
}

void add_symbol(char* symbol,char type,string scope){
  //cout<<endl<<scope<<endl;
  struct Symbol *ns=new Symbol();
  ns->symbol=symbol;
  ns->type=type;
  ns->scope=scope;
  symbols.push_back(ns);
}

struct Symbol* search_symbol(char* symbol,string scope){
  for(int i=0;i<symbols.size();i++)
  {
    if (strcmp(symbol,symbols[i]->symbol)==0&&scope==symbols[i]->scope){
      return symbols[i];
    }
  }
  int m=scope.find_last_of(" ");
  while(m!=-1){
    string newscope=scope.substr(0,m);
    for(int i=0;i<symbols.size();i++)
    {
      if (strcmp(symbol,symbols[i]->symbol)==0&&newscope==symbols[i]->scope){
        return symbols[i];
      }
    }
    m=newscope.find_last_of(" ");
  }
}
