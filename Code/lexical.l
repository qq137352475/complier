%option yylineno
%{
#include<stdio.h>
#include<stdlib.h>
#include"syntax.tab.h"
#include"node.h"
//#define YYSTYPE node*
typedef struct YYLTYPE {
int first_line;
int first_column;
int last_line;
int last_column;
};

extern int errorno;
int yycolumn = 1;
struct YYLTYPE yylloc;
#define YY_USER_ACTION \
yylloc.first_line = yylloc.last_line = yylineno; \
yylloc.first_column = yycolumn;\
yylloc.last_column = yycolumn + yyleng -1;\
yycolumn +=yyleng;
%}
digit [0-9]
letter [a-zA-Z]
delim [ \t]
%%
{delim}+ {}
"\n" {yycolumn = 1;}
0|[1-9]{digit}* {
			      char token[20] = "INT";
			      int type_flag = 0;
			      value val;
			      val.i = atoi(yytext);
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return INT;
			      } 
{digit}+\.[0-9]+ {
			      char token[20] = "FLOAT";
			      int type_flag = 2;
			      value val;
			      val.f = atof(yytext);
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return FLOAT;
			      } 
";" {
			      char token[20] = "SEMI";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return SEMI;
			      } 
"," {
			      char token[20] = "COMMA";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return COMMA;
			      } 
"=" {
			      char token[20] = "ASSIGNOP";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return ASSIGNOP;
			      } 
>|<|>=|<=|==|!= {
			      char token[20] = "RELOP";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return RELOP;
			      } 
"+" {
			      char token[20] = "PLUS";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return PLUS;
			      } 
"-" {
			      char token[20] = "MINUS";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return MINUS;
			      } 
"*" {
			      char token[20] = "STAR";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return STAR;
			      } 
"/" {
			      char token[20] = "DIV";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return DIV;
			      } 
"&&" {
			      char token[20] = "AND";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return AND;
			      } 
"||" {
			      char token[20] = "OR";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return OR;
			      } 
"." {
			      char token[20] = "DOT";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return DOT;
			      } 
"!" {
			      char token[20] = "NOT";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return NOT;
			      } 
"int"|"float" {
			      char token[20] = "TYPE";
			      int lineno = yylineno;
			      int type_flag = 1;
			      value val;
			      int n = strlen(yytext);
			      val.c = (char*)malloc(n*sizeof(char));
			      strcpy(val.c,yytext);
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return TYPE;
			      } 
"(" {
			      char token[20] = "LP";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return LP;
			      } 
")" {
			      char token[20] = "RP";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return RP;
			      } 
"[" {
			      char token[20] = "LB";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return LB;
			      } 
"]" {
			      char token[20] = "RB";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return RB;
			      } 
"{" {
			      char token[20] = "LC";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return LC;
			      } 
"}" {
			      char token[20] = "RC";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return RC;
			      } 
"struct" {
			      char token[20] = "STRUCT";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return STRUCT;
			      } 
"return" {
			      char token[20] = "RETURN";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return RETURN;
			      } 
"if" {
			      char token[20] = "IF";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return IF;
			      } 
"else" {
			      char token[20] = "ELSE";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return ELSE;
			      } 
"while" {
			      char token[20] = "WHILE";
			      int type_flag = 3;
			      value val;
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return WHILE;
			      } 
"//" {
			      char c = input();
			      while ( c != '\n') c = input();
			      }
			      
"/*" {			      
			     char c = input();
			     while(1)
			    {
			      while ( c != '*') c = input();
			      c = input();
			      if(c == '/')break;
			      }
			      }
			      
({letter}|_)({letter}|{digit}|_)* {
			      char token[20] = "ID";
			      
			      int type_flag = 1;
			      value val;
			      int n = strlen(yytext);
			      val.c = (char*)malloc(n*sizeof(char));
			      strcpy(val.c,yytext);
			      yylval = createleaf(token,yylineno,type_flag,val);
			      return ID;
			      } 

. {
			      errorno = 1;
			      printf("Error type A at line %d: Mystrious type : \'%s\'\n",yylineno,yytext);}
%%
