%{

#include<stdio.h>
#include<string.h>

%}

%%
"#" {printf("Token and Lexeme: # \n");}
"(" {printf("Token and Lexeme: ( \n");}
")" {printf("Token and Lexeme: ) \n");}
"Reverse" {printf("Token: REVERSE; Lexeme: Reverse \n");}
[a-z]+ {printf("Token: STRING; Lexeme: %s \n", yytext);}
\n {printf("Token and Lexeme: <newline> \n");}
[+-/=*%&@$]+ printf("ERROR : %s\n",yytext);
[a-zA-Z0-9]+ printf("ERROR : %s\n",yytext);
.|\n {}
%%

int yywrap(){}

int main()
{
yylex();
return 0;
}
