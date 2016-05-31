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
//%type<instr>Declarations
%type<instr>Body
%type<instr>InstructionsList
//%type<instr>Declaration
//%type<instr>DeclarationsList
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

Program : Declarations Body                 {;}  
;
Body : BEGINNING InstructionsList END       {;} 
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
| id '[' ExpAdditiv ']'                    {printf("pushgp\npushg %d\npadd\n", 1); }
| id '[' ExpAdditiv ']' '[' ExpAdditiv ']' {printf("pushgp\npushg %d\npadd\n", 1);
                                            printf("pushi %d\n", 20);
                                            printf("mul\n");
                                            printf("add\n"); 
                                           //$$=Integer;
					   }    
;



Constant : num  {printf("pushi %d\n", $1);
	         //$$=Integer;
                }
         ;
Term : Constant                           {$$=$1;}
| Variable                                {;}
| '-''('Exp')'                            {$$=$3; printf("pushi -1\n");      
                                           printf("sub\n");
                                          }
| '(' Exp ')'                             {$$=$2;}                          
| NOT '(' Exp ')'                         {$$=$3;}                          
;


ExMultipl : Term                         {$$=$1;}
|  ExMultipl '*' Term                    {$$.s=strdup("mul\n");}  
|  ExMultipl '/' Term                    {$$.s=strdup("div\n");}  
|  ExMultipl '%' Term                    {$$.s=strdup("mod\n");}  
|  ExMultipl AND Term                    {$$.s=strdup(mul);}  
;                                             

ExpAdditiv : ExMultipl                   {$$=$1;}
| ExpAdditiv '+' ExMultipl               {$$.s=strdup("add\n");}  
| ExpAdditiv '-' ExMultipl               {$$.s=strdup("sub\n");}  
| ExpAdditiv OR  ExMultipl               {$$.s=strdup("add\n");}  
;                                         

Exp : ExpAdditiv                         {$$=$1;}  
|  ExpAdditiv L   ExpAdditiv             {$$.s=strdup( "inf\n"       );}  
|  ExpAdditiv G   ExpAdditiv             {$$.s=strdup("sup\n"       );}  
|  ExpAdditiv GEQ ExpAdditiv             {$$.s=strdup("supeq\n"     );}  
|  ExpAdditiv LEQ ExpAdditiv             {$$.s=strdup("infeq\n"     );}  
|  ExpAdditiv EQ  ExpAdditiv             {$$.s=strdup("equal\n"     );}  
|  ExpAdditiv NEQ ExpAdditiv             {$$.s=strdup("equal\nnot\n");}  
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


| IF '('  Exp ')'                      {



printf("jz l1level%s\n", add_label(else_inst));



}

'{' InstructionsList '}' Else   {

                              
				                }



| WHILE 	                           { printf("loop%s: nop\t\n", add_label(while_inst)); }

'(' Exp ')' 	                       { printf("jz done%s\n", get_label(status,while_inst));}




'{' InstructionsList '}'               { printf("jump loop%s\n", get_label(status, while_inst)); 
                                         printf("done%s: nop\n", get_label(status, while_inst));
			                             remove_label(while_inst);
			               }

| DO                                   { printf("loop%s: nop\t\n", add_label(do_while_inst));
                                       }




'{' InstructionsList '}' WHILE '(' Exp ')' ';' { printf("jz loop%s\t\n", get_label(status, do_while_inst));
                                                 remove_label(do_while_inst);
                                               }
; 

Else :        {  
     
              printf("l1level%s: nop\n",get_label(status, if_inst)); 
              remove_label(if_inst);
	      
	      } 

|             {  
                printf("jz l2level%s\n", add_label(else_inst)); 
                 printf("l1level%s: nop\n", get_label(status, if_inst));
		         remove_label(if_inst);
	      }
ELSE '{' InstructionsList '}' { printf("l2level%s:nop\n", get_label(status, else_inst));
                                remove_label(if_inst); }
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

