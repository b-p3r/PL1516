enum Category
{
    variable,
    function,
    procedure

};

enum Level
{
    main_function,
    called_function


};


enum Type
{
    integer,
    array
};


typedef struct item
{

    Category category;
    Level level;
    Type type;
    int numBytes;
//lista de parametros
    int nDim;
    int limitDim;




} * ITEM;


ITEM init_bucket()
{

    ITEM it = (ITEM)malloc(sizeof(struct item));
    if(it==NULL)
        return NULL;
    it->category = 0;
    it->level = 0;
    it->limitDim = 0;
    it->nDim = 0;
    it->numBytes = 0;
    it->type = 0;
    return it;

}

Category getCategory(ITEM * it)
{
    if(it)

        return it->category;
    else return -1;

}

Level getLevel(ITEM * it)
{
    if(it)

        return it->level;
    else return -1;

}
int getLimitDim(ITEM * it)
{
    if(it)

        return it->limitDim;
    else return -1;

}
int getNDim(ITEM * it)
{
    if(it)

        return it->nDim;
    else return -1;

}
int getType(ITEM * it)
{
    if(it)

        return it->type;
    else return -1;

}

/****************************/

int setCategory(ITEM * it, Category category)
{
    if(it)
        it->category = category;
    return 0;
    else return -1;

}

int setLevel(ITEM * it, Level level)
{
    if(it)
        it->level = level;
    return 0;
    else return -1;

}
int setLimitDim(ITEM * it, int limitlDim)
{
    if(it)
        it->limitDim = limitlDim;
    return 0;
    else return -1;

}
int setNDim(ITEM * it, int nDim)
{
    if(it)
        it->nDim = nDim;
    return 0;
    else return -1;

}
int getType(ITEM * it, Type type )
{
    if(it)
        it->type;
    return 0;
    else return -1;

}

void delete_item(ITEM * t)
{

    if(t)
    {
        free(t);
        t=NULL;
    }


}
