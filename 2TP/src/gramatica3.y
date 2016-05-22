%{
/include <stdio.h>
/include <string.h>

	
int conta = 0;
int total = 0;
float soma;
float media;

%}

%union{float valN; char* valNo;}

%token TURMA
%token <valNo>nome
%token <valN>nota
%type <valN>Aluno
%type <valN>Alunos

%%




Program : Declarations Body ;

Body : 'BEGIN' InstructionList 'END';

// Declarações
Declaration : id
            | id '[' num ']'
            | id '[' num ']' '[' num ']' 
	    ;

Declarations : 'VAR' DeclarationsList  
	     ;

DeclarationsList : Declaration ';'
                 | DeclarationsList  ',' Declaration ';'
		 ;


Term  : id
      | num
      | id '[' Exp ']'
      | id '[' Exp ']' '[' Exp ']'
      | '(' Exp ')';

Variable : id
        | id '[' Exp ']'
        | id '[' Exp ']' '[' Exp ']' 
	;
 




// Expressões

/ Expressões Multiplicativas
ExMultipl : Term
          | ExMultipl '*'  Term
          | ExMultipl '/' Term
          | ExMultipl '%' Term
	  ;

/ Expressões Aditivas
ExpAdditiv : ExMultipl 
           | ExpAdditiv '+' ExMultipl
           | ExpAdditiv '-' ExMultipl 
	   ;


/ Expressões Relacionais
ExpRelational : ExpAdditiv
              | '(' ExpAdditiv '>' ExpAdditiv ')'
              | '(' ExpAdditiv '<' ExpAdditiv ')'
              | '(' ExpAdditiv '>''=' ExpAdditiv ')'
              | '(' ExpAdditiv '<''=' ExpAdditiv ')'
              | '(' ExpAdditiv '=''=' ExpAdditiv ')'
              | '(' ExpAdditiv '!''=' ExpAdditiv ')'
	      ;



/ Expressões Negação Lógica
ExpLogicalNOT : NOT ExpRelational;

/ Expressões E Lógico
ExpLogicalAND : ExpLogicalNOT 
            | '(' ExpLogicalAND AND ExpLogicalNOT ')' ;

ExpLogicalOR : ExpRelational
            | ExpLogicalOR 'OR' ExpRelational  ;

/ Expressões OU Lógico
ExpLogic : ExpLogicalAND 
            | ExpLogicalOR;

/ Lista de Expressões
Exp : ExpLogic
            | Exp ExpLogic;


// Fim Expressões

// Instruções
/ Atribuição
Atribution :  Variable '=' Exp ;

Instruction : Atribution ';' 
            | 'READ' Variable ';'
            | 'WRITE' Variable ';'
            | 'WRITE' string ';'
            | 'IF' '(' Exp ')' '{' InstructionsList '}' 
            | 'IF' '(' Exp ')' '{' InstructionsList '}' 'ELSE' '{' InstructionsList '}' 
            | 'WHILE '(' Exp ')' '{' InstructionsList '}' 
            | 'DO''{' InstructionsList '}''WHILE '(' Exp ')' ';' ;

InstructionList : Instruction
            |  InstructionList Instruction;


%%

/include "lex.yy.c"

int yyerror(char * mensagem) {
	printf("Erro Sintático %s\n", mensagem);
	return 0;
}

int main() {
	
	yyparse();
	return 0;
}

