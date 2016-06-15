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
Body : BEGINNING {printf("start\n");} InstructionsList END      {asprintf(&$$.s,
     "%sstop\n", $3.s);}
;
Declaration : id              
{
// *INDENT-ON*
    Entry *entry =  find_identifier ( status, $1 );

    if ( entry == NULL )
    {
        printf ( "\tpushi 0\n" );
        add_Variable ( status, $1, Integer, Variable, Program );
        $$.val_type = Integer;
    }

    else
    {
        yyerror( "Variável já existe\n" );
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
        printf ( "\tpushn %d\n", $3 );
        $$.val_type = Integer;
    }

else
{
    yyerror( "Variável já existe\n" );
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
add_Matrix ( status, $1, Integer, Matrix, $3*$6, $3, Program );
    printf ( "\tpushn %d\n", $3*$6 );
    $$.val_type = Integer;
}

else
{
    yyerror( "Variável já existe\n" );
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

    if ( entry&&get_class(entry)==Variable)
    {
        //int address = get_address ( entry );
        //asprintf ( &$$.s, "\t ");
        $$.val_type=Integer;
        $$.entry=entry;
    }

    else
    {
        yyerror( "Variável não está declarada" );
        exit ( -1 );
    }

// *INDENT-OFF*
}
| id '[' ExpAdditiv ']'       
{
// *INDENT-ON*
    Entry *entry =  find_identifier ( status, $1 );

    if ( entry&&get_class(entry)==Array)
    {
    int address = get_address ( entry );
        asprintf ( &$$.s, "\tpushgp\n\tpushg %d\n\tpadd\n%s",address, $3.s );
        $$.val_type=Integer;
        $$.entry=entry;
    }
    
    else
    {
        yyerror( "Variável não está declarada" );
        exit ( -1 );
    }

// *INDENT-OFF*
}
| id '[' ExpAdditiv ']' '[' ExpAdditiv ']' {
// *INDENT-ON*
    Entry *entry =  find_identifier ( status, $1 );

    if ( entry&&get_class(entry)==Matrix)
    {
    int address = get_address ( entry );
    int nRows = get_nRows ( entry );
    asprintf ( &$$.s, "\tpushgp\n\tpushg %d\n\tpadd\n\tpushi %d\n%s\tmul\n%s\tadd\n",
               address, nRows, $3.s, $6.s );
    $$.val_type=Integer;
    $$.entry=entry;
    }
    
    else
    {
        yyerror( "Variável não está declarada" );
        exit ( -1 );
    }

// *INDENT-OFF*
}    
;
Constant : num  {
// *INDENT-ON*
    asprintf ( &$$.s, "\tpushi %d\n", $1 );

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
    if ( get_class ( $1.entry ) == Matrix || get_class ( $1.entry ) == Array )
    {
        asprintf ( &$$.s, "%s\tloadn\n", $1.s );
    }

    else {
        int address = get_address ( $1.entry );
        asprintf ( &$$.s, "\tpushg %d\n",  address );
    }
    //$$.s=$1.s;
    $$.val_type=$1.val_type;
// *INDENT-OFF*
}
| '-''('Exp')'               
{
// *INDENT-ON*
    if ( check_type ( $3.val_type, Integer ) )
    {
        asprintf ( &$$.s, "%s\tpushi -1\n\tsub\n", $3.s );
        $$.val_type=$3.val_type;
    }

    else {
        yyerror( "A condição não tem um valor inteiro" );
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
        yyerror( "A condição não tem um valor booleano" );
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
        asprintf ( &$$.s, "%s%s\tmul\n", $1.s, $3.s );
        $$.val_type=$1.val_type;
    }

    else {
        yyerror( "A expressão não tem elementos do mesmo tipo " );
        exit ( -1 );
    }
// *INDENT-OFF*
}   
|  Term '/' Factor       
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {
        asprintf ( &$$.s, "%s%s\tdiv\n", $1.s, $3.s );
        $$.val_type=$1.val_type;
    }

    else {
        yyerror( "A expressão não tem elementos do mesmo tipo " );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
|  Term '%' Factor       
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {
        asprintf ( &$$.s, "%s%s\tmod\n", $1.s, $3.s );
        $$.val_type=$1.val_type;
    }

    else {
        yyerror( "A expressão não tem elementos do mesmo tipo " );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
|  Term AND Factor       
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Boolean ) &&check_type ( $3.val_type, Boolean ) )
    {
        asprintf ( &$$.s, "%s%s\tmul\n", $1.s, $3.s );
        $$.val_type=Boolean;
    }

    else {
        yyerror( "A expressão não tem elementos do mesmo tipo " );
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
        asprintf ( &$$.s, "%s%s\tadd  \n", $1.s, $3.s    );
        $$.val_type=$1.val_type;
    }

    else {
        yyerror( "A expressão não tem elementos do mesmo tipo " );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
| ExpAdditiv '-' Term  
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {
        asprintf ( &$$.s, "%s%s\tsub  \n", $1.s, $3.s    );
        $$.val_type=$1.val_type;
    }

    else {
        yyerror( "A expressão não tem elementos do mesmo tipo " );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
| ExpAdditiv OR  Term  
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Boolean ) &&check_type ( $3.val_type, Boolean ) )
    {
        asprintf ( &$$.s, "%s%s\tadd  \n", $1.s, $3.s    );
        $$.val_type=Boolean;
    }

    else {
        yyerror( "A expressão não tem elementos do mesmo tipo " );
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
        asprintf ( &$$.s, "%s%s\tinf  \n", $1.s, $3.s    );
        $$.val_type=Boolean;
    }

    else {
        yyerror( "A expressão não tem elementos do mesmo tipo " );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
|  ExpAdditiv G   ExpAdditiv
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {
        asprintf ( &$$.s, "%s%s\tsup  \n", $1.s, $3.s    );
        $$.val_type=Boolean;
    }

    else {
        yyerror( "A expressão não tem elementos do mesmo tipo " );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
|  ExpAdditiv GEQ ExpAdditiv
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {
        asprintf ( &$$.s, "%s%s\tsupeq\n", $1.s, $3.s    );
        $$.val_type=Boolean;
    }

    else {
        yyerror( "A expressão não tem elementos do mesmo tipo " );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
|  ExpAdditiv LEQ ExpAdditiv
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {
        asprintf ( &$$.s, "%s%s\tinfeq\n", $1.s, $3.s    );
        $$.val_type=Boolean;
    }

    else {
        yyerror( "A expressão não tem elementos do mesmo tipo " );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
|  ExpAdditiv EQ  ExpAdditiv
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {
        asprintf ( &$$.s, "%s%s\tequal\n", $1.s, $3.s    );
        $$.val_type=Boolean;
    }

    else {
        yyerror( "A expressão não tem elementos do mesmo tipo " );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
|  ExpAdditiv NEQ ExpAdditiv
{
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer ) &&check_type ( $3.val_type, Integer ) )
    {
        asprintf ( &$$.s, "%s%s\tequal\n\tnot\n", $1.s, $3.s );
        $$.val_type=Boolean;
    }

    else {
        yyerror( "A expressão não tem elementos do mesmo tipo " );
        exit ( -1 );
    }
// *INDENT-OFF*
}  
;                                      
Atribution :  Variable '=' ExpAdditiv    {
// *INDENT-ON*
    if ( check_type ( $1.val_type, Integer )&& check_type ( $3.val_type, Integer ) )
    {
         if ( get_class ( $1.entry ) == Matrix || get_class ( $1.entry ) == Array )
         {
             asprintf ( &$$.s, "%s%s\tstoren\n", $1.s, $3.s );
         }

         else {
             int address = get_address ( $1.entry );
             asprintf ( &$$.s, "%s\tstoreg %d\n", $3.s, address );
         }
    }else {
        yyerror( "Os tipo de elementos da atribuição não são iguais" );
        exit ( -1 );
    }


// *INDENT-OFF*
}
;
InstructionsList : Instruction           {$$.s=$1.s;}
| InstructionsList Instruction           {asprintf(&$$.s, "%s%s", $1.s, $2.s);}
;
Else :         {
// *INDENT-ON*

    ///pop_label ( status,if_inst );

    asprintf ( &$$.s, "then%s:\tnop\n", get_label ( status,if_inst ) );



// *INDENT-OFF*
} 
|            
ELSE '{' InstructionsList '}'          { 
// *INDENT-ON*
    char *tmp1 = add_label ( else_inst );

    //char *tmp2 = get_label ( status,if_inst );
    char *tmp2 = get_label ( status, if_inst );

    //remove_label ( if_inst );


    char *tmp = get_label ( status,else_inst );

    asprintf ( &$$.s, "\tjump else%s\nthen%s:\tnop\n%selse%s:\tnop\n", tmp1,
    tmp2, $3.s,  tmp );

    remove_label ( else_inst );

// *INDENT-OFF*
}
Instruction : Atribution ';'           {$$.s=$1.s;}
| READ  Variable ';'      
{
    if ( get_class ( $2.entry ) == Matrix || get_class ( $2.entry ) == Array )
    {
        asprintf ( &$$.s, "%s\tread\n\tatoi\n\tstoren\n", $2.s);
    }

    else {
        int address = get_address ( $2.entry );
        asprintf ( &$$.s, "\tread\n\tatoi\n\tstoreg %d\n", address);
    }
// *INDENT-OFF*
}
| WRITE ExpAdditiv ';'    
{
// *INDENT-ON*
    if ( check_type ( $2.val_type, Integer ) )
    {
        asprintf ( &$$.s,"%s\twritei\n", $2.s );
    }

    else {
        yyerror( "Não é possível escrever valores booleanos" );
        exit ( -1 );
    }
// *INDENT-OFF*
}
| WRITE string ';'        
{
// *INDENT-ON*
    asprintf ( &$$.s,"\tpushs %s\n\twrites\n", $2 );

// *INDENT-OFF*
}
| IF { add_label( if_inst); } '('  Exp ')' '{' InstructionsList '}' 
Else          
{
// *INDENT-ON*
    if ( check_type ( $4.val_type, Boolean ) )
    {
       asprintf ( &$$.s,"%s\tjz then%s\n%s%s", $4.s, get_label
       ( status, if_inst), $7.s,$9.s);
        //printf ( "\tjz then%s\n", add_label ( if_inst ) );
        //asprintf ( &$<instr>$.s,"%s", $3.s );
        //printf ( "\tjz then%s\n", add_label ( if_inst ) );
        remove_label ( if_inst );
    }

    else {
         yyerror( "A condição não tem um valor booleano");
        exit ( -1 );
    }

    //asprintf ( &$$.s,"%s%s", $7.s,$9.s );

// *INDENT-OFF*
} 
| WHILE '(' Exp ')' '{' InstructionsList '}'  
{ 
// *INDENT-ON*
    if ( check_type ( $3.val_type, Boolean ) )
    {
        char *tmp = add_label ( while_inst );
        asprintf ( &$$.s,"wloop%s:\tnop\n%s\tjz wdone%s\n%s\tjump wloop%s\nwdone%s:\tnop\n", tmp, $3.s, tmp, $6.s, tmp, tmp );
        remove_label ( while_inst );

    } else {
        yyerror( "A condição não tem um valor booleano" );
        exit ( -1 );
    }
// *INDENT-OFF*
}
| DO '{' InstructionsList '}' WHILE '(' Exp ')' ';' 

{ 
// *INDENT-ON*
    if ( check_type ( $7.val_type, Boolean ) )
    {
        char *tmp = add_label ( do_while_inst );
        asprintf ( &$$.s,"doloop%s:\tnop\n%s%s\tjz dodone%s\tjump doloop%s\n\tdodone%s:\tnop\n\n", tmp, $3.s,  $7.s, tmp,tmp, tmp );
        remove_label ( do_while_inst );

    } else {
        yyerror( "A condição não tem um valor booleano" );
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

    printf ( "Erro sintático %d: %s em %s\n", yylineno, mensagem, yytext);
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

