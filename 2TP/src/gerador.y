// *INDENT-OFF*
%{
// *INDENT-ON*
#include <stdio.h>
#include <string.h>
#include "./src/program_status.h"
#include "./src/entry.h"
#include "./src/types.h"
int yylex();
int yylineno;

Program_status * status;
char *  add_label(){

push_label_stack(status);
return push_label(status);
}
void remove_label(){
reset_label_stack(status);
pop_label_stack(status);
}
int yyerror(char *s);

// *INDENT-OFF*
%}

%union{char * val_string; int val_nro; char* val_id; Type val_type;}

%token <val_iD>id
%token <val_nro>num
%token <val_string>string
%token BEGINNING
%token END

%token VAR
%token G
%token L
%token GEQ
%token LEQ
%token EQ
%token NEQ
%token NOT
%token AND
%token OR
%token READ
%token WRITE
%token IF
%token ELSE
%token WHILE
%token DO

//%type <val_type> Program
//%type<val_type>Declarations
//%type<val_type>Body
//%type<val_type>Instructions_list
//%type<val_type>Declaration
//%type<val_type>Declarations_list



//%type<val_type>Atribution
//%type<val_type>Instruction
//%type<val_type>Else

%type<val_id>Variable

%type<val_type>Constant
%type<val_type>Term
%type<val_type>ExpAdditiv
%type<val_type>ExMultipl
%type<val_type>Exp


%%

Program : Declarations Body                   
;
Body : BEGINNING InstructionsList END         
;
Declaration : id                           {printf("pushi 0\n");}
| id '[' num ']'                           {printf("pushn %d\n", $3 );}   
| id '[' num ']' '[' num ']'               {printf("pushn %d\n", $3*$6 );}   
;
Declarations : VAR DeclarationsList ';'       
;
DeclarationsList : Declaration                
| DeclarationsList ',' Declaration            
;
Variable : id                              {printf("pushg %d\n", 1); 

	                                    //$$=Integer;
					    }
| id '[' ExpAdditiv ']' SecondDimension {printf("pushgp\npushg %d\npadd\n", 1);
                                           //$$=Integer;
					   }    
;

SecondDimension : 
		| '[' {printf("pushi %d\n", 20);}

		   ExpAdditiv 

		   ']' {printf("mul\n");
		        printf("add\n");       }
		;

Constant : num  {printf("pushi %d\n", $1);
	         $$=Integer;}
         ;
Term : Constant                           {$$=$1;}
| Variable                                {;}
| '-' Exp                                 {printf("pushi -1\n");      
                                           printf("sub\n");
                                          }
| '(' Exp ')'                             {$$=$2;}                          
| NOT '(' Exp ')'                         {$$=$3;}                          
;


ExMultipl : Term
|  ExMultipl '*' Term                    {printf("mul\n");}  
|  ExMultipl '/' Term                    {printf("div\n");}  
|  ExMultipl '%' Term                    {printf("mod\n");}  
|  ExMultipl AND Term                    {printf("mul\n");}  
;                                             

ExpAdditiv : ExMultipl                   {;}
| ExpAdditiv '+' ExMultipl               {printf("add\n");}  
| ExpAdditiv '-' ExMultipl               {printf("sub\n");}  
| ExpAdditiv OR  ExMultipl                {printf("add\n");}  
;                                         

Exp : ExpAdditiv                         {;}  
|  ExpAdditiv L   ExpAdditiv              {printf("inf\n");}  
|  ExpAdditiv G   ExpAdditiv              {printf("sup\n");}  
|  ExpAdditiv GEQ ExpAdditiv             {printf("supeq\n");}  
|  ExpAdditiv LEQ ExpAdditiv             {printf("infeq\n");}  
|  ExpAdditiv EQ  ExpAdditiv              {printf("equal\n");}  
|  ExpAdditiv NEQ ExpAdditiv             {printf("equal\nnot\n");}  
;                                      


Atribution :  Variable '=' ExpAdditiv    {
	                                //if($3==matriz||$3==array)
	   				//printf("loadn %s\n", $1);
					//get_type()
	                                //if($1==matriz||$1==array)
	   				//printf("storen\n");
				        //else	
	   				printf("storeg %d\n", 1);

					 }
;


InstructionsList : Instruction
| InstructionsList Instruction  
;


Instruction : Atribution ';'           
| READ  Variable ';'                   {printf("pushi %d\n", 1);}
| WRITE ExpAdditiv ';'                 {printf("writei\n");}   
| WRITE string ';'                     {printf("pushs %s\n", $2);
                                        printf("writes\n");
					}


| IF '('  Exp ')'                      {printf("jz l1level%s\n", add_label());



}

'{' InstructionsList '}' 
Else                                   {remove_label();}
| WHILE 	                       { printf("loop%s: nop\t\n", add_label()); }

'(' Exp ')' 	                       { printf("jz done%s\n", get_label(status));}




'{' InstructionsList '}'               { printf("jump loop%s\n", get_label(status)); 
                                         printf("done%s: nop\n", get_label(status));
			                 remove_label();
			               }

| DO                                   { printf("loop%s: nop\t\n", add_label());
                                       }




'{' InstructionsList '}' WHILE '(' Exp ')' ';' { printf("jz loop%s\t\n", get_label(status));
                                                 remove_label();
                                               }
; 

Else :        {  printf("l1level%s: nop\n", get_label(status)); } 

|             {  printf("jz l2level%s\n", get_label(status)); 
                 printf("l1level%s: nop\n", get_label(status));
	      }
ELSE '{' InstructionsList '}' { printf("l2level%s:nop\n", get_label(status)); }
;





%%
// *INDENT-ON*
#include "lex.yy.c"

int yyerror(char * mensagem)
{
    printf("Erro sintático %d: %s em %s\n", yylineno, mensagem, yytext);
    return 0;
}

int main()
{

    status = init();
    printf("STATUS %p", status);

    push_label_stack(status);
    yyparse();
    pop_label(status);
    return 0;
}

