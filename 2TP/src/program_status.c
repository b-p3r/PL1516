#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "program_status.h"
#define MAX_LABEL_STACK 252
#define MAX_LABEL 1024

struct status
{

    char label[ MAX_LABEL ];
    int  labelStack[ MAX_LABEL_STACK ];

    int spointer, strpointer, adresspointer;
    int sizeLabelString;



};

ProgramStatus * init()
{
    int i;
    ProgramStatus * tmp = (ProgramStatus *)malloc(sizeof(struct status));

    if(tmp == NULL)
        return NULL;

    tmp->spointer = 0;
    tmp->strpointer = 0;
    tmp->sizeLabelString = 0;
    tmp->adresspointer = -1;
    for(i = 0; i < MAX_LABEL_STACK; tmp->labelStack[i++]=0);



}

int pushLabelStack(ProgramStatus * status, int value)
{
    if(status==NULL)
        return -1;

    status->labelStack[status->spointer] = value;
    status->spointer++;


    return 0;

}

int popLabelStack(ProgramStatus * status)
{
    int res = -1;
    if(status==NULL)
        return -1;

    res = status->labelStack[--(status->spointer)];

    return res;

}

int topLabelStack(ProgramStatus * status)
{
    int res = -1;
    if(status==NULL)
        return -1;

    res = status->labelStack[status->spointer - 1 ];

    return res;

}

int resetLabelStack(ProgramStatus * status)
{
    int res = -1;
    if(status==NULL)
        return -1;

    status->labelStack[status->spointer]=0;

    return 0;

}

char * pushLabel(ProgramStatus * status)
{
    char buffer[10];
    char * tmp;
    if(status==NULL)
        return NULL;


    snprintf(buffer, 10, "%d", topLabelStack(status));
    status->sizeLabelString = strlen(buffer);
    strcpy(status->label + status->strpointer, buffer);
    tmp = strdup(status->label);
    return tmp;

}

int popLabel(ProgramStatus * status)
{
    int i;

    if(status==NULL)
        return -1;
    for( i = status->sizeLabelString + 1; i > 0; i-- )
        status->label[status->strpointer + i] = '\0';


    return 0;

}



