%{
#include <stdlib.h>
#include <stdio.h>


%}

%S AUT CHAV
%%

[ ]*"="[ ]*[{"]+               {printf(" = {");  BEGIN CHAV;}
["][ ]*","[ ]*                 {printf("}, ");   BEGIN CHAV;}
["][ ]*("\n")?[ ]*[}][ ]*      {printf("}\n} "); BEGIN CHAV;}
[ ]*"author"[  ]*"="[  ]*[{"]+ {printf("    author = {"); BEGIN AUT;}
<AUT>" and "                   {printf(", ");}
<AUT>[}"]                      {printf("\n"); BEGIN INITIAL;}


<AUT>([A-Z]\.)                 {printf("%c.", yytext[0]);}
<AUT>([ ]|[-])+[A-Z][A-Za-z]+        {printf("%s", yytext);}
<AUT>[A-Z][A-Za-z]+            {printf("%c.", yytext[0]);}

<CHAV>(.|\n)                   {ECHO;BEGIN INITIAL;}
(.|\n)                         {ECHO;}

%%


int yywrap(){ return 1; } 


int main (){


yylex();




return (0); }














