
%{
#include <stdlib.h>
#include <stdio.h>
#include "../Exercicio2/structures/trie.h"
#define  ARRAY_SIZE  64

char autor[ARRAY_SIZE];
int i = 0;



TRIE * dicionario;

//char * str = "Tim Teitelbaum";

char * str;
%}

%S AUT AUT2

%%

[ ]*"author"[ ]*"="[ ]*[{"][ ]* {i=0; BEGIN AUT;}


<AUT>[ ]*[}"]                	 { BEGIN INITIAL;}
  /** Duvidas em relacao a esta linha por causa da eficiencia **/
<AUT>((and)?[ ]*[A-Z]((\.)|([a-z\-]+))[ ]*)+   {
                                                
                                               if(strstr(yytext, str)){

						yyless(0);

						BEGIN AUT2;
					       }
				               }
<AUT2>[ ]*[}"]                   { autor[i+1]='\0'; 
                                   TRIE_insert(dicionario, strdup(autor));
				   i=0;
			          BEGIN INITIAL;}
<AUT2>[ ]+(and)[ ]+              {
                                  autor[i+1]='\0';
                                  TRIE_insert(dicionario, strdup(autor));
				  i = 0; 
				  }
<AUT2>(.|\n)                     {autor[i++]= yytext[0];
				  
					}
(.|\n)                           {;}
%%


int yywrap(){ return 1; } 

int main (int argc, char *argv[]){

if(argv[1]==NULL)
return -1;

str = argv[1];
dicionario = TRIE_init();

printf("strict digraph G {\n");
printf("  ratio=fill;\n");
printf("  size=\"7.5,10\"\n");
printf("  center=true;\n");
printf("  rankdir=LR;\n");


yylex();
if(TRIE_getTotalKeys(dicionario))
TRIE_getAllKeys_GRAPH(dicionario, str);

printf("}\n");


return (0); }














