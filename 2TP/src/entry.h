#ifndef ENTRY_H_INCLUDED
#define ENTRY_H_INCLUDED
#include "types.h"

typedef struct entry Entry;
/* entry.c */
Entry *init_entry(void);
Class get_class(Entry *it);
int get_address(Entry *it);
Level get_level(Entry *it);
int get_limit_dim(Entry *it);
int get_nRows(Entry *it);
Type get_type(Entry *it);
int set_class(Entry *it, Class id_class);
int set_address(Entry *it, int address);
int set_level(Entry *it, Level level);
int set_limit_dim(Entry *it, int limitlDim);
int set_nRows(Entry *it, int ncols);
int set_type(Entry *it, Type type);
void delete_entry(Entry *t);
Entry *new_entry_variable(int address, Type type, Class id_class, Level level);
Entry *new_entry_array(int address, Type type, Class id_class, int size, Level level);
Entry *new_entry_matrix(int address, Type type, Class id_class, int size, int ncols, Level level);




#endif // ENTRY_H_INCLUDED
