/*Turmas e Notas de Alunos*/

%{
#include <stdio.h>
#include <string.h>

	
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


Turma : TURMA nome ';' Alunos {printf("Média da Turma %s: %.1f\n", $2,($4/total));}
      ;

Alunos : Aluno 			      {total = 1; $$ = $1;}
	   | Alunos ';' Aluno 	  {total++; $$ = $1 + $3;}
	   ;

Aluno : nome '(' Notas ')'	  {media = soma/conta; printf("Nota de %s: %.1f\n", $1,media); $$ = media;}
      ;

Notas : nota 			      {conta = 1; soma = $1;}
	  | Notas ',' nota 	      {conta++; soma+=$3;}
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
