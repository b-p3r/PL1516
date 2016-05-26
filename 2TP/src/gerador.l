%{

%}

letra [A-Za-z]
digito [0-9]
lixo .|\n

%%

[-/;,\[\]=><!+\(\)\{\}%]  {return (yytext[0]);}
(AND)                     {return AND;}
(OR)                      {return OR;}
(NOT)                     {return NOT;}
(BEGI)                   {return BEGI;}
(END)                     {return END;}
(READ)                    {return READ;}
(WRITE)                   {return WRITE;}
(VAR)                     {return VAR;}
(WHILE)                   {return WHILE;}
(IF)                      {return IF;}
(ELSE)                    {return ELSE;}
(DO)                      {return DO;}
\"[^"]+\"                 {yylval.valString = strdup(yytext); return string;}
{digito}+                 {yylval.valNro = atof(yytext); return num;}
{letra}+                  {yylval.valID= strdup(yytext); return id;}
{lixo}                    {;}

%%

int yywrap() {
       return 1;
}
