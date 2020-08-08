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
~$ ./a.out FILE_NAME
------------------------
*Output : Output.asm
*/
%{

  #include <iostream>
  #include <string.h>
	#include <stdlib.h>
	#include <math.h>
  #include <stack>
  #include <vector>
  using namespace std;
  /////////////////////////////////////////////////////////
  /*Function Declaration*/
	extern int yylex();
  void yyerror(const char* Message);
  void PreOrder(struct Node *node, int PrintByTokenNameMode);
  /*Code Generation Section*/
  struct Symbol* search_symbol(char* symbol,string scope);
  void add_symbol(char *symbol, string scope,string reg,char type);

  struct Function* search_function(char* name);
  void add_function(char* name,char outType,int args);

  string AssignRegister(char registerType);
  void FreeRegister(string reg);
  /////////////////////////////////////////////////////////
  /*Global Variables and Structures*/
  extern FILE* yyin;
  FILE* ASM;

  struct Symbol{
    char* symbol;
    char type;
    string scope;
    string reg;
  };

  struct Function{
    char* name;
    char outType;
    int args;
  };
  /*Symbol Table*/
  vector <struct Symbol*> symbols;
  /* Function Table */
  vector <struct Function*> functions;

  string currentScope="global";

  string here;
  char expType='i';

  /*Code Generation Section*/
  /*Temporary Registers*/
  string t_registers[10] = {"$t0","$t1","$t2","$t3","$t4","$t5","$t6","$t7","$t8","$t9"};
  bool t_registers_state[10] = {0};
  /*Saved Values Registers*/
  string s_registers[8] = {"$s0","$s1","$s2","$s3","$s4","$s5","$s6","$s7"};
  bool s_registers_state[8] = {0};
  /*Function Argument Registers*/
  string a_registers[4] = {"$a0","$a1","$a2","$a3"};
  bool a_registers_state[4] = {0};
  /*Return Values Registers*/
  string v_registers[2] = {"$v0","$v1"};
  /* ----Other Registers----
  * $zero = the constant zero
  * $gp = Global Pointer
  * $sp = Stack Pointer
  * $fp = Frame Pointer
  * $ra = Return Address
  * ----MIPS Instruction---
  * R-Type : OP_Code Rd , Rs , Rt ;
  * I-Type : OP_Code Rt , (Immediate-Value) Rs
  * J-Type : OP_Code Word-Address
  *  ----------------------- */
  stack <string> Stack;
  int Label = 0;//used to index labels
  int Loop = 0;//used to index loop_labels
  int Error = 0;/* used to control removing
                output file when we have any
                error but not stoping Parser
                in order to find other errors
                if there is anyone */
  /////////////////////////////////////////////////////////

%}

/*Error Handling*/
%define parse.error verbose
%locations
/********************************/
%union {
        int i_val;
        char* s_val;
        char c_val;
       }

/************Priority************/
%left TOKEN_LCB TOKEN_RCB
%left TOKEN_ASSIGNOP
%left TOKEN_LESSEQUAL TOKEN_GREATEREQUAL TOKEN_LESS TOKEN_GREATER
%left TOKEN_EQUAL TOKEN_NOTEQUAL
%left TOKEN_MINUS TOKEN_PLUS
%left TOKEN_TIMES TOKEN_DIVISION
%left TOKEN_LOGICAND TOKEN_LOGICOR
%left TOKEN_BITWISEAND TOKEN_BITWISEXOR TOKEN_BITWISEOR
%left TOKEN_NOT
%left TOKEN_LEFTPAREN TOKEN_RIGHTPAREN
%left TOKEN_LB TOKEN_RB

/************TOKENS************/
%token <i_val> TOKEN_INTCONST
%token <s_val> TOKEN_ID
%token TOKEN_FLOATCONST
%token TOKEN_CHARCONST
%token TOKEN_STRINGCONST
%token TOKEN_VOIDTYPE /* void */
%token TOKEN_INTTYPE /* int */
%token TOKEN_IFCONDITION /* if */
%token TOKEN_ELSECONDITION /* else */
%token TOKEN_RETURN /* return */
%token TOKEN_LOOP /* foreach */
%token TOKEN_MAINFUNC /* main */
%token TOKEN_DOUBLETYPE /* double */
%token TOKEN_STRINGTYPE /* string */
%token TOKEN_CONTINUESTMT /* continue */
%token TOKEN_FLOATTYPE /* float */
%token TOKEN_CHARTYPE /* char */
%token TOKEN_BREAKSTMT /* break */
%token TOKEN_PRFUNC /* print */
%token TOKEN_ASSIGNOP /* = */
%token TOKEN_PLUS /* + */
%token TOKEN_MINUS /* - */
%token TOKEN_TIMES /* * */
%token TOKEN_DIVISION /* / */
%token TOKEN_BITWISEXOR /* ^ */
%token TOKEN_LESSEQUAL /* <= */
%token TOKEN_GREATEREQUAL /* >= */
%token TOKEN_LESS /* < */
%token TOKEN_GREATER /* > */
%token TOKEN_EQUAL /* == */
%token TOKEN_NOTEQUAL /* != */
%token TOKEN_NOT /* ! */
%token TOKEN_LOGICAND /* && */
%token TOKEN_BITWISEAND /* & */
%token TOKEN_LOGICOR /* || */
%token TOKEN_BITWISEOR /* | */
%token TOKEN_LEFTPAREN /* ( */
%token TOKEN_RIGHTPAREN /* ) */
%token TOKEN_RCB /* } */
%token TOKEN_LCB /* { */
%token TOKEN_SEMICOLON /* ; */
%token TOKEN_COMMA /* , */
%token TOKEN_UNTIL /* .. */
%token TOKEN_LB /* [ */
%token TOKEN_RB /* ] */

/********NON-TERMINALS*********/
%nterm <i_val>  F_ARG
%nterm <i_val> EXP
%nterm <i_val> ARGS
%nterm <c_val> TYPE
%nterm PROGRAM
%nterm GLOBAL_DECLARE
%nterm PGM
%nterm ARG
%nterm STMTS
%nterm STMT
%nterm PRINTFUNC
%nterm LOOP
%nterm CONDITION
%nterm SCOPE
%nterm STMT_RETURN
%nterm STMT_VAR_DECLARE
%nterm STMT_ARRAY_DECLARE
%nterm CALL
%nterm STMT_VAR_ASSIGN
%nterm STMT_ARRAY_ASSIGN
%start PROGRAM

/********Grammar Rules*********/
%%

PROGRAM : GLOBAL_DECLARE PGM ;

GLOBAL_DECLARE : GLOBAL_DECLARE TYPE TOKEN_ID TOKEN_ASSIGNOP EXP TOKEN_SEMICOLON
                 {
                    add_symbol($3,currentScope,AssignRegister('s'),$2);
                    /*Code Generation*/
                    ASM = fopen("Output.asm", "a+");
                    string Rt = Stack.top();
                    Stack.pop();
                    if(Rt[0]!='$')
                    	fprintf(ASM,"\taddi %s,$zero,%s\n", (search_symbol($3,currentScope)->reg).c_str(), Rt.c_str());
                    else{
                    	fprintf(ASM,"\tmove %s,%s\n", (search_symbol($3,currentScope)->reg).c_str(), Rt.c_str());
                    	if(Rt[1] == 't')
                    		FreeRegister(Rt);
                    }
                    fclose(ASM);
                 }
                 |/*epsilon*/{}
                 ;

