#include <stdlib.h>
#include "entry.h"
#include "types.h"


typedef struct entry
{

    Class id_class;
    Level level;
    Type type;
    int address;
    //lista de parametros
    int ncols;
    int limitDim;
} ENTRY;


Entry *init_entry()
{
    Entry *it = ( Entry * ) malloc ( sizeof ( struct entry ) );

    if ( it==NULL )
        return NULL;

    it->id_class = 0;
    it->level = 0;
    it->limitDim = 0;
    it->ncols = 0;
    it->type = 0;
    it->address = -1;
    return it;
}

Class get_class ( Entry *it )
{
    if ( it )
        return it->id_class;

    return Nothing;
}

int get_address ( Entry *it )
{
    if ( it )
        return it->address;

    return -1;
}

Level get_level ( Entry *it )
{
    if ( it )
        return it->level;

    else return -1;
}
int get_limit_dim( Entry *it )
{
    if ( it )
        return it->limitDim;

    else return -1;
}
int get_nCols ( Entry *it )
{
    if ( it )
        return it->ncols;

    else return -1;
}
Type get_type( Entry *it )
{
    if ( it )
        return it->type;

    return Any;
}

/****************************/

int set_class ( Entry *it, Class id_class )
{
    if ( it == NULL )
        return -1;

    it->id_class = id_class;
    return 0;
}

int set_address ( Entry *it, int address )
{
    if ( it == NULL )
        return -1;

    it->address = address;


    return -1;
}

int set_level ( Entry *it, Level level )
{
    if ( it==NULL )
        return -1;

    it->level = level;
    return 0;
}
int set_limit_dim ( Entry *it, int limitlDim )
{
    if ( it==NULL )
        return -1;

    it->limitDim = limitlDim;
    return 0;
}
int set_nCols ( Entry *it, int ncols )
{
    if ( it==NULL )
        return -1;

    it->ncols = ncols;
    return 0;
}
int set_type ( Entry *it, Type type )
{
    if ( it==NULL )
        return -1;

    it->type = type;
    return 0;
}

void delete_entry ( Entry *t )
{
    if ( t )
        {
            free ( t );
            t=NULL;
        }
}


Entry * new_entry_variable (int address, Type type, Class id_class, Level level)
{
    Entry * it = init_entry();

    if ( it==NULL )
        return NULL;

    set_type(it, type);
    set_class(it, id_class);
    set_level(it, level);
    set_address(it, address);

    return it;



}

Entry * new_entry_array (int address, Type type, Class id_class, int size, Level level)
{
    Entry * it = init_entry();

    if ( it==NULL )
        return NULL;

    set_type(it, type);
    set_class(it, id_class);
    set_limit_dim(it, size);
    set_level(it, level);
    set_address(it, address);

    return it;

}

Entry * new_entry_matrix (int address, Type type, Class id_class, int size, int ncols, Level level)
{
    Entry * it = init_entry();

    if ( it==NULL )
        return NULL;

    set_type(it, type);
    set_class(it, id_class);
    set_limit_dim(it, size);
    set_level(it, level);
    set_nCols(it, ncols);
    set_address(it, address);


    return it;



}
