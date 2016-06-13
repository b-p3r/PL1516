%{
 #define _GNU_SOURCE
 #include <string.h>
 #include <stdio.h>
 #include <stdlib.h>
 int yylex();
 int yyerror(char *);
 double vars[26];

 int atoindice(char *s){
  return s[0] -'a';
 }

%}

%union{ 
    double v;
    char *s;
    }

%token <s> var 
%token <s> num 
%type <s> e p f leitura atribuicao escrita
%%

calc :                        {printf("pushn 26\n");}
     | calc leitura '\n'      {printf("%s", $2);}
     | calc atribuicao '\n'   {printf("%s", $2);}
     | calc escrita '\n'      {printf("%s", $2);}
	   | calc '\n'
     ;


leitura    : '?' var      {asprintf(&$$,
                             "read\n atoi\n storeg %d\n",
                             atoindice($2));}
           ;

atribuicao : var '=' e    {asprintf(&$$, "%s storeg %d\n",
                                          $3, atoindice($1));}
           ; 

escrita    : '!' e        {asprintf(&$$, "%s writei\n",
                                              $2);}
           ;


e : p					    {$$ = $1;}
  | e '+' p 			{asprintf(&$$, "%s %s add\n",
                              $1, $3);}
  | e '-' p  			{asprintf(&$$, "%s %s sub\n",
                              $1, $3);}
  ;

p : p '*' f  			{asprintf(&$$, "%s %s mul\n",
                              $1, $3);}
  | p '/' f  			{asprintf(&$$, "%s %s div\n",
                              $1, $3);}
  | f 					  {$$ = $1;}
  ;

f : var           {asprintf(&$$, "pushg %d\n",
                              atoindice($1));}
  | num					  {asprintf(&$$, "pushi %s\n", $1);}
  | '(' e ')'			{$$ = $2;}
  ;



%%

#include "lex.yy.c"

int yyerror(char *s){
    fprintf(stderr, "Erro sintatico: %s (%d)\n", s, yylineno);
    return 0;
}

int main(){
    yyparse();
    return 0;
}