PGM : TYPE TOKEN_ID
      {
        here=string($2);
        /*Code Generation*/
        currentScope=currentScope+" "+string($2);
        ASM = fopen("Output.asm", "a+");
        fprintf(ASM,"%s:\n\taddi $sp,$sp,-32\n", $2);
				for(int i=0; i<=7; i++)
					fprintf(ASM,"\tsw $s%d, %d($sp)\n", i, i*4);
  			fclose(ASM);
      }
      TOKEN_LEFTPAREN F_ARG TOKEN_RIGHTPAREN TOKEN_LCB
      {
        add_function($2,$1,$5);
      }
      STMTS TOKEN_RCB{
        currentScope.erase(currentScope.size()-(string($2).size()+1),string($2).size()+1);
        /* Code Generation */
        ASM = fopen("Output.asm", "a+");
        for(int i=0; i<=7; i++)
          fprintf(ASM,"\tlw $s%d,%d($sp)\n", i, i*4);
        fprintf(ASM,"\taddi $sp,$sp,32\n");
        fprintf(ASM,"\tjr $ra\n");
        fclose(ASM);
        here="";
      }
      PGM
      | TOKEN_INTTYPE TOKEN_MAINFUNC {
        ASM = fopen("Output.asm", "a+");
        fprintf(ASM,"main:\n");
        fclose(ASM);
        here="main";
      }
      TOKEN_LEFTPAREN TOKEN_RIGHTPAREN TOKEN_LCB {currentScope=currentScope+" "+"main";} STMTS
      {
        currentScope.erase(currentScope.size()-(string("main").size()+1),string("main").size()+1);
        /*Code Generation*/
        ASM = fopen("Output.asm", "a+");
        fprintf(ASM,"\tli %s,10\n\tsyscall\n",v_registers[0].c_str());
        fclose(ASM);
      }
      TOKEN_RCB;

F_ARG : ARG TOKEN_COMMA ARG TOKEN_COMMA ARG TOKEN_COMMA ARG{($$)=4;}
        | ARG TOKEN_COMMA ARG TOKEN_COMMA ARG{($$)=3;}
        | ARG TOKEN_COMMA ARG{($$)=2;}
        | ARG{($$)=1;}
        | /*epsilon*/{($$)=0;}
        ;

ARG : TYPE TOKEN_ID
      {
        add_symbol($2,currentScope,AssignRegister('s'),$1);
      };

STMTS : STMT STMTS
        | /*epsilon*/{}
        ;

STMT : STMT_VAR_DECLARE TOKEN_SEMICOLON
       | STMT_ARRAY_DECLARE TOKEN_SEMICOLON
       | STMT_ARRAY_ASSIGN TOKEN_SEMICOLON
       | STMT_VAR_ASSIGN TOKEN_SEMICOLON
       | STMT_RETURN TOKEN_SEMICOLON
       | LOOP
       | CONDITION
       | CALL TOKEN_SEMICOLON
       | EXP TOKEN_SEMICOLON
       | PRINTFUNC TOKEN_SEMICOLON
       ;

PRINTFUNC : TOKEN_PRFUNC TOKEN_LEFTPAREN EXP TOKEN_RIGHTPAREN
            {
              /*Code Generation*/
              ASM = fopen("Output.asm", "a+");
              string Rt = Stack.top();
              Stack.pop();
              if(currentScope!="global main"){
        				fprintf(ASM,"\taddi $sp,$sp,-4\n");
        				fprintf(ASM,"\tsw %s,0($sp)\n", a_registers[0].c_str());
              }
              if(Rt[0]!='$')
                fprintf(ASM,"\taddi %s,$zero,%s\n", a_registers[0].c_str(), Rt.c_str());
              else
        				fprintf(ASM,"\tmove %s,%s\n", a_registers[0].c_str(), Rt.c_str());
        			fprintf(ASM,"\tli %s,1\n\tsyscall\n",v_registers[0].c_str());
        			if(currentScope!="global main"){
        				fprintf(ASM,"\tlw %s,0($sp)\n",a_registers[0].c_str());
        				fprintf(ASM,"\taddi $sp,$sp,4\n");
        			}
              fclose(ASM);
            };

