#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "uthash.h"
#include "multi_level_hashtable.h"

typedef struct item
{   int id;
    struct item *sub;
    char *key;
    UT_hash_handle hh;
} ITEM;

ITEM *items = NULL;

void add_autor ( char *key )
{   ITEM *s;
    HASH_FIND_STR ( items, key, s );

    if ( s==NULL )
    {   s = ( ITEM * ) malloc ( sizeof ( ITEM ) );
        s->key = strdup ( key );
        s->sub = NULL;
        s->id = 0;
        HASH_ADD_KEYPTR ( hh,  items, s->key, strlen ( s->key ), s );
    }

    s->id++;
}
void add_coautor ( char *key, char *key2 )
{   ITEM *i, *s;
    HASH_FIND_STR ( items, key, i );

    if ( i==NULL )
    {   i = ( ITEM * ) malloc ( sizeof ( ITEM ) );
        i->key = strdup ( key );
        i->sub = NULL;
        i->id = 0;
        HASH_ADD_KEYPTR ( hh,  items, i->key, strlen ( i->key ), i );
    }

    i->id++;
    HASH_FIND_STR ( i->sub, key2, s );

    if ( s==NULL )
    {   s = ( ITEM * ) malloc ( sizeof ( ITEM ) );
        s->key = strdup ( key2 );
        s->sub = NULL;
        s->id = 0;
        HASH_ADD_KEYPTR ( hh,  i->sub , s->key, strlen ( s->key ), s );
    }

    s->id++;
}

ITEM *find_autor ( char *key )
{   ITEM *s;
    HASH_FIND_STR ( items, key, s );
    return s;
}

void delete_autor ( ITEM *autor )
{   ITEM *item1, *tmp1;
    HASH_ITER ( hh, autor, item1, tmp1 )
    {   HASH_DEL ( items, item1 );
        free ( item1 );
    }
}

void delete_all()
{   ITEM *item1, *item2, *tmp1, *tmp2;
    HASH_ITER ( hh, items, item1, tmp1 )
    {   HASH_ITER ( hh, item1->sub, item2, tmp2 )
        {   HASH_DEL ( item1->sub, item2 );
            free ( item2 );
        }
        HASH_DEL ( items, item1 );
        free ( item1 );
    }
}

void print_items()
{   ITEM *item1, *item2, *tmp1, *tmp2;
    HASH_ITER ( hh, items, item1, tmp1 )
    {   HASH_ITER ( hh, item1->sub, item2, tmp2 )
        {   printf ( "$items{%s}{%s} = %d\n", item1->key, item2->key, item2->id );
        }
    }
}

void print_autor ( char *key )
{   ITEM *s, *item1, *item2, *tmp1, *tmp2;
    s = find_autor ( key );

    if ( s )
    {   HASH_ITER ( hh, s->sub, item1, tmp1 )
        {   printf ( "$items{%s}{%s} = %d\n", s->key, item1->key, item1->id );
        }
    }
}


