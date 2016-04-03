%{
#include <stdlib.h>
#include <stdio.h>
#define ARRAY_SIZE 16
char * fullname[ARRAY_SIZE];
int pos = 0;

void clean_array (char ** array)
{
    int i;

    for (i = 0; i < ARRAY_SIZE&&array[i]; free(array[i]),array[i++]=NULL);


}
void print_array (char ** array)
{
    int i;

    for (i = 1; i < ARRAY_SIZE&&array[i]; i++)
        {

            printf("%s ", array[i]);
        }
    printf("%s", array[0]);


}

%}

%S AUT CHAV SPEC PREFORMAT
%%
  /** Reconhece o campo autor, colocando no ultimo caracatere lido
   * uma chaveta. Inicia a START CONDITION para manipulcao dos nomes dos autores */      
[Aa][Uu][Tt][Hh][Oo][Rr][ ]*"="[ ]*[{"] {yytext[yyleng-1]='{'; ECHO; BEGIN AUT;}
  /** Reconhece qualquer outro tipo de campo, colocando no ultimo caracatere lido
   *  uma chaveta. Inicia a START CONDITION para manipulcao das chavetas */
[A-Za-z]+[ ]*"="[ ]*[{"]                  {yytext[yyleng-1]='{';ECHO; BEGIN CHAV;}


 /** START CONDITION para manipulacao dos nomes dos autores **/

 /** Detecta o final de um campo, caso termina numa chaveta ou em aspas, e volta
   * a START CONDITION inicial */
<AUT>[}"]                                   {printf("}"); BEGIN INITIAL;}

 /** Em determinados estilos de bibliografia, apenas o primeiro caractere
  * e mantido como maiuscula, sendo tudo o resto colocado em minuscula. O autor da
  * bibliografia pode colocar a inicial entre chavetas para evitar esse efeito.
  * Assim e necessario iniciar uma START CONDITION para evitar que o fecho da
  * chavetas neste caso entre em conflito com o final do campo. Assim, para cada
  * chaveta aberta, logo tera que haver uma chaveta fechada. A expressao regular
  * captura uma abertura de uma dessas chavetas, sendo o fecho capturado dentro
  * deste comdicao de contexto. Deste modo, guarda-se o estado atual, imprime-se
  * a chaveta de abertura no sdtout e inicia-se a START CONDITION especial para
  * este caso*/

 /** Caso encontre um ou mais espaco, imprime um espaco no stdout */
<AUT>[ \t]+                                   {printf(" ");}

 /** Existem nomes com palavras no meio como Daniela da Cruz, Thomas van Dijk,
  *  etc. Optou-se por omitir essas palavras, colocando no seu lugar um espaco */
<AUT>[ \t][a-z]+[\t ]                           {printf(" ");}
 /** Os primeiros nomes podem ser uma inicial seguida de um ponto ou um nome
  * completo. A acao a tomar aqui e apenas passar ao stdout a primeira letra com um
  * ponto */
<AUT>[A-Z]((\.)?|[a-z]+)                     {printf("%c.", yytext[0]);}

<AUT>((-)?[A-Z][a-z]+)+[,]+[ \t]              { yyless(0); pos = 0; clean_array(fullname); BEGIN PREFORMAT;}
 /** Assumimos que os nomes proprios com hifen sao um so nome proprio. Deteta-se
  * o final de um nome quando termina a enumeracao dos autores  ou quando se segue
  * um "and". Note-se ainda que se adicionou a expressao 0 ou mais espacos, pois
  * a enumeracao pode ter espacos antes de terminar ou nao. */
<AUT>((-)?[A-Z][a-z]+)+[ \t]*[}"]             {yytext[yyleng-1]='}'; ECHO; BEGIN INITIAL;}
<AUT>((-)?[A-Z][a-z]+)+[ \t]+(and)[ \t]+         {ECHO;}


 /** Optou-se por omitir tudo o resto, dado que as expressoes regulares acima
  * ja tratam por completo tudo o que e suposto capturar. De igual modo, remove-se
  * o '\n' colocando tudo numa so linha */
<AUT>(.|\n)                                 {;}


 /** START CONDITON para manipulacao das chavetas */


 /** Existem casos especias onde ja existe uma possivel formatacao, como
  *  Henriques, Pedro Rangel. Neste caso a expressao regular captura tudo ate
  *  a primeira virgula. Assumindo que a formatacao e consistente com o resto da
  *  enumeracao, obriga-se o analizador lexico a voltar ao inicio, iniciando uma
  *  nova START CONDITION. Para tratar os nomes nessa formatacao recorre-se a um
  *  vetor de apontadores de 'strings' que e inicializado com todas as posicoes
  *  a NULL, ou se ja foi utilizado coloca todas posicoes nao nulas ate ao momento
  *  a NULL. O estado da START CONDITION e guardado para poder voltar a este
   *  contexto. Inicia-se  a START CONDITION para manipular os nomes nesta formatacao */

<CHAV>[{]                                   {printf("{"); BEGIN SPEC;}

 /** Assim como nos autores, quando esta expressao regular captura uma chaveta ou
  * as aspas determina o fim do campo, voltando a condicao inicial */
<CHAV>[}"]                                  {printf("}"); BEGIN INITIAL;}
 /** Imprime tudo o que estiver dentro do campo, incluindo o '\n' */
<CHAV>(.|\n)                                   {ECHO;}


 /*Deteta o final do texto entre chavetas, voltando para o contexto anterior */
<SPEC>[}]                                   {ECHO; BEGIN CHAV;}
 /* Imprime tudo o que estiver dentro de chavetas */
<SPEC>(.|\n)                                {ECHO;}

 /** START CONDITION para manipular autores no formato Apelido, Nome Nome */

  /** Expressao regular indentifica o final do campo com a enumeracao do nome.
   * Como o final do campo esta de noutra START CONDITION, recua-se nesse caractere
   * iniciando a anterior START CONDITION, apos imprimir o ultimo nome pela
   * ordem N. N. Apelido */
<PREFORMAT>[}"]                          {yyless(0); pos = 0;
print_array(fullname); ;BEGIN AUT;}
 
 
 /** Caso uma ou mais virgulas forem encontradas incrementa a posicao do vetor
  * de de strings. De igual modo consome as virgulas, os espacos e possiveis
  * tabulacoes*/
<PREFORMAT>[, \t]+                            {pos++;}

 /** Deteta o final de um nome anterior ao ultimo nome da enumeracao, fazendo
  * a captura do "and". Note-se que pode encontrar um ou mais mais espacos, bem
  * como tabulacoes antes deste verbo, pelo que se imprime o mesmo apenas com um
  * espaco, antes e depois*/
<PREFORMAT>[ \t]+(and)[ \t]+                    {pos = 0; print_array(fullname); printf(" and ");}

 /** Tratemento dos nomes com minusculas como anteriormente descrito */
<PREFORMAT>[ \t][a-z]+[ \t]                     {;}

 /** Caso encontre um nome ou uma inicial, se for o primeiro nome encontrado,
  * guarda a 'string' e coloca o apontado na primeira posicao. Caso forem outros
  * nomes adiciona um ponto e o caractere nulo na primeira e na segunda posicao.
  * A funcao strdup apenas copia ate ao caractere nulo. */
<PREFORMAT>((-)?[A-Z]((\.)|[a-z]+))               { 
                                               if(pos!=0){

                                               yytext[1]='.'; 
					       yytext[2]='\0';
					       }

					       fullname[pos]=strdup(yytext);
					      }


 /** Tudo o resto e ignorado */
<PREFORMAT>(.|\n)                           {;}

 /** Imprime tudo o resto das condicoes iniciais */
(.|\n)                                      {ECHO;}

%%

int yywrap()
{
return 1;
}


/** Assume-se para este exercicio que os nomes dos autores estao escritos em
 * caracteres ASCII. Numa melhoria futura poder-se-a adicionar condicoes para
 * manipulacao de carateres em UTF-8*/
int main ()
{


yylex();




return (0);
}














