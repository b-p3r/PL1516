%{
#include <stdlib.h>
#include <stdio.h>

int state_caller = 0;

%}

%S ENTRY A AUT TITLE FIELD SPEC 
%%
\@[A-Za-z]+ {if(state_caller==AUT||state_caller==TITLE){BEGIN ENTRY;}else{yyless(1); state_caller = YYSTATE; BEGIN A;}}
<ENTRY>[}] {BEGIN INITIAL;}
<ENTRY>[}][ ]*[,] {;}
<A>[}] {BEGIN INITIAL;}
<A>[}][ ]*[,] {;}
<ENTRY>[Oo][Rr][Gg][Aa][Nn][Ii][Zz][Aa][Tt][Ii][Oo][Nn][ ]*"="[ ]*[{"]?  {printf("Organizacao----:\t"); state_caller = YYSTATE;BEGIN FIELD;}
<ENTRY>[Hh][Oo][Ww][Pp][Uu][Bb][Ll][Ii][Ss][Hh][Ee][Dd][ ]*"="[ ]*[{"]?  {printf("Pulicado como -:\t"); state_caller = YYSTATE;BEGIN FIELD;}
<ENTRY>[Ii][Nn][Ss][Tt][Ii][Tt][Uu][Tt][Ii][Oo][Nn][ ]*"="[ ]*[{"]?      {printf("Instituicao ---:\t"); state_caller = YYSTATE;BEGIN FIELD;}
<ENTRY>[Pp][Uu][Bb][Ll][Ii][Ss][Hh][Ee][Rr][ ]*"="[ ]*[{"]?              {printf("Publicacao ----:\t"); state_caller = YYSTATE;BEGIN FIELD;}
<ENTRY>[Bb][Oo][Oo][Kk][Tt][Ii][Tt][Ll][Ee][ ]*"="[ ]*[{"]?              {printf("Titulo do livro:\t"); state_caller = YYSTATE;BEGIN FIELD;}  
<ENTRY>[Jj][Oo][Uu][Rr][Nn][Aa][Ll][ ]*"="[ ]*[{"]?                      {printf("Jornal --------:\t"); state_caller = YYSTATE;BEGIN FIELD;}
<ENTRY>[Ee][Dd][Ii][Tt][Ii][Oo][Nn][ ]*"="[ ]*[{"]?                      {printf("Edicao --------:\t"); state_caller = YYSTATE;BEGIN FIELD;}
<ENTRY>[Cc][Hh][Aa][Pp][Tt][Ee][Rr][ ]*"="[ ]*[{"]?                      {printf("Capitulo ------:\t"); state_caller = YYSTATE;BEGIN FIELD;}
<ENTRY>[Aa][Dd][Dd][Rr][Ee][Ss][Ss][ ]*"="[ ]*[{"]?                      {printf("Morada --------:\t"); state_caller = YYSTATE;BEGIN FIELD;}
<ENTRY>[Vv][Oo][Ll][Uu][Mm][Ee][ ]*"="[ ]*[{"]?                          {printf("Volume --------:\t"); state_caller = YYSTATE;BEGIN FIELD;}
<ENTRY>[Ss][Ee][Rr][Ii][Ee][Ss][ ]*"="[ ]*[{"]?                          {printf("Serie  --------:\t"); state_caller = YYSTATE;BEGIN FIELD;}
<ENTRY>[Ss][Cc][Hh][Oo][Oo][Ll][ ]*"="[ ]*[{"]?                          {printf("Escola --------:\t"); state_caller = YYSTATE;BEGIN FIELD;}
<ENTRY>[Nn][Uu][Mm][Bb][Ee][Rr][ ]*"="[ ]*[{"]?                          {printf("Numero --------:\t"); state_caller = YYSTATE;BEGIN FIELD;}
<ENTRY>[Ee][Dd][Ii][Tt][Oo][Rr][ ]*"="[ ]*[{"]?                          {printf("Editor --------:\t"); state_caller = YYSTATE;BEGIN FIELD;}
<A>[Aa][Uu][Tt][Hh][Oo][Rr][ ]*"="[ ]*[{"]?                          {printf("\n\n\n################\n");
                         	                                         printf("Autor(es) -----:\t"); state_caller = YYSTATE;BEGIN AUT;}
<A>[Tt][Ii][Tt][Ll][Ee][ ]*"="[ ]*[{"]?                              {printf("Titulo --------:\t"); state_caller = YYSTATE;BEGIN TITLE;}
<ENTRY>[Pp][Aa][Gg][Ee][Ss][ ]*"="[ ]*[{"]?                              {printf("Pags ----------:\t"); state_caller = YYSTATE;BEGIN FIELD;}
<ENTRY>[Mm][Oo][Nn][Tt][Hh][ ]*"="[ ]*[{"]?                              {printf("Mes ---------- :\t"); state_caller = YYSTATE;BEGIN FIELD;}
<ENTRY>[Yy][Ee][Aa][Rr][ ]*"="[ ]*[{"]?                                  {printf("Ano ---------- :\t"); state_caller = YYSTATE;BEGIN FIELD;}
<ENTRY>[Tt][Yy][Pp][Ee][ ]*"="[ ]*[{"]?                                  {printf("Tipo ----------:\t"); state_caller = YYSTATE;BEGIN FIELD;}
<ENTRY>[A-Za-z]+[ ]*"="[ ]*[{"]            {;}

<AUT>[ \t]+"and"[ \t]+            {printf("\n\t\t\t");}
<AUT>[}"][ ]*[ ]?                 {printf("\n"); BEGIN A;}
<AUT>(.|\n)                       {ECHO;}

<TITLE>[ ]{2,}                    {printf(" ");}
<TITLE>[{]                        { state_caller = YYSTATE; BEGIN SPEC;}
<TITLE>[}"][ ]*[,]?                {state_caller = YYSTATE; printf("\n");BEGIN A;}
<TITLE>(.)                        {ECHO;}
<TITLE>(\n)                       {;}


<FIELD>"\\url{"                   { state_caller = YYSTATE; BEGIN SPEC;}
<FIELD>[ ]{2,}                    {printf(" ");}
<FIELD>[{]                        { state_caller = YYSTATE; BEGIN SPEC;}
<FIELD>[}"]?[ ]*[,]                       {state_caller = YYSTATE; printf("\n"); BEGIN ENTRY;}
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




