#ifndef PROGRAM_STATUS_H_INCLUDED
#define PROGRAM_STATUS_H_INCLUDED
#include "types.h"
#include "entry.h"
#include "hash_table.h"
#define MAX_LABEL_STACK 1024
#define MAX_LABEL 1024
#define MAX_CONDITION_ROW 4

/* program_status.c */
typedef struct stat
{

    char label              [MAX_CONDITION_ROW] [ MAX_LABEL ];
    int  label_stack        [MAX_CONDITION_ROW] [ MAX_LABEL_STACK ];
    int  label_number_size  [MAX_CONDITION_ROW] [ MAX_LABEL_STACK ];
    int spointer            [MAX_CONDITION_ROW] [1];
    int strpointer          [MAX_CONDITION_ROW] [1];
    int size_label_string   [MAX_CONDITION_ROW] [1];
    int addresspointer;
} Program_status;

Program_status *init(Program_status * status);
int push_label_stack(Program_status *status, CompoundInstruction cpd);
int pop_label_stack(Program_status *status, CompoundInstruction cpd);
int top_label_stack(Program_status *status, CompoundInstruction cpd);
int reset_label_stack(Program_status *status, CompoundInstruction cpd);
int increment_top_label_stack(Program_status *status, CompoundInstruction cpd);
char *get_label(Program_status *status, CompoundInstruction cpd);
char *push_label(Program_status *status, CompoundInstruction cpd);
int pop_label(Program_status *status, CompoundInstruction cpd);
int atribute_adress_for_var(Program_status *status);
int atribute_adress_for_array(Program_status *status, int size);
int check_type(Type a, Type b);
Type get_class_integer_type(Entry *entry);
int add_Variable(Program_status *status, char *key, Type type, Class id_class, Level level);
int add_Array(Program_status *status, char *key, Type type, Class id_class, int size, Level level);
int add_Matrix(Program_status *status, char *key, Type type, Class id_class, int size, int ncols, Level level);
Entry *find_identifier(Program_status *status, char *key);
void delete_identifier(Program_status *status, char *key);
void delete_all_identifiers(Program_status *status);
void destroy_status(Program_status *status);




#endif // PROGRAM_STATUS_H_INCLUDED
