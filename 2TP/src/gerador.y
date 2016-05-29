
%{
#include <stdio.h>
#include <string.h>
#include "./src/program_status.h"
int yylex();
int yylineno;

int yyerror(char *s);
int stack[ 1024 ];
int sp = 0, str = 0;
char * auxstr;
char label[ 1024 ];

%}

%union{char * valString; int valNro; char* valID; int valType;}

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

//%type <valType>


%%

Program : Declarations Body 
;
Body : BEGINNING InstructionsList END
;
Declaration : id
| id '[' num ']'
| id '[' num ']' '[' num ']' 
;
Declarations : VAR DeclarationsList ';' 
;
DeclarationsList : Declaration 
| DeclarationsList ',' Declaration 
;
Term : id
| num
| id '[' ExpAdditiv ']'
| id '[' ExpAdditiv ']' '[' ExpAdditiv ']'
| '(' Exp ')'
| NOT '(' Exp ')'
;
Variable : id
| id '[' ExpAdditiv ']'
| id '[' ExpAdditiv ']' '[' ExpAdditiv ']' 
;
ExMultipl : Term
|  ExMultipl '*' Term   
|  ExMultipl '/' Term  
|  ExMultipl '%' Term  
|  ExMultipl AND Term  
;
ExpAdditiv : ExMultipl 
| ExpAdditiv '+' ExMultipl
| ExpAdditiv '-' ExMultipl 
| ExpAdditiv OR ExMultipl 
;

Exp : ExpAdditiv             
|  ExpAdditiv L  ExpAdditiv 
|  ExpAdditiv G  ExpAdditiv 
|  ExpAdditiv GEQ ExpAdditiv
|  ExpAdditiv LEQ ExpAdditiv
|  ExpAdditiv EQ ExpAdditiv 
|  ExpAdditiv NEQ ExpAdditiv
;


Atribution :  Variable '=' ExpAdditiv 
;
InstructionsList : Instruction
| InstructionsList Instruction  
;
Instruction : Atribution ';' 
| READ  Variable ';'
| WRITE ExpAdditiv ';'                      
| WRITE string ';'
| IF 

{
sp++;



stack[sp-1]++;
char buffer[10];
snprintf(buffer, 10, "%d", stack[sp-1]);
strcpy(label+ str, buffer);
printf("ifLabel%s\t\n", label);
str++;


}

'('  Exp ')' '{' InstructionsList '}' 
Else
{

str--;
label[str+1]='\0';

printf("ifLabelEnd-%s\t:NOP\n", label);


stack[sp] = 0;
sp--;

}

| WHILE {printf("Ola");}'(' Exp ')' '{' InstructionsList '}' 
| DO'{' InstructionsList '}' WHILE '(' Exp ')' ';'
; 

Else : 
| 
{printf("jz L2\n");} ELSE '{' InstructionsList '}' {printf("L2:NOP\n");}
;





%%

#include "lex.yy.c"

int yyerror(char * mensagem) {
printf("Erro sintático %d: %s em %s\n", yylineno, mensagem, yytext);
	return 0;
}

int main() {
int i;
for(i = 0; i < 1024; stack[i++]=0);
sp++;
	yyparse();
sp--;
	return 0;
}

