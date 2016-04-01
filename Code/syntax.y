%{
#include<stdlib.h>
#include<stdio.h>
//#include"lex.yy.c"
#include"node.h"
#define YYSTYPE node*
// #include"output.h"
node * syn_node;
int errorno = 0;
extern int yylex();
extern yylineno;
// extern int yyerror(const char*);

%}
%token FLOAT INT ID TYPE
%token DOT LB RB LP RP LC RC FOR WHILE STRUCT RETURN ASSIGNOP SEMI COMMA IF ELSE SUB_ELSE

%nonassoc SUB_ELSE
%nonassoc ELSE

%right ASSIGNOP
%left OR
%left AND
%left RELOP
%left PLUS MINUS
%left STAR DIV
%right NOT
%left LP RP DOT LB RB

%%

Program         : ExtDefList {
			      char token[20] = "Program";
			      int lineno = $1->lineno;
			      int n_node = 1;
			      node * child_node[10];
			      child_node[0] = $1;
			      int i;
			      for(i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      syn_node = createtree(token,lineno,n_node,child_node);
			      if(errorno == 0)output_tree(syn_node,0);
			      }
                ;

ExtDefList      : ExtDef ExtDefList {
			      char token[20] = "ExtDefList";
			      int lineno = $1->lineno;
			      int n_node = 2;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }
                |             {
			      $$ = NULL;     
			      }
                ;


ExtDef          : Specifier ExtDecList SEMI  {
			      char token[20] = "ExtDef";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }
                | Specifier SEMI   {
			      char token[20] = "ExtDef";
			      int lineno = $1->lineno;
			      int n_node = 2;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }          
                | Specifier FunDec CompSt {
			      char token[20] = "ExtDef";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }   
                ;

ExtDecList      : VarDec {
			      char token[20] = "ExtDecList";
			      int lineno = $1->lineno;
			      int n_node = 1;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }                 
                | VarDec COMMA ExtDecList {
			      char token[20] = "ExtDecList";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }
                ;


Specifier       : TYPE {
			      char token[20] = "Specifier";
			      int lineno = $1->lineno;
			      int n_node = 1;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }            
                | StructSpecifier {
			      char token[20] = "Specifier";
			      int lineno = $1->lineno;
			      int n_node = 1;
			      int i;
			      node * child_node[10];
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }
                ;

StructSpecifier : STRUCT OptTag LC DefList RC {
			      char token[20] = "StructSpecifier";
			      int lineno = $1->lineno;
			      int n_node = 5;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      child_node[3] = $4;
			      child_node[4] = $5;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }
                | STRUCT LC DefList RC {
			      char token[20] = "StructSpecifier";
			      int lineno = $1->lineno;
			      int n_node = 4;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      child_node[3] = $4;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }   
                | STRUCT Tag  {
			      char token[20] = "StructSpecifier";
			      int lineno = $1->lineno;
			      int n_node = 2;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }            
                ;

OptTag		: ID {
			      char token[20] = "OptTag";
			      int lineno = $1->lineno;
			      int n_node = 1;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }
		| {
			      $$ = NULL;
			      }
		;

Tag 		: ID {
			      char token[20] = "Tag";
			      int lineno = $1->lineno;
			      int n_node = 1;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }
		;
		
		

VarDec          : ID {
			      char token[20] = "VarDec";
			      int lineno = $1->lineno;
			      int n_node = 1;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }              
                | VarDec LB INT RB {
			      char token[20] = "VarDec";
			      int lineno = $1->lineno;
			      int n_node = 4;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      child_node[3] = $4;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }
                ;

FunDec          : ID LP VarList RP {
			      char token[20] = "FunDec";
			      int lineno = $1->lineno;
			      int n_node = 4;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }
                | ID LP RP {
			      char token[20] = "FunDec";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }        
                ;

ParamDec        : Specifier VarDec {
			      char token[20] = "ParamDec";
			      int lineno = $1->lineno;
			      int n_node = 2;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }
                ;

VarList         : ParamDec COMMA VarList {
			      char token[20] = "VarList";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }
                | ParamDec {
			      char token[20] = "VarList";
			      int lineno = $1->lineno;
			      int n_node = 1;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }
                ;


CompSt          : LC DefList StmtList RC {
			      char token[20] = "CompSt";
			      int lineno = $1->lineno;
			      int n_node = 4;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      child_node[3] = $4;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }
                ;

StmtList        : Stmt StmtList {
			      char token[20] = "StmtList";
			      int lineno = $1->lineno;
			      int n_node = 2;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }
                | {
			      $$ = NULL;
			      }              
                ;

Stmt            : Exp SEMI  {
			      char token[20] = "Stmt";
			      int lineno = $1->lineno;
			      int n_node = 2;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }                           
                | CompSt {
			      char token[20] = "Stmt";
			      int lineno = $1->lineno;
			      int n_node = 1;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }                               
                | RETURN Exp SEMI 
{
			      char token[20] = "Stmt";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }                     
                | IF LP Exp RP Stmt %prec SUB_ELSE {
			      char token[20] = "Stmt";
			      int lineno = $1->lineno;
			      int n_node = 5;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      child_node[3] = $4;
			      child_node[4] = $5;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }    
                | IF LP Exp RP Stmt ELSE Stmt {
			      char token[20] = "Stmt";
			      int lineno = $1->lineno;
			      int n_node = 7;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      child_node[3] = $4;
			      child_node[4] = $5;
			      child_node[5] = $6;
			      child_node[6] = $7;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }          
                | WHILE LP Exp RP Stmt {
			      char token[20] = "Stmt";
			      int lineno = $1->lineno;
			      int n_node = 5;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      child_node[3] = $4;
			      child_node[4] = $5;
			      $$ = createtree(token,lineno,n_node,child_node);
			      } 
                ;


DefList         : Def DefList {
			      char token[20] = "DefList";
			      int lineno = $1->lineno;
			      int n_node = 2;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      $$ = createtree(token,lineno,n_node,child_node);
			      } 
                | {
			      $$ = NULL;
			      }           
                ;

Def             : Specifier DecList SEMI {
			      char token[20] = "Def";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      } 
		;

DecList         : Dec {
			      char token[20] = "DecList";
			      int lineno = $1->lineno;
			      int n_node = 1;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      $$ = createtree(token,lineno,n_node,child_node);
			      } 
                | Dec COMMA DecList {
			      char token[20] = "DecList";
			      int lineno = $1->lineno;
			      int n_node = 1;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      } 
                ;

Dec             : VarDec {
			      char token[20] = "Dec";
			      int lineno = $1->lineno;
			      int n_node = 1;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }              
                | VarDec ASSIGNOP Exp {
			      char token[20] = "Stmt";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      } 
                ;


Exp             : Exp ASSIGNOP Exp {
			      char token[20] = "Exp";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      } 
                | Exp AND Exp {
			      char token[20] = "Exp";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }     
                | Exp OR Exp {
			      char token[20] = "Exp";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }       
                | Exp RELOP Exp {
			      char token[20] = "Exp";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }    
                | Exp PLUS Exp {
			      char token[20] = "Exp";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }     
                | Exp MINUS Exp {
			      char token[20] = "Exp";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }    
                | Exp STAR Exp {
			      char token[20] = "Exp";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }     
                | Exp DIV Exp {
			      char token[20] = "Exp";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }      
                | Exp LB Exp RB {
			      char token[20] = "Exp";
			      int lineno = $1->lineno;
			      int n_node = 4;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      child_node[3] = $4;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }    
                | Exp DOT ID {
			      char token[20] = "Exp";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }       
                | LP Exp RP {
			      char token[20] = "Exp";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }        
                | MINUS Exp {
			      char token[20] = "Exp";
			      int lineno = $1->lineno;
			      int n_node = 2;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }        
                | NOT Exp {
			      char token[20] = "Exp";
			      int lineno = $1->lineno;
			      int n_node = 2;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }           
                | ID LP Args RP {
			      char token[20] = "Exp";
			      int lineno = $1->lineno;
			      int n_node = 4;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      child_node[3] = $4;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }    
                | ID LP RP {
			      char token[20] = "Exp";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }          
                | ID {
			      char token[20] = "Exp";
			      int lineno = $1->lineno;
			      int n_node = 1;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }                
                | INT {
			      char token[20] = "Exp";
			      int lineno = $1->lineno;
			      int n_node = 1;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }             
                | FLOAT {
			      char token[20] = "Exp";
			      int lineno = $1->lineno;
			      int n_node = 1;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }             
                ;

Args            : Exp COMMA Args {
			      char token[20] = "Args";
			      int lineno = $1->lineno;
			      int n_node = 3;
			      node * child_node[10];
			      int i;
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      child_node[1] = $2;
			      child_node[2] = $3;
			      $$ = createtree(token,lineno,n_node,child_node);
			      }  
                | Exp {
			      char token[20] = "Args";
			      int lineno = $1->lineno;
			      int n_node = 1;
			      int i;
			      node * child_node[10];
			      for( i = 1; i <10; i++)
				child_node[i] = NULL;
			      child_node[0] = $1;
			      $$ = createtree(token,lineno,n_node,child_node);
			      } 
                ;
Stmt            : Exp{
			      yyerror("missing \";\"");
			      }
		|RETURN Exp {
			      yyerror("missing \";\"");
			      }
		|IF Exp RP Stmt{
			      yyerror("missing \"(\"");
			      }
		|IF LP RP Stmt{
			      yyerror("no exp in ()");
			      }
		|IF LP Exp Stmt{
			      yyerror("missing \")\"");
			      }	
		|IF Exp RP Stmt ELSE Stmt{
			      yyerror("missing \"(\"");
			      }	
		|IF LP RP Stmt ELSE Stmt{
			      yyerror("no exp in ()");
			      }	 
		|IF LP Exp Stmt ELSE Stmt{
			      yyerror("missing \")\"");
			      }	      
VarDec 		: VarDec LB INT{
			      yyerror("missing \"]\"");
			      }
		| VarDec INT RB{
			      yyerror("missing \"[\"");
			      }	      
Stmt		: error SEMI
CompSt		: error RC
Exp 		: error RP
                
                
%%


int yyerror(const char* c)
{
errorno = 1;
printf("error type B:at %d: %s\n",yylineno,c);
}



