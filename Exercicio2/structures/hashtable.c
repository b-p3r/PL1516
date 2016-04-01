#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "uthash.h"
#include "hashtable.h"

typedef struct item
{
    int id;
    struct item *sub;
    char *nome_autor;
    UT_hash_handle hh;
} AUTOR;

AUTOR *autores = NULL;

void add_autor ( char *nome_autor )
{
    AUTOR *s;
    HASH_FIND_STR ( autores, nome_autor, s );
    if ( s==NULL )
        {
            s = ( AUTOR * ) malloc ( sizeof ( AUTOR ) );
            s->nome_autor = strdup ( nome_autor );
            s->sub = NULL;
            s->id = 0;
            HASH_ADD_KEYPTR ( hh,  autores, s->nome_autor, strlen ( s->nome_autor ), s );
        }
    s->id++;
}
void add_coautor ( char *nome_autor, char *nome_autor2 )
{
    AUTOR *i, *s;
    HASH_FIND_STR ( autores, nome_autor, i );
    if ( i==NULL )
        return;
    HASH_FIND_STR ( i->sub, nome_autor2, s );
    if ( s==NULL )
        {
            s = ( AUTOR * ) malloc ( sizeof ( AUTOR ) );
            s->nome_autor = strdup ( nome_autor2 );
            s->sub = NULL;
            s->id = 0;
            HASH_ADD_KEYPTR ( hh,  i->sub , s->nome_autor, strlen ( s->nome_autor ), s );
        }
    s->id++;
}

AUTOR *find_autor ( char *nome_autor )
{
    AUTOR *s;
    HASH_FIND_STR ( autores, nome_autor, s );
    return s;
}

void delete_autor ( AUTOR *autor )
{
    AUTOR *item1, *tmp1;
    HASH_ITER ( hh, autor, item1, tmp1 )
    {
        HASH_DEL ( autores, item1 );
        free ( item1 );
    }
}

void delete_all()
{
    AUTOR *item1, *item2, *tmp1, *tmp2;
    HASH_ITER ( hh, autores, item1, tmp1 )
    {
        HASH_ITER ( hh, item1->sub, item2, tmp2 )
        {
            HASH_DEL ( item1->sub, item2 );
            free ( item2 );
        }
        HASH_DEL ( autores, item1 );
        free ( item1 );
    }
}

void print_autores()
{
    AUTOR *item1, *item2, *tmp1, *tmp2;
    HASH_ITER ( hh, autores, item1, tmp1 )
    {
        if(item1->sub==NULL)
            printf ( "\"%s\";\n", item1->nome_autor);
        HASH_ITER ( hh, item1->sub, item2, tmp2 )
        {
            printf("\"%s\" -> \"%s\" 	[label = %d	];",  item1->nome_autor, item2->nome_autor, item2->id);
            printf ( "$items{%s}{%s} = %d\n", item1->nome_autor, item2->nome_autor, item2->id );
        }
    }
}

void print_autor ( char *nome_autor )
{
    AUTOR *s, *item1, *item2, *tmp1, *tmp2;
    s = find_autor ( nome_autor );
    if ( s )
        {
            if(s->sub==NULL)
                printf ( "\"%s\";\n", s->nome_autor);
            else
                HASH_ITER ( hh, s->sub, item1, tmp1 )
                {
                    printf("\"%s\" -> \"%s\"\t\t\[label = %d\t];\n",  s->nome_autor, item1->nome_autor, item1->id);
                }
        }
}


