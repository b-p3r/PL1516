#ifndef ENTRY_INCLUDED
#define ENTRY_INCLUDED
#include "types.h"

typedef struct entry ENTRY;
/* entry.c */
ENTRY *init_bucket(void);
Category getCategory(ENTRY *it);
Level getLevel(ENTRY *it);
int getLimitDim(ENTRY *it);
int getNDim(ENTRY *it);
Type getType(ENTRY *it);
int setCategory(ENTRY *it, Category category);
int setLevel(ENTRY *it, Level level);
int setLimitDim(ENTRY *it, int limitlDim);
int setNDim(ENTRY *it, int nDim);
int setType(ENTRY *it, Type type);
void delete_item(ENTRY *t);



#endif // ENTRY_INCLUDED
