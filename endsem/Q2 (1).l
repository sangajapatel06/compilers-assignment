%option noinput nounput
%{

#include "y.tab.h"
#include<stdio.h>
#include<string.h>

void yyerror(char *);

%}

num [0-9]

%%
[ \t]   ;


{num}       {

		printf("Token: NUM; LEXEME: %s\n",yytext);
		yylval.i = atoi(yytext);
		
       	return NUM;
                
            }

s|si|sim|simp|simpl|simple {
		
       	printf("Token: SIMPLE; Lexeme: %s\n", yytext);
       	yylval.str = strdup(yytext);
       	return SIMPLE;
        }

regular {
        	printf("Token: REGULAR; Lexeme: %s\n", yytext);
	        yylval.str = strdup(yytext);
        	return REGULAR;
        }
c|co|com|comp|compo|compou|compoun|compound {
        	printf("Token: COMPOUND; Lexeme: %s\n", yytext);
        	yylval.str = strdup(yytext);
        	return COMPOUND;
        }
[(),]   {
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
