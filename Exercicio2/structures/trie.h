/* trie.c */

typedef struct trie_node NODO;

typedef struct NODO TRIE;

NODO *novoNodo(void);
TRIE *TRIE_init(void);
TRIE *TRIE_insert(TRIE *trie, char *key);
int TRIE_getTotalKeys(TRIE *t);
void TRIE_getAllKeys(TRIE *trie);
