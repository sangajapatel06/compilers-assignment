%{

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int yylex();
void yyerror(char *s);
int yydebug = 0;
char *reverse(char *);

%}

%union {
        char *str;
};

%token <str> STRING
%token <str> REVERSE
%type <str> S
%type <str> E  
%start S

%%

S: E {printf("%s\n", $$);}
 | { }
 ;
E: E '#' E {strcat($1,$3);}
 | STRING {}
 | REVERSE '(' E ')' {$$ = reverse($3);}

%%

char *reverse(char *final)
{
    if (!final || ! *final)
        return final;

    int i = strlen(final) - 1, j = 0;

    char ch;
    while (i > j)
    {
        ch = final[i];
        final[i] = final[j];
        final[j] = ch;
        i--;
        j++;
    }
    return final;
}

int main()
{
        yyparse();
        return 0;
}