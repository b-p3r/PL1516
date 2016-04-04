%{
#include <stdlib.h>
#include <stdio.h>


#DEFINE PUBLICACAO 2
#DEFINE JORNAL 3
#DEFINE EDICAO 4
#DEFINE CAPITULO 5
#DEFINE MORADA 6
#DEFINE VOLUME 7
#DEFINE SERIE  8
#DEFINE ESCOLA 9
#DEFINE NUMERO 10
#DEFINE EDITOR 11
#DEFINE TITULO 12
#DEFINE PAGS 13
#DEFINE MES 14
#DEFINE ANO 15
#DEFINE TIPO 16


int state_caller = 0, pos = 2, p2 = 2, i = 0;
char ** fieldname;
char ** fields;
char value [256];

void print_campos(char **field1, char **field2  ){
int i, j;

printf("###########################\n");


printf("Publicação: %s", field2[PUBLICACAO]);
printf("Jornal: %s", field2[JORNAL]);
printf("Edição: %s", field2[EDICAO]);
printf("Capítulo: %s", field2[CAPITULO]);
printf("Morada: %s", field2[MORADA]);
printf("Volume: %s", field2[VOLUME]);
printf("Série: %s", field2[SERIE]);
printf("Escola: %s", field2[ESCOLA]);
printf("Número: %s", field2[NUMERO]);
printf("Editor: %s", field2[EDITOR]);
printf("Título: %s", field2[TITULO]);
printf("Páginas: %s", field2[PAGS]);
printf("Mês: %s", field2[MES]);
printf("Ano: %s", field2[ANO]);
printf("Tipo: %s", field2[TIPO]);

}







%}





%x ENTRY AUT TITLE FIELD SPEC 
%%







\@[A-Za-z]+[ ]*[{]           	{pos = 2; 
					fieldname =(char **)calloc(16,sizeof(char*)); 
					fields =(char **)calloc(16,sizeof(char*)); 
					BEGIN ENTRY;}

<ENTRY>[}]                               {print_campos(fieldname,  fields); 
                                           free(fieldname);
                                           free(fields); 
					   BEGIN INITIAL;}
