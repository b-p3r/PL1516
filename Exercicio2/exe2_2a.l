%{
#include <stdlib.h>
#include <stdio.h>
#define ARRAY_SIZE 16
int state = 0;
char * fullname[ARRAY_SIZE];
int pos = 0;
void swap (char ** array, int i, int j)
{

char * tmp = array[i];
array[i]=array[j];
array[j] = tmp;

}
void clean_array (char ** array)
{
int i;

	for (i = 0; i < ARRAY_SIZE&&array[i]; array[i++]=NULL);


}
void print_array (char ** array){
int i;

for (i = 1; i < ARRAY_SIZE&&array[i]; i++){

printf("%s ", array[i]);
}
printf("%s", array[0]);


}


%}

%S AUT CHAV SPEC PREFORMAT
%%
  /* Reconhece qualquer outro tipo de campo, colocando no último caracatere lido
  uma chaveta. Inicia a START CONDITION para manipulção das chavetas */
[ ]*"="[ ]*[{"]+                            {yytext[yyleng-1]='{'; ECHO; BEGIN CHAV;}
  /* Reconhece o campo autor, colocando no último caracatere lido
  uma chaveta. Inicia a START CONDITION para manipulção dos nomes dos autores */
[ ]*[Aa][Uu][Tt][Hh][Oo][Rr][ ]*"="[ ]*[{"] {yytext[yyleng-1]='{'; ECHO; BEGIN AUT;}

 /** START CONDITION para manipulação dos nomes dos autores **/

 /** Detecta o final de um campo, caso termina numa chaveta ou em aspas, e volta
 à START CONDITION inicial */
<AUT>[}"]                                   {printf("}"); BEGIN INITIAL;}

 /** Em determinados estilos de bibliografia, apenas o primeiro caractere
 é mantido como maiúscula, sendo tudo o resto colocado em minúscula. O autor da
 bibliografia pode colocar a inicial entre chavetas para evitar esse efeito.
 Assim é necessário iniciar uma START CONDITION para evitar que o fecho da
 chavetas neste caso entre em conflito com o final do campo. Assim, para cada
 chaveta aberta, logo terá que haver uma chaveta fechada. A expressão regular
 captura uma abertura de uma dessas chavetas, sendo o fecho capturado dentro
 deste comdição de contexto. Deste modo, guarda-se o estado atual, imprime-se
 a chaveta de abertura no sdtout e inicia-se a START CONDITION especial para
 este caso*/
<AUT>[{]                                    {state = YYSTATE; printf("{"); BEGIN SPEC;}


 /** Assumimos que os nomes próprios com hífen são um só nome próprio. Deteta-se
 o final de um nome quando termina a enumeração dos autores  ou quando se segue
 um "and". Note-se ainda que se adicionou a expressão 0 ou mais espaços, pois
 a enumeração pode ter espaços antes de terminar ou não. */
<AUT>((-)?[A-Z][a-z]+)+[ ]*[}"]             {yytext[yyleng-1]='}'; ECHO; BEGIN INITIAL;}
<AUT>((-)?[A-Z][a-z]+)+[ ]+(and)[ ]+         {ECHO;}

 /** Existem nomes com palavras no meio como Daniela da Cruz, Thomas van Dijk,
 etc. Optou-se por omitir essas palavras, colocando no seu lugar um espaço */
<AUT>[ ][a-z]+[ ]                           {printf(" ");}

 /** Os primeiros nomes podem ser uma inicial seguida de um ponto ou um nome
 completo. A ação a tomar aqui é apenas passar ao stdout a primeira letra com um
 ponto */
<AUT>[A-Z]((\.)?|[a-z]+)                     {printf("%c.", yytext[0]);}
 /** Caso encontre um ou mais espaço, imprime um espaço no stdout */
<AUT>[ ]+                                   {printf(" ");}

<AUT>((-)?[A-Z][a-z]+)+[,]+[ ]              { yyless(0); pos = 0; clean_array(fullname);state = YYSTATE; BEGIN PREFORMAT;}
 /** Optou-se por omitir tudo o resto, dado que as expressões regulares acima
 já tratam por completo tudo o que é suposto capturar. De igual modo, remove-se
 o '\n' colocando tudo numa só linha */
<AUT>(.|\n)                                 {;}


 /** START CONDITON para manipulação das chavetas */


 /** Existem casos especias onde já existe uma possível formatação, como
 Henriques, Pedro Rangel. Neste caso a expressão regular captura tudo até
 a primeira vírgula. Assumindo que a formatação é consistente com o resto da
 enumeração, obriga-se o analizador léxico a voltar ao início, iniciando uma
 nova START CONDITION. Para tratar os nomes nessa formatação recorre-se a um
 vetor de apontadores de 'strings' que é inicializado com todas as posições
 a NULL, ou se já foi utilizado coloca todas posições não nulas até ao momento
 a NULL. O estado da START CONDITION é guardado para poder voltar a este
 contexto. Inicia-se  a START CONDITION para manipular os nomes nesta formatação
 */
<CHAV>[{]                                   {state = YYSTATE; printf("{"); BEGIN SPEC;}

 /* Assim como nos autores, quando esta expressão regular captura uma chaveta ou
 as aspas determina o fim do campo, voltando à condição inicial */
<CHAV>[}"]                                  {printf("}"); BEGIN INITIAL;}
 /** Imprime tudo o que estiver dentro do campo, incluido o '\n' */
<CHAV>(.|\n)                                {ECHO;}


 /*Deteta o final do texto entre chavetas, voltando para o contexto anterior */
<SPEC>[}]                                   {ECHO; BEGIN state;}
 /* Imprime tudo o que estiver dentro de chavetas */
<SPEC>(.|\n)                                {ECHO;}

 /** START CONDITION para manipular autores no formato Apelido, Nome Nome */

  /** Expressão regular indentifica o final do campo com a enumeração do nome.
  Como o final do campo está de noutra START CONDITION, recua-se nesse caractere
  iniciando a anterior START CONDITION, após imprimir o último nome pela ordem N. N.
  Apelido */
<PREFORMAT>(\}|\")                          {yyless(0); pos = 0; print_array(fullname); ;BEGIN state;}

 /** Deteta o final de um nome anterior ao último nome da enumeração, fazendo
 a captura do "and". Note-se que pode encontrar um ou mais mais espaço antes
 deste verbo, pelo que se imprime o mesmo apenas com um espaço, antes e depois*/
<PREFORMAT>[ ]+(and)[ ]+                    {pos = 0; print_array(fullname); printf(" and ");}

 /** Tratemento dos nomes com minusculas como anteriormente descrito */
<PREFORMAT>[ ][a-z]+[ ]                     {;}

 /** Caso encontre um nome ou uma inicial, se for o primeiro nome encontrado,
 guarda a 'string' e coloca o apontado na primeira posição. Caso forem outros
 nomes adiciona um ponto e o caractere nulo na primeira e na segunda posição.
 A função strdup apenas copia até ao caractere nulo. */
<PREFORMAT>[A-Z]((\.)|[a-z]+)               { 
                                               if(pos!=0){
					       
                                               yytext[1]='.'; 
					       yytext[2]='\0';
					       }

					       fullname[pos]=strdup(yytext);
					      }
 /** Caso uma ou mais vírgulas forem encontradas incrementa a posição do vetor
 de de strings. De igual modo consome as vírgulas e os espaços */
<PREFORMAT>[, ]+                            {pos++;}

 /** Tudo o resto é ignorado */
<PREFORMAT>(.|\n)                           {;}

 /** Imprime tudo o resto das condições iniciais */
(.|\n)                                      {ECHO;}

%%


int yywrap(){ return 1; } 

/** Assume-se para este exercicio que os nomes dos autores estão escritos em
caracteres ASCII. Numa melhoria futura poder-se-á adicionar condições para
manipulação de carateres em UTF-8*/
int main (){


yylex();




return (0); }














