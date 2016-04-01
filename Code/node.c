#include"node.h"

node* createnode()
{
  node *nd;
  nd = (node *)malloc(sizeof(node));
  memset(nd,0,sizeof(node));
  return nd;
}

node* createtree(char* token, int lineno, int n_node, node** child_node)
{
  node *nd = createnode();
 // nd->token = token;
  strcpy(nd->token,token);
  nd->lineno = lineno;
  nd->n_node = n_node;
  nd->type_flag = 3;
  int i ;
  for(i =0; i<n_node ; i ++)
  {
    nd->child_node[i] = child_node[i];
  }
  return nd;
}

node* createleaf(char *token, int lineno, int type_flag,value val)
{
  node *nd = createnode();
  strcpy(nd->token,token);
  nd->type_flag = type_flag;
  nd->val = val;
  nd->lineno = lineno;
  int i;
  for( i = 0; i<10; i++)
    nd->child_node[i] = NULL;
  nd->n_node  = 0;
  return nd;
}

void output_tree(node * nd,int jr)
{
  if(nd == NULL)
    return;
  
  int i;
  
  if(nd->n_node == 0)
  {
    for(i = 0; i < jr; i++)
    printf("  ");
    switch(nd->type_flag)
    {
      case 0:
	printf("%s: %d\n",nd->token,nd->val.i);
	break;
      case 1:
	printf("%s: %s\n",nd->token,nd->val.c);
	break;
      case 2:
	printf("%s: %f\n",nd->token,nd->val.f);
	break;
      case 3:
	printf("%s\n",nd->token);
	break;
      default:
	printf("error type\n");
    }
  }
  else
  {
    for(i = 0; i < jr; i++)
    printf("  ");
    printf("%s(%d)\n",nd->token,nd->lineno);
    jr++;
    for(i = 0; i < nd->n_node; i++)
      output_tree(nd->child_node[i],jr);
  }
  
  return;
}