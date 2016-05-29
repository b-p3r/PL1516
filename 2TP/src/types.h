#ifndef TYPES_INCLUDED
#define TYPES_INCLUDED


#include <stdlib.h>
#include "entry.h"

typedef enum cl
{
    variable,
    function,
    procedure,
    nothing

}Category;

typedef enum lv
{
    main_function,
    called_function


}Level;


typedef enum tp
{
    integer,
    array
}Type;
#endif // TYPES_INCLUDED
