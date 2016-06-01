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
    typedef struct aux
    {   Type val_type;
        char *s;
    } Instr;
    typedef struct auxvar
    {   Type val_type;
        Entry *entry;
        char *s;
    } Var;
    Program_status *status = NULL;
    char   *add_label ( CompoundInstruction cpd )
    {   push_label_stack ( status, cpd );
        return push_label ( status, cpd );
    }
    void remove_label ( CompoundInstruction cpd )
    {   reset_label_stack ( status, cpd );
        pop_label_stack ( status, cpd );
    }
    int yyerror ( char *s );
// *INDENT-OFF*
%}
%union{char * val_string; int val_nro; char* val_id;  Instr instr; Var var;}
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
%type<var> Variable
%start Program
%%
Program : Declarations Body    {printf("%s", $2.s);} 
;
Body : BEGINNING {printf("start\n");} InstructionsList END      {asprintf(&$$.s, "%sstop\n", $3.s);}
;
Declaration : id              
{
// *INDENT-ON*
    Entry *entry =  find_identifier ( status, $1 );

    if ( entry )
    {   printf ( "pushi 0\n" );
        add_Variable ( status, $1, Integer, Variable, Program );
        $$.val_type = Integer;
    }

    else
    {   printf ( "Erro!! Variável já existe!\n" );
        exit ( -1 );
    }

// *INDENT-OFF*
}
| id '[' num ']'              
{
// *INDENT-ON*
    Entry *entry =  find_identifier ( status, $1 );

    if ( entry )
    {   add_Array ( status, $1, Integer, Array, $3, Program );
        printf ( "pushn %d\n", $3 );
        $$.val_type = Integer;
    }

else
{   printf ( "Erro!! Variável já existe!\n" );
    exit ( -1 );
}

// *INDENT-OFF*
}   
| id '[' num ']' '[' num ']'  
{
// *INDENT-ON*
    Entry *entry =  find_identifier ( status, $1 );

    if ( entry )
    {   add_Matrix ( status, $1, Integer, Matrix, $3*$6, $6, Program );
        printf ( "pushn %d\n", $3*$6 );
        $$.val_type = Integer;
    }

else
{   printf ( "Erro!! Variável já existe!\n" );
    exit ( -1 );
}

// *INDENT-OFF*
}   
;
Declarations : VAR DeclarationsList ';'    {$$.s=$2.s;}   
;
DeclarationsList : Declaration             {$$.s=$1.s;}
| DeclarationsList ',' Declaration         {asprintf(&$$.s, "%s%s", $1.s, $3.s);}
;

Variable : id                 
{
// *INDENT-ON*
    Entry *entry =  find_identifier ( status, $1 );

    if ( entry )
    {   int address = get_address ( entry );
        asprintf ( &$$.s, "pushg %d\n", address );
        $$.val_type=Integer;
        $$.entry=entry;
    }

    else
    {   printf ( "Erro!! Variável não está declarada!\n" );
        exit ( -1 );
    }

// *INDENT-OFF*
}
| id '[' ExpAdditiv ']'       
{
// *INDENT-ON*
    Entry *entry =  find_identifier ( status, $1 );

    if ( entry )
    {   int address = get_address ( entry );
        asprintf ( &$$.s, "pushgp\npushg %d\npadd\n%s",address, $3.s );
        $$.val_type=Integer;
        $$.entry=entry;
    }

    else
    {   printf ( "Erro!! Variável não está declarada!\n" );
        exit ( -1 );
    }

// *INDENT-OFF*
}
| id '[' ExpAdditiv ']' '[' ExpAdditiv ']' {
// *INDENT-ON*
    Entry *entry =  find_identifier ( status, $1 );

    if ( entry )
    {   int address = get_address ( entry );
        int nCols = get_nCols ( entry );
        asprintf ( &$$.s, "pushgp\npushg %d\npadd\n%spushi %d\nmul\nadd\n%s",
                   address, $3.s, nCols, $6.s );
        $$.val_type=Integer;
        $$.entry=entry;
    }

    else
    {   printf ( "Erro!! Variável não está declarada!\n" );
        exit ( -1 );
    }

// *INDENT-OFF*
}    
;
Constant : num  {
// *INDENT-ON*
    asprintf ( &$$.s, "pushi %d\n", $1 );

    $$.val_type = Integer;

// *INDENT-OFF*
}
         ;
