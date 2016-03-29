#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "trie.h"
#define MAX_ALPH 256
#define KEY_SIZE 32
#define ARRAY_SIZE 64
#define OFFSET(i) (i-'\0')
typedef struct trie_node
{   struct trie_node *nodo[MAX_ALPH];

    struct trie_node *aux;
    int control;
} NODO;

typedef struct NODO
{

    NODO *raiz;
    int total_keys;

} TRIE;


static NODO *novoNodo()
{   int i;
    NODO *a = ( NODO * ) malloc ( sizeof ( NODO ) );

    for ( i=0; i<MAX_ALPH; i++ )
    {   a -> nodo[i] = NULL;
    }

    a->control = 0;
    return a;
}

TRIE *TRIE_init()    /*cria a raiz*/
{   TRIE *raiz= ( TRIE * ) malloc ( sizeof ( TRIE ) );
    TRIE *root=NULL;
    raiz->raiz = novoNodo();
    raiz->total_keys = 0;
    root = raiz;
    return root;
}


static int append_char2str ( char a , char *buff, int buff_index )
{   buff[buff_index] = a;
    buff[buff_index + 1] = '\0';
    buff_index++;
    return buff_index;
}



TRIE *TRIE_insert ( TRIE *trie, char *key )
{   int  nivel, tam;
    int i = 0;
    TRIE *raiz= ( TRIE * ) trie;
    NODO *ap = raiz->raiz;
    tam = strlen ( key );

    for ( nivel = 0; nivel < tam; nivel++ )
    {   i = OFFSET ( key[nivel] );

        if ( ap->nodo[i] == NULL )
        {   ap->nodo[i] = novoNodo();
        }

        ap = ap->nodo[i];
    }

    if ( ap->control==0 )
    {   raiz->total_keys++;
    }

    ap->control++;
    return trie;
}



int TRIE_getTotalKeys ( TRIE *t )
{   TRIE *raiz = t;
    return raiz->total_keys;
}

static void get_Keys ( NODO *t, char *intern_buff, int buff_index , int format , const char *name )
{   NODO *ap = t;
    int nivel = 0;

    if ( ap == NULL )
        return;

    if ( ap->control )
    {   switch ( format )
        {   case 0 :
		if(strcmp(intern_buff, name))
                printf ( "\"%s\" -> \"%s\" [label = %d ];\n", name, intern_buff, ap->control );
                break;

            case 1 :
                printf ( "<tr>\n" );
                printf ( "	<td> %s </td>\n", intern_buff );
                printf ( "	<td> %d </td>\n", ap->control );
                printf ( "</tr>\n" );
                break;

            case 2 :
                printf ( "%s %d\n", intern_buff, ap->control );
                break;
        }
    }

    for ( ; nivel < MAX_ALPH; nivel++ )
    {   if ( ap->nodo[nivel] != NULL )
        {   buff_index = append_char2str ( OFFSET ( nivel ) , intern_buff, buff_index );
            get_Keys ( ap->nodo[nivel] , intern_buff, buff_index , format, name );
            buff_index--;
        }
    }
}




int TRIE_lookup ( TRIE *trie, char *key, NODO *aux )
{   TRIE *raiz= trie;
    NODO *ap = raiz->raiz;
    int i, nivel, tam;

    if ( ap == NULL )
    {   return 0;
    }

    tam = strlen ( key );

    for ( nivel = 0; nivel < tam; nivel++ )
    {   i = OFFSET ( key[nivel] );

        if ( ap->nodo[i] == NULL )
        {   *aux;
            return 0;
        }

        ap = ap->nodo[i];
    }

    if ( ap&&ap->control )
        *aux= *ap;

    return ( ap&&ap->control );
}




void TRIE_getAllKeys_HTML ( TRIE *trie )
{   char intern_buff[ARRAY_SIZE];
    int buff_index = 0;
    NODO *aux = trie->raiz;
    get_Keys ( aux, intern_buff, buff_index, 1, NULL );
}
void TRIE_getAllKeys_GRAPH ( TRIE *trie , const char *name )
{   char intern_buff[ARRAY_SIZE];
    int buff_index = 0;
    NODO *aux = trie->raiz;
    get_Keys ( aux, intern_buff, buff_index, 0, name );
}

void TRIE_getAllKeys ( TRIE *trie )
{   char intern_buff[ARRAY_SIZE];
    int buff_index = 0;
    NODO *aux = trie->raiz;
    get_Keys ( aux, intern_buff, buff_index, 2, NULL );
}

