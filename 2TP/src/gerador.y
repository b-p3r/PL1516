
%{
#include <stdio.h>
#include <string.h>
int yylex();
int yylineno;

int yyerror(char *s);

	

%}

%union{char * valString; int valNro; char* valID;}

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
| IF '(' Exp ')' '{' InstructionsList '}' 
| IF '(' Exp ')' '{' InstructionsList '}' ELSE '{' InstructionsList '}' 
| WHILE '(' Exp ')' '{' InstructionsList '}' 
| DO'{' InstructionsList '}' WHILE '(' Exp ')' ';'
; 







%%

#include "lex.yy.c"

int yyerror(char * mensagem) {
printf("%d: %s at %s\n", yylineno, mensagem, yytext);
//	printf("Erro Sintático %s\n", mensagem);
	return 0;
}

int main() {
	
	yyparse();
	return 0;
}

