/* simple_hashtable.c */
typedef struct item ITEM;
void add_key(char *key);
ITEM *find_key(char *key);
void delete_key(ITEM *key);
void delete_all(void);
void print_items(void);
void print_item_by_key(char *key);
int total_items();
