#include "semantic_analysis.h"

mysymbol_table * sem_switch(node * tree,mysymbol_table * q);
void semantic_analysis(node* tree)
{
  init_mysymbol_table();
  sem_switch(tree->child_node[0],NULL);
}

mysymbol_table * sem_switch(node * tree,mysymbol_table * q)
{
  if(strcmp(tree->token,"ExtDefList") == 0)
  {
    if(tree->n_node == 0)
      return NULL;
    mysymbol_table * p = sem_switch(tree->child_node[0],q);
    if(p == NULL)
      return NULL;
    mysymbol_table * buf = p;
    while(buf->sym_next != NULL)
      buf = buf->sym_next;
    if(tree->child_node[1] != NULL)
      buf->sym_next = sem_switch(tree->child_node[1],q);
    return p;
  }
  else if(strcmp(tree->token,"ExtDef") == 0)
  {
    mysymbol_table * p = sem_switch(tree->child_node[0],q);
    if(tree->n_node == 2)
      return p;
    p = sem_switch(tree->child_node[1],p);
    if(p == NULL)
      return NULL;
    sem_switch(tree->child_node[2],p);
    return p;
  }
  else if(strcmp(tree->token,"ExtDecList") == 0)
  {
    mysymbol_table * p = sem_switch(tree->child_node[0],q);
    if(p == NULL)
      return NULL;
    if(tree->n_node == 1)
      return p;
     mysymbol_table * buf = p;
    while(buf->sym_next != NULL)
      buf = buf->sym_next;
    buf->sym_next = sem_switch(tree->child_node[2],q);
    return p;
  }
  
  //Specifiers
  else if(strcmp(tree->token,"Specifier") == 0)
  {
    return sem_switch(tree->child_node[0],q);
  }
  else if(strcmp(tree->token,"StructSpecifier") == 0)
  {
    mysymbol_table * p;
    if(tree->n_node == 2)
      p = sem_switch(tree->child_node[1],q);
    else
    {
      p = sem_switch(tree->child_node[1],q);
      mysymbol_table * buf = p;
      if (p == NULL)
	return NULL;
    while(buf->sym_next != NULL)
      buf = buf->sym_next;
    buf->sym_next = sem_switch(tree->child_node[3],q);
    }
    return p;
  }
  else if(strcmp(tree->token,"TYPE") == 0)
  {
    if(strcmp(tree->val.c,"int") == 0)
      return (mysymbol_table * )1;
    else if(strcmp(tree->val.c,"float") == 0)
      return (mysymbol_table * )2;
    return NULL;
  }
  else if(strcmp(tree->token,"OptTag") == 0)
  {
    char id[50];
    if(tree->n_node == 0)
    {
      id[0] = '\0';
      return add_sym_table(id,(mysymbol_table *)3,NULL,NULL);
    }
    mysymbol_table *p;
    p = add_sym_table(tree->child_node[0]->val.c,(mysymbol_table * )3,NULL,NULL);
    if(p == NULL)
      printf("Error type 16 at Line %d: Redefined struct \"%s\".\n",tree->lineno,tree->child_node[0]->val.c);
    return p;
  }
  else if(strcmp(tree->token,"Tag") == 0)
  {
    mysymbol_table *p = find_id(tree->child_node[0]->val.c);
    if(p == NULL)
    printf("Error type 1 at Line %d: Undefined Variable \"%s\".",tree->lineno,tree->child_node[0]->val.c);
    return p;
  }
  
  //Declarators
  else if(strcmp(tree->token,"VarDec") == 0 )
  {
    mysymbol_table *p;
    if(tree->n_node == 1)
    {
      p = add_sym_table(tree->child_node[0]->val.c,q,NULL,NULL);
      if(p == NULL)
      {
	printf("Error type 3 at Line %d: Redefined Variable \"%s\".\n",tree->lineno,tree->child_node[0]->val.c);
	return NULL;
      }
      p->flag = 0;
      return p;
    }
    p = add_sym_table(NULL,q,NULL,NULL);
    p->flag = 0;
    return sem_switch(tree->child_node[0],p);
  }
  else if(strcmp(tree->token,"FunDec") == 0)
  {
    mysymbol_table * p;
    if(tree->n_node == 3)
    {
      p = add_sym_table(tree->child_node[0]->val.c,q,NULL,NULL);
      if(p == NULL)
    {
      printf("Error type 4 at Line %d: Redefined function \"%s\".\n",tree->lineno,tree->child_node[0]->val.c);
      return NULL;
    }
    p->flag = 1;
    return p;
    }
    
    p = add_sym_table(tree->child_node[0]->val.c,q,NULL,NULL);
    if(p == NULL)
    {
      printf("Error type 4 at Line %d: Redefined function \"%s\".\n",tree->lineno,tree->child_node[0]->val.c);
      return NULL;
    }
    p->sym_next = sem_switch(tree->child_node[2],q);
    p->flag = 1;
    return p;
    
  }
  else if(strcmp(tree->token,"VarList") == 0 )
  {
    if(tree->n_node == 1)
      return sem_switch(tree->child_node[0],q);
    mysymbol_table * p;
    p = sem_switch(tree->child_node[0],q);
    if(p == NULL)
      return NULL;
    p->sym_next = sem_switch(tree->child_node[2],q);
    return p;
  }
  else if(strcmp(tree->token,"ParamDec") == 0)
  {
    mysymbol_table * p;
    p = sem_switch(tree->child_node[0],q);
    p = sem_switch(tree->child_node[1],p);
    return p;
  }
  
  //statement
  else if(strcmp(tree->token,"CompSt") == 0)
  {
    mysymbol_table * p = sem_switch(tree->child_node[1],q);
//     if(p == NULL)
//       return NULL;
    sem_switch(tree->child_node[2],q);
    return p;
  }
  else if(strcmp(tree->token,"StmtList") == 0)
  {
    if(tree->n_node == 0)
      return NULL;
    mysymbol_table * p = sem_switch(tree->child_node[0],q);
//     if(p == NULL)
//       return NULL;
    sem_switch(tree->child_node[1],q);
    return p;
  }
  else if(strcmp(tree->token,"Stmt") == 0)
  {
    mysymbol_table * p;
//     if(p == NULL)
//       return NULL;
    if(tree->n_node == 1)
      return sem_switch(tree->child_node[0],q);
    if(tree->n_node == 2)
      return sem_switch(tree->child_node[0],q);
    if(tree->n_node == 3)
    {
      p = sem_switch(tree->child_node[1],q);
      if(p == NULL)
	return NULL;
      if(p->sym_type != q->sym_type)
	printf("error type 8 at Line %d: Type mismatched for return.\n",tree->lineno);
      return p;
    }
    if(tree->n_node == 5)
    {
      p = sem_switch(tree->child_node[2],q);
      int n;
      n = (int)p->sym_type;
      if(n != 1)
      {
	printf("error type 7  at line %d: Type mismatched for operands\n",tree->lineno);
      }
      sem_switch(tree->child_node[4],q);
      
      return p;
    }
    if(tree->n_node == 7)
    {
      p = sem_switch(tree->child_node[2],q);
      int n;
      n = (int)p->sym_type;
      if(n != 1)
      {
	printf("error type 7  at line %d: Type mismatched for operands\n",tree->lineno);
      }
      sem_switch(tree->child_node[4],q);
      sem_switch(tree->child_node[6],q);
      return p;
    }
  }
  
  //local definitions
  else if(strcmp(tree->token,"DefList") == 0)
  {
    if(tree->n_node == 0)
      return NULL;
    mysymbol_table * p = sem_switch(tree->child_node[0],q);
    if(p == NULL)
      return NULL;
    mysymbol_table * buf = p;
    while(buf -> sym_next != NULL)
      buf = buf->sym_next;
    buf->sym_next = sem_switch(tree->child_node[1],q);
    return p;
  }
  else if(strcmp(tree->token,"Def") == 0)
  {
    mysymbol_table * p = sem_switch(tree->child_node[0],q);
    if(p == NULL)
      return NULL;
    p = sem_switch(tree->child_node[1],p);
    if(p == NULL)
      return NULL;
    return p;
  }
  else if(strcmp(tree->token,"DecList") == 0)
  {
    if(tree->n_node == 1)
      return sem_switch(tree->child_node[0],q);
    mysymbol_table * p = sem_switch(tree->child_node[0],q);
    if(p == NULL)
      return NULL;
    p->sym_next = sem_switch(tree->child_node[1],q);
  }
  else if(strcmp(tree->token,"Dec") == 0)
  {
    if(tree->n_node == 1)
      return sem_switch(tree->child_node[0],q);
    mysymbol_table * p = sem_switch(tree->child_node[0],q);
    if(p == NULL)
      return NULL;
    mysymbol_table * buf = sem_switch(tree->child_node[2],q);
    if(buf == NULL)
      return NULL;
    q = p;
    while(1)
    {
      if((int)p->sym_type == 3)
      {
	printf("Error type 5  at line %d: Type mismatched for assignmet.\n",tree->lineno);
	return q;
      }
      else if( p->sym_type == buf->sym_type)
	return q;
      if((int)p->sym_type == 1 || (int)p->sym_type == 2 ||(int)p->sym_type == 3||(int)buf->sym_type == 1 ||(int)buf->sym_type ==  2 ||(int)buf->sym_type ==  3)
      {
	printf("Error type 5  at line %d: Type mismatched for assignmet.\n",tree->lineno);
	return q;
      }
      p = p->sym_type;
      buf = buf->sym_type;
    }
  }
  
  
  //expressions
  else if(strcmp(tree->token,"Exp") == 0)
  {
    mysymbol_table * p;
    mysymbol_table * buf;
    if(tree->n_node == 3)
    {
      if(strcmp (tree->child_node[1]->token,"Exp") == 0)
	return sem_switch(tree->child_node[1],q);
      if(strcmp (tree->child_node[0]->token,"ID") == 0)
      {
	p = find_id(tree->child_node[0]->token);
	if(p == NULL)
	{
	  printf("Error type 2 at line %d: Undefined function \"%s\".\n",tree->lineno,tree->child_node[0]->val.c);
	  return NULL;
	}
	if(p->flag != 1)
	{
	  printf("Error type 11 at line %d: \"%s\" is not a function\n",tree->lineno,tree->child_node[0]->val.c);
	  return NULL;
	}
	if(p->sym_next != NULL)
	{
	  printf("Error type 9 at line %d: function\"%s\" variable is not compatable\n",tree->child_node[0]->lineno,tree->child_node[0]->val.c);
	  return NULL;
	}
	return p->sym_type;
      }
      if(strcmp(tree->child_node[1]->token,"DOT") == 0)
      {
	p = sem_switch(tree->child_node[0],q);
	if(p == NULL)
	  return NULL;
	if(p->sym_type == 3||p->sym_type == 2||p->sym_type == 1)
	{
	  printf("Error type 13 at Line %d: Illegal use of \".\".\n",tree->lineno);
	  return NULL;
	}
	p = p->sym_type;
	if(p->sym_type != 3)
	{
	  printf("Error type 13 at Line %d: Illegal use of \".\".\n",tree->lineno);
	  return NULL;
	}
	buf = p->sym_next;
	while(1)
	{
	  if(buf == NULL)
	  {
	    printf("Error type 14 at Line %d: Non-exittent field \"%s\".\n",tree->lineno,tree->child_node[2]->val.c);
	    return NULL;
	  }
	  if(strcmp(buf->id,tree->child_node[2]->val.c) == 0)
	    return buf;
	  buf = buf->sym_next;
	}
      }
      p = sem_switch(tree->child_node[0],q);
      buf = sem_switch(tree->child_node[2],q);
      if(p == NULL || buf == NULL)
	return NULL;
      q = p;
      if(strcmp (tree->child_node[1]->token,"ASSIGNOP") == 0)
      {
	if(p->flag == -1)
	{
	  printf ("Error type 6  at line %d: The left-hand side of an assignmet must be a variable. \n",tree->lineno);
	  return NULL;
	}
	if((int)p == 3 ||(int)p == 1 || (int)p == 2)
	{
	  printf("error p = 123 at exp\n");
	  return NULL;
	}
// 	if( p->sym_type == buf ->sym_type)
// 	    return q;
	while(1)
	{
	  /*if((int)p == 3)
	  {
	    printf("= liangbian leixing buyiyang at line %d\n",tree->lineno);
	    return NULL;
	  }*/
	  
	  
	  if(p == 3)
	  {
	    printf("Error type 5  at line %d: Type mismatched for assignmet.\n",tree->lineno);
	    return NULL;
	  }
	  if( p->sym_type == buf ->sym_type)
	    return q;
	  if((int)p->sym_type == 1 || (int)p->sym_type == 2 ||(int)p->sym_type == 3||(int)buf->sym_type == 1 ||(int)buf->sym_type ==  2 ||(int)buf->sym_type ==  3)
	  {
	    printf("Error type 5  at line %d: Type mismatched for assignmet.\n",tree->lineno);
	    return NULL;
	  }
	  p = p->sym_type;
	  buf = buf->sym_type;
	}
      }
      else  if((strcmp (tree->child_node[1]->token,"AND") == 0) || (strcmp (tree->child_node[1]->token,"OR") == 0))
      {
	p->flag = -1;
	if(p->sym_type == 1 && buf->sym_type == 1)
	  return p;
	printf("Error type 7 at line%d\n: Type mismatched for operands.\n",tree->lineno);
	return NULL;
      }
      else 
      {
	p->flag = -1;
	if((p->sym_type == 1 && buf->sym_type == 1)||p->sym_type == 2 && buf->sym_type == 2)
	  return p;
	printf("Error type 7 at line%d\n: Type mismatched for operands.\n",tree->lineno);
	return NULL;
      }
    }
    else if(tree->n_node == 4)
    {
//       p = sem_switch(tree->child_node[0],q);
//       buf = sem_switch(tree->child_node[0],p->sym_next);
      if(strcmp(tree->child_node[0]->token,"Exp") == 0)
      {
	p = sem_switch(tree->child_node[0],q);
	buf = sem_switch(tree->child_node[2],q);
	if(p == NULL || buf == NULL)
	  return NULL;
	if(buf->sym_type != 1)
	{
	  printf("Error type12 at Line %d: what in the array is not a int\n",tree->lineno);
	  return NULL;
	}
	if((int)p->sym_type == 1|| (int)p->sym_type == 2 || (int)p->sym_type == 3)
	{
	  printf("Error type 10 :%s is not a array at line %d\n",p->id,tree->lineno);
	  return NULL;
	}
	return p->sym_type;
      }
      else
      {
	p = find_id(tree->child_node[0]->val.c);
	if(p == NULL)
	{
	  printf("Error type 2 at line %d: Undefined function \"%s\".\n",tree->lineno,tree->child_node[0]->val.c);
	  return NULL;
	}
	 if(p->flag != 1)
	{
	  printf("Error type 11 at line %d: \"%s\" is no a function\n",tree->lineno,tree->child_node[0]->val.c);
	  return NULL;
	} 
	buf = sem_switch(tree->child_node[2],p->sym_next);
	if(p == NULL || buf == NULL)
	  return NULL;
	return p->sym_type;
      }
    }
    else if(strcmp(tree->child_node[0]->token,"MINUS") == 0)
    {
      p = sem_switch(tree->child_node[0],q);
      if(p == NULL)
	return NULL;
      p->flag = -1;
      if(p->sym_type == 1|| p->sym_type== 2 )
      {
	return p;
      }
      printf("Error type 7 at line%d\n: Type mismatched for operands.\n",tree->lineno);
      return NULL;
    }
    else if(strcmp(tree->child_node[0]->token,"NOT") == 0)
    {
      p = sem_switch(tree->child_node[0],q);
      if(p == NULL)
	return NULL;
      if((int)p->sym_type == 1 )
      {
	return p;
      }
      printf("Error type 7 at line%d\n: Type mismatched for operands.\n",tree->lineno);
      return NULL;
    }
    else if(strcmp(tree->child_node[0]->token,"ID") == 0)
    {
      p = find_id(tree->child_node[0]->val.c);
      if(p == NULL)
	printf("Error type 1 at Line %d: Undefined Variable \"%s\".\n",tree->lineno,tree->child_node[0]->val.c);
      return p;
    }
    else if(strcmp(tree->child_node[0]->token,"INT") == 0)
    
      return add_sym_table(NULL,(mysymbol_table*)1,NULL,NULL);
    else if(strcmp(tree->child_node[0]->token,"FLOAT") == 0)
      return add_sym_table(NULL,(mysymbol_table*)2,NULL,NULL);
  }
  else if(strcmp(tree->token,"Args") == 0)
  {
    if (q == NULL)
    {
      printf("error Type 9 in the fun at line %d\n",tree->lineno);
      return NULL;
    }
    mysymbol_table * p = sem_switch(tree->child_node[0],q);
//     if( p->sym_type == q->sym_type){
// 	    if(tree->child_node[1] != NULL)
// 	      sem_switch(tree->child_node[2],q->sym_next);
// 	    else if(q->sym_next != NULL)
// 	      printf("error Type 9 in the fun at line %d\n",tree->lineno);
// 	    return q;
// 	  }
    while(1)
	{
	  if((int)p == 3)
	  {
	    
	    return NULL;
	  }
	  
	  
	  if( p->sym_type == q->sym_type)
	  {
	    if(tree->child_node[1] != NULL)
	      sem_switch(tree->child_node[2],q->sym_next);
	    else if(q->sym_next != NULL)
	    {
	      printf("error Type 9 in the fun at line %d\n",tree->lineno);
	      return NULL;
	    }
	    return q;
	  }
	  if((int)p->sym_type == 1 || (int)p->sym_type == 2 ||(int)p->sym_type == 3||(int)q->sym_type == 1 ||(int)q->sym_type ==  2 ||(int)q->sym_type ==  3)
	  {
	    printf("error Type 9 in the fun at line %d\n",tree->lineno);
	    return NULL;
	  }
	  p = p->sym_type;
	  q = q->sym_type;
	}
	
  }
  return NULL;
}