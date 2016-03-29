
%{ #include <stdlib.h> #include <stdio.h> #include <string.h> #include <ctype.h>
#include "../Exercicio2/structures/trie.h"




union {

char autor[64]; int density;

} yyval; 

TRIE * dicionario; int i, ocurrences = 0;

char * str = "Tim Teitelbaum";

void func(const char * original, const char * delim, TRIE *t){ 

const char * src = original;
const char *next = src;
int i;
char * str = calloc(yyleng, sizeof(char));
        
 for(i=0; (next = strstr(src, delim)) != NULL; ) { 
 
 	while(*src==' ')*src++;
	
	while (src != next)
 		str[i++]=*src++;

 while(*str==' ') *src++;        
		//str[i]='\n';
		str[i]='\0';
		printf("%s", str);
		free(str);
		str = calloc(yyleng, sizeof(char));

        //putchar('\n');

  /* Skip the delimiter */ 
  	src += 3;
	i=0;
      }
 
 	while(*src==' ')*src++;
   /* Handle the last token */ 
   while (*src != '\0') 
 	   str[i++]=*src++;

str[i]='\n';
   printf("%s", str);
    										        
		printf("------------------------\n");

} 


%}

%S AUT2 AUT

%%

[ ]*"author"[  ]*"="[  ]*[{"][ ]* {i=0; ocurrences = 0;BEGIN AUT;}




<AUT>[}"]                    {i = 0; BEGIN INITIAL; } 
<AUT>((and)?[ ]*[A-Z]((\.)|([a-z\-]+))[ ]*)+   { char * mycpy;
						if(strstr(yytext, str )){
					        //mycpy = strdup(yytext);
						func(yytext, "and ", dicionario);
						//printf("%s\n", mycpy);



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














