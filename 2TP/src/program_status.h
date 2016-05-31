#ifndef PROGRAM_STATUS_H_INCLUDED
#define PROGRAM_STATUS_H_INCLUDED
#include "types.h"
#include "entry.h"
/* program_status.c */
typedef struct status Program_status;
Program_status *init(void);
int push_label_stack(Program_status *status);
int pop_label_stack(Program_status *status);
int top_label_stack(Program_status *status);
int reset_label_stack(Program_status *status);
int increment_top_label_stack(Program_status *status);
char *get_label(Program_status *status);
char *push_label(Program_status *status);
int pop_label(Program_status *status);
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
