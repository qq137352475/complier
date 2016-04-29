#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H
#include <stdlib.h>
#include <stdio.h>

typedef struct MYSYMBOL_TABLE{
  char id[20];
  int flag;
  struct MYSYMBOL_TABLE * sym_type;
  struct MYSYMBOL_TABLE * next;
  struct MYSYMBOL_TABLE * sym_next;
  struct MYSYMBOL_TABLE * sym_list;
}mysymbol_table;

mysymbol_table *  add_sym_table(char *id ,mysymbol_table * sym_type,mysymbol_table * sym_list,mysymbol_table * sym_next);
mysymbol_table * find_id(char *id);
void init_mysymbol_table();
#endif