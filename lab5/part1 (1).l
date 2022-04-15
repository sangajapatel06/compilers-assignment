
%{
#include <stdio.h>
#include <string.h>
#include "AST.h"
#include "part1.tab.h"

void yyerror(char *);
%}

id [a-z]+
num [0-9]+
op [-+*/()]

%%

[ \t]+              {}

\n          {
                return  *yytext;
            }

{num}       {
                yylval.str = strdup(yytext);
                return  NUM;
            }

{id}        {
                yylval.str = strdup(yytext);
                return  ID;
            }

{op}	    {
                return  *yytext;
            }

.           {
                yyerror("invalid character");
            }


%%

void yyerror(char *s) {
    fprintf(stderr, "line %d: yytext = %s.  Error msg: %s.\n", yylineno, yytext, s);
}

int yywrap(void) {
   return 1;
}

