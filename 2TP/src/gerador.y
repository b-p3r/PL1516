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
    typedef struct auxvar {
        Type val_type;
        Entry *entry;
        char *s;
    } Var;
    Program_status *status = NULL;
    char   *add_label ( CompoundInstruction cpd )
    {
        push_label_stack ( status, cpd );
        return push_label ( status, cpd );
    }
    void remove_label ( CompoundInstruction cpd )
    {
        pop_label ( status, cpd );
        reset_label_stack ( status, cpd );
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
%type<instr>Factor
%type<instr>ExpAdditiv
%type<instr>Term
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

    if ( entry == NULL )
    {
        printf ( "pushi 0\n" );
        add_Variable ( status, $1, Integer, Variable, Program );
        $$.val_type = Integer;
    }

    else
    {
        printf ( "Erro!! Variável já existe!\n" );
        exit ( -1 );
    }

// *INDENT-OFF*
}
| id '[' num ']'              
{
// *INDENT-ON*
    Entry *entry =  find_identifier ( status, $1 );

    if ( entry==NULL )
    {
       add_Array ( status, $1, Integer, Array, $3, Program );
       printf ( "pushn %d\n", $3 );
       $$.val_type = Integer;
    }

else
{
    printf ( "Erro!! Variável já existe!\n" );
    exit ( -1 );
}

// *INDENT-OFF*
}   
| id '[' num ']' '[' num ']'  
{
// *INDENT-ON*
    Entry *entry =  find_identifier ( status, $1 );

    if ( entry==NULL )
    {
       add_Matrix ( status, $1, Integer, Matrix, $3*$6, $6, Program );
       printf ( "pushn %d\n", $3*$6 );
       $$.val_type = Integer;
    }

else
{
    printf ( "Erro!! Variável já existe!\n" );
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
    {
        int address = get_address ( entry );
        asprintf ( &$$.s, "pushg %d\n", address );
        $$.val_type=Integer;
        $$.entry=entry;
    }

    else
    {
        printf ( "Erro!! Variável não está declarada!\n" );
        exit ( -1 );
    }

// *INDENT-OFF*
}
| id '[' ExpAdditiv ']'       
{
// *INDENT-ON*
    Entry *entry =  find_identifier ( status, $1 );

    if ( entry )
    {
       int address = get_address ( entry );
       asprintf ( &$$.s, "pushgp\npushg %d\npadd\n%s",address, $3.s );
       $$.val_type=Integer;
       $$.entry=entry;
    }

else
{
    printf ( "Erro!! Variável não está declarada!\n" );
    exit ( -1 );
}

// *INDENT-OFF*
}
| id '[' ExpAdditiv ']' '[' ExpAdditiv ']' {
// *INDENT-ON*
    Entry *entry =  find_identifier ( status, $1 );

    if ( entry )
    {
       int address = get_address ( entry );
       int nRows = get_nRows ( entry );
       asprintf ( &$$.s, "pushgp\npushg %d\npadd\n%spushi %d\nmul\nadd\n%s",
                  address, $3.s, nRows, $6.s );
       $$.val_type=Integer;
       $$.entry=entry;
    }

else
{
    printf ( "Erro!! Variável não está declarada!\n" );
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
Factor : Constant              
{
// *INDENT-ON*
    $$.s=$1.s;

    $$.val_type=$1.val_type;
}
| Variable {
    // *INDENT-ON*
    $$.s=$1.s;
    $$.val_type=$1.val_type;
// *INDENT-OFF*
}
| '-''('Exp')'               
{
// *INDENT-ON*
    if ( check_type ( $3.val_type, Integer ) )
    {
        asprintf ( &$$.s, "%s pushi -1\nsub\n", $3.s );
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
    {
        $$.val_type=$3.val_type;
        $$.s=$3.s;
    }

    else {
        printf ( "Erro!! A condição não tem um valor booleano!!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}                          
;
Term : Factor            
{
    $$.s=$1.s;
    $$.val_type=$1.val_type;
}
|  Term '*' Factor       
{ 
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {
        asprintf ( &$$.s, "%s%smul\n", $1.s, $3.s );
        $$.val_type=$1.val_type;
    }

    else {
        printf ( "Erro!! A expressão não tem elementos do mesmo tipo !!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}   
|  Term '/' Factor       
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {
        asprintf ( &$$.s, "%s%sdiv\n", $1.s, $3.s );
        $$.val_type=$1.val_type;
    }

    else {
        printf ( "Erro!! A expressão não tem elementos do mesmo tipo !!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
|  Term '%' Factor       
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {
        asprintf ( &$$.s, "%s%smod\n", $1.s, $3.s );
        $$.val_type=$1.val_type;
    }

    else {
        printf ( "Erro!! A expressão não tem elementos do mesmo tipo !!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
|  Term AND Factor       
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Boolean ) &&check_type ( $3.val_type, Boolean ) )
    {
        asprintf ( &$$.s, "%s%smul\n", $1.s, $3.s );
        $$.val_type=Boolean;
    }

    else {
        printf ( "Erro!! A expressão não tem elementos do mesmo tipo !!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
;                                             
ExpAdditiv : Term      
{
// *INDENT-ON*
    $$.s=$1.s;

    $$.val_type=$1.val_type;

// *INDENT-OFF*
}
| ExpAdditiv '+' Term  
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {
        asprintf ( &$$.s, "%s%sadd  \n", $1.s, $3.s    );
        $$.val_type=$1.val_type;
    }

    else {
        printf ( "Erro!! A expressão não tem elementos do mesmo tipo !!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
| ExpAdditiv '-' Term  
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {
        asprintf ( &$$.s, "%s%ssub  \n", $1.s, $3.s    );
        $$.val_type=$1.val_type;
    }

    else {
        printf ( "Erro!! A expressão não tem elementos do mesmo tipo !!" );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
| ExpAdditiv OR  Term  
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Boolean ) &&check_type ( $3.val_type, Boolean ) )
    {
        asprintf ( &$$.s, "%s%sadd  \n", $1.s, $3.s    );
        $$.val_type=Boolean;
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
    {
        asprintf ( &$$.s, "%s%sinf  \n", $1.s, $3.s    );
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
    {
        asprintf ( &$$.s, "%s%ssup  \n", $1.s, $3.s    );
        $$.val_type=Boolean;
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
    {
        asprintf ( &$$.s, "%s%ssupeq\n", $1.s, $3.s    );
        $$.val_type=Boolean;
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
    {
        asprintf ( &$$.s, "%s%sinfeq\n", $1.s, $3.s    );
        $$.val_type=Boolean;
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
    {
        asprintf ( &$$.s, "%s%sequal\n", $1.s, $3.s    );
        $$.val_type=Boolean;
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
    {
        asprintf ( &$$.s, "%s%sequal\nnot\n", $1.s, $3.s );
        $$.val_type=Boolean;
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
    if ( !check_type ( $1.val_type, Integer ) || !check_type ( $3.val_type, Integer ) )
    {
        printf ( "Erro!!Os tipo de elementos da atribuição não são iguais!\n" );
        exit ( -1 );
    }

    if ( get_class ( $1.entry ) == Matrix || get_class ( $1.entry ) == Array )
    {
        asprintf ( &$$.s, "%s%sstoren\n", $1.s, $3.s );
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

    pop_label ( status,if_inst );

    asprintf ( &$<instr>$.s, "l1level%s:nop\n", get_label ( status,if_inst ) );

    remove_label ( if_inst );

// *INDENT-OFF*
} 
|            
ELSE '{' InstructionsList '}'          { 
// *INDENT-ON*
    char *tmp1 = add_label ( else_inst );

    char *tmp2 = get_label ( status,if_inst );

    remove_label ( else_inst );


    char *tmp = get_label ( status,else_inst );

    asprintf ( &$$.s, "jump l2level%s\nl1level%s:nop\n%sl2level%s:nop\n", tmp1,
    tmp2, $3.s,  tmp );

    remove_label ( else_inst );

// *INDENT-OFF*
}
Instruction : Atribution ';'           {$$.s=$1.s;}
| READ  Variable ';'      
{
// *INDENT-ON*
    //int address = get_address ( $2.entry );

    //asprintf ( &$$.s,"%spushg %d\nread\n", $2.s, address );
    asprintf ( &$$.s,"%sread\n", $2.s);

// *INDENT-OFF*
}
| WRITE ExpAdditiv ';'    
{
// *INDENT-ON*
    if ( check_type ( $2.val_type, Integer ) )
    {
        asprintf ( &$$.s,"%swritei\n", $2.s );
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
    {
        asprintf ( &$<instr>$.s,"%s", $3.s );
        printf ( "jz l1level%s\t\n", add_label ( if_inst ) );
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
    asprintf ( &$$.s,"%s%s", $7.s,$9.s );

// *INDENT-OFF*
} 
| WHILE '(' Exp ')' { 
// *INDENT-ON*
    if ( check_type ( $3.val_type, Boolean ) )
    {
        printf ( "whileloop%s:nop\n", add_label ( while_inst ) );
        asprintf ( &$<instr>$.s,"%s", $3.s );
        printf ( "%sjz whiledone%s\n", $3.s, get_label ( status,while_inst ) );
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
    char *tmp =  get_label ( status,while_inst );

    pop_label ( status,while_inst );

    asprintf ( &$<instr>$.s, "%sjump whileloop%s\nwhiledone%s:nop\n", $7.s,
    tmp,  tmp );

    remove_label ( while_inst );

// *INDENT-OFF*
}
| DO '{' InstructionsList '}' WHILE '(' Exp ')' ';' 

{ 
// *INDENT-ON*
    if ( check_type ( $7.val_type, Boolean ) )
    {
        char *tmp = add_label ( do_while_inst );
        asprintf ( &$$.s,"loop%s:nop\n%s%sjz loop%s\t\n", tmp, $3.s,  $7.s, tmp );
        remove_label ( do_while_inst );

    } else {
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
{
    printf ( "Erro sintático %d: %s em %s\n", yylineno, mensagem, yytext );
    return 0;
}

int main()
{
    status = ( Program_status * ) malloc ( sizeof ( struct stat ) );
    status = init ( status );

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

