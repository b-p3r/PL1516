#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "program_status.h"


Program_status *init(Program_status * status)
{
    int i;

    if ( status == NULL )
        return NULL;

    for ( i = 0; i < MAX_CONDITION_ROW; i++ ){
    status->spointer         [i][1] = 0;
    status->strpointer       [i][1] = 0;
    status->size_label_string[i][1] = 0;

    }
    status->addresspointer = 0;

    for ( i = 0; i < MAX_LABEL_STACK; i++ ){
    
     status->label_stack      [0][i]=0;
     status->label_stack      [1][i]=0;
     status->label_stack      [2][i]=0;
     status->label_stack      [3][i]=0;
     status->label_number_size[0][i]=0;
     status->label_number_size[1][i]=0;
     status->label_number_size[2][i]=0;
     status->label_number_size[3][i]=0;
    
    }
}

int push_label_stack ( Program_status *status, CompoundInstruction cpd )
{
    if ( status==NULL )
        return -1;

    status->spointer[cpd][1]++;
    return 0;
}

int pop_label_stack ( Program_status *status, CompoundInstruction cpd )
{
    if ( status==NULL )
        return -1;

    status->spointer[cpd][1]--;
    return 0;
}

int top_label_stack ( Program_status *status , CompoundInstruction cpd)
{
    int res = -1;

    if ( status==NULL )
        return -1;

    res = status->label_stack[cpd][status->spointer[cpd][1] - 1 ];
    return res;
}

int reset_label_stack ( Program_status *status , CompoundInstruction cpd)
{
    int res = -1;

    if ( status==NULL )
        return -1;

    status->label_stack[cpd][status->spointer[cpd][1]]=0;
    status->label_number_size[cpd][status->spointer[cpd][1]]=0;
    return 0;
}
int increment_top_label_stack ( Program_status *status, CompoundInstruction cpd )
{
    if ( status == NULL )
        return -1;

    status->label_stack[cpd][status->spointer[cpd][1] - 1 ]++;
    return 0;
}

char *get_label ( Program_status *status , CompoundInstruction cpd)
{
    if ( status==NULL )
        return NULL;

    return strdup ( status->label[cpd] );
}
char *push_label ( Program_status *status, CompoundInstruction cpd)
{
    char buffer[10];
    char *tmp;

    if ( status==NULL )
        return NULL;

    increment_top_label_stack ( status, cpd );
    snprintf ( buffer, 10, "%d", top_label_stack ( status, cpd ) );
    status->size_label_string[cpd][1] = strlen ( buffer );
    strcpy ( status->label[cpd] + status->strpointer[cpd][1], buffer );
    tmp = strdup ( status->label[cpd] );
    status->label_number_size[cpd][status->spointer[cpd][1]] = status->size_label_string[cpd][1];
    status->strpointer[cpd][1]+=status->size_label_string[cpd][1];
    return tmp;
}

int pop_label ( Program_status *status, CompoundInstruction cpd )
{
    int i;

    if ( status==NULL )
        return -1;

    for ( i = status->size_label_string[cpd][1] + 1; i >= 0; i-- )
        status->label[cpd][status->strpointer[cpd][1] + i] = '\0';

    status->strpointer[cpd][1]-=status->label_number_size[cpd][status->spointer[cpd][1]];

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

    status->addresspointer++;
    address = status->addresspointer-1;
    status->addresspointer+=(size-1);

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

    entry  = new_entry_variable(address, type, id_class, level);

    if(entry==NULL)
        return -1;
    add_key(key, entry);

    return 0;
}

int add_Array ( Program_status *status, char *key, Type type, Class id_class, int size, Level level)
{
    Entry * entry = NULL;
    int address = -1;

    if(status==NULL)
        return -1;

    address = atribute_adress_for_array(status, size);

printf("ENTRY adress %p %s %d\n", entry, key, address);
    if(address==-1)
        return -1;

    entry  = new_entry_array(address, type, id_class, size, level);

    if(entry==NULL)
        return -1;

    add_key( key, entry);
printf("ENTRY %p %s\n", entry, key);
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

    add_key( key, entry);

    return 0;
}

Entry *find_identifier ( Program_status *status, char *key )
{
    Entry * entry = NULL;

    if(status==NULL)
        return NULL;

    entry = find_key( key);

    return entry;

}

void delete_identifier ( Program_status *status, char *key )
{
    Entry * entry = NULL;

    if(status==NULL)
        return;

    entry = find_key( key);

    if(entry)
        delete_key(key);

}

void delete_all_identifiers ( Program_status *status)
{
    if(status==NULL)
        return;

    delete_all();

}

void destroy_status(Program_status * status)
{
    delete_all_identifiers (status);
    free(status);
    status = NULL;
}








