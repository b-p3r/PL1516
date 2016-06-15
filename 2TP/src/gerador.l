%{

%}

letra [A-Za-z]
digito [0-9]
lixo .|\n
%option yylineno
%%

[-/;,\[\]+\(\)\{\}\%=]    {return (yytext[0]);}
(AND)                     {return AND;}
(OR)                      {return OR;}
(<)                       {return L;}
(>)                       {return G;}
(<=)                      {return LEQ;}
(>=)                      {return GEQ;}
(==)                      {return EQ;}
(!=)                      {return NEQ;}
(NOT)                     {return NOT;}
(BEGINNING)               {return BEGINNING;}
(END)                     {return END;}
(READ)                    {return READ;}
(WRITE)                   {return WRITE;}
(VAR)                     {return VAR;}
(WHILE)                   {return WHILE;}
(IF)                      {return IF;}
(ELSE)                    {return ELSE;}
(DO)                      {return DO;}
\"[^"]+\"                 {yylval.val_string = strdup(yytext); return string;}
{digito}+                 {yylval.val_nro = atoi(yytext); return num;}
{letra}+                  {yylval.val_id= strdup(yytext); return id;}
{lixo}                    {;}

%%

int yywrap() {
       return 1;
}
