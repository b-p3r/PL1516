#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "program_status.h"
#include "entry.h"
#include "types.h"
#include "hash_table.h"
#define MAX_LABEL_STACK 1024
#define MAX_LABEL 1024

typedef struct status
{

    char label[ MAX_LABEL ];
    int  label_stack[ MAX_LABEL_STACK ];
    int  label_number_size[ MAX_LABEL_STACK ];

    int spointer, strpointer, addresspointer;
    int size_label_string;
    ITEM *items;




} STATUS;

Program_status *init()
{
    int i;
    Program_status *tmp = ( Program_status * ) malloc ( sizeof ( struct status ) );

    if ( tmp == NULL )
        return NULL;

    tmp->spointer = 0;
    tmp->strpointer = 0;
    tmp->size_label_string = 0;
    tmp->addresspointer =  0;
    tmp->items = init_hashtable();

    for ( i = 0; i < MAX_LABEL_STACK; i++ ){
    
     tmp->label_stack[i]=0;
      tmp->label_number_size[i]=0;
    
    }
}

int push_label_stack ( Program_status *status )
{
    if ( status==NULL )
        return -1;

    status->spointer++;
    return 0;
}

int pop_label_stack ( Program_status *status )
{
    if ( status==NULL )
        return -1;

    status->spointer--;
    return 0;
}

int top_label_stack ( Program_status *status )
{
    int res = -1;

    if ( status==NULL )
        return -1;

    res = status->label_stack[status->spointer - 1 ];
    return res;
}

int reset_label_stack ( Program_status *status )
{
    int res = -1;

    if ( status==NULL )
        return -1;

    status->label_stack[status->spointer]=0;
    status->label_number_size[status->spointer]=0;
    return 0;
}
int increment_top_label_stack ( Program_status *status )
{
    if ( status == NULL )
        return -1;

    status->label_stack[status->spointer - 1 ]++;
    return 0;
}

char *get_label ( Program_status *status )
{
    if ( status==NULL )
        return NULL;

    return strdup ( status->label );
}
char *push_label ( Program_status *status )
{
    char buffer[10];
    char *tmp;

    if ( status==NULL )
        return NULL;

    increment_top_label_stack ( status );
    snprintf ( buffer, 10, "%d", top_label_stack ( status ) );
    status->size_label_string = strlen ( buffer );
    strcpy ( status->label + status->strpointer, buffer );
    tmp = strdup ( status->label );
    status->label_number_size[status->spointer] = status->size_label_string;
    status->strpointer+=status->size_label_string;
    return tmp;
}

int pop_label ( Program_status *status )
{
    int i;

    if ( status==NULL )
        return -1;

    for ( i = status->size_label_string + 1; i >= 0; i-- )
        status->label[status->strpointer + i] = '\0';

    status->strpointer-=status->label_number_size[status->spointer];

    return 0;
}

int atribute_adress_for_var ( Program_status *status )
{
    int address;

    if ( status==NULL )
        return -1;

    status->addresspointer++;
    address = status->addresspointer-1;

    return address;
}

int atribute_adress_for_array ( Program_status *status, int size)
{
    int address=0;

    if ( status==NULL )
        return -1;

    address = status->addresspointer-1;
    status->addresspointer+=size;

    return address;
}





int check_type ( Type a, Type b)
{

    return a == b;
}


Type get_class_integer_type ( Entry *entry )
{
    Class id_class;
    Type res = Any;

    if(entry==NULL)
        return Any;

    id_class = get_class(entry);

    switch(id_class)
        {

        case Variable:
        case Array:
        case Matrix:
            res = Integer;
            break;

        default :
            break;

        }

    return res;
}

int add_Variable ( Program_status *status, char *key, Type type, Class id_class, Level level)
{
    Entry * entry = NULL;
    int address = -1;

    if(status==NULL)
        return -1;

    address = atribute_adress_for_var(status);

    if(address==-1)
        return -1;

    address = atribute_adress_for_var(status);
    entry  = new_entry_variable(address, type, id_class, level);

    if(entry==NULL)
        return -1;

    add_key(status->items, key, entry);

    return 0;
}

int add_Array ( Program_status *status, char *key, Type type, Class id_class, int size, Level level)
{
    Entry * entry = NULL;
    int address = -1;

    if(status==NULL)
        return -1;

    address = atribute_adress_for_array(status, size);

    if(address==-1)
        return -1;

    entry  = new_entry_array(address, type, id_class, size, level);

    if(entry==NULL)
        return -1;

    add_key(status->items, key, entry);
    return 0;
}

int add_Matrix ( Program_status *status, char *key, Type type, Class id_class, int size, int ncols, Level level)
{
    Entry * entry = NULL;
    int address = -1;

    if(status==NULL)
        return -1;

    address = atribute_adress_for_array(status, size);


    if(address==-1)
        return -1;

    entry  = new_entry_matrix(address, type, id_class,size, ncols, level);

    if(entry==NULL)
        return -1;

    add_key(status->items, key, entry);

    return 0;
}

Entry *find_identifier ( Program_status *status, char *key )
{
    Entry * entry = NULL;

    if(status==NULL)
        return NULL;

    entry = find_key(status->items, key);

    return entry;

}

void delete_identifier ( Program_status *status, char *key )
{
    Entry * entry = NULL;

    if(status==NULL)
        return;

    entry = find_key(status->items, key);

    if(entry)
        delete_key(status->items, key);

}

void delete_all_identifiers ( Program_status *status)
{
    if(status==NULL)
        return;

    delete_all(status->items);

}

void destroy_status(Program_status * status)
{
    delete_all_identifiers (status);
    free(status);
    status = NULL;
}








