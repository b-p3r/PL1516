%{
#include <sys/time.h>
#include <stdlib.h>
#include <stdio.h>
#include "../Exercicio2/structures/hashtable.h"
#define  authors_SIZE  64
#define  AUTHORS  16

struct timeval  tv1, tv2;
char author[authors_SIZE];
char * authors[AUTHORS];
int i = 0, j = 0;

void insertAuthors ( int length )
{
    int i;
    add_autor(authors[0]);
    for ( i=1; i < length; i++ )
        add_coautor(authors[0], authors[i] );

}
void swap(char **ap_str1, char **ap_str2)
{
    char *temp = *ap_str1;
    *ap_str1 = *ap_str2;
    *ap_str2 = temp;
}


void permute (int length )
{
    int j, i;
    if(length==1)
        {
            insertAuthors ( 1 );
            return;

        }


    for ( i = 0; i < length ; i++ )
        {
            swap( &authors[0], &authors[i] );
            insertAuthors ( length );
        }

    return;
}
%}

%x AUT 

%%

[Aa][Uu][Tt][Hh][Oo][Rr][ ]*"="[ ]*[{"][ ]* {i=j=0; BEGIN AUT;}


<AUT>[ ]*[}"]                   {author[i]='\0';authors[j++]=strdup(author);
				 permute(j);BEGIN INITIAL;}
<AUT>[ \t]+(and)[ \t]+          {author[i]='\0';authors[j++]=strdup(author);i = 0;}
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
gettimeofday(&tv1, NULL);
    printf("strict digraph G {\n");
    printf("  ratio=fill;\n");
    printf("  size=\"7.5,10\"\n");
    printf("  center=true;\n");
    printf("  rankdir=LR;\n");
    yylex();
    print_autor(str);



    printf("}\n");

    delete_all();

gettimeofday(&tv2, NULL);

printf ("Total time = %f seconds\n",
         (double) (tv2.tv_usec - tv1.tv_usec) / 1000000 +
	          (double) (tv2.tv_sec - tv1.tv_sec));
    return (0);
}














