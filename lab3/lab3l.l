%option noinput nounput
%{

#include "y.tab.h"
#include<stdio.h>
#include<string.h>

void yyerror(char *);

%}

%%
[ \t]   ;
[a-z]+  {
        printf("Token: STRING; Lexeme: %s\n", yytext);
        yylval.str = strdup(yytext);
        return STRING;
        }
Reverse {
        printf("Token: REVERSE; Lexeme: %s\n", yytext);
        yylval.str = strdup(yytext);
        return REVERSE;
        }
[#()]   {
        printf("TOKEN and Lexeme: %s\n", yytext);
        return *yytext;
        }
\n      {
        printf("Token and Lexeme: <newline>\n");
        }
.       {
        printf("Invalid Character\n");
        yyerror("Invalid Character");
        }

%%

void yyerror(char *s)
{
        fprintf(stderr, "Error in %s", yytext);
}

int yywrap()
{
        return 1;
}