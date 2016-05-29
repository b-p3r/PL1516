#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "program_status.h"
#include "hash_table.h"
#define MAX_LABEL_STACK 256
#define MAX_LABEL 1024

struct status
{

    char label[ MAX_LABEL ];
    int  labelStack[ MAX_LABEL_STACK ];
    int  labelNumberSize[ MAX_LABEL_STACK ];

    int spointer, strpointer, addresspointer;
    int sizeLabelString;
    ITEM *items;




};

ProgramStatus *init()
{   int i;
    ProgramStatus *tmp = ( ProgramStatus * ) malloc ( sizeof ( struct status ) );

    if ( tmp == NULL )
        return NULL;

    tmp->spointer = 0;
    tmp->strpointer = 0;
    tmp->sizeLabelString = 0;
    tmp->addresspointer = -1;
    tmp->items = init_hashtable();

    for ( i = 0; i < MAX_LABEL_STACK; tmp->labelStack[i++]=0 );
}

int pushLabelStack ( ProgramStatus *status )
{   if ( status==NULL )
        return -1;

    status->spointer++;
    return 0;
}

int popLabelStack ( ProgramStatus *status )
{   if ( status==NULL )
        return -1;

    status->spointer--;
    return 0;
}

int topLabelStack ( ProgramStatus *status )
{   int res = -1;

    if ( status==NULL )
        return -1;

    res = status->labelStack[status->spointer - 1 ];
    return res;
}

int resetLabelStack ( ProgramStatus *status )
{   int res = -1;

    if ( status==NULL )
        return -1;

    status->labelStack[status->spointer]=0;
    return 0;
}
int incrementTopLabelStack ( ProgramStatus *status )
{   if ( status == NULL )
        return -1;

    status->labelStack[status->spointer - 1 ]++;
    return 0;
}

char *getLabel ( ProgramStatus *status )
{   if ( status==NULL )
        return NULL;

    return strdup ( status->label );
}
char *pushLabel ( ProgramStatus *status )
{   char buffer[10];
    char *tmp;

    if ( status==NULL )
        return NULL;

    incrementTopLabelStack ( status );
    snprintf ( buffer, 10, "%d", topLabelStack ( status ) );
    status->sizeLabelString = strlen ( buffer );
    strcpy ( status->label + status->strpointer, buffer );
    tmp = strdup ( status->label );
    status->labelNumberSize[status->spointer] = status->sizeLabelString;
    status->strpointer+=status->sizeLabelString;
    return tmp;
}

int popLabel ( ProgramStatus *status )
{   int i;

    if ( status==NULL )
        return -1;

    for ( i = status->sizeLabelString + 1; i >= 0; i-- )
        status->label[status->strpointer + i] = '\0';

    status->strpointer-=status->labelNumberSize[status->spointer];
    return 0;
}

int atribute_adress_for_var ( ProgramStatus *status )
{   int address;

    if ( status==NULL )
        return -1;

    address = ++status->addresspointer;
    return address;
}

int atribute_adress_for_array ( ProgramStatus *status, int size)
{   int address=0;

    if ( status==NULL )
        return -1;
    address = ++status->addresspointer;
    status->addresspointer+=size;

    return address;
}

void add_identifier ( ProgramStatus *status, char *key, Entry *entry )
{
}

Entry *find_identifier ( ITEM *items, char *key )
{
}








