%{
#include <stdlib.h>
#include <stdio.h>

int state_caller = 0;

%}

%S AUT TITLE FIELD SPEC URL 
%%
[ ]*"organization"[ ]*"="[ ]*[{"] {printf("Organizacao----:\t"); BEGIN FIELD;}
[ ]*"howpublished"[ ]*"="[ ]*[{"] {printf("Pulicado como -:\t"); BEGIN FIELD;}
[ ]*"institution"[ ]*"="[ ]*[{"]  {printf("Instituicao ---:\t"); BEGIN FIELD;}
[ ]*"publisher"[ ]*"="[ ]*[{"]    {printf("Publicacao ----:\t"); BEGIN FIELD;}
[ ]*"booktitle"[ ]*"="[ ]*[{"]    {printf("Titulo do livro:\t"); BEGIN FIELD;}  
[ ]*"journal"[ ]*"="[ ]*[{"]      {printf("Jornal --------:\t"); BEGIN FIELD;}
[ ]*"edition"[ ]*"="[ ]*[{"]      {printf("Edicao --------:\t"); BEGIN FIELD;}
[ ]*"chapter"[ ]*"="[ ]*[{"]      {printf("Capitulo ------:\t"); BEGIN FIELD;}
[ ]*"address"[ ]*"="[ ]*[{"]      {printf("Morada --------:\t"); BEGIN FIELD;}
[ ]*"volume"[ ]*"="[ ]*[{"]       {printf("Volume --------:\t"); BEGIN FIELD;}
[ ]*"series"[ ]*"="[ ]*[{"]       {printf("Serie  --------:\t"); BEGIN FIELD;}
[ ]*"school"[ ]*"="[ ]*[{"]       {printf("Escola --------:\t"); BEGIN FIELD;}
[ ]*"number"[ ]*"="[ ]*[{"]       {printf("Numero --------:\t"); BEGIN FIELD;}
[ ]*"editor"[ ]*"="[ ]*[{"]       {printf("Editor --------:\t"); BEGIN FIELD;}
[ ]*"author"[ ]*"="[ ]*[{"]       {printf("\n\n\n################\n");
				   printf("Autor(es) -----:\t"); BEGIN AUT;}
[ ]*"title"[ ]*"="[ ]*[{"]        {printf("Titulo --------:\t"); BEGIN TITLE;}
[ ]*"pages"[ ]*"="[ ]*[{"]        {printf("Pags ----------:\t"); BEGIN FIELD;}
[ ]*"month"[ ]*"="[ ]*[{"]        {printf("Mes ---------- :\t"); BEGIN FIELD;}
[ ]*"year"[ ]*"="[ ]*[{"]         {printf("Ano ---------- :\t"); BEGIN FIELD;}
[ ]*"type"[ ]*"="[ ]*[{"]         {printf("Tipo ----------:\t"); BEGIN FIELD;}
[ ]*[a-z]+[ ]*"="[ ]*[{"]         {;}
<AUT>[ \t]+"and"[ \t]+            {printf("\n\t\t\t");}
<AUT>[{]                          { state_caller = YYSTATE; BEGIN SPEC;}
<AUT>[}"]                         {printf("\n"); BEGIN INITIAL;}
<AUT>(.|\n)                       {ECHO;}

<TITLE>[ ]{2,}                    {printf(" ");}
<TITLE>[{]                        { state_caller = YYSTATE; BEGIN SPEC;}
<TITLE>[}"]                       {printf("\n");BEGIN INITIAL;}
<TITLE>(.)                        {ECHO;}
<TITLE>(\n)                       {;}


<FIELD>"\\url{"                   { state_caller = YYSTATE; BEGIN SPEC;}
<FIELD>[ ]{2,}                    {printf(" ");}
<FIELD>[{]                        { state_caller = YYSTATE; BEGIN SPEC;}
<FIELD>[}"]                       {printf("\n"); BEGIN INITIAL;}
<FIELD>(.|\n)                     {ECHO;}
<SPEC>[}]                         {BEGIN state_caller;}
<SPEC>(.|\n)                      {ECHO;}


(.|\n)                          {;}

%%


int yywrap(){ return 1; } 


int main (){


yylex();




return (0); }




