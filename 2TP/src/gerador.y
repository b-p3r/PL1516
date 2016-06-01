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

int is_only_if = 0;

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



%type<instr> Variable


%start Program

%%

Program : Declarations Body    {printf("%s", $2.s);} 
;
Body : BEGINNING {printf("start\n");} InstructionsList END      {asprintf(&$$.s, "%sstop\n", $3.s); }
;
Declaration : id                           {printf("pushi 0\n");}
| id '[' num ']'                           {printf("pushn %d\n", $3 );}   
| id '[' num ']' '[' num ']'               {printf("pushn %d\n", $3*$6 );}   
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

Else :         { 
is_only_if=1;
pop_label(status,if_inst);
char * tmp = get_label(status,if_inst);

printf("l1level%s:nop\n", tmp);
//printf("l1level%s:nop\n", tmp);
free(tmp);
reset_label_stack(status,if_inst);
pop_label_stack(status, if_inst);


              } 

|            

ELSE '{' InstructionsList '}'          { 
                                           
 

//push_label_stack(status, else_inst);
//char * tmp1 = push_label(status,else_inst);
//printf("jz l2level%s\t\n",tmp1);
//pop_label(status,else_inst);
//free(tmp1);
//char * tmp2 = get_label(status,if_inst);
//printf("%sjump l2level%s\t\nl1level%s:nop\n", $$.s, tmp1, tmp2);
//free(tmp2);
//reset_label_stack(status,if_inst);
//pop_label_stack(status, if_inst);

                 //printf("jz l2level%s\n", add_label(else_inst)); 
                 //printf("l1level%s: nop\n", get_label(status, if_inst));
		         //remove_label(if_inst);
	          
                                          char * tmp = get_label(status,else_inst);
                                          asprintf(&$$.s, "%sl2level%s:nop\n", $3.s,  tmp);
                                          free(tmp);
                                          reset_label_stack(status,else_inst);
                                          pop_label_stack(status, else_inst);

                                         //asprintf(&$$.s,"%s l2level%s:nop\n", $4.s, get_label(status, else_inst)); 
		                                 //remove_label(if_inst);
                                      
                                       }

Instruction : Atribution ';'           {$$.s=$1.s;}
| READ  Variable ';'                   {asprintf(&$$.s,"%spushi %d\nread\n", $2.s, 1);}
| WRITE ExpAdditiv ';'                 {asprintf(&$$.s,"%swritei %d\n", $2.s, 1);}   
| WRITE string ';'                     {asprintf(&$$.s,"pushs %s\nwrites\n", $2);
                                       
					}


| IF '('  Exp ')' 
{
push_label_stack(status, if_inst);
char * tmp = push_label(status,if_inst);
asprintf(&$<instr>$.s,"%s", $3.s);
printf("%sjz l1level%s\t\n", $3.s, tmp);
free(tmp);


}






'{' InstructionsList '}' 
Else          
                                          { 
if(is_only_if==0){
push_label_stack(status, else_inst);
char * tmp1 = push_label(status,else_inst);
//printf("jz l2level%s\t\n",tmp1);
pop_label(status,else_inst);
free(tmp1);
char * tmp2 = get_label(status,if_inst);
printf("%sjump l2level%s\t\nl1level%s:nop\n", $7.s, tmp1, tmp2);
free(tmp2);
reset_label_stack(status,if_inst);
pop_label_stack(status, if_inst);
}
asprintf(&$$.s,"%s%s", $7.s,$9.s);

//asprintf(&$$.s, "%sjz l1level%s\nl1level%d: nop\n%s%s",$3.s, add_label(if_inst), 
                                                 //    get_label(status, if_inst),  $6.s, $8.s);  
                                           } 

				       






| WHILE '(' Exp ')' 	{ 

push_label_stack(status, while_inst);
char * tmp = push_label(status,while_inst);
asprintf(&$<instr>$.s,"%s", $3.s);
printf("whileloop%s:nop\n%s\t\n", tmp, $3.s);
free(tmp);
//push_label_stack(status, while_inst);
char * tmp2 = get_label(status,while_inst);
//asprintf(&$<instr>$.s,"%s", $3.s);
printf("%sjz whiledone%s\t\n", $3.s, tmp2);
free(tmp2);


}                      
'{' InstructionsList '}'               {  pop_label(status,while_inst);
                                          char * tmp2 = get_label(status,while_inst);
                                          //printf("jump whileloop%s\n",tmp2);
                                          free(tmp2);
                                          reset_label_stack(status,while_inst);
                                          pop_label_stack(status, while_inst);

                                          char * tmp1 = get_label(status,while_inst);
                                          asprintf(&$$.s, "jump whileloop%s\n%swhiledone%s:nop\n", tmp2, $7.s,  tmp1);
                                          free(tmp1);
                                          reset_label_stack(status,while_inst);
                                          pop_label_stack(status, while_inst);
			               }

| DO '{' InstructionsList '}' WHILE '(' Exp ')' ';' 
                                       { 
                                         //asprintf(&$$.s,"%sloop%s: nop\t\n%s jz loop%s\t\n", $3.s, add_label(do_while_inst),   $7.s, get_label(status, do_while_inst));
                                         //remove_label(do_while_inst);
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