<ENTRY>[}][ ]*[,]      {;}
<ENTRY>[Aa][Uu][Tt][Hh][Oo][Rr][ ]*"="[ ]*[{"]                         {
                          	                                        i=0;fieldname[0]=strdup("Autor(es) -----:\t"); BEGIN AUT;}
<ENTRY>[Tt][Ii][Tt][Ll][Ee][ ]*"="[ ]*[{"]                             {i=0;fieldname[1]=strdup("Titulo --------:\t"); BEGIN TITLE;}
<ENTRY>[Oo][Rr][Gg][Aa][Nn][Ii][Zz][Aa][Tt][Ii][Oo][Nn][ ]*"="[ ]*[{"] {i=0;fieldname[pos++]=strdup("Organizacao----:\t"); BEGIN FIELD;}
<ENTRY>[Hh][Oo][Ww][Pp][Uu][Bb][Ll][Ii][Ss][Hh][Ee][Dd][ ]*"="[ ]*[{"] {i=0;fieldname[pos++]=strdup("Pulicado como -:\t"); BEGIN FIELD;}
<ENTRY>[Ii][Nn][Ss][Tt][Ii][Tt][Uu][Tt][Ii][Oo][Nn][ ]*"="[ ]*[{"]     {i=0;fieldname[pos++]=strdup("Instituicao ---:\t"); BEGIN FIELD;}
<ENTRY>[Pp][Uu][Bb][Ll][Ii][Ss][Hh][Ee][Rr][ ]*"="[ ]*[{"]             {i=0;fieldname[pos++]=strdup("Publicacao ----:\t"); BEGIN FIELD;}
<ENTRY>[Bb][Oo][Oo][Kk][Tt][Ii][Tt][Ll][Ee][ ]*"="[ ]*[{"]             {i=0;fieldname[pos++]=strdup("Titulo do livro:\t"); BEGIN FIELD;}  
<ENTRY>[Jj][Oo][Uu][Rr][Nn][Aa][Ll][ ]*"="[ ]*[{"]                     {i=0;fieldname[pos++]=strdup("Jornal --------:\t"); BEGIN FIELD;}
<ENTRY>[Ee][Dd][Ii][Tt][Ii][Oo][Nn][ ]*"="[ ]*[{"]                     {i=0;fieldname[pos++]=strdup("Edicao --------:\t"); BEGIN FIELD;}
<ENTRY>[Cc][Hh][Aa][Pp][Tt][Ee][Rr][ ]*"="[ ]*[{"]                     {i=0;fieldname[pos++]=strdup("Capitulo ------:\t"); BEGIN FIELD;}
<ENTRY>[Aa][Dd][Dd][Rr][Ee][Ss][Ss][ ]*"="[ ]*[{"]                     {i=0;fieldname[pos++]=strdup("Morada --------:\t"); BEGIN FIELD;}
<ENTRY>[Vv][Oo][Ll][Uu][Mm][Ee][ ]*"="[ ]*[{"]                         {i=0;fieldname[pos++]=strdup("Volume --------:\t"); BEGIN FIELD;}
<ENTRY>[Ss][Ee][Rr][Ii][Ee][Ss][ ]*"="[ ]*[{"]                         {i=0;fieldname[pos++]=strdup("Serie  --------:\t"); BEGIN FIELD;}
<ENTRY>[Ss][Cc][Hh][Oo][Oo][Ll][ ]*"="[ ]*[{"]                         {i=0;fieldname[pos++]=strdup("Escola --------:\t"); BEGIN FIELD;}
<ENTRY>[Nn][Uu][Mm][Bb][Ee][Rr][ ]*"="[ ]*[{"]                         {i=0;fieldname[pos++]=strdup("Numero --------:\t"); BEGIN FIELD;}
<ENTRY>[Ee][Dd][Ii][Tt][Oo][Rr][ ]*"="[ ]*[{"]                         {i=0;fieldname[pos++]=strdup("Editor --------:\t"); BEGIN FIELD;}

<ENTRY>[Pp][Aa][Gg][Ee][Ss][ ]*"="[ ]*[{"]               {i=0;fieldname[pos]=strdup("Pags ----------:\t"); BEGIN FIELD;}
<ENTRY>[Mm][Oo][Nn][Tt][Hh][ ]*"="[ ]*[{"]               {i=0;fieldname[pos]=strdup("Mes ---------- :\t"); BEGIN FIELD;}
<ENTRY>[Yy][Ee][Aa][Rr][ ]*"="[ ]*[{"]                   {i=0;fieldname[pos]=strdup("Ano ---------- :\t"); BEGIN FIELD;}
<ENTRY>[Tt][Yy][Pp][Ee][ ]*"="[ ]*[{"]                   {i=0;fieldname[pos]=strdup("Tipo ----------:\t"); BEGIN FIELD;}
<ENTRY>[A-Za-z]+[ ]*"="[ ]*[{"]            {;}
<ENTRY>(.|\n)                          {;}
<AUT>[ \t]+"and"[ \t]+            {value[i++]='\n';
				   value[i++]='\t';
				   value[i++]='\t';
				   value[i++]='\t';
				   }
<AUT>[}"][ ]*[,]                         {value[i++]='\n'; 
                                   value[i++]='\0';
				   fields[0]=strdup(value);
                                   BEGIN ENTRY;}
<AUT>(.|\n)                       {value[i++]=yytext[0];}

<TITLE>[ ]{2,}                    {value[i++]=' ';}
<TITLE>[{]                        { state_caller = YYSTATE; BEGIN SPEC;}
<TITLE>[}"][ ]*[,]                       {value[i++]='\n';
                                   value[i]='\0';
				   fields[1]=strdup(value);
                                   BEGIN ENTRY;}
<TITLE>(.)                        {value[i++]=yytext[0];}
<TITLE>(\n)                       {;}


<FIELD>"\\url{"                   { state_caller = YYSTATE; BEGIN SPEC;}
<FIELD>[ ]{2,}                    {value[i++]=' ';}
<FIELD>[{]                        {ECHO; state_caller = YYSTATE; BEGIN SPEC;}
<FIELD>[}"][ ]*[,]               {value[i++]='\n';
                                   value[i]='\0';
				   fields[p2++]=strdup(value);
				   printf("F %d\n", pos);
                                   BEGIN ENTRY;}
<FIELD>(.)                        {value[i++]=yytext[0];}
<FIELD>(\n)                       {;}

<SPEC>[}]                         {yyless(0);BEGIN state_caller;}
<SPEC>(.|\n)                      {value[i++]=yytext[0];}


(.|\n)                          {;}

%%


int yywrap(){ return 1; } 


int main (){


yylex();




return (0); }




