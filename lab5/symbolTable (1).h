#include <stdlib.h>

typedef struct symtable
{
  char *name;    
  char *type;         
  struct symtable *next;
} symtable;

symtable *sym_table = (symtable *)0;

symtable *putsym ();
symtable *getsym ();

symtable * putsym ( char *sym_name, char *sym_type )
{
    symtable *ptr;
    ptr = (symtable *) malloc (sizeof(symtable));
    ptr->name = strdup(sym_name);
    ptr->type = strdup(sym_type);
    ptr->next = (symtable *)sym_table;
    sym_table = ptr;
    return ptr; 
}
symtable * getsym ( char *sym_name )
{
    symtable *ptr;
    for (ptr = sym_table; ptr != (symtable *) 0; ptr = (symtable *)ptr->next)
        if (strcmp (ptr->name,sym_name) == 0)
            return ptr;
    return 0;
}
