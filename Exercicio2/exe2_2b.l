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
			       

<AUT>"[\'{a}]"		       {printf("%s", yytext);}
<AUT>"[\'{e}]"		       {printf("%s", yytext);}
<AUT>"[\'{i}]"		       {printf("%s", yytext);}
<AUT>"[\'{o}]"		       {printf("%s", yytext);}
<AUT>"[\'{u}]"		       {printf("%s", yytext);}
<AUT>"[\'{A}]"		       {printf("%s", yytext);}
<AUT>"[\'{E}]"		       {printf("%s", yytext);}
<AUT>"[\'{I}]"		       {printf("%s", yytext);}
<AUT>"[\'{O}]"		       {printf("%s", yytext);}
<AUT>"[\'{U}]"		       {printf("%s", yytext);}
<AUT>"[\`{a}]"		       {printf("%s", yytext);}
<AUT>"[\`{e}]"		       {printf("%s", yytext);}
<AUT>"[\`{i}]"		       {printf("%s", yytext);}
<AUT>"[\`{o}]"		       {printf("%s", yytext);}
<AUT>"[\`{u}]"		       {printf("%s", yytext);}
<AUT>"[\`{A}]"		       {printf("%s", yytext);}
<AUT>"[\`{E}]"		       {printf("%s", yytext);}
<AUT>"[\`{I}]"		       {printf("%s", yytext);}
<AUT>"[\`{O}]"		       {printf("%s", yytext);}
<AUT>"[\`{U}]"		       {printf("%s", yytext);}
<AUT>"[\^{a}]"		       {printf("%s", yytext);}
<AUT>"[\^{e}]"		       {printf("%s", yytext);}
<AUT>"[\^{i}]"		       {printf("%s", yytext);}
<AUT>"[\^{o}]"		       {printf("%s", yytext);}
<AUT>"[\^{u}]"		       {printf("%s", yytext);}
<AUT>"[\^{A}]"		       {printf("%s", yytext);}
<AUT>"[\^{E}]"		       {printf("%s", yytext);}
<AUT>"[\^{I}]"		       {printf("%s", yytext);}
<AUT>"[\^{O}]"		       {printf("%s", yytext);}
<AUT>"[\^{U}]"		       {printf("%s", yytext);}
<AUT>"[\"{a}]"		       {printf("%s", yytext);}
<AUT>"[\"{e}]"		       {printf("%s", yytext);}
<AUT>"[\"{i}]"		       {printf("%s", yytext);}
<AUT>"[\"{o}]"		       {printf("%s", yytext);}
<AUT>"[\"{u}]"		       {printf("%s", yytext);}
<AUT>"[\"{A}]"		       {printf("%s", yytext);}
<AUT>"[\"{E}]"		       {printf("%s", yytext);}
<AUT>"[\"{I}]"		       {printf("%s", yytext);}
<AUT>"[\"{O}]"		       {printf("%s", yytext);}
<AUT>"[\"{U}]"		       {printf("%s", yytext);}
<AUT>"[\~{a}]"		       {printf("%s", yytext);}
<AUT>"[\~{e}]"		       {printf("%s", yytext);}
<AUT>"[\~{o}]"		       {printf("%s", yytext);}
<AUT>"[\~{A}]"		       {printf("%s", yytext);}
<AUT>"[\~{E}]"		       {printf("%s", yytext);}
<AUT>"[\~{O}]"		       {printf("%s", yytext);}
<AUT>"[\c{c}]"		       {printf("%s", yytext);}
<AUT>"[\c{C}]"		       {printf("%s", yytext);}
<AUT>"[\k{a}]"		       {printf("%s", yytext);}
<AUT>"[\k{e}]"		       {printf("%s", yytext);}
<AUT>"[\k{A}]"		       {printf("%s", yytext);}
<AUT>"[\k{E}]"		       {printf("%s", yytext);}
<AUT>"[\H{a}]"		       {printf("%s", yytext);}
<AUT>"[\H{e}]"		       {printf("%s", yytext);}
<AUT>"[\H{i}]"		       {printf("%s", yytext);}
<AUT>"[\H{o}]"		       {printf("%s", yytext);}
<AUT>"[\H{u}]"		       {printf("%s", yytext);}
<AUT>"[\H{A}]"		       {printf("%s", yytext);}
<AUT>"[\H{E}]"		       {printf("%s", yytext);}
<AUT>"[\H{I}]"		       {printf("%s", yytext);}
<AUT>"[\H{O}]"		       {printf("%s", yytext);}
<AUT>"[\H{U}]"		       {printf("%s", yytext);}
<AUT>"[\{oe}]"		       {printf("%s", yytext);}
<AUT>"[\{OE}]"		       {printf("%s", yytext);}
<AUT>"[\{ae}]"		       {printf("%s", yytext);}
<AUT>"[\{AE}]"		       {printf("%s", yytext);}
<AUT>"[\{ss}]"		       {printf("%s", yytext);}
<AUT>"[\{o}]"		       {printf("%s", yytext);}
<AUT>"[\{O}]"		       {printf("%s", yytext);}
<AUT>"[\r{a}]"		       {printf("%s", yytext);}
<AUT>"[\r{e}]"		       {printf("%s", yytext);}
<AUT>"[\r{i}]"		       {printf("%s", yytext);}
<AUT>"[\r{o}]"		       {printf("%s", yytext);}
<AUT>"[\r{u}]"		       {printf("%s", yytext);}
<AUT>"[\r{A}]"		       {printf("%s", yytext);}
<AUT>"[\r{E}]"		       {printf("%s", yytext);}
<AUT>"[\r{I}]"		       {printf("%s", yytext);}
<AUT>"[\r{O}]"		       {printf("%s", yytext);}
<AUT>"[\r{U}]"		       {printf("%s", yytext);}
<AUT>"[\u{a}]"		       {printf("%s", yytext);}
<AUT>"[\u{e}]"		       {printf("%s", yytext);}
<AUT>"[\u{i}]"		       {printf("%s", yytext);}
<AUT>"[\u{o}]"		       {printf("%s", yytext);}
<AUT>"[\u{u}]"		       {printf("%s", yytext);}
<AUT>"[\u{A}]"		       {printf("%s", yytext);}
<AUT>"[\u{E}]"		       {printf("%s", yytext);}
<AUT>"[\u{I}]"		       {printf("%s", yytext);}
<AUT>"[\u{O}]"		       {printf("%s", yytext);}
<AUT>"[\u{U}]"		       {printf("%s", yytext);}
<AUT>"[\v{a}]"		       {printf("%s", yytext);}
<AUT>"[\v{e}]"		       {printf("%s", yytext);}
<AUT>"[\v{i}]"		       {printf("%s", yytext);}
<AUT>"[\v{o}]"		       {printf("%s", yytext);}
<AUT>"[\v{u}]"		       {printf("%s", yytext);}
<AUT>"[\v{A}]"		       {printf("%s", yytext);}
<AUT>"[\v{E}]"		       {printf("%s", yytext);}
<AUT>"[\v{I}]"		       {printf("%s", yytext);}
<AUT>"[\vu{O}]"		       {printf("%s", yytext);}
<AUT>"[\v{U}]"		       {printf("%s", yytext);}
<AUT>"[\{EUR}]"		       {printf("%s", yytext);}
<AUT>"[\{pounds}]"	       {printf("%s", yytext);}
<AUT>"[\.{a}]"		       {printf("%s", yytext);}
<AUT>"[\.{e}]"		       {printf("%s", yytext);}
<AUT>"[\.{i}]"		       {printf("%s", yytext);}
<AUT>"[\.{o}]"		       {printf("%s", yytext);}
<AUT>"[\.{A}]"		       {printf("%s", yytext);}
<AUT>"[\.{E}]"		       {printf("%s", yytext);}
<AUT>"[\.{I}]"		       {printf("%s", yytext);}
<AUT>"[\.{O}]"		       {printf("%s", yytext);}
<AUT>"[\d{a}]"		       {printf("%s", yytext);}
<AUT>"[\d{e}]"		       {printf("%s", yytext);}
<AUT>"[\d{i}]"		       {printf("%s", yytext);}
<AUT>"[\d{o}]"		       {printf("%s", yytext);}
<AUT>"[\d{u}]"		       {printf("%s", yytext);}
<AUT>"[\d{A}]"		       {printf("%s", yytext);}
<AUT>"[\d{E}]"		       {printf("%s", yytext);}
<AUT>"[\d{I}]"		       {printf("%s", yytext);}
<AUT>"[\d{O}]"		       {printf("%s", yytext);}
<AUT>"[\d{U}]"		       {printf("%s", yytext);}
<AUT>"[\={a}]"		       {printf("%s", yytext);}
<AUT>"[\={e}]"		       {printf("%s", yytext);}
<AUT>"[\={i}]"		       {printf("%s", yytext);}
<AUT>"[\={o}]"		       {printf("%s", yytext);}
<AUT>"[\={u}]"		       {printf("%s", yytext);}
<AUT>"[\={A}]"		       {printf("%s", yytext);}
<AUT>"[\={E}]"		       {printf("%s", yytext);}
<AUT>"[\={I}]"		       {printf("%s", yytext);}
<AUT>"[\={O}]"		       {printf("%s", yytext);}
<AUT>"[\={U}]"		       {printf("%s", yytext);}
<AUT>"[\l{}]"		       {printf("%s", yytext);}
<AUT>"[\t{oo}]"		       {printf("%s", yytext);}

<AUT>(.|\n)                     {ECHO;}

<TITLE>[{][A-Z]+[}]		{printf("%s", yytext);}
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














