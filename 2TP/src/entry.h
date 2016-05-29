#ifndef ENTRY_INCLUDED
#define ENTRY_INCLUDED
#include "types.h"

typedef struct entry Entry;
/* entry.c */
Entry *init_entry(void);
Category getCategory(Entry *it);
Level getLevel(Entry *it);
int getLimitDim(Entry *it);
int getNDim(Entry *it);
Type getType(Entry *it);
int setCategory(Entry *it, Category category);
int setLevel(Entry *it, Level level);
int setLimitDim(Entry *it, int limitlDim);
int setNDim(Entry *it, int nDim);
int setType(Entry *it, Type type);
void delete_item(Entry *t);



#endif // ENTRY_INCLUDED
