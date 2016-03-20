%{
#include <stdlib.h>
#include <stdio.h>


%}

%S AUT TITLE FIELD
%%

[ ]*"booktitle"[ ]*"="[  ]*[{"]+  {printf("            "); BEGIN FIELD;} 
[ ]*"title"[ ]*"="[  ]*[{"]+      {printf("Título    : "); BEGIN TITLE;}
[ ]*"author"[ ]*"="[  ]*[{"]+     {printf("\nAutor(es) : "); BEGIN AUT;}
[ ]*[a-z]+[ ]*"="[  ]*[{"]+       {printf("            "); BEGIN FIELD;}
<AUT>" and "                      {printf("\n            ");}
<AUT>[}"]                         {printf("\n"); BEGIN INITIAL;}


<AUT>(.|\n)                     {ECHO;}

<TITLE>[ ]*(\n)[ ]*             {printf("\n            ");}
<TITLE>[ ]*                     {printf(" ");}
<TITLE>[}"]                     {printf("\n");BEGIN INITIAL;}
<TITLE>(.|\n)                   {ECHO;}
<FIELD>[}"](\n)[ ]+[}]          {printf("\n\n\n"); BEGIN INITIAL;}
<FIELD>[}"]                     {printf("\n"); BEGIN INITIAL;}
<FIELD>(.|\n)                   {ECHO;}
(.|\n)                          {;}

%%


int yywrap(){ return 1; } 


int main (){


yylex();




return (0); }














