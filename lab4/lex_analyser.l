%{
  #include<stdio.h>
%}
%%


[a-zA-Z_][a-zA-Z0-9_]* {printf("id ");}
[1-9][0-9]* {printf("num ");}
[(] {printf("%s ",yytext);}
[)] {printf("%s ",yytext);}
[+*/-]  {printf("%s ",yytext);}
\n {;}
. {printf("error");}



%%
int yywrap() {}
int main(){
    
    yylex();
    
}
