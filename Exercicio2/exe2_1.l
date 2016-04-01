%{
#define ARTICLE         0        
#define BOOKLET         1
#define BOOK            2
#define CONFERENCE      3
#define INBOOK          4
#define INCOLLECTION    5
#define INPROCEEDINGS   6
#define MANUAL          7
#define MASTERSTHESIS   8
#define MISC            9
#define PHDTHESIS       10
#define PROCEEDINGS     11
#define TECHREPORT      12
#define UNPUBLISHED     13
#include <stdlib.h>
#include <stdio.h>
#include "./structures/trie.h"

int counter[14];
TRIE * dicionario;

%}


%%

\@[Aa][Rr][Tt][Ii][Cc][Ll][Ee]              {counter[ARTICLE]++;}

\@[Bb][Oo][Oo][Kk][Ll][Ee][Tt]              {counter[BOOKLET]++;}

\@[Bb][Oo][Oo][Kk]                          {counter[BOOK]++;}

\@[Cc][Oo][Nn][Ff][Ee][Rr][Ee][Nn][Cc][Ee]  {counter[CONFERENCE]++;}

\@[Ii][Nn][Bb][Oo][Oo][Kk]                  {counter[INBOOK]++;}

\@[Ii][Nn][Cc][Oo][Ll][Ll][Ee][Cc][Tt][Ii][Oo][Nn] {counter[INCOLLECTION]++;}

\@[Ii][Nn][Pp][Rr][Oo][Cc][Ee][Ee][Dd][Ii][Nn][Gg][Ss] {counter[INPROCEEDINGS]++;}

\@[Mm][Aa][Nn][Uu][Aa][Ll]                     {counter[MANUAL]++;}

\@[Mm][Aa][Ss][Tt][Ee][Rr][Ss][Tt][Hh][Ee][Ss][Ii][Ss] {counter[MASTERSTHESIS]++;}

\@[Mm][Ii][Ss][Cc]                            {counter[MISC]++;}

\@[Pp][Hh][Dd][Tt][Hh][Ee][Ss][Ii][Ss]         {counter[PHDTHESIS]++;}

\@[Pp][Rr][Oo][Cc][Ee][Ee][Dd][Ii][Nn][Gg][Ss] {counter[PROCEEDINGS]++;}

\@[Tt][Ee][Cc][Hh][Rr][Ee][Pp][Oo][Rr][Tt]     {counter[TECHREPORT]++;}

\@[Uu][Nn][Pp][Uu][Bb][Ll][Ii][Ss][Hh][Ee][Dd] {counter[UNPUBLISHED]++;}

\@[Ss][Tt][Rr][Ii][Nn][Gg]                       {;}
\@[A-Za-z]+ {TRIE_insert(dicionario, strdup(yytext + 1));}

.|\n {;}

%%

int yywrap()
{
    return 1;
}


int main ()
{

    int i;

    for (i = 0; i < 14; counter[i++]=0);
    dicionario=TRIE_init();

    yylex();

//Criacao do output em HTML


    printf("<!DOCTYPE html>                  \n");
    printf("<html>                           \n");
    printf("<head>                           \n");
    printf("   <style>                       \n");
    printf("     table, th, td {             \n");
    printf("      border: 1px solid black;   \n");
    printf("      border-collapse: collapse; \n");
    printf("    }                            \n");
    printf("   </style>                      \n");
    printf("</head>                          \n");

    printf("<body>                           \n");

    printf("   <table width=400>             \n");

    printf("       <tr>\n");
    printf("           <td>Article</td>      \n");
    printf("           <td> %d </td>         \n", counter[ARTICLE      ]);
    printf("       </tr>                      \n");
    printf("       <tr>                     \n");
    printf("           <td>Booklet</td>      \n");
    printf("           <td> %d </td>         \n", counter[BOOKLET      ]);
    printf("       </tr>                      \n");
    printf("       <tr>                     \n");
    printf("           <td>Book</td>         \n");
    printf("           <td> %d </td>         \n", counter[BOOK         ]);
    printf("       </tr>                      \n");
    printf("       <tr>                     \n");
    printf("           <td>Conference</td>   \n");
    printf("           <td> %d </td>         \n", counter[CONFERENCE   ]);
    printf("       </tr>                      \n");
    printf("       <tr>                     \n");
    printf("           <td>Inbook</td>       \n");
    printf("           <td> %d </td>         \n", counter[INBOOK       ]);
    printf("       </tr>                      \n");
    printf("       <tr>                     \n");
    printf("           <td>Incollection</td> \n");
    printf("           <td> %d </td>         \n", counter[INCOLLECTION ]);
    printf("       </tr>                      \n");
    printf("       <tr>                     \n");
    printf("           <td>Inproceedings</td>\n");
    printf("           <td> %d </td>         \n", counter[INPROCEEDINGS]);
    printf("       </tr>                      \n");
    printf("       <tr>                     \n");
    printf("           <td>Manual</td>       \n");
    printf("           <td> %d </td>         \n", counter[MANUAL       ]);
    printf("       </tr>                      \n");
    printf("       <tr>                     \n");
    printf("         <td>Master's Thesis</td>\n");
    printf("           <td> %d </td>         \n", counter[MASTERSTHESIS]);
    printf("       </tr>                      \n");
    printf("       <tr>                     \n");
    printf("           <td>Misc </td>        \n");
    printf("           <td> %d </td>         \n", counter[MISC         ]);
    printf("       </tr>                      \n");
    printf("       <tr>                     \n");
    printf("           <td>Phd Thesis</td>   \n");
    printf("           <td> %d </td>         \n", counter[PHDTHESIS    ]);
    printf("       </tr>                      \n");
    printf("       <tr>                     \n");
    printf("           <td>Proceedings</td>  \n");
    printf("           <td> %d </td>         \n", counter[PROCEEDINGS  ]);
    printf("       </tr>                      \n");
    printf("       <tr>                     \n");
    printf("           <td>Techreport</td>   \n");
    printf("           <td> %d </td>         \n", counter[TECHREPORT   ]);
    printf("       </tr>                      \n");
    printf("       <tr>                     \n");
    printf("           <td>Unpublished</td>  \n");
    printf("           <td> %d  </td>        \n", counter[UNPUBLISHED  ]);
    printf("       </tr>                     \n");

    if(TRIE_getTotalKeys(dicionario))
        TRIE_getAllKeys_HTML(dicionario);


    printf("   </table>                         \n");
    printf("</body>                             \n");

    printf("</html>                             \n");
//Fim da pagina



    return (0);
}