EXP : EXP TOKEN_LESS EXP
      {
        /*Code Generation*/
        ASM = fopen("Output.asm", "a+");
        ($$) = $1<$3 ? 1 : 0;
  			string Rt = Stack.top();
        Stack.pop();
  			string Rs = Stack.top();
        Stack.pop();
        string Rd = AssignRegister('t');
  			if(Rs[0]!='$' && Rt[0]!='$')
  				fprintf(ASM,"\taddi %s,$zero,%d\n", Rd.c_str(),stoi(Rs)<stoi(Rt));
  			else if(Rs[0]!='$'){
  				fprintf(ASM,"\taddi %s,$zero,%s\n", Rd.c_str(), Rs.c_str());
  				fprintf(ASM,"\tslt %s,%s,%s\n", Rd.c_str(), Rd.c_str(), Rt.c_str());
  			}
  			else if(Rt[0]!='$')
  				fprintf(ASM,"\tslti %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
  			else
  				fprintf(ASM,"\tslt %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
  			fclose(ASM);
  			Stack.push(Rd);
      }
      | EXP TOKEN_LESSEQUAL EXP
      {
        /*Code Generation*/
        ASM = fopen("Output.asm", "a+");
        ($$) = $1<=$3 ? 1 : 0;
  			string Rt = Stack.top();
        Stack.pop();
  			string Rs = Stack.top();
        Stack.pop();
        string Rd = AssignRegister('t');
  			if(Rs[0]!='$' && Rt[0]!='$')
  				fprintf(ASM,"\taddi %s,$zero,%d\n", Rd.c_str(),stoi(Rs)<=stoi(Rt));
  			else if(Rs[0]!='$'){
  				fprintf(ASM,"\taddi %s,$zero,%s\n", Rd.c_str(), Rs.c_str());
  				fprintf(ASM,"\tslt %s,%s,%s\n", Rd.c_str(), Rd.c_str(), Rt.c_str());
  			}
  			else if(Rt[0]!='$')
  				fprintf(ASM,"\tslti %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
  			else
  				fprintf(ASM,"\tslt %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
        fprintf(ASM,"\txori %s,%s,1\n", Rd.c_str(), Rd.c_str());
  			fclose(ASM);
  			Stack.push(Rd);
      }
      | EXP TOKEN_GREATER EXP
      {
        /*Code Generation*/
        ASM = fopen("Output.asm", "a+");
        ($$) = $1>$3 ? 1 : 0;
  			string Rt = Stack.top();
        Stack.pop();
  			string Rs = Stack.top();
        Stack.pop();
        string Rd = AssignRegister('t');
  			if(Rs[0]!='$' && Rt[0]!='$')
  				fprintf(ASM,"\taddi %s,$zero,%d\n", Rd.c_str(),stoi(Rs)>stoi(Rt));
  			else if(Rs[0]!='$')
          fprintf(ASM,"\tslti %s,%s,%s\n", Rd.c_str(), Rt.c_str(), Rs.c_str());
  			else if(Rt[0]!='$'){
          fprintf(ASM,"\taddi %s,$zero,%s\n", Rd.c_str(), Rt.c_str());
  				fprintf(ASM,"\tslt %s,%s,%s\n", Rd.c_str(), Rd.c_str(), Rs.c_str());
        }
  			else
  				fprintf(ASM,"\tslt %s,%s,%s\n", Rd.c_str(), Rt.c_str(), Rs.c_str());
  			fclose(ASM);
  			Stack.push(Rd);
      }
      | EXP TOKEN_GREATEREQUAL EXP
      {
        /*Code Generation*/
        ASM = fopen("Output.asm", "a+");
        ($$) = $1>=$3 ? 1 : 0;
  			string Rt = Stack.top();
        Stack.pop();
  			string Rs = Stack.top();
        Stack.pop();
        string Rd = AssignRegister('t');
  			if(Rs[0]!='$' && Rt[0]!='$')
  				fprintf(ASM,"\taddi %s,$zero,%d\n", Rd.c_str(),stoi(Rs)>=stoi(Rt));
  			else if(Rs[0]!='$'){
          fprintf(ASM,"\taddi %s,$zero,%s\n", Rd.c_str(), Rs.c_str());
  				fprintf(ASM,"\tslt %s,%s,%s\n", Rd.c_str(), Rd.c_str(), Rt.c_str());
        }
        else if(Rt[0]!='$')
          fprintf(ASM,"\tslti %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
  			else
  				fprintf(ASM,"\tslt %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
        fprintf(ASM,"\txori %s,%s,1\n", Rd.c_str(), Rd.c_str());
  			fclose(ASM);
  			Stack.push(Rd);
      }
      | EXP TOKEN_NOTEQUAL EXP
      {
        /*Code Generation*/
        ASM = fopen("Output.asm", "a+");
        ($$) = $1!=$3 ? 1 : 0;
  			string Rt = Stack.top();
        Stack.pop();
  			string Rs = Stack.top();
        Stack.pop();
        string Rd1 = AssignRegister('t');
        string Rd2 = AssignRegister('t');
  			if(Rs[0]!='$' && Rt[0]!='$')
  				fprintf(ASM,"\taddi %s,$zero,%d\n", Rd1.c_str(),stoi(Rs)!=stoi(Rt));
  			else if(Rs[0]!='$'){
          fprintf(ASM,"\taddi %s,$zero,%s\n", Rd1.c_str(), Rs.c_str());
  				fprintf(ASM,"\tslt %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rt.c_str());
          fprintf(ASM,"\tslti %s,%s,%s\n", Rd2.c_str(), Rt.c_str(), Rs.c_str());
  				fprintf(ASM,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
        }
        else if(Rt[0]!='$'){
          fprintf(ASM,"\taddi %s,$zero,%s\n", Rd2.c_str(), Rt.c_str());
  				fprintf(ASM,"\tslt %s,%s,%s\n", Rd2.c_str(), Rd2.c_str(), Rs.c_str());
  				fprintf(ASM,"\tslti %s,%s,%s\n", Rd1.c_str(), Rs.c_str(), Rt.c_str());
  				fprintf(ASM,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
        }
  			else{
  				fprintf(ASM,"\tslt %s,%s,%s\n", Rd1.c_str(), Rs.c_str(), Rt.c_str());
  				fprintf(ASM,"\tslt %s,%s,%s\n", Rd2.c_str(), Rt.c_str(), Rs.c_str());
  				fprintf(ASM,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  			}
        FreeRegister(Rd2);
        if(Rs[1] == 't')
  					FreeRegister(Rs);
  			if(Rt[1] == 't')
  					FreeRegister(Rt);
  			fclose(ASM);
  			Stack.push(Rd1);
      }
      | EXP TOKEN_EQUAL EXP
      {
        /*Code Generation*/
        ASM = fopen("Output.asm", "a+");
        ($$) = $1==$3 ? 1 : 0;
  			string Rt = Stack.top();
        Stack.pop();
  			string Rs = Stack.top();
        Stack.pop();
        string Rd1 = AssignRegister('t');
        string Rd2 = AssignRegister('t');
  			if(Rs[0]!='$' && Rt[0]!='$')
  				fprintf(ASM,"\taddi %s,$zero,%d\n", Rd1.c_str(),stoi(Rs)==stoi(Rt));
  			else if(Rs[0]!='$'){
          fprintf(ASM,"\taddi %s,$zero,%s\n", Rd1.c_str(), Rs.c_str());
  				fprintf(ASM,"\tslt %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rt.c_str());
          fprintf(ASM,"\tslti %s,%s,%s\n", Rd2.c_str(), Rt.c_str(), Rs.c_str());
  				fprintf(ASM,"\txor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
        }
        else if(Rt[0]!='$'){
          fprintf(ASM,"\taddi %s,$zero,%s\n", Rd2.c_str(), Rt.c_str());
  				fprintf(ASM,"\tslt %s,%s,%s\n", Rd2.c_str(), Rd2.c_str(), Rs.c_str());
  				fprintf(ASM,"\tslti %s,%s,%s\n", Rd1.c_str(), Rs.c_str(), Rt.c_str());
  				fprintf(ASM,"\txor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
        }
  			else{
  				fprintf(ASM,"\tslt %s,%s,%s\n", Rd1.c_str(), Rs.c_str(), Rt.c_str());
  				fprintf(ASM,"\tslt %s,%s,%s\n", Rd2.c_str(), Rt.c_str(), Rs.c_str());
  				fprintf(ASM,"\txor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  			}
        FreeRegister(Rd2);
        if(Rs[1] == 't')
  					FreeRegister(Rs);
  			if(Rt[1] == 't')
  					FreeRegister(Rt);
  			fclose(ASM);
  			Stack.push(Rd1);
      }
      | EXP TOKEN_PLUS EXP
      {
        /*Code Generation*/
        ASM = fopen("Output.asm", "a+");
        ($$)= $1 + $3;
  			string Rt = Stack.top();
        Stack.pop();
        //cout<<Rt<<endl;
  			string Rs = Stack.top();
        Stack.pop();
        //cout<<Rt<<endl;
        string Rd = AssignRegister('t');
  			if(Rs[0]!='$' && Rt[0]!='$')
  				fprintf(ASM,"\taddi %s,$zero,%d\n", Rd.c_str(),stoi(Rs)+stoi(Rt));
  			else if(Rs[0]!='$')
          fprintf(ASM,"\taddi %s,%s,%s\n", Rd.c_str(), Rt.c_str(), Rs.c_str());
        else if(Rt[0]!='$')
          fprintf(ASM,"\taddi %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
  			else
          fprintf(ASM,"\tadd %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
        if(Rs[1] == 't')
  					FreeRegister(Rs);
  			if(Rt[1] == 't')
  					FreeRegister(Rt);
  			fclose(ASM);
  			Stack.push(Rd);
      }
      | EXP TOKEN_MINUS EXP
      {
        /*Code Generation*/
        ASM = fopen("Output.asm", "a+");
        ($$) = $1 - $3;
  			string Rt = Stack.top();
        Stack.pop();
  			string Rs = Stack.top();
        Stack.pop();
        string Rd = AssignRegister('t');
  			if(Rs[0]!='$' && Rt[0]!='$')
  				fprintf(ASM,"\taddi %s,$zero,%d\n", Rd.c_str(),stoi(Rs)-stoi(Rt));
  			else if(Rs[0]!='$'){
          fprintf(ASM,"\tsub %s,$zero,%s", Rd.c_str(),Rt.c_str());
          fprintf(ASM,"\taddi %s,%s,%s\n", Rd.c_str(), Rd.c_str(), Rs.c_str());
        }
        else if(Rt[0]!='$')
          fprintf(ASM,"\taddi %s,%s,-%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
  			else
          fprintf(ASM,"\tsub %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
        if(Rs[1] == 't')
  					FreeRegister(Rs);
  			if(Rt[1] == 't')
  					FreeRegister(Rt);
  			fclose(ASM);
  			Stack.push(Rd);
      }
      | EXP TOKEN_TIMES EXP
      {
        /*Code Generation*/
        ASM = fopen("Output.asm", "a+");
        ($$) = $1 * $3;
  			string Rt = Stack.top();
        Stack.pop();
  			string Rs = Stack.top();
        Stack.pop();
        string Rd = AssignRegister('t');
  			if(Rs[0]!='$' && Rt[0]!='$')
  				fprintf(ASM,"\taddi %s,$zero,%d\n", Rd.c_str(),stoi(Rs)*stoi(Rt));
  			else if(Rs[0]!='$'){
          fprintf(ASM,"\taddi %s,$zero,%s", Rd.c_str(),Rs.c_str());
          fprintf(ASM,"\tmul %s,%s,%s\n", Rd.c_str(), Rd.c_str(), Rt.c_str());
        }
        else if(Rt[0]!='$'){
          fprintf(ASM,"\taddi %s,$zero,%s", Rd.c_str(),Rt.c_str());
          fprintf(ASM,"\tmul %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
        }
  			else
          fprintf(ASM,"\tmul %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
        if(Rs[1] == 't')
  					FreeRegister(Rs);
  			if(Rt[1] == 't')
  					FreeRegister(Rt);
  			fclose(ASM);
  			Stack.push(Rd);
      }
      | EXP TOKEN_DIVISION EXP
      {
        /*Code Generation*/
        ASM = fopen("Output.asm", "a+");
        ($$)= $1 / $3;
  			string Rt = Stack.top();
        Stack.pop();
  			string Rs = Stack.top();
        Stack.pop();
        string Rd = AssignRegister('t');
        if($3==0 || Rs[1]=='s' || Rt[1]=='s') cout<<"divide by zero on line "<<yylloc.first_line<<" column "<<yylloc.first_column<<endl;
  			if(Rs[0]!='$' && Rt[0]!='$')
  				fprintf(ASM,"\taddi %s,$zero,%d\n", Rd.c_str(),stoi(Rs)/stoi(Rt));
  			else if(Rs[0]!='$'){
          fprintf(ASM,"\taddi %s,$zero,%s", Rd.c_str(),Rs.c_str());
          fprintf(ASM,"\tdiv %s,%s,%s\n", Rd.c_str(), Rd.c_str(), Rt.c_str());
        }
        else if(Rt[0]!='$'){
          fprintf(ASM,"\taddi %s,$zero,%s", Rd.c_str(),Rt.c_str());
          fprintf(ASM,"\tdiv %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
        }
  			else
          fprintf(ASM,"\tdiv %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
        if(Rs[1] == 't')
  					FreeRegister(Rs);
  			if(Rt[1] == 't')
  					FreeRegister(Rt);
  			fclose(ASM);
  			Stack.push(Rd);
      }
      | EXP TOKEN_LOGICAND EXP
      {
        /*Code Generation*/
        ASM = fopen("Output.asm", "a+");
        ($$) = $1 && $3 ? 1 : 0;
  			string Rt = Stack.top();
        Stack.pop();
  			string Rs = Stack.top();
        Stack.pop();
        string Rd1 = AssignRegister('t');
        string Rd2 = AssignRegister('t');
  			if(Rs[0]!='$' && Rt[0]!='$')
  				fprintf(ASM,"\taddi %s,$zero,%d\n", Rd1.c_str(),stoi(Rs)&&stoi(Rt));
  			else if(Rs[0]!='$'){
          fprintf(ASM,"\tslti %s,$zero,%s\n", Rd1.c_str(), Rs.c_str());
  				fprintf(ASM,"\taddi %s,$zero,%s\n", Rd2.c_str(), Rs.c_str());
  				fprintf(ASM,"\tslt %s,%s,$zero\n", Rd2.c_str(), Rd2.c_str());
  				fprintf(ASM,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  				Label++;
  				fprintf(ASM,"\tbeq %s,$zero L%d\n", Rd1.c_str(), Label);
  				fprintf(ASM,"\tslt %s,$zero %s\n", Rd1.c_str(), Rt.c_str());
  				fprintf(ASM,"\tslt %s,%s,$ero\n", Rd2.c_str(), Rt.c_str());
  				fprintf(ASM,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  				fprintf(ASM,"\tL%d:\n", Label);
        }
        else if(Rt[0]!='$'){
          fprintf(ASM,"\tslt %s,$zero,%s\n", Rd1.c_str(), Rs.c_str());
  				fprintf(ASM,"\tslt %s,%s,$zero\n", Rd2.c_str(), Rs.c_str());
  				fprintf(ASM,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  				Label++;
  				fprintf(ASM,"\tbeq %s,$zero,L%d\n", Rd1.c_str(), Label);
  				fprintf(ASM,"\tslti %s,$zero,%s\n", Rd1.c_str(), Rt.c_str());
  				fprintf(ASM,"\taddi %s,$zero,%s\n", Rd2.c_str(), Rt.c_str());
  				fprintf(ASM,"\tslt %s,%s,$zero\n", Rd2.c_str(), Rd2.c_str());
  				fprintf(ASM,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  				fprintf(ASM,"\tL%d:\n",Label);
        }
  			else{
          fprintf(ASM,"\tslt %s,$zero,%s\n", Rd1.c_str(), Rs.c_str());
  				fprintf(ASM,"\tslt %s,%s,$zero \n", Rd1.c_str(), Rs.c_str());
  				fprintf(ASM,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd1.c_str());
  				Label++;
  				fprintf(ASM,"\tbeq %s,$zero,L%d\n", Rd1.c_str(), Label);
  				fprintf(ASM,"\tslt %s,$zero,%s\n", Rd1.c_str(), Rt.c_str());
  				fprintf(ASM,"\tslt %s,%s,$zero\n", Rd1.c_str(), Rt.c_str());
  				fprintf(ASM,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  				fprintf(ASM,"\tL%d:\n", Label);
        }
        FreeRegister(Rd2);
        if(Rs[1] == 't')
  					FreeRegister(Rs);
  			if(Rt[1] == 't')
  					FreeRegister(Rt);
  			fclose(ASM);
  			Stack.push(Rd1);
      }
      | EXP TOKEN_LOGICOR EXP
      {
        /*Code Generation*/
        ASM = fopen("Output.asm", "a+");
        ($$) = $1 || $3 ?1:0;
  			string Rt = Stack.top();
        Stack.pop();
  			string Rs = Stack.top();
        Stack.pop();
        string Rd1 = AssignRegister('t');
        string Rd2 = AssignRegister('t');
  			if(Rs[0]!='$' && Rt[0]!='$')
  				fprintf(ASM,"\taddi %s,$zero,%d\n", Rd1.c_str(),stoi(Rs)||stoi(Rt));
  			else if(Rs[0]!='$'){
          fprintf(ASM,"\tslti %s,$zero,%s\n", Rd1.c_str(), Rs.c_str());
  				fprintf(ASM,"\taddi %s,$zero,%s\n", Rd2.c_str(), Rs.c_str());
  				fprintf(ASM,"\tslt %s,%s,$zero\n", Rd2.c_str(), Rd2.c_str());
  				fprintf(ASM,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  				Label++;
          fprintf(ASM,"\taddi %s,$zero,1\n", Rd2.c_str());
  				fprintf(ASM,"\tbeq %s,%s L%d\n", Rd2.c_str(), Rd1.c_str(), Label);
  				fprintf(ASM,"\tslt %s,$zero %s\n", Rd1.c_str(), Rt.c_str());
  				fprintf(ASM,"\tslt %s,%s,$ero\n", Rd2.c_str(), Rt.c_str());
  				fprintf(ASM,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  				fprintf(ASM,"\tL%d:\n", Label);
        }
        else if(Rt[0]!='$'){
          fprintf(ASM,"\tslt %s,$zero,%s\n", Rd1.c_str(), Rs.c_str());
  				fprintf(ASM,"\tslt %s,%s,$zero\n", Rd2.c_str(), Rs.c_str());
  				fprintf(ASM,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  				Label++;
          fprintf(ASM,"\taddi %s,$zero,1\n",Rd2.c_str());
  				fprintf(ASM,"\tbeq %s,%s,L%d\n", Rd2.c_str(), Rd1.c_str(), Label);
  				fprintf(ASM,"\tslti %s,$zero,%s\n", Rd1.c_str(), Rt.c_str());
  				fprintf(ASM,"\taddi %s,$zero,%s\n", Rd2.c_str(), Rt.c_str());
  				fprintf(ASM,"\tslt %s,%s,$zero\n", Rd2.c_str(), Rd2.c_str());
  				fprintf(ASM,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  				fprintf(ASM,"\tL%d:\n",Label);
        }
  			else{
          fprintf(ASM,"\tslt %s,$zero,%s\n", Rd1.c_str(), Rs.c_str());
  				fprintf(ASM,"\tslt %s,%s,$zero \n", Rd2.c_str(), Rs.c_str());
  				fprintf(ASM,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  				Label++;
          fprintf(ASM,"\taddi %s,$zero,1\n", Rd2.c_str());
  				fprintf(ASM,"\tbeq %s,%s,L%d\n", Rd2.c_str(), Rd1.c_str(), Label);
  				fprintf(ASM,"\tslt %s,$zero,%s\n", Rd1.c_str(), Rt.c_str());
  				fprintf(ASM,"\tslt %s,%s,$zero\n", Rd2.c_str(), Rt.c_str());
  				fprintf(ASM,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  				fprintf(ASM,"\tL%d:\n", Label);
        }
        FreeRegister(Rd2);
        if(Rs[1] == 't')
  					FreeRegister(Rs);
  			if(Rt[1] == 't')
  					FreeRegister(Rt);
  			fclose(ASM);
  			Stack.push(Rd1);
      }
      | EXP TOKEN_BITWISEOR EXP
      {
        /*Code Generation*/
        ASM = fopen("Output.asm", "a+");
        ($$) = $1 | $3;
  			string Rt = Stack.top();
        Stack.pop();
  			string Rs = Stack.top();
        Stack.pop();
        string Rd = AssignRegister('t');
  			if(Rs[0]!='$' && Rt[0]!='$')
  				fprintf(ASM,"\tori %s,$zero,%d\n", Rd.c_str(), stoi(Rs)|stoi(Rt));
  			else if(Rs[0]!='$')
          fprintf(ASM,"\tori %s,%s,%s\n", Rd.c_str(), Rt.c_str(), Rs.c_str());
        else if(Rt[0]!='$')
          fprintf(ASM,"\tori %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
  			else
          fprintf(ASM,"\tor %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
        FreeRegister(Rd);
        if(Rs[1] == 't')
  					FreeRegister(Rs);
  			if(Rt[1] == 't')
  					FreeRegister(Rt);
  			fclose(ASM);
  			Stack.push(Rd);
      }
      | EXP TOKEN_BITWISEAND EXP
      {
        /*Code Generation*/
        ASM = fopen("Output.asm", "a+");
        ($$)= $1 & $3;
  			string Rt = Stack.top();
        Stack.pop();
  			string Rs = Stack.top();
        Stack.pop();
        string Rd = AssignRegister('t');
  			if(Rs[0]!='$' && Rt[0]!='$')
  				fprintf(ASM,"\tandi %s,$zero,%d\n", Rd.c_str(), stoi(Rs)&stoi(Rt));
  			else if(Rs[0]!='$')
          fprintf(ASM,"\tandi %s,%s,%s\n", Rd.c_str(), Rt.c_str(), Rs.c_str());
        else if(Rt[0]!='$')
          fprintf(ASM,"\tandi %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
  			else
          fprintf(ASM,"\tand %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
        FreeRegister(Rd);
        if(Rs[1] == 't')
  					FreeRegister(Rs);
  			if(Rt[1] == 't')
  					FreeRegister(Rt);
  			fclose(ASM);
  			Stack.push(Rd);
      }
      | EXP TOKEN_BITWISEXOR EXP
      {
        /*Code Generation*/
        ASM = fopen("Output.asm", "a+");
        ($$)= $1 ^ $3;
  			string Rt = Stack.top();
        Stack.pop();
  			string Rs = Stack.top();
        Stack.pop();
        string Rd = AssignRegister('t');
  			if(Rs[0]!='$' && Rt[0]!='$')
  				fprintf(ASM,"\txori %s,$zero,%d\n", Rd.c_str(), stoi(Rs)&stoi(Rt));
  			else if(Rs[0]!='$')
          fprintf(ASM,"\txori %s,%s,%s\n", Rd.c_str(), Rt.c_str(), Rs.c_str());
        else if(Rt[0]!='$')
          fprintf(ASM,"\txori %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
  			else
          fprintf(ASM,"\txor %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
        FreeRegister(Rd);
        if(Rs[1] == 't')
  					FreeRegister(Rs);
  			if(Rt[1] == 't')
  					FreeRegister(Rt);
  			fclose(ASM);
  			Stack.push(Rd);
      }
      | TOKEN_MINUS EXP
      {
        /*Code Generation*/
        ($$) = -$2;
  			string Rs = Stack.top();
        Stack.pop();
        if(Rs[0]!='$')
          Stack.push("-"+to_string($2));
  			else{
  				string Rd = AssignRegister('t');
  				ASM = fopen("Output.asm", "a+");
  				fprintf(ASM,"\tsub %s,$zero,%s\n", Rd.c_str(), Rs.c_str());
          fclose(ASM);
    			Stack.push(Rd);
  			}
      }
      | TOKEN_ID TOKEN_LB EXP TOKEN_RB
      {
        /*Code Generation*/
  			string Rs = Stack.top();
        Stack.pop();
        string Rd = AssignRegister('t');
        struct Symbol* Rt=search_symbol($1,currentScope);//search $1 in lookup table and assign int to variable Struct Symbol *Rt
        if(Rt == NULL){
  				string message = "undefined array " + string($1);
  				yyerror(message.c_str());
  			}
  			else{
  				ASM = fopen("Output.asm", "a+");
  				if(Rs[0]!='$')
  					fprintf(ASM,"\tlw %s,%d(%s)\n", Rd.c_str(), stoi(Rs)*4, (Rt->reg).c_str());
  				else{
  					fprintf(ASM,"\tsll %s,%s,2\n", Rd.c_str(), Rs.c_str());
  					fprintf(ASM,"\tadd %s,%s,%s\n", Rd.c_str(), Rd.c_str(), (Rt->reg).c_str());
  					fprintf(ASM,"\tlw %s,0(%s)\n", Rd.c_str(), Rd.c_str());
  				}
          fclose(ASM);
    			Stack.push(Rd);
  			}
      }
      | TOKEN_NOT EXP
      {
        /*Code Generation*/
        ($$) = !$2;
  			string Rs = Stack.top();
        Stack.pop();
        if(Rs[0]!='$'){
  				if(Rs[0]!='$' == 0)
  					Stack.push("1");
  				else
  					Stack.push("0");
        }
        else{
          string Rd1 = AssignRegister('t');
          string Rd2 = AssignRegister('t');
  				ASM = fopen("Output.asm", "a+");
  				fprintf(ASM,"\tslt %s,$zero,%s\n", Rd1.c_str(), Rs.c_str());
  				fprintf(ASM,"\tslt %s,%s,$zero\n", Rd2.c_str(), Rs.c_str());
  				fprintf(ASM,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  				fprintf(ASM,"\txori %s,%s,1\n", Rd1.c_str(), Rd1.c_str());
  				FreeRegister(Rd2);
  				if(Rs[1] == 't')
  					FreeRegister(Rs);
          fclose(ASM);
    			Stack.push(Rd1);
  			}
      }
      | TOKEN_LEFTPAREN EXP TOKEN_RIGHTPAREN
      {
        /*Code Generation*/
        ($$) = $2;
      }
      | TOKEN_ID
      {
        /*Code Generation*/
        struct Symbol* Rs=search_symbol($1,currentScope);
        if(Rs != NULL);
					//($$) = strdup(Rs->symbol);
				else
				{
					string message = "undefined variable "+string($1);
					yyerror(message.c_str());
				}
				Stack.push(Rs->reg);
        expType=Rs->type;
        //cout<<$1<<endl;
      }
      | TOKEN_INTCONST
      {
        /*Code Generation*/
        ($$) = $1;
        Stack.push(to_string($1));
        //cout<<$1<<endl;
        expType='i';
      }
      | TOKEN_FLOATCONST {}
      | TOKEN_CHARCONST {}
      | TOKEN_STRINGCONST {};

LOOP : TOKEN_LOOP TOKEN_ID {currentScope=currentScope+" "+"loop";}
       TOKEN_LEFTPAREN EXP TOKEN_UNTIL EXP
       {
         /* cout<<$7<<endl;
         cout<<"here"<<endl; */
         //cout<<search_symbol($2,currentScope)->reg;
         /*Code Generation*/
         string Rt = Stack.top();
         //cout<<Rt<<endl;
         Stack.pop();
         string Rs = Stack.top();
         //cout<<Rs<<endl;
         Stack.pop();
         /* cout<<"here2"<<endl;
         cout<<search_symbol($2,currentScope)->reg<<endl;
         cout<<"here3"<<endl; */
         if(search_symbol($2,currentScope)==NULL)yyerror(strdup("undefined variable"));

         ASM = fopen("Output.asm", "a+");
         fprintf(ASM,"\taddi %s,$zero,%s\n", (search_symbol($2,currentScope)->reg).c_str(), Rs.c_str());

         // Generation of LOOP Label
         Loop++;
         fprintf(ASM,"LOOP%d:\n", Loop);

         string Rd = AssignRegister('t');
         fprintf(ASM,"\taddi %s,$zero,%s\n", Rd.c_str(), Rt.c_str());
         fprintf(ASM,"\tslt %s,%s,%s\n", Rd.c_str(), Rd.c_str(), (search_symbol($2,currentScope)->reg).c_str());
         fprintf(ASM,"\txori %s,%s,1\n", Rd.c_str(), Rd.c_str());
         Label++;
   		   fprintf(ASM,"\tbeq %s,$zero,L%d\n", Rd.c_str(), Label);
         fclose(ASM);
         Stack.push(Rd);
         //cout<<"end of here\n";
       }
       TOKEN_RIGHTPAREN TOKEN_LCB STMTS TOKEN_RCB
       {
         //cout<<"here\n";
        currentScope.erase(currentScope.size()-(string("loop").size()+1),string("loop").size()+1);
        /*Code Generation*/
        ASM = fopen("Output.asm", "a+");
        string Rd = Stack.top();
        Stack.pop();
        //search for loop-counter in symbol-table
        fprintf(ASM,"\taddi %s,%s,1\n", Rd.c_str(), (search_symbol($2,currentScope)->reg).c_str());
        fprintf(ASM,"\tmove %s,%s\n", (search_symbol($2,currentScope)->reg).c_str(), Rd.c_str());
        fprintf(ASM,"\tj LOOP%d\n", Loop);
  	    fprintf(ASM,"L%d:\n", Label);
        fclose(ASM);
        //cout<<"end of here2\n";
      };

CONDITION : TOKEN_IFCONDITION TOKEN_LEFTPAREN EXP
            {
              currentScope=currentScope+" "+"if";
              /*Code Generation*/
              string Rd = Stack.top();
              Stack.pop();
              Label++;
              ASM = fopen("Output.asm", "a+");
        			fprintf(ASM,"\tbeq %s,$zero,L%d\n", Rd.c_str(), Label);
              fclose(ASM);
            }
            TOKEN_RIGHTPAREN SCOPE
            {
              currentScope.erase(currentScope.size()-(string("if").size()+1),string("if").size()+1);
            };

SCOPE : TOKEN_LCB STMTS TOKEN_RCB
        {
          /*Code Generation*/
          ASM = fopen("Output.asm", "a+");
          fprintf(ASM,"\tL%d:\n", Label);
          fclose(ASM);
        }
        | TOKEN_LCB STMTS TOKEN_RCB TOKEN_ELSECONDITION
        {
          currentScope.erase(currentScope.size()-(string("if").size()+1),string("if").size()+1);
          currentScope=currentScope+" "+"else";
          /*Code Generation*/
          Label++;
          ASM = fopen("Output.asm", "a+");
          fprintf(ASM,"\tj L%d\n", Label);
          fprintf(ASM,"\tL%d:\n", Label-1);
          fclose(ASM);
        }
        TOKEN_LCB STMTS TOKEN_RCB
        {
          currentScope.erase(currentScope.size()-(string("else").size()+1),string("else").size()+1);
          /*Code Generation*/
          ASM = fopen("Output.asm", "a+");
          fprintf(ASM,"\tL%d : \n", Label);
          fclose(ASM);
        };

STMT_VAR_DECLARE : TYPE TOKEN_ID TOKEN_ASSIGNOP EXP
                  {
                    add_symbol($2,currentScope,AssignRegister('s'),$1);

                    /*Code Generation*/
                    string Rs=Stack.top();
                    Stack.pop();
                    ASM = fopen("Output.asm", "a+");
              			if(Rs[0]!='$')
              				fprintf(ASM,"\taddi %s,$zero,%s\n", (search_symbol($2,currentScope)->reg).c_str(), Rs.c_str());
              			else{
              				fprintf(ASM,"\tmove %s,%s\n", (search_symbol($2,currentScope)->reg).c_str(), Rs.c_str());
              				if(Rs[1] == 't')
              					FreeRegister(Rs);
              			}
              			fclose(ASM);
                  }
                  | TYPE TOKEN_ID
                  {
                    add_symbol($2,currentScope,AssignRegister('s'),$1);
                  }
                  | TYPE TOKEN_ID TOKEN_ASSIGNOP TOKEN_ID TOKEN_LEFTPAREN ARGS TOKEN_RIGHTPAREN
                  {

                    string variable_reg = AssignRegister('s');
                    add_symbol($2,currentScope,variable_reg,$1);

                    /*Code Generation*/
                    struct Function *func = search_function($4);
                    ASM = fopen("Output.asm", "a+");
                    if(func==NULL) yyerror(strdup("undefined function"));
                    else if(func->outType!='i') yyerror(strdup("void function can not be assigned to something"));
                    else {
                      if(func->args != $6) yyerror(strdup("the number of arguments does not match"));
                      else{
                        ASM = fopen("Output.asm", "a+");
                        string arguments[4];
                        for(int i=$6-1 ; i>=0 ; i--){
                          arguments[i] = Stack.top();
                          Stack.pop();
                        }
                        for(int i=0; i<$6; i++){
                          if(arguments[i][0]!='$')
                            fprintf(ASM,"\taddi $a%d,$zero,%s\n",i, arguments[i].c_str());
                          else
                            fprintf(ASM,"\tmove $a%d,%s\n",i, arguments[i].c_str());
                        }
                       fprintf(ASM,"\tjal %s\n", $4);
                       fprintf(ASM,"\tmove %s,$v0\n", variable_reg.c_str());
                      fclose(ASM);
                      }
                    }
                  };

STMT_ARRAY_DECLARE : TYPE TOKEN_ID TOKEN_LB EXP TOKEN_RB
                     {
                        add_symbol($2,currentScope,AssignRegister('s'),$1);

                        string Rs=Stack.top();
                        Stack.pop();
                        ASM = fopen("Output.asm", "a+");
                        if(currentScope!="global main"){
                          fprintf(ASM,"\taddi $sp,$sp,-4\n");
                          fprintf(ASM,"\tsw $a0,0($sp)\n");
                        }
                        if(Rs[0]!='$')
                          fprintf(ASM,"\taddi $a0,$zero,%d\n", stoi(Rs)*4);
                        else{
                          fprintf(ASM,"\tsll $a0,%s,2\n", Rs.c_str());
                          if(Rs[1] == 't')
                            FreeRegister(Rs);
                        }
                        fprintf(ASM,"\tli $v0,9\n\tsyscall\n");
                        fprintf(ASM,"\tmove %s,$v0\n", (search_symbol($2,currentScope)->reg).c_str());
                        if(currentScope!="global main"){
                          fprintf(ASM,"\tlw $a0,0($sp)\n");
                          fprintf(ASM,"\taddi $sp,$sp,4\n");
                        }
                        fclose(ASM);
                      };

CALL : TOKEN_ID TOKEN_LEFTPAREN ARGS TOKEN_RIGHTPAREN
       {
         /*Code Generation*/
         struct Function* func = search_function($1);
         if(func==NULL) yyerror(strdup("undefined function"));
         else {
           if(func->args != $3) yyerror(strdup("the number of arguments does not match"));
           else{
             ASM = fopen("Output.asm", "a+");
             string arguments[4];
             for(int i=$3-1 ; i>=0 ; i--){
               arguments[i] = Stack.top();
               Stack.pop();
             }
             for(int i=0; i<$3; i++){
   						if(arguments[i][0]!='$')
   							fprintf(ASM,"\taddi $a%d,$zero,%s\n",i, arguments[i].c_str());
   						else
   							fprintf(ASM,"\tmove $a%d,%s\n",i, arguments[i].c_str());
   					}
            fprintf(ASM,"\tjal %s\n", $1);
  					fclose(ASM);
           }
         }
       }
       | TOKEN_ID TOKEN_ASSIGNOP TOKEN_ID TOKEN_LEFTPAREN ARGS TOKEN_RIGHTPAREN
       {
         /*Code Generation*/
         struct Function *func = search_function($3);
         struct Symbol *variable = search_symbol($1,currentScope);
         if(func==NULL) yyerror(strdup("undefined function"));
         else if(func->outType!='i') yyerror(strdup("void function can not be assigned to something"));
         else if(variable==NULL) yyerror(strdup("undefined variable"));
         else {
           if(func->args != $5) yyerror(strdup("the number of arguments does not match"));
           else{
             ASM = fopen("Output.asm", "a+");
             string arguments[4];
             for(int i=$5-1 ; i>=0 ; i--){
               arguments[i] = Stack.top();
               Stack.pop();
             }
             for(int i=0; i<$5; i++){
   						if(arguments[i][0]!='$')
   							fprintf(ASM,"\taddi $a%d,$zero,%s\n",i, arguments[i].c_str());
   						else
   							fprintf(ASM,"\tmove $a%d,%s\n",i, arguments[i].c_str());
   					}
            fprintf(ASM,"\tjal %s\n", $3);
            fprintf(ASM,"\tmove %s,$v0\n", (variable->reg).c_str());
  					fclose(ASM);
           }
         }
       };

ARGS : EXP TOKEN_COMMA EXP TOKEN_COMMA EXP TOKEN_COMMA EXP{($$)=4;}
       | EXP TOKEN_COMMA EXP TOKEN_COMMA EXP{($$)=3;}
       | EXP TOKEN_COMMA EXP{($$)=2;}
       | EXP{($$)=1;}
       |/*epsilon*/{($$)=0;}
       ;

STMT_RETURN : TOKEN_RETURN EXP{
              string Rs=Stack.top();
              Stack.pop();
              if(search_function(strdup(here.c_str()))->outType!=expType) yyerror(strdup("wrong return type"));

              string Rv = "$v0";


              ASM = fopen("Output.asm", "a+");

              if(Rs[0]!='$')
              fprintf(ASM, "\taddi %s, $zero, %s \n",Rv.c_str() , Rs.c_str());
              else{
                fprintf(ASM, "\tmove %s, %s \n",Rv.c_str(), Rs.c_str());
                if(Rs[1] == 't')
                FreeRegister(Rs);
              }
              fclose(ASM);
            };

STMT_VAR_ASSIGN : TOKEN_ID TOKEN_ASSIGNOP EXP
              {
                //cout<<"here"<<endl;
                  struct Symbol* Rt=search_symbol($1,currentScope);
                  if(Rt==NULL) yyerror(strdup("undefined variable"));

                  string Rs = Stack.top();
                  Stack.pop();

                  ASM = fopen("Output.asm", "a+");

                  if(Rs[0]!='$')
                    fprintf(ASM, "\taddi %s, $zero, %s \n", (Rt->reg).c_str(), Rs.c_str());
                  else{
                    fprintf(ASM, "\tmove %s, %s \n", (Rt->reg).c_str(), Rs.c_str());
                    if(Rs[1] == 't')
                      FreeRegister(Rs);
                  }

                  fclose(ASM);
              };

STMT_ARRAY_ASSIGN :TOKEN_ID TOKEN_LB EXP TOKEN_RB TOKEN_ASSIGNOP EXP
                  {
                    struct Symbol* Rs=search_symbol($1,currentScope);
              			if(Rs == NULL){
              			     yyerror(strdup("undefined array"));
              			}
              			else{
              				ASM = fopen("Output.asm", "a+");
                      string Rd1=Stack.top();
                      Stack.pop();
              				string Rd2=Stack.top();
                      Stack.pop();
              				string Rt1=AssignRegister('t');
                      string Rt2=AssignRegister('t');
              				if(Rd1[0]!='$' && Rd2[0]!='$'){
              					fprintf(ASM, "\taddi %s, $zero , %s\n", Rt1.c_str(), Rd2.c_str());
              					fprintf(ASM, "\tsw %s, %d(%s)\n", Rt1.c_str(), stoi(Rd1)*4,(search_symbol($1,currentScope)->reg).c_str() );
              				}
              				else if(Rd1[0]!='$' ){
              					fprintf(ASM, "\tsw %s, %d(%s)\n", Rd2.c_str(), stoi(Rd1)*4,(search_symbol($1,currentScope)->reg).c_str() );
              				}
              				else if(Rd2[0]!='$'){
              					fprintf(ASM, "\tsll %s, %s , 2\n", Rt1.c_str(), Rd1.c_str());
              					fprintf(ASM, "\tadd %s, %s , %s\n", Rt1.c_str(), Rt1.c_str(), (search_symbol($1,currentScope)->reg).c_str());
              					fprintf(ASM, "\taddi %s, $zero , %s\n", Rt2.c_str(), Rd2.c_str());
              					fprintf(ASM, "\tsw %s, 0(%s)\n", Rt2.c_str(), Rt1.c_str());
              				}
              				else{
              					fprintf(ASM, "\tsll %s, %s , 2\n", Rt1.c_str(), Rd1.c_str());
              					fprintf(ASM, "\tadd %s, %s , %s\n", Rt1.c_str(), Rt1.c_str(), (search_symbol($1,currentScope)->reg).c_str());
              					fprintf(ASM, "\tsw %s, 0(%s)\n", Rd2.c_str(), Rt1.c_str());
              				}
              				FreeRegister(Rt1);
              				FreeRegister(Rt2);
              				fclose(ASM);
              			}
                  };

TYPE : TOKEN_VOIDTYPE
       {
          ($$)='v';
       }
       | TOKEN_INTTYPE
       {
         ($$)='i';
       }
       /* clear other type for type clash warning */
       ;

%%

/********Main Function*********/
int main(int argc, char*argv[])
{
  /*Input File*/
  yyin = fopen(argv[1], "r");
	if(yyin == 0){
		cout << "Unable to open the file" << endl;
    return 0;
	}

  /*Output File*/
  ASM = fopen("Output.asm", "w");
	if(ASM == 0){
    cout << "Unable to create the output file" << endl;
    return 0;
	}
	else{
		fprintf(ASM,".data\n\tbackn: .asciiz \"\\n\" \n.text\n.globl main\n");
		fclose(ASM);
	}

  yyparse();

  //whether to remove output file or not
  if(Error){
    fclose(ASM);
    remove("Output.asm");
    return 0;
  }
  fclose(ASM);
  return 0;
}

/******Function Definition******/
void yyerror(const char *Message){
  cout<<"Error on line "<<yylloc.first_line<<" column "<<yylloc.first_column<< " : "<<Message<<endl;
  remove("Output.asm");
  Error++;
  exit(-1);
}

void add_symbol(char* symbol,string scope,string reg,char type){
  struct Symbol *ns=new Symbol();
  ns->symbol=symbol;
  ns->scope=scope;
  ns->reg=reg;
  ns->type=type;
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
  return NULL;
}

struct Function* search_function(char* name){
  for(int i=0;i<functions.size();i++)
    if(strcmp(name,functions[i]->name)==0)
      return functions[i];
  return NULL;
}

void add_function(char* name,char outType,int args){
  struct Function* nf=new Function();
  nf->name=name;
  nf->outType=outType;
  nf->args=args;
  functions.push_back(nf);
}

/*Code Generation Section*/
string AssignRegister(char registerType){
  // registerType : 't','s','a'
  switch(registerType){
		case 't':
				for(int i=0; i<=9; i++)
					if(t_registers_state[i] == 0)
						{t_registers_state[i] = 1;return "$t"+to_string(i);}
				break;
		case 's':
				for(int i=0; i<=7; i++)
					if(s_registers_state[i] == 0)
						{s_registers_state[i] = 1;return "$s"+to_string(i);}
				break;
		case 'a':
				for(int i=0; i<=3; i++)
					if(a_registers_state[i] == 0)
						{a_registers_state[i] = 1;return "$a"+to_string(i);}
				break;
	}
  return "$";
}

void FreeRegister(string reg){
  // reg ~ '$t0'
  switch(reg[1]){
		case 't':
			t_registers_state[reg[2]-'0'] = 0;
			break;
		case 's':
			s_registers_state[reg[2]-'0'] = 0;
			break;
		case 'a':
			a_registers_state[reg[2]-'0'] = 0;
			break;
	}
}
