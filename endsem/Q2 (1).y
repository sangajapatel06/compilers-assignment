%{

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int yylex();
void yyerror(char *s);
int yydebug = 0;

float regular(float a,float b);
float simple(float a,float b);
float compound(float a,float b);
float power(float x, int y);
%}

%union {
        char *str;        
        int i;
        float f;
};

%token <str> REGULAR
%token <str> COMPOUND
%token <str> SIMPLE
%token <i> NUM
%type <f> S
%type <f> E
%start S

%%

S: E {printf("%f\n", $1);};
E: REGULAR '(' E ',' E ')' {$$ = regular($3,$5);}
 | SIMPLE '(' E ',' E ')' {$$ = simple($3,$5);}
 | COMPOUND '(' E ',' E ')' {$$ = compound($3,$5);}
 | NUM NUM {//printf("%f %d %d\n",$$,$1,$2);
 		$$=(10*$1+$2)/1.0;
 		}
 | NUM {//printf("%f\n",$$);
 	$$ = $1*1.0;}
 | {};
 


%%

float power(float x, int y)
{
    if (y == 0)
        return 1;
    else if (y%2 == 0)
        return power(x, y/2)*power(x, y/2);
    else
        return x*power(x, y/2)*power(x, y/2);
}


float simple(float a,float b){
	//printf("simple a : %f b: %f\n",a,b);
	//printf("simple %f\n",a + (a*5.5*b)/100.0);
	return a + (a*5.5*b)/100.0;
}

float regular(float a,float b){
	//printf("regular a : %f b: %f\n",a,b);
	//printf("regular %f\n",a + ((a*2.01)/100.0)*b);
	return a + ((a*2.01)/100.0)*b;
}

float compound(float a,float b){
	//printf("compound a : %f b: %f\n",a,b);
	float temp = (1+5.7/b);
	//printf("compound %f\n",a*power(temp,(int)b));
	return a*power(temp,(int)b);
}



int main()
{
        yyparse();
        return 0;
}
