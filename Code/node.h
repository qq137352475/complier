#ifndef NODE_H
#define NODE_H
#include<stdlib.h>
#include<stdio.h>

typedef union VALUE{
  int i;
  char* c;
  float f;
}value;

typedef struct NODE{
  char token[20];
  int lineno;
  int n_node;
  value val;
  int type_flag;
  struct NODE *child_node[10];
  
}node;

node* createnode();
node* createtree(char* token, int lineno, int n_node, node** child_node);
node* createleaf(char *token, int lineno, int type_flag,value val);
void output_tree(node * nd,int jr);
#endif