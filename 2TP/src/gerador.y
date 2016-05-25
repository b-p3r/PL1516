
%{
#include <stdio.h>
#include <string.h>

	

%}

%union{float valN; char* valNo;}

%token id
%token num
%token string
%token BEGIN
%token END

%token VAR
%token TURMA
%token NOT
%token AND
%token OR
%token READ
%token WRITE
%token IF
%token ELSE
%token WHILE
%token DO
%token <valNo>nome
%token <valN>nota
//%type <valN>Aluno
//%type <valN>Alunos

%%

Program : Declarations Body 
;
Body : BEGIN InstructionsList END
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
| NOT Exp
;
Variable : id
| id '[' ExpAdditiv ']'
| id '[' ExpAdditiv ']' '[' ExpAdditiv ']' 
;
ExMultipl : Term
| ExMultipl '*'  Term
| ExMultipl '/' Term
| ExMultipl '%' Term
| ExMultipl AND Term
;
ExpAdditiv : ExMultipl 
| ExpAdditiv '+' ExMultipl
| ExpAdditiv '-' ExMultipl 
| ExpAdditiv OR ExMultipl 
;

Exp : ExpAdditiv             
| '(' ExpAdditiv '>'  ExpAdditiv ')'
| '(' ExpAdditiv '<'  ExpAdditiv ')'
| '(' ExpAdditiv '>''=' ExpAdditiv ')'
| '(' ExpAdditiv '<''=' ExpAdditiv ')'
| '(' ExpAdditiv '=''=' ExpAdditiv ')'
| '(' ExpAdditiv '!''=' ExpAdditiv ')'
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
	printf("Erro Sintático %s\n", mensagem);
	return 0;
}

int main() {
	
	yyparse();
	return 0;
}

