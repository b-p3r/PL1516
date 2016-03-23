
%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
 #include <ctype.h>
#include "../Exercicio2/structures/trie.h"




union {

char autor[64];
int density;

} yyval;


TRIE * dicionario;
int i, ocurrences = 0;

char * str = "Tim Teitelbaum";

%}

%S AUT2 AUT

%%

[ ]*"author"[  ]*"="[  ]*[{"][ ]* {i=0; ocurrences = 0;BEGIN AUT;}




<AUT>[ ]*[}"]                	 {i = 0;
				 BEGIN INITIAL;
				 }
<AUT>((and)?[ ]*[A-Z]((\.)|([a-z\-]+))[ ]*)+   {char *mystr;
                                               int j;
					       char c;
                                               mystr =  strdup(yytext);
                                               if(strstr(mystr, str)){
                         			printf("%s", yytext);

					       }
                                                

				               }



<AUT>(.|\n)                      {;}


(.|\n)                          {;}
%%


int yywrap(){ return 1; } 

int main (){


dicionario = TRIE_init();


yylex();

printf("%d\n", ocurrences);

//TRIE_getAllKeys(dicionario);

return (0); }














