%{
#include <stdlib.h>
#include <stdio.h>
#define ARRAY_SIZE 16
char * fullname[ARRAY_SIZE];
int pos = 0;

void clean_array (char ** array)
{
    int i;

    for (i = 0; i < ARRAY_SIZE&&array[i]; free(array[i]),array[i++]=NULL);


}
void print_array (char ** array)
{
    int i;

    for (i = 1; i < ARRAY_SIZE&&array[i]; i++)
        {

            printf("%s ", array[i]);
        }
    printf("%s", array[0]);


}

%}

%x AUT CHAV SPEC PREFORMAT
%%
[Aa][Uu][Tt][Hh][Oo][Rr][ ]*"="[ ]*[{"] {yytext[yyleng-1]='{'; ECHO; BEGIN AUT;}
[A-Za-z]+[ ]*"="[ ]*[{"]                  {yytext[yyleng-1]='{';ECHO; BEGIN CHAV;}


<AUT>[}"]                                   {printf("}"); BEGIN INITIAL;}


<AUT>[ \t]+                                   {printf(" ");}

<AUT>[ \t][a-z]+[\t ]                           {printf(" ");}
<AUT>[A-Z]((\.)?|[a-z]+)                     {printf("%c.", yytext[0]);}

<AUT>((-)?[A-Z][a-z]+)+[,]+[ \t]              { yyless(0); pos = 0; clean_array(fullname); BEGIN PREFORMAT;}
<AUT>((-)?[A-Z][a-z]+)+[ \t]*[}"]             {yytext[yyleng-1]='}'; ECHO; BEGIN INITIAL;}
<AUT>((-)?[A-Z][a-z]+)+[ \t]+(and)[ \t]+         {ECHO;}


<AUT>(.|\n)                                 {;}



<CHAV>[{]                                   {printf("{"); BEGIN SPEC;}

<CHAV>[}"]                                  {printf("}"); BEGIN INITIAL;}
<CHAV>(.|\n)                                   {ECHO;}


<SPEC>[}]                                   {ECHO; BEGIN CHAV;}
<SPEC>(.|\n)                                {ECHO;}


<PREFORMAT>[}"]                          {yyless(0); pos = 0;
print_array(fullname); ;BEGIN AUT;}
 
 
<PREFORMAT>[, \t]+                            {pos++;}

<PREFORMAT>[ \t]+(and)[ \t]+                    {pos = 0; print_array(fullname); printf(" and ");}

<PREFORMAT>[ \t][a-z]+[ \t]                     {;}

<PREFORMAT>((-)?[A-Z]((\.)|[a-z]+))               { 
                                               if(pos!=0){

                                               yytext[1]='.'; 
					       yytext[2]='\0';
					       }

					       fullname[pos]=strdup(yytext);
					      }


<PREFORMAT>(.|\n)                           {;}

(.|\n)                                      {ECHO;}

%%

int yywrap()
{
return 1;
}


int main ()
{


yylex();




return (0);
}














