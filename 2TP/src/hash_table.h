#ifndef HASH_TABLE_H_INCLUDED
#define HASH_TABLE_H_INCLUDED
#include "entry.h"
/* simple_hashtable.c */
typedef struct item ITEM;
ITEM *init_hashtable(void);
void add_key(ITEM *items, char *key, Entry *entry);
Entry *find_key(ITEM *items, char *key);
void delete_key(ITEM *items, char *key);
void delete_all(ITEM *items);
int total_items(ITEM *items);

#endif // HASH_TABLE_H_INCLUDED
