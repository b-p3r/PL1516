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
int  add_label(CompoundInstruction cpd)
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



%type<instr> Variable


%start Program

%%

Program : Declarations Body    {printf("%s%s", $1.s, $2.s);} 
;
Body : BEGINNING {asprintf(&$<instr>$.s, "start\n");} InstructionsList END      {asprintf(&$$.s, "%sstop\n", $3.s); }
;
Declaration : id                           {asprintf(&$$.s, "pushi 0\n");}
| id '[' num ']'                           {asprintf(&$$.s, "pushn %d\n", $3 );}   
| id '[' num ']' '[' num ']'               {asprintf(&$$.s, "pushn %d\n", $3*$6 );}   
;
Declarations : VAR DeclarationsList ';'    {$$.s=$2.s;}   
;
DeclarationsList : Declaration             {$$.s=$1.s;}
| DeclarationsList ',' Declaration         {asprintf(&$$.s, "%s%s", $1.s, $3.s);}
;
Variable : id                              {asprintf(&$$.s, "pushg %d\n", 1); 

	                                    //$$=Integer;
					    }

| id '[' ExpAdditiv ']'                    {asprintf(&$$.s, "pushgp\npushg %s\npadd\n%s", $1, $3.s);
                                           //$$=Integer;
					   }    
| id '[' ExpAdditiv ']' '[' ExpAdditiv ']' {asprintf(&$$.s, "pushgp\npushg %s\npadd\n%s\npushi %d\nmul\nadd\n%s\n", $1, $3.s, 20, $6.s );
                                           //$$=Integer;
					   }    
;


Constant : num  {asprintf(&$$.s, "pushi %d\n", $1);};
	         
         ;
Term : Constant                           {$$.s=$1.s;}
| Variable                                {$$.s=$1.s;}
| '-''('Exp')'                            {asprintf(&$$.s, "%s pushi -1\nsub\n", $3.s);      
                                          }
| '(' Exp ')'                             {$$.s=$2.s;}                          
| NOT '(' Exp ')'                         {$$.s=$3.s;}                          
;


ExMultipl : Term
|  ExMultipl '*' Term                    {asprintf(&$$.s, "%s%smul\n", $1.s, $3.s);}  
|  ExMultipl '/' Term                    {asprintf(&$$.s, "%s%sdiv\n", $1.s, $3.s);}  
|  ExMultipl '%' Term                    {asprintf(&$$.s, "%s%smod\n", $1.s, $3.s);}  
|  ExMultipl AND Term                    {asprintf(&$$.s, "%s%smul\n", $1.s, $3.s);}  
;                                             

ExpAdditiv : ExMultipl                   {$$.s=$1.s;}
| ExpAdditiv '+' ExMultipl               {asprintf(&$$.s, "%s%sadd  \n", $1.s, $3.s    );}  
| ExpAdditiv '-' ExMultipl               {asprintf(&$$.s, "%s%ssub  \n", $1.s, $3.s    );}  
| ExpAdditiv OR  ExMultipl               {asprintf(&$$.s, "%s%sadd  \n", $1.s, $3.s    );}  
;                                         

Exp : ExpAdditiv                         {$$.s=$1.s;}  
|  ExpAdditiv L   ExpAdditiv             {asprintf(&$$.s, "%s%sinf  \n", $1.s, $3.s    );}  
|  ExpAdditiv G   ExpAdditiv             {asprintf(&$$.s, "%s%ssup  \n", $1.s, $3.s    );}  
|  ExpAdditiv GEQ ExpAdditiv             {asprintf(&$$.s, "%s%ssupeq\n", $1.s, $3.s    );}  
|  ExpAdditiv LEQ ExpAdditiv             {asprintf(&$$.s, "%s%sinfeq\n", $1.s, $3.s    );}  
|  ExpAdditiv EQ  ExpAdditiv             {asprintf(&$$.s, "%s%sequal\n", $1.s, $3.s    );}  
|  ExpAdditiv NEQ ExpAdditiv             {asprintf(&$$.s, "%s%sequal\nnot\n", $1.s, $3.s);}  
;                                      


Atribution :  Variable '=' ExpAdditiv    {asprintf(&$$.s, "%s%sstoreg %d\n", $1.s, $3.s, 1);
	                                //if($3==matriz||$3==array)
	   				//printf("loadn %s\n", $1);
					//get_type()
	                                //if($1==matriz||$1==array)
	   				//printf("storen\n");
				        //else	
	   				

					 }
;


InstructionsList : Instruction           {$$.s=$1.s;}
| InstructionsList Instruction           {asprintf(&$$.s, "%s%s", $1.s, $2.s);}
;

Else :        {  
                 
              } 

|            

ELSE '{' InstructionsList '}'          { 
                                         asprintf(&$$.s, "%sjz l2level%d\nsl1level%d: nop\n", $3.s,  add_label(else_inst)); 
                                         asprintf(&$$.s, "%sl1level%d: nop\n", get_label(status, if_inst));
		                         remove_label(if_inst);
                                         asprintf(&$$.s,"%sl2level%d:nop\n", $3.s, get_label(status, else_inst)); 
		                         remove_label(else_inst);
                                       }

Instruction : Atribution ';'           {$$.s=$1.s;}
| READ  Variable ';'                   {asprintf(&$$.s,"%spushi %d\nread\n", $2.s, 1);}
| WRITE ExpAdditiv ';'                 {asprintf(&$$.s,"%swritei %d\n", $2.s, 1);}   
| WRITE string ';'                     {asprintf(&$$.s,"pushs %s\nwrites\n", $2);
                                       
					}


| IF '('  Exp ')' '{' InstructionsList '}' Else          
                                       { asprintf(&$$.s, "%sjz l1level%d\nl1level%d: nop\n%s%s",$3.s, add_label(if_inst), get_label(status, if_inst),  $6.s, $8.s);  } 

				       






| WHILE 	                          
'(' Exp ')' 	                        
'{' InstructionsList '}'               { asprintf(&$$.s,"loop%d: nop\t\n%s\njump loop%d\n%sjz done%d\n",add_label(while_inst), $3.s, 
                                         get_label(status,while_inst), $6.s, get_label(status, while_inst)); 
                                         asprintf(&$$.s,"done%d: nop\n", get_label(status, while_inst ));
			                 remove_label(while_inst);
			               }

| DO '{' InstructionsList '}' WHILE '(' Exp ')' ';' 
                                       { asprintf(&$$.s,"%$loop%d: nop\t\n%s %s jz loop%d\t\n",add_label(do_while_inst),  $3.s, $7.s, get_label(status, do_while_inst));
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

