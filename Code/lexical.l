%option yylineno
%{
#include<stdio.h>
#include<stdlib.h>
}%
digit [0-9]
letter [a-zA-Z]
%%
0|[1-9]{digit}+ {printf("int %d\n",atoi(yytext);}
{digit}+\.[0-9]+ {printf(folat %f\n",atof(yytext);}
";" {printf("SEMI");}
"," {printf("COMMA");}
"=" {printf("ASSIGNOP");}
>|<|>=|<=|==|!= {printf("RELOP");}
"+" {printf("PLUS");}
"-" {printf("MINUS");}
"*" {printf("STAR");}
"/" {printf("DIV");}
"&&" {printf("AND"):}
"||" {printf("");}
"." {printf("");}
"!" {printf("");}
"int"|"float" {printf("");}
"(" {printf("");}
")" {printf("");}
"[" {printf("");}
"]" {printf("");}
"{" {printf("");}
"}" {printf("");}
"struct" {printf("");}
"return" {printf("");}
"if" {printf("");}
"else" {printf("");}
"while" {printf("");}
"" {printf("");}
"" {printf("");}