%{
#include <stdio.h>
#include <string.h>
#include "./src/program_status.h"
int yylex();
int yylineno;

ProgramStatus * status;

typedef struct ast_type_inference {

Type type;



};

int yyerror(char *s);

char *  addLabel(){

pushLabelStack(status);
return pushLabel(status);



}
void removeLabel(){

resetLabelStack(status);
popLabelStack(status);

}

%}

%union{char * valString; int valNro; char* valID; Type valType;}

%token <valID>id
%token <valNro>num
%token <valString>string
%token BEGINNING
%token END

%token VAR
%token G
%token L
%token GEQ
%token LEQ
%token EQ
%token NEQ
%token NOT
%token AND
%token OR
%token READ
%token WRITE
%token IF
%token ELSE
%token WHILE
%token DO

//%type<valID>Variable
//%type <valType> Program
//%type<valType>Declarations
//%type<valType>Body
//%type<valType>InstructionsList
//%type<valType>Declaration
//%type<valType>DeclarationsList

%type<valID>Variable

//%type<valType>Atribution
//%type<valType>Instruction
//%type<valType>Else

%type<valType>Constant
%type<valType>Term
%type<valType>ExpAdditiv
%type<valType>ExMultipl
%type<valType>Exp


%%

Program : Declarations Body                   
;
Body : BEGINNING InstructionsList END         
;
Declaration : id                           {printf("pushi 0\n", );}
| id '[' num ']'                           {printf("pushn %d\n", $3 );}   
| id '[' num ']' '[' num ']'               {printf("pushn %d\n", $3*$6 );}   
;
Declarations : VAR DeclarationsList ';'       
;
DeclarationsList : Declaration                
| DeclarationsList ',' Declaration            
;
Variable : id                              {printf("pushg %d\n", 1); 

	                                    $$=integer;}
| id '[' ExpAdditiv ']' SecondDimension {printf("pushgp\npushg %d\npadd\n", 1);
                                           $$=integer;}    
;

SecondDimension : 
		| '[' {printf("pushi %d\n", 20)}
                     
		   ExpAdditiv 
		   
		   ']' {printf("mul\n");
		        printf("add\n");       }
		;

Constant : num  {printf("pushi %d\n", $1)
	         $$=integer;}
         ;
Term : Constant
| Variable                                {$$=$1;}
| '-' Exp                                 {printf("pushi -1\n");      
                                           printf("sub\n");
                                          }
| '(' Exp ')'                             {$$=$2;}                          
| NOT '(' Exp ')'                         {$$=$3;}                          
;


ExMultipl : Term
|  ExMultipl '*' Term                    {printf("mul\n");}  
|  ExMultipl '/' Term                    {printf("div\n");}  
|  ExMultipl '%' Term                    {printf("mod\n");}  
|  ExMultipl AND Term                    {printf("mul\n");}  
;                                             

ExpAdditiv : ExMultipl                   {;}
| ExpAdditiv '+' ExMultipl               {printf("add\n");}  
| ExpAdditiv '-' ExMultipl               {printf("sub\n");}  
| ExpAdditiv OR ExMultipl                {printf("add\n");}  
;                                         
                                          
Exp : ExpAdditiv                         {;}  
|  ExpAdditiv L  ExpAdditiv              {printf("inf\n");}  
|  ExpAdditiv G  ExpAdditiv              {printf("sup\n");}  
|  ExpAdditiv GEQ ExpAdditiv             {printf("supeq\n");}  
|  ExpAdditiv LEQ ExpAdditiv             {printf("infeq\n");}  
|  ExpAdditiv EQ ExpAdditiv              {printf("equal\n");}  
|  ExpAdditiv NEQ ExpAdditiv             {printf("equal\nnot\n");}  
;                                      


Atribution :  Variable '=' ExpAdditiv    {
	                                if($3==matriz||$3==array)
	   				printf("loadn %s\n", $1);
					//getType()
	                                if($1==matriz||$1==array)
	   				printf("storen\n");
				        else	
	   				printf("storeg %s\n", $1);
					
					 }
;


InstructionsList : Instruction
| InstructionsList Instruction  
;


Instruction : Atribution ';'           
| READ  Variable ';'                   {printf("pushi %d\n", 1);}
| WRITE ExpAdditiv ';'                 {printf("writei\n");}   
| WRITE string ';'                     {printf("pushs %s\n", $2);
                                        printf("writes\n");
					}


| IF '('  Exp ')'                      {printf("jz l1level%d\n",addLabel());



}

'{' InstructionsList '}' 
Else                                   {removeLabel();}
| WHILE 	                       { printf("loop%s: nop\t\n", addLabel()); }

'(' Exp ')' 	                       { printf("jz done%d\n", getLabel(status));}




'{' InstructionsList '}'               { printf("jump loop%d\n", getLabel(status)); 
                                         printf("done%d: nop\n", getLabel(status));
			                 removeLabel();
			               }

| DO                                   { printf("loop%s: nop\t\n", addLabel());
                                       }




'{' InstructionsList '}' WHILE '(' Exp ')' ';' { printf("jz loop%s\t\n", getLabel());
                                                 removeLabel();
                                               }
; 

Else :        {  printf("l1level%d: nop\n", getLabel(status)); } 

|             {  printf("jz l2level%d\n", getLabel(status)); 
                 printf("l1level%d: nop\n", getLabel(status));
	      }
ELSE '{' InstructionsList '}' { printf("l2level%s:nop\n", getLabel(status)); }
;





%%

#include "lex.yy.c"

int yyerror(char * mensagem) {
printf("Erro sintático %d: %s em %s\n", yylineno, mensagem, yytext);
	return 0;
}

int main() {

status = init();

pushLabelStack(status);
	yyparse();
popLabel(status);
	return 0;
}

