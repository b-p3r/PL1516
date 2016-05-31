// *INDENT-OFF*
%{
// *INDENT-ON*
#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "./src/program_status.h"
#include "./src/entry.h"
#include "./src/types.h"
int yylex();
int yylineno;

typedef struct aux {
Type val_type;
char *s;

} Instr;

Program_status * status = NULL;
char *  add_label(CompoundInstruction cpd)
{

    push_label_stack(status, cpd);
    return push_label(status, cpd);
}
void remove_label(CompoundInstruction cpd)
{
    reset_label_stack(status, cpd);
    pop_label_stack(status, cpd);
}

    int yyerror(char *s);

// *INDENT-OFF*
%}

%union{char * val_string; int val_nro; char* val_id;  Instr instr;}

%token <val_id>id
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

%type<instr>Program
%type<instr>Declarations
%type<instr>Body
%type<instr>InstructionsList
%type<instr>Declaration
%type<instr>DeclarationsList
%type<instr>Else
%type<instr>Constant
%type<instr>Term
%type<instr>ExpAdditiv
%type<instr>ExMultipl
%type<instr>Exp
%type<instr>Atribution
%type<instr>Instruction



%type<val_id> Variable




%%

Program : Declarations Body                   
;
Body : BEGINNING {printf("start\n");} InstructionsList END      {printf("%sstop\n", $3.s); }
;
Declaration : id                           {printf("pushi 0\n");}
| id '[' num ']'                           {printf("pushn %d\n", $3 );}   
| id '[' num ']' '[' num ']'               {printf("pushn %d\n", $3*$6 );}   
;
Declarations : VAR DeclarationsList ';'    {$$=$2;}   
;
DeclarationsList : Declaration             {;}
| DeclarationsList ',' Declaration         {;}
;
Variable : id                              {printf("pushg %d\n", 1); 

	                                    //$$=Integer;
					    }

| id '[' ExpAdditiv ']'                    {printf("pushgp\npushg %d\npadd\n%s", 1, $3.s);
                                           //$$=Integer;
					   }    
| id '[' ExpAdditiv ']' '[' ExpAdditiv ']' {printf("pushgp\npushg %s\npadd\n%s\npushi %d\nmul\nadd\n%s\n", $1, $3.s, 20, $6.s );
                                           //$$=Integer;
					   }    
;


Constant : num  {printf("pushi %d\n", $1);};
	         
         ;
Term : Constant                           {$$=$1;}
| Variable                                {;}
| '-''('Exp')'                            {asprintf(&$$.s, "%s pushi -1\nsub\n", $3.s);      
                                          }
| '(' Exp ')'                             {$$=$2;}                          
| NOT '(' Exp ')'                         {$$=$3;}                          
;


ExMultipl : Term
|  ExMultipl '*' Term                    {asprintf(&$$.s, "mul\n");}  
|  ExMultipl '/' Term                    {asprintf(&$$.s, "div\n");}  
|  ExMultipl '%' Term                    {asprintf(&$$.s, "mod\n");}  
|  ExMultipl AND Term                    {asprintf(&$$.s, "mul\n");}  
;                                             

ExpAdditiv : ExMultipl                   {$$=$1;}
| ExpAdditiv '+' ExMultipl               {asprintf(&$$.s, "add\n");}  
| ExpAdditiv '-' ExMultipl               {asprintf(&$$.s, "sub\n");}  
| ExpAdditiv OR  ExMultipl               {asprintf(&$$.s, "add\n");}  
;                                         

Exp : ExpAdditiv                         {$$=$1;}  
|  ExpAdditiv L   ExpAdditiv             {asprintf(&$$.s, "inf\n"      );}  
|  ExpAdditiv G   ExpAdditiv             {asprintf(&$$.s, "sup\n"      );}  
|  ExpAdditiv GEQ ExpAdditiv             {asprintf(&$$.s, "supeq\n"    );}  
|  ExpAdditiv LEQ ExpAdditiv             {asprintf(&$$.s, "infeq\n"    );}  
|  ExpAdditiv EQ  ExpAdditiv             {asprintf(&$$.s, "equal\n"    );}  
|  ExpAdditiv NEQ ExpAdditiv             {asprintf(&$$.s, "equal\nnot\n");}  
;                                      


Atribution :  Variable '=' ExpAdditiv    {asprintf(&$$.s, "storeg %d\n", 1);
	                                //if($3==matriz||$3==array)
	   				//printf("loadn %s\n", $1);
					//get_type()
	                                //if($1==matriz||$1==array)
	   				//printf("storen\n");
				        //else	
	   				

					 }
;


InstructionsList : Instruction           {$$=$1;}
| InstructionsList Instruction           {asprintf(&$$.s, "%s %s", $1.s, $2.s);}
;

Else :        {  asprintf(&$$.s,"l1level%s: nop\n", get_label(status, if_inst));
                 remove_label(if_inst);
              } 

|             {  
                 printf("jz l2level%s\n", add_label(else_inst)); 
                 printf("l1level%s: nop\n", get_label(status, if_inst));
		         remove_label(if_inst);
	          }

ELSE '{' InstructionsList '}'          { asprintf(&$$.s,"%s l2level%s:nop\n", $4.s, get_label(status, else_inst)); 
		                                 remove_label(if_inst);
                                       }

Instruction : Atribution ';'           {$$=$1;}
| READ  Variable ';'                   {asprintf(&$$.s,"pushi %s\n", $2);}
| WRITE ExpAdditiv ';'                 {asprintf(&$$.s,"%swritei\n", $2.s);}   
| WRITE string ';'                     {asprintf(&$$.s,"pushs %s\nwrites\n", $2);
                                       
					}


| IF '('  Exp ')' '{' InstructionsList '}' Else          
                                       { asprintf(&$$.s, "%s jz l1level%s\n %s %s\n",$3.s, add_label(if_inst), $6.s, $8.s);  } 

				       






| WHILE 	                          
'(' Exp ')' 	                        
'{' InstructionsList '}'               { asprintf(&$$.s,"loop%s: nop\t\n%s\njump loop%s\n%sjz done%s\n",add_label(while_inst), $3.s, 
                                         get_label(status,while_inst), $6.s, get_label(status, while_inst)); 
                                         asprintf(&$$.s,"done%s: nop\n", get_label(status, while_inst ));
			                 remove_label(while_inst);
			               }

| DO '{' InstructionsList '}' WHILE '(' Exp ')' ';' 
                                       { asprintf(&$$.s,"loop%s: nop\t\n%s %s jz loop%s\t\n",add_label(do_while_inst),  $3.s, $7.s, get_label(status, do_while_inst));
                                                 remove_label(do_while_inst);
                                       }
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
    status = ( Program_status * ) malloc ( sizeof (struct stat) );
    status = init(status);
    printf("STATUS %p\n", status);
    if(status==NULL)
        return -1;

    push_label_stack(status, if_inst);
    push_label_stack(status, else_inst);
    push_label_stack(status, while_inst);
    push_label_stack(status, do_while_inst);
    yyparse();
    pop_label_stack(status, if_inst);
    pop_label_stack(status, else_inst);
    pop_label_stack(status, while_inst);
    pop_label_stack(status, do_while_inst);
    return 0;
}