Term : Constant              
{
// *INDENT-ON*
    $$.s=$1.s;

    $$.val_type=$1.val_type;
}
| Variable
{   // *INDENT-ON*
    $$.s=$1.s;
    $$.val_type=$1.val_type;
// *INDENT-OFF*
}
| '-''('Exp')'               
{
// *INDENT-ON*
    if ( check_type ( $3.val_type, Integer ) )
    {   asprintf ( &$$.s, "%s pushi -1\nsub\n", $3.s );
        $$.val_type=$3.val_type;
    }

    else {
        printf ( "Erro!! A condição não tem um valor inteiro!!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}
| '(' Exp ')'                
{
// *INDENT-ON*
    $$.s=$2.s;

    $$.val_type=$2.val_type;

// *INDENT-OFF*
}                          
| NOT '(' Exp ')'            
{
// *INDENT-ON*
    if ( check_type ( $3.val_type, Boolean ) )
    {   $$.val_type=$3.val_type;
        $$.s=$3.s;
    }

    else {
        printf ( "Erro!! A condição não tem um valor booleano!!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}                          
;
ExMultipl : Term            
{
    $$.s=$1.s;
    $$.val_type=$1.val_type;
}
|  ExMultipl '*' Term       
{ 
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {   asprintf ( &$$.s, "%s%smul\n", $1.s, $3.s );
        $$.val_type=$1.val_type;
    }

    else {
        printf ( "Erro!! A expressão não tem elementos do mesmo tipo !!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}   
|  ExMultipl '/' Term       
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {   asprintf ( &$$.s, "%s%sdiv\n", $1.s, $3.s );
        $$.val_type=$1.val_type;
    }

    else {
        printf ( "Erro!! A expressão não tem elementos do mesmo tipo !!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
|  ExMultipl '%' Term       
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {   asprintf ( &$$.s, "%s%smod\n", $1.s, $3.s );
        $$.val_type=$1.val_type;
    }

    else {
        printf ( "Erro!! A expressão não tem elementos do mesmo tipo !!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
|  ExMultipl AND Term       
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {   asprintf ( &$$.s, "%s%smul\n", $1.s, $3.s );
        $$.val_type=$1.val_type;
    }

    else {
        printf ( "Erro!! A expressão não tem elementos do mesmo tipo !!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
;                                             
ExpAdditiv : ExMultipl      
{
// *INDENT-ON*
    $$.s=$1.s;

    $$.val_type=$1.val_type;

// *INDENT-OFF*
}
| ExpAdditiv '+' ExMultipl  
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {   asprintf ( &$$.s, "%s%sadd  \n", $1.s, $3.s    );
        $$.val_type=$1.val_type;
    }

    else {
        printf ( "Erro!! A expressão não tem elementos do mesmo tipo !!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
| ExpAdditiv '-' ExMultipl  
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {   asprintf ( &$$.s, "%s%ssub  \n", $1.s, $3.s    );
        $$.val_type=$1.val_type;
    }

    else {
        printf ( "Erro!! A expressão não tem elementos do mesmo tipo !!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
| ExpAdditiv OR  ExMultipl  
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {   asprintf ( &$$.s, "%s%sadd  \n", $1.s, $3.s    );
        $$.val_type=$1.val_type;
    }

    else {
        printf ( "Erro!! A expressão não tem elementos do mesmo tipo !!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
;                                         
Exp : ExpAdditiv            
{
// *INDENT-ON*
    $$.s=$1.s;

    $$.val_type=$1.val_type;

// *INDENT-OFF*
}  
|  ExpAdditiv L   ExpAdditiv
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {   asprintf ( &$$.s, "%s%sinf  \n", $1.s, $3.s    );
        $$.val_type=Boolean;
    }

    else {
        printf ( "Erro!! A expressão não tem elementos do mesmo tipo !!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
|  ExpAdditiv G   ExpAdditiv
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {   asprintf ( &$$.s, "%s%ssup  \n", $1.s, $3.s    );
        $$.val_type=$1.val_type;
    }

    else {
        printf ( "Erro!! A expressão não tem elementos do mesmo tipo !!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
|  ExpAdditiv GEQ ExpAdditiv
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {   asprintf ( &$$.s, "%s%ssupeq\n", $1.s, $3.s    );
        $$.val_type=$1.val_type;
    }

    else {
        printf ( "Erro!! A expressão não tem elementos do mesmo tipo !!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
|  ExpAdditiv LEQ ExpAdditiv
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {   asprintf ( &$$.s, "%s%sinfeq\n", $1.s, $3.s    );
        $$.val_type=$1.val_type;
    }

    else {
        printf ( "Erro!! A expressão não tem elementos do mesmo tipo !!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
|  ExpAdditiv EQ  ExpAdditiv
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {   asprintf ( &$$.s, "%s%sequal\n", $1.s, $3.s    );
        $$.val_type=$1.val_type;
    }

    else {
        printf ( "Erro!! A expressão não tem elementos do mesmo tipo !!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
|  ExpAdditiv NEQ ExpAdditiv
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {   asprintf ( &$$.s, "%s%sequal\nnot\n", $1.s, $3.s );
        $$.val_type=$1.val_type;
    }

    else {
        printf ( "Erro!! A expressão não tem elementos do mesmo tipo !!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
;                                      
Atribution :  Variable '=' ExpAdditiv    {
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {   printf ( "Erro!!Os tipo de elementos da atribuição não são iguais!\n" );
        exit ( -1 );
    }

    if ( get_class ( $1.entry ) == Matrix || get_class ( $1.entry ) == Array )
    {   asprintf ( &$$.s, "%s%sstoren\n", $1.s, $3.s );
    }

    else {
        int address = get_address ( $1.entry );
        asprintf ( &$$.s, "%s%sstoreg %d\n", $1.s, $3.s, address );
    }
// *INDENT-OFF*
}
;
InstructionsList : Instruction           {$$.s=$1.s;}
| InstructionsList Instruction           {asprintf(&$$.s, "%s%s", $1.s, $2.s);}
;
Else :         {
// *INDENT-ON*
    is_only_if=1;

    pop_label ( status,if_inst );

    char *tmp = get_label ( status,if_inst );

    printf ( "l1level%s:nop\n", tmp );

    //printf("l1level%s:nop\n", tmp);
    free ( tmp );

    reset_label_stack ( status,if_inst );

    pop_label_stack ( status, if_inst );

// *INDENT-OFF*
} 
|            
ELSE '{' InstructionsList '}'          { 
// *INDENT-ON*
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
    char *tmp = get_label ( status,else_inst );

    asprintf ( &$$.s, "%sl2level%s:nop\n", $3.s,  tmp );

    free ( tmp );

    reset_label_stack ( status,else_inst );

    pop_label_stack ( status, else_inst );

    //asprintf(&$$.s,"%s l2level%s:nop\n", $4.s, get_label(status, else_inst));
    //remove_label(if_inst);
// *INDENT-OFF*
}
Instruction : Atribution ';'           {$$.s=$1.s;}
| READ  Variable ';'      
{
// *INDENT-ON*
    int address = get_address ( $2.entry );

    asprintf ( &$$.s,"%spushg %d\nread\n", $2.s, address );

// *INDENT-OFF*
}
| WRITE ExpAdditiv ';'    
{
// *INDENT-ON*
    if ( check_type ( $2.val_type, Integer ) )
    {   asprintf ( &$$.s,"%swritei\n", $2.s );
    }

    else {
        printf ( "erro!! Não é possível escrever valores booleanos" );
        exit ( -1 );
    }
// *INDENT-OFF*
}
| WRITE string ';'        
{
// *INDENT-ON*
    asprintf ( &$$.s,"pushs %s\nwrites\n", $2 );

// *INDENT-OFF*
}
| IF '('  Exp ')' 
{
// *INDENT-ON*
    if ( check_type ( $3.val_type, Boolean ) )
    {   push_label_stack ( status, if_inst );
        char *tmp = push_label ( status,if_inst );
        asprintf ( &$<instr>$.s,"%s", $3.s );
        printf ( "%sjz l1level%s\t\n", $3.s, tmp );
        free ( tmp );
    }

    else {
        printf ( "Erro!! A condição não tem um valor booleano!!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}
'{' InstructionsList '}' 
Else          

{
// *INDENT-ON*
    if ( is_only_if==0 )
    {   push_label_stack ( status, else_inst );
        char *tmp1 = push_label ( status,else_inst );
        //printf("jz l2level%s\t\n",tmp1);
        pop_label ( status,else_inst );
        free ( tmp1 );
        char *tmp2 = get_label ( status,if_inst );
        printf ( "%sjump l2level%s\t\nl1level%s:nop\n", $7.s, tmp1, tmp2 );
        free ( tmp2 );
        reset_label_stack ( status,if_inst );
        pop_label_stack ( status, if_inst );
    }

    asprintf ( &$$.s,"%s%s", $7.s,$9.s );
    //asprintf(&$$.s, "%sjz l1level%s\nl1level%d: nop\n%s%s",$3.s, add_label(if_inst),
    //    get_label(status, if_inst),  $6.s, $8.s);
// *INDENT-OFF*
} 
| WHILE '(' Exp ')' { 
// *INDENT-ON*
    if ( check_type ( $3.val_type, Boolean ) )
    {   push_label_stack ( status, while_inst );
        char *tmp = push_label ( status,while_inst );
        asprintf ( &$<instr>$.s,"%s", $3.s );
        printf ( "whileloop%s:nop\n%s\t\n", tmp, $3.s );
        free ( tmp );
        //push_label_stack(status, while_inst);
        char *tmp2 = get_label ( status,while_inst );
        //asprintf(&$<instr>$.s,"%s", $3.s);
        printf ( "%sjz whiledone%s\t\n", $3.s, tmp2 );
        free ( tmp2 );
    }

    else {
        printf ( "Erro!! A condição não tem um valor booleano!!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}                      
'{' InstructionsList '}'  
{  
// *INDENT-ON*
    pop_label ( status,while_inst );

    char *tmp2 = get_label ( status,while_inst );

    //printf("jump whileloop%s\n",tmp2);
    free ( tmp2 );

    reset_label_stack ( status,while_inst );

    pop_label_stack ( status, while_inst );

    char *tmp1 = get_label ( status,while_inst );

    asprintf ( &$$.s, "jump whileloop%s\n%swhiledone%s:nop\n", tmp2, $7.s,  tmp1 );

    free ( tmp1 );

    reset_label_stack ( status,while_inst );

    pop_label_stack ( status, while_inst );

// *INDENT-OFF*
}
| DO '{' InstructionsList '}' WHILE '(' Exp ')' ';' 

{ 
// *INDENT-ON*
    if ( check_type ( $3.val_type, Boolean ) )
    {   //asprintf(&$$.s,"%sloop%s: nop\t\n%s jz loop%s\t\n", 
        //$3.s, add_label(do_while_inst),   $7.s, get_label(status, do_while_inst));
        //remove_label(do_while_inst);
    }
    else {
        printf ( "Erro!! A condição não tem um valor booleano!!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}
; 
%%
// *INDENT-ON*
#include "lex.yy.c"
int yyerror ( char *mensagem )
{   printf ( "Erro sintático %d: %s em %s\n", yylineno, mensagem, yytext );
    return 0;
}

int main()
{   status = ( Program_status * ) malloc ( sizeof ( struct stat ) );
    status = init ( status );
    printf ( "STATUS %p\n", status );

    if ( status==NULL )
        return -1;

    push_label_stack ( status, if_inst );
    push_label_stack ( status, else_inst );
    push_label_stack ( status, while_inst );
    push_label_stack ( status, do_while_inst );
    yyparse();
    pop_label_stack ( status, if_inst );
    pop_label_stack ( status, else_inst );
    pop_label_stack ( status, while_inst );
    pop_label_stack ( status, do_while_inst );
    return 0;
}

