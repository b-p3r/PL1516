
%{
#include <stdlib.h>
#include <stdio.h>
#include "../Exercicio2/structures/simple_hashtable.h"
#define  ARRAY_SIZE  64

char autor[ARRAY_SIZE];
int i = 0;




char * str = "Tim Teitelbaum";

%}

%S AUT AUT2

%%

[ ]*"author"[ ]*"="[ ]*[{"][ ]* {i=0; BEGIN AUT;}


<AUT>[ ]*[}"]                	 { BEGIN INITIAL;}
  /** Dúvidas em relação a esta linha por causa da eficiência **/
<AUT>((and)?[ ]*[A-Z]((\.)|([a-z\-]+))[ ]*)+   {
                                                
                                               if(strstr(yytext, str)){

						yyless(0);

						BEGIN AUT2;
					       }
				               }
<AUT2>[ ]*[}"]                   { autor[i+1]='\0'; 
                                   add_key(strdup(autor));
				   i=0;
			          BEGIN INITIAL;}
<AUT2>[ ]+(and)[ ]+              {
                                  autor[i+1]='\0';
                                  add_key(strdup(autor));
				  i = 0; 
				  }
<AUT2>(.|\n)                     {autor[i++]= yytext[0];
				  
					}
(.|\n)                           {;}
%%


int yywrap(){ return 1; } 

int main (){




yylex();

delete_key(find_key(str);

print_items();

return (0); }














