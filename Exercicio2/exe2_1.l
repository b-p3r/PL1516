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

int counter[14];

%}


%%

\@[Aa][Rr][Tt][Ii][Cc][Ll][Ee]                          {counter[ARTICLE      ]++;}

\@[Bb][Oo][Oo][Kk][Ll][Ee][Tt]                          {counter[BOOKLET      ]++;}

\@[Bb][Oo][Oo][Kk]                                      {counter[BOOK         ]++;}

\@[Cc][Oo][Nn][Ff][Ee][Rr][Ee][Nn][Cc][Ee]              {counter[CONFERENCE   ]++;}

\@[Ii][Nn][Bb][Oo][Oo][Kk]                              {counter[INBOOK       ]++;}

\@[Ii][Nn][Cc][Oo][Ll][Ll][Ee][Cc][Tt][Ii][Oo][Nn]      {counter[INCOLLECTION ]++;}

\@[Ii][Nn][Pp][Rr][Oo][Cc][Ee][Ee][Dd][Ii][Nn][Gg][Ss]  {counter[INPROCEEDINGS]++;}

\@[Mm][Aa][Nn][Uu][A][Ll]                               {counter[MANUAL       ]++;}

\@[Mm][Aa][Ss][Tt][Ee][Rr][Ss][Tt][Hh][Ee][Ss][Ii][Ss]  {counter[MASTERSTHESIS]++;}

\@[Mm][Ii][Ss][Cc]                                      {counter[MISC         ]++;}

\@[Pp][Hh][Dd][Tt][H][Ee][Ss][Ii][Ss]                   {counter[PHDTHESIS    ]++;}

\@[Pp][Rr][Oo][Cc][Ee][Ee][Dd][Ii][Nn][Gg][Ss]          {counter[PROCEEDINGS  ]++;}

\@[Tt][Ee][Cc][Hh][Rr][Ee][Pp][Oo][Rr][Tt]              {counter[TECHREPORT   ]++;}

\@[Uu][Nn][Pp][Uu][Bb][Ll][Ii][Ss][Hh][Ee][Dd]          {counter[UNPUBLISHED  ]++;}

.|\n {;}

%%


int yywrap(){ return 1; } 


int main (){

int i;

for (i = 0; i < 14; counter[i++]=0);

yylex();
//Cabeçalho da página

//ListItems

//printf("number of identifiers = %d\n", count);

printf("Article       %d \n ", atoi(counter[ARTICLE      ])); 
printf("Booklet       %d \n ", atoi(counter[BOOKLET      ])); 
printf("Book          %d \n ", atoi(counter[BOOK         ])); 
printf("Conference    %d \n ", atoi(counter[CONFERENCE   ])); 
printf("Inbook        %d \n ", atoi(counter[INBOOK       ])); 
printf("Incollection  %d \n ", atoi(counter[INCOLLECTION ])); 
printf("Inproceedings %d \n ", atoi(counter[INPROCEEDINGS])); 
printf("Manual        %d \n ", atoi(counter[MANUAL       ])); 
printf("Mastersthesis %d \n ", atoi(counter[MASTERSTHESIS])); 
printf("Misc          %d \n ", atoi(counter[MISC         ])); 
printf("Phdthesis     %d \n ", atoi(counter[PHDTHESIS    ])); 
printf("Proceedings   %d \n ", atoi(counter[PROCEEDINGS  ])); 
printf("Techreport    %d \n ", atoi(counter[TECHREPORT   ])); 
printf("Unpublished   %d \n ", atoi(counter[UNPUBLISHED  ])); 


//Fim da página



return (0); }














