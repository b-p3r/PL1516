%{
#include <stdlib.h>
#include <stdio.h>
#include "../Exercicio2/structures/hashtable.h"
#define  ARRAY_SIZE  64
#define  AUTHORS  16

char author[ARRAY_SIZE];
char * authors[AUTHORS];
int i = 0, j = 0;

void insertAuthors ( char **array, int length )
{
    int i;
    add_autor(array[0]);
    for ( i=1; i < length; i++ )
        add_coautor(array[0], array[i] );

}
void swap(char **ap_str1, char **ap_str2)
{
    char *temp = *ap_str1;
    *ap_str1 = *ap_str2;
    *ap_str2 = temp;
}


void permute ( char **array, int length )
{
    int j, i;
    if(length==1)
        {
            insertAuthors ( array, 1 );
            return;

        }


    for ( i = 0; i < length ; i++ )
        {
            swap( &array[0], &array[i] );
            insertAuthors ( array, length );
        }

    return;
}
%}

%S AUT 

%%

[Aa][Uu][Tt][Hh][Oo][Rr][ ]*"="[ ]*[{"][ ]* {i=j=0; BEGIN AUT;}


<AUT>[ ]*[}"]                   {author[i]='\0';authors[j++]=strdup(author);
				 permute(authors, j);BEGIN INITIAL;}
<AUT>[ ]+(and)[ ]+              {author[i]='\0';authors[j++]=strdup(author);i = 0;}
<AUT>(.|\n)                     {author[i++]=yytext[0];	}
(.|\n)                           {;}
%%

int yywrap()
{
    return 1;
}

int main (int argc, char *argv[])
{
    char * str;
    if(argv[1]==NULL)
        return -1;
    str = argv[1];

    printf("strict digraph G {\n");
    printf("  ratio=fill;\n");
    printf("  size=\"7.5,10\"\n");
    printf("  center=true;\n");
    printf("  rankdir=LR;\n");
    yylex();
    print_autor(str);



    printf("}\n");


    return (0);
}














