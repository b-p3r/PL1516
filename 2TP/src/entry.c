#include <stdlib.h>
#include "entry.h"
#include "types.h"


typedef struct entry
{

    Category category;
    Level level;
    Type type;
    int numBytes;
    //lista de parametros
    int nDim;
    int limitDim;
} ENTRY;


ENTRY *init_bucket()
{   ENTRY *it = ( ENTRY * ) malloc ( sizeof ( struct entry ) );

    if ( it==NULL )
        return NULL;

    it->category = 0;
    it->level = 0;
    it->limitDim = 0;
    it->nDim = 0;
    it->numBytes = 0;
    it->type = 0;
    return it;
}

Category getCategory ( ENTRY *it )
{   if ( it )
        return it->category;

    return nothing;
}

Level getLevel ( ENTRY *it )
{   if ( it )
        return it->level;

    else return -1;
}
int getLimitDim ( ENTRY *it )
{   if ( it )
        return it->limitDim;

    else return -1;
}
int getNDim ( ENTRY *it )
{   if ( it )
        return it->nDim;

    else return -1;
}
Type getType ( ENTRY *it )
{   if ( it )
        return it->type;

    return nothing;
}

/****************************/

int setCategory ( ENTRY *it, Category category )
{   if ( it == NULL )
        return -1;

    it->category = category;
    return 0;
}

int setLevel ( ENTRY *it, Level level )
{   if ( it==NULL )
        return -1;

    it->level = level;
    return 0;
}
int setLimitDim ( ENTRY *it, int limitlDim )
{   if ( it==NULL )
        return -1;

    it->limitDim = limitlDim;
    return 0;
}
int setNDim ( ENTRY *it, int nDim )
{   if ( it==NULL )
        return -1;

    it->nDim = nDim;
    return 0;
}
int setType ( ENTRY *it, Type type )
{   if ( it==NULL )
        return -1;

    it->type = type;
    return 0;
}

void delete_item ( ENTRY *t )
{   if ( t )
    {   free ( t );
        t=NULL;
    }
}
