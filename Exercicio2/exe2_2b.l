%{
#include <stdlib.h>
#include <stdio.h>

int state_caller = 0;

%}

%S ENTRY A AUT TITLE FIELD SPEC 
%%
\@[A-Za-z]+ {BEGIN ENTRY;printf("\n\n\n################\n");}
<ENTRY>[}] {BEGIN INITIAL;}
<ENTRY>[}][ ]*[,] {;}
<ENTRY>[Oo][Rr][Gg][Aa][Nn][Ii][Zz][Aa][Tt][Ii][Oo][Nn][ ]*"="[ ]*[{"]?  {printf("Organizacao----:\t"); BEGIN FIELD;}
<ENTRY>[Hh][Oo][Ww][Pp][Uu][Bb][Ll][Ii][Ss][Hh][Ee][Dd][ ]*"="[ ]*[{"]?  {printf("Pulicado como -:\t"); BEGIN FIELD;}
<ENTRY>[Ii][Nn][Ss][Tt][Ii][Tt][Uu][Tt][Ii][Oo][Nn][ ]*"="[ ]*[{"]?      {printf("Instituicao ---:\t"); BEGIN FIELD;}
<ENTRY>[Pp][Uu][Bb][Ll][Ii][Ss][Hh][Ee][Rr][ ]*"="[ ]*[{"]?              {printf("Publicacao ----:\t"); BEGIN FIELD;}
<ENTRY>[Bb][Oo][Oo][Kk][Tt][Ii][Tt][Ll][Ee][ ]*"="[ ]*[{"]?              {printf("Titulo do livro:\t"); BEGIN FIELD;}  
<ENTRY>[Jj][Oo][Uu][Rr][Nn][Aa][Ll][ ]*"="[ ]*[{"]?                      {printf("Jornal --------:\t"); BEGIN FIELD;}
<ENTRY>[Ee][Dd][Ii][Tt][Ii][Oo][Nn][ ]*"="[ ]*[{"]?                      {printf("Edicao --------:\t"); BEGIN FIELD;}
<ENTRY>[Cc][Hh][Aa][Pp][Tt][Ee][Rr][ ]*"="[ ]*[{"]?                      {printf("Capitulo ------:\t"); BEGIN FIELD;}
<ENTRY>[Aa][Dd][Dd][Rr][Ee][Ss][Ss][ ]*"="[ ]*[{"]?                      {printf("Morada --------:\t"); BEGIN FIELD;}
<ENTRY>[Vv][Oo][Ll][Uu][Mm][Ee][ ]*"="[ ]*[{"]?                          {printf("Volume --------:\t"); BEGIN FIELD;}
<ENTRY>[Ss][Ee][Rr][Ii][Ee][Ss][ ]*"="[ ]*[{"]?                          {printf("Serie  --------:\t"); BEGIN FIELD;}
<ENTRY>[Ss][Cc][Hh][Oo][Oo][Ll][ ]*"="[ ]*[{"]?                          {printf("Escola --------:\t"); BEGIN FIELD;}
<ENTRY>[Nn][Uu][Mm][Bb][Ee][Rr][ ]*"="[ ]*[{"]?                          {printf("Numero --------:\t"); BEGIN FIELD;}
<ENTRY>[Ee][Dd][Ii][Tt][Oo][Rr][ ]*"="[ ]*[{"]?                          {printf("Editor --------:\t"); BEGIN FIELD;}
<ENTRY>[Aa][Uu][Tt][Hh][Oo][Rr][ ]*"="[ ]*[{"]?                          {printf("Autor(es) -----:\t"); BEGIN AUT;}
<ENTRY>[Tt][Ii][Tt][Ll][Ee][ ]*"="[ ]*[{"]?                              {printf("Titulo --------:\t"); BEGIN TITLE;}
<ENTRY>[Pp][Aa][Gg][Ee][Ss][ ]*"="[ ]*[{"]?                              {printf("Pags ----------:\t"); BEGIN FIELD;}
<ENTRY>[Mm][Oo][Nn][Tt][Hh][ ]*"="[ ]*[{"]?                              {printf("Mes ---------- :\t"); BEGIN FIELD;}
<ENTRY>[Yy][Ee][Aa][Rr][ ]*"="[ ]*[{"]?                                  {printf("Ano ---------- :\t"); BEGIN FIELD;}
<ENTRY>[Tt][Yy][Pp][Ee][ ]*"="[ ]*[{"]?                                  {printf("Tipo ----------:\t"); BEGIN FIELD;}
<ENTRY>[A-Za-z]+[ ]*"="[ ]*[{"]            {;}

<AUT>[ \t]+"and"[ \t]+            {printf("\n\t\t\t");}
<AUT>[}"][ ]*[ ]?                 {printf("\n"); BEGIN ENTRY;}
<AUT>(.|\n)                       {ECHO;}

<TITLE>[ ]{2,}                    {printf(" ");}
<TITLE>[{]                        { state_caller = YYSTATE; BEGIN SPEC;}
<TITLE>[}"][ ]*[,]?                {printf("\n");BEGIN ENTRY;}
<TITLE>(.)                        {ECHO;}
<TITLE>(\n)                       {;}


<FIELD>"\\url{"                   { state_caller = YYSTATE; BEGIN SPEC;}
<FIELD>[ ]{2,}                    {printf(" ");}
<FIELD>[{]                        { state_caller = YYSTATE; BEGIN SPEC;}
<FIELD>[}"]?[ ]*[,]               {printf("\n"); BEGIN ENTRY;}
<FIELD>(.)                        {ECHO;}
<FIELD>(\n)                       {;}
<SPEC>[}]                         {BEGIN state_caller;}
<SPEC>(.|\n)                      {ECHO;}


<ENTRY>(.|\n)                          {;}
(.|\n)                          {;}

%%


int yywrap(){ return 1; } 


int main (){


yylex();




return (0); }




