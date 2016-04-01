typedef struct trie_node NODO;

typedef struct NODO TRIE;
TRIE *TRIE_init();
TRIE *TRIE_init(void);
TRIE *TRIE_insert(TRIE *trie, char *key);
int TRIE_getTotalKeys(TRIE *t);
int TRIE_lookup(TRIE *trie, char *key, NODO *aux);
void TRIE_getAllKeys_HTML(TRIE *trie);


