%{
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#define MAX_ENTRIES 20
#define MAX_ROWS 20
#define MAXLENGTH 256

int state_caller = 0, pos = 2, i = 0;
char * fields[MAX_ROWS][MAX_ENTRIES];
char value [MAXLENGTH];

void print_campos(){
int j;

for(j = 0; j < pos; j++)
printf("%s %s", fields[0][j], fields[1][j]);
free(fields[0][j]);
free(fields[1][j]);
fields[0][j]=NULL;
fields[1][j]=NULL;

}

%}


%x ENTRY AUT TITLE FIELD SPEC 
%%



\@[A-Za-z]+ {pos = 2; BEGIN ENTRY;printf("\n\n\n################\n");}
<ENTRY>[}] {print_campos(); BEGIN INITIAL;}
<ENTRY>[}][ ]*[,] {;} 

<ENTRY>[Oo][Rr][Gg][Aa][Nn][Ii][Zz][Aa][Tt][Ii][Oo][Nn][ ]*"="[ ]*[{"]? {i=0; fields[0][pos]=strdup("Organizacao----:\t");BEGIN FIELD;}
<ENTRY>[Hh][Oo][Ww][Pp][Uu][Bb][Ll][Ii][Ss][Hh][Ee][Dd][ ]*"="[ ]*[{"]? {i=0; fields[0][pos]=strdup("Pulicado como -:\t");BEGIN FIELD;}
<ENTRY>[Ii][Nn][Ss][Tt][Ii][Tt][Uu][Tt][Ii][Oo][Nn][ ]*"="[ ]*[{"]?     {i=0; fields[0][pos]=strdup("Instituicao ---:\t");BEGIN FIELD;}
<ENTRY>[Pp][Uu][Bb][Ll][Ii][Ss][Hh][Ee][Rr][ ]*"="[ ]*[{"]?             {i=0; fields[0][pos]=strdup("Publicação de -:\t");BEGIN FIELD;}
<ENTRY>[Bb][Oo][Oo][Kk][Tt][Ii][Tt][Ll][Ee][ ]*"="[ ]*[{"]?             {i=0; fields[0][pos]=strdup("Titulo do livro:\t");BEGIN FIELD;}  
<ENTRY>[Jj][Oo][Uu][Rr][Nn][Aa][Ll][ ]*"="[ ]*[{"]?                     {i=0; fields[0][pos]=strdup("Jornal --------:\t");BEGIN FIELD;}
<ENTRY>[Ee][Dd][Ii][Tt][Ii][Oo][Nn][ ]*"="[ ]*[{"]?                     {i=0; fields[0][pos]=strdup("Edicao --------:\t");BEGIN FIELD;}
<ENTRY>[Cc][Hh][Aa][Pp][Tt][Ee][Rr][ ]*"="[ ]*[{"]?                     {i=0; fields[0][pos]=strdup("Capitulo ------:\t");BEGIN FIELD;}
<ENTRY>[Aa][Dd][Dd][Rr][Ee][Ss][Ss][ ]*"="[ ]*[{"]?                     {i=0; fields[0][pos]=strdup("Morada --------:\t");BEGIN FIELD;}
<ENTRY>[Vv][Oo][Ll][Uu][Mm][Ee][ ]*"="[ ]*[{"]?                         {i=0; fields[0][pos]=strdup("Volume --------:\t");BEGIN FIELD;}
<ENTRY>[Ss][Ee][Rr][Ii][Ee][Ss][ ]*"="[ ]*[{"]?                         {i=0; fields[0][pos]=strdup("Serie  --------:\t");BEGIN FIELD;}
<ENTRY>[Ss][Cc][Hh][Oo][Oo][Ll][ ]*"="[ ]*[{"]?                         {i=0; fields[0][pos]=strdup("Escola --------:\t");BEGIN FIELD;}
<ENTRY>[Nn][Uu][Mm][Bb][Ee][Rr][ ]*"="[ ]*[{"]?                         {i=0; fields[0][pos]=strdup("Numero --------:\t");BEGIN FIELD;}
<ENTRY>[Ee][Dd][Ii][Tt][Oo][Rr][ ]*"="[ ]*[{"]?                         {i=0; fields[0][pos]=strdup("Editor --------:\t");BEGIN FIELD;}
<ENTRY>[Aa][Uu][Tt][Hh][Oo][Rr][ ]*"="[ ]*[{"]?                         {i=0; fields[0][0  ]=strdup("Autor(es) -----:\t");BEGIN AUT;}
<ENTRY>[Tt][Ii][Tt][Ll][Ee][ ]*"="[ ]*[{"]                              {i=0; fields[0][1  ]=strdup("Titulo --------:\t");BEGIN TITLE;}
<ENTRY>[Pp][Aa][Gg][Ee][Ss][ ]*"="[ ]*[{"]?                             {i=0; fields[0][pos]=strdup("Pags ----------:\t");BEGIN FIELD;}
<ENTRY>[Mm][Oo][Nn][Tt][Hh][ ]*"="[ ]*[{"]?                             {i=0; fields[0][pos]=strdup("Mes ---------- :\t");BEGIN FIELD;}
<ENTRY>[Yy][Ee][Aa][Rr][ ]*"="[ ]*[{"]?                                 {i=0; fields[0][pos]=strdup("Ano ---------- :\t");BEGIN FIELD;}
<ENTRY>[Tt][Yy][Pp][Ee][ ]*"="[ ]*[{"]?                                 {i=0; fields[0][pos]=strdup("Tipo ----------:\t");BEGIN FIELD;}
<ENTRY>[A-Za-z]+[ ]*"="[ ]*[{"]?                                        {;}

<ENTRY>(.|\n)                     {;}


<AUT>[ \t]+"and"[ \t]+            {strcpy(value+i, "\n\t\t\t "); i+=5;}
<AUT>[}"][ ]*[ ]?                 {strcpy(value+i,"\n"); i++; 
                                   fields[1][0]=strdup(value); 
				   BEGIN ENTRY;}

<AUT>(.|\n)                       {value[i++]=yytext[0];}

<TITLE>[ ]{2,}                    {value[i++]=' ';}

<TITLE>[{]                        { state_caller = YYSTATE; BEGIN SPEC;}
<TITLE>[}"][ ]*[,]?               {strcpy(value+i,"\n"); i++;
				   fields[1][1]=strdup(value);
                                   BEGIN ENTRY;}
<TITLE>(.)                        {value[i++]=yytext[0];}
<TITLE>(\n)                       {;}


<FIELD>"\\url{"                   { state_caller = YYSTATE; BEGIN SPEC;}
<FIELD>[ ]{2,}                    {value[i++]=' ';}
<FIELD>[{]                        { state_caller = YYSTATE; BEGIN SPEC;}
<FIELD>[}"]?[ ]*[,]               {strcpy(value+i,"\n"); i++;
				   fields[1][pos++]=strdup(value);
				   BEGIN ENTRY;}
<FIELD>(.)                        {value[i++]=yytext[0];}
<FIELD>(\n)                       {;}

<SPEC>[}]                         {yyless(0);BEGIN state_caller;}
<SPEC>(.|\n)                      {value[i++]=yytext[0];}



(.|\n)                            {;}

%%


int yywrap(){ return 1; } 


int main (){
int j;

yylex();


for(j = 0; j < MAX_ENTRIES; j++){
if(fields[0][j])
free(fields[0][j]);
else if (fields[1][j])
free(fields[1][j]);

}


return (0); }




