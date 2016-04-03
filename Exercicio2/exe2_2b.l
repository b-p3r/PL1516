%{
#include <stdlib.h>
#include <stdio.h>

int state_caller = 0;

%}

%S AUT TITLE FIELD SPEC 
%%
[ ]*[Oo][Rr][Gg][Aa][Nn][Ii][Zz][Aa][Tt][Ii][Oo][Nn][ ]*"="[ ]*[{"]  {printf("Organizacao----:\t"); BEGIN FIELD;}
[ ]*[Hh][Oo][Ww][Pp][Uu][Bb][Ll][Ii][Ss][Hh][Ee][Dd][ ]*"="[ ]*[{"]  {printf("Pulicado como -:\t"); BEGIN FIELD;}
[ ]*[Ii][Nn][Ss][Tt][Ii][Tt][Uu][Tt][Ii][Oo][Nn][ ]*"="[ ]*[{"]  {printf("Instituicao ---:\t"); BEGIN FIELD;}
[ ]*[Pp][Uu][Bb][Ll][Ii][Ss][Hh][Ee][Rr][ ]*"="[ ]*[{"]  {printf("Publicacao ----:\t"); BEGIN FIELD;}
[ ]*[Bb][Oo][Oo][Kk][Tt][Ii][Tt][Ll][Ee][ ]*"="[ ]*[{"]  {printf("Titulo do livro:\t"); BEGIN FIELD;}  
[ ]*[Jj][Oo][Uu][Rr][Nn][Aa][Ll][ ]*"="[ ]*[{"]  {printf("Jornal --------:\t"); BEGIN FIELD;}
[ ]*[Ee][Dd][Ii][Tt][Ii][Oo][Nn][ ]*"="[ ]*[{"]  {printf("Edicao --------:\t"); BEGIN FIELD;}
[ ]*[Cc][Hh][Aa][Pp][Tt][Ee][Rr][ ]*"="[ ]*[{"]  {printf("Capitulo ------:\t"); BEGIN FIELD;}
[ ]*[Aa][Dd][Dd][Rr][Ee][Ss][Ss][ ]*"="[ ]*[{"]  {printf("Morada --------:\t"); BEGIN FIELD;}
[ ]*[Vv][Oo][Ll][Uu][Mm][Ee][ ]*"="[ ]*[{"]  {printf("Volume --------:\t"); BEGIN FIELD;}
[ ]*[Ss][Ee][Rr][Ii][Ee][Ss][ ]*"="[ ]*[{"]  {printf("Serie  --------:\t"); BEGIN FIELD;}
[ ]*[Ss][Cc][Hh][Oo][Oo][Ll][ ]*"="[ ]*[{"]  {printf("Escola --------:\t"); BEGIN FIELD;}
[ ]*[Nn][Uu][Mm][Bb][Ee][Rr][ ]*"="[ ]*[{"]  {printf("Numero --------:\t"); BEGIN FIELD;}
[ ]*[Ee][Dd][Ii][Tt][Oo][Rr][ ]*"="[ ]*[{"]  {printf("Editor --------:\t"); BEGIN FIELD;}
[ ]*[Aa][Uu][Tt][Hh][Oo][Rr][ ]*"="[ ]*[{"]  {printf("\n\n\n################\n");
                              	               printf("Autor(es) -----:\t"); BEGIN AUT;}
[ ]*[Tt][Ii][Tt][Ll][Ee][ ]*"="[ ]*[{"]  {printf("Titulo --------:\t"); BEGIN TITLE;}
[ ]*[Pp][Aa][Gg][Ee][Ss][ ]*"="[ ]*[{"]  {printf("Pags ----------:\t"); BEGIN FIELD;}
[ ]*[Mm][Oo][Nn][Tt][Hh][ ]*"="[ ]*[{"]  {printf("Mes ---------- :\t"); BEGIN FIELD;}
[ ]*[Yy][Ee][Aa][Rr][ ]*"="[ ]*[{"]  {printf("Ano ---------- :\t"); BEGIN FIELD;}
[ ]*[Tt][Yy][Pp][Ee][ ]*"="[ ]*[{"]  {printf("Tipo ----------:\t"); BEGIN FIELD;}
[ ]*[A-Za-z]+[ ]*"="[ ]*[{"]            {;}

<AUT>[ \t]+"and"[ \t]+            {printf("\n\t\t\t");}
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
<FIELD>(.)                        {ECHO;}
<FIELD>(\n)                       {;}
<SPEC>[}]                         {BEGIN state_caller;}
<SPEC>(.|\n)                      {ECHO;}


(.|\n)                          {;}

%%


int yywrap(){ return 1; } 


int main (){


yylex();




return (0); }




