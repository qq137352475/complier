#include "symbol_table.h"

mysymbol_table * start ;
mysymbol_table* next;
void init_mysymbol_table()
{
start = (struct MYSYMBOL_TABLE * )malloc(sizeof(struct MYSYMBOL_TABLE ));
next = start;
}

mysymbol_table *  add_sym_table(char *id ,mysymbol_table * sym_type,mysymbol_table * sym_list,mysymbol_table * sym_next)
{
  mysymbol_table * p = (mysymbol_table * )malloc(sizeof(mysymbol_table));
  p->flag = 0;
  if(id == NULL)
    p->flag = -1;
  else
    strcpy(p->id,id);
  if(find_id(id) != NULL)
    return NULL;
  p->sym_type = sym_type;
  p->sym_next = sym_next;
  p->sym_list = sym_list;
  p->next = NULL;
  next->next = p;
  next = next->next;
  return p;
}
mysymbol_table * find_id(char *id)
{
  if(id == NULL)
    return NULL;
  mysymbol_table * p =start->next;
  while(p != NULL)
  {
    if(strcmp(p->id,id) == 0)
      return p;
    p = p->next;
  }
  return NULL;
}