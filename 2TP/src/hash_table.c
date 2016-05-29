#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "uthash.h"
#include "hash_table.h"

typedef struct item
{   int total_ocurrences;
    char *key;
    UT_hash_handle hh;
} ITEM;

ITEM *items = NULL;

void add_key ( char *key )
{   ITEM *s;
    HASH_FIND_STR ( items, key, s );

    if ( s==NULL )
    {   s = ( ITEM * ) malloc ( sizeof ( ITEM ) );
        s->key = strdup ( key );
        s->total_ocurrences = 0;
        HASH_ADD_KEYPTR ( hh,  items, s->key, strlen ( s->key ), s );
    }

    s->total_ocurrences++;
}

ITEM *find_key ( char *key )
{   ITEM *s;
    HASH_FIND_STR ( items, key, s );
    return s;
}

void delete_key ( ITEM *key )
{   HASH_DEL ( items, key );
    free ( key );
}

void delete_all()
{   ITEM *item1, *tmp1;
    HASH_ITER ( hh, items, item1, tmp1 )
    {   HASH_DEL ( items, item1 );
        free ( item1 );
    }
}

void print_items ()
{   ITEM *s = items, *item1, *tmp1;
    HASH_ITER ( hh, s, item1, tmp1 )
    {   printf ( "<tr>\n" );
        printf ( "      <td> %s </td>\n", item1->key );
        printf ( "      <td> %d </td>\n", item1->total_ocurrences );
        printf ( "</tr>\n" );
    }
}


void print_item_by_key ( char *key )
{   ITEM *s, *item1, *item2, *tmp1, *tmp2;
    s = find_key ( key );

    if ( s )
    {   HASH_ITER ( hh, s, item1, tmp1 )
        {   printf ( "%s = %d\n", item1->key, item1->total_ocurrences );
        }
    }
}


int total_items(){

unsigned int num_items;
num_items = HASH_COUNT(items);
return num_items;

}
