#ifndef HASH_TABLE_H_INCLUDED
#define HASH_TABLE_H_INCLUDED
#include "entry.h"
/* simple_hashtable.c */

typedef struct item ITEM;
void add_key(char *key, Entry *entry);
Entry *find_key(char *key);
void delete_key(char *key);
void delete_all(void);
int total_items(void);



#endif // HASH_TABLE_H_INCLUDED
