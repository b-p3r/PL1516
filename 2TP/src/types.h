#ifndef TYPES_H_INCLUDED
#define TYPES_H_INCLUDED


typedef enum comp
{
if_inst,
else_inst,
while_inst,
do_while_inst


}CompoundInstruction;




typedef enum cl
{
    Variable,
    Array,
    Matrix,
    Function,
    Procedure,
    Nothing

}Class;

typedef enum lv
{
    Program,
    Subprogram


}Level;


typedef enum tp
{
    Any,
    Integer,
    Boolean

}Type;
#endif // TYPES_H_INCLUDED
