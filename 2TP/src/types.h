#ifndef TYPES_H_INCLUDED
#define TYPES_H_INCLUDED

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
