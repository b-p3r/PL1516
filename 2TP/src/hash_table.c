#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "uthash.h"
#include "hash_table.h"
#include "entry.h"
ITEM *items = NULL;
typedef struct item {
    char *key;
    Entry *value;
    UT_hash_handle hh;
} ITEM;




void add_key ( char *key, Entry *entry )
{
    ITEM *s;
    HASH_FIND_STR ( items, key, s );

    if ( s==NULL ) {
        s = ( ITEM * ) malloc ( sizeof ( ITEM ) );
        s->key = strdup ( key );
        s->value = entry;
        HASH_ADD_KEYPTR ( hh,  items, s->key, strlen ( s->key ), s );
    }
}

Entry *find_key ( char *key )
{
    ITEM *s;
    HASH_FIND_STR ( items, key, s );
    return ( s?s->value: NULL );
}

void delete_key ( char *key )
{
    ITEM *s;
    HASH_FIND_STR ( items, key, s );
    HASH_DEL ( items, s );
    free ( s->value );
    free ( s->key );
    free ( key );
}

void delete_all()
{
    ITEM *item1, *tmp1;
    HASH_ITER ( hh, items, item1, tmp1 ) {
        HASH_DEL ( items, item1 );
        free ( item1->value );
        free ( item1->key );
        free ( item1 );
    }
}



int total_items()
{
    unsigned int num_items;
    num_items = HASH_COUNT ( items );
    return num_items;
}
