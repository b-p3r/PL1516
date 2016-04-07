
typedef struct item AUTOR;

void add_autor(char *nome_autor);
void add_coautor(char *nome_autor, char *nome_autor2);
AUTOR *find_autor(char *nome_autor);
void delete_autor(AUTOR *autor);
void delete_all(void);
void print_autores(void);
void print_autor(char *nome_autor);
int total_items(void);
