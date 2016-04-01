//#include"lex.yy.c"
#include<stdlib.h>
#include<stdio.h>
#include"syntax.tab.h"
#include "lex.yy.c"
//extern FILE* yyin;
int main(int argc,char **argv)
{
  FILE* f;
  if(argc >1 )
  {
    if(!(f = fopen(argv[1],"r"))){
      printf("%s\n",argv[1]);
      return 1;
      }
    
  }
//  while(yylex() != 0);
  yyrestart(f);
  yyparse();
  return 0;
}

