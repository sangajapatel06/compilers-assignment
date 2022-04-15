
%{
        #include <stdio.h>
        #include <string.h>
        #include "AST.h"
        #include "symbolTable.h"

        extern FILE *yyin;
        extern FILE *yyout;

        int yylex(void);
        void yyerror(char *);
        int yydebug = 0;
        
        node *createNode(node *, node *, char *); 
        void insertSym(char *, char*);
        void printAST(node *); 
        void printST();
        char *attChecker(char*);
        char *typeChecker(node *);
        int checkOp(char *);
%}

%union { 
        char *str;
        node *ptr;
};

%token <str> NUM
%token <str> ID

%start  start
%type <ptr> expr
%type <ptr> term
%type <ptr> factor

%left '+' '-'
%left '*' '/'

%%

start:   
        start expr  '\n'                { 
						printf("The type of the resulting output: %s\n",typeChecker($2)); }
        |       /* EMPTY */             { }
        ;

expr:
        expr '+' term                   { $$ = createNode($1, $3, "+"); }
        |       expr '-' term           { $$ = createNode($1, $3, "-"); }
        |       term                    { $$ = $1; }  
        ;

term:
        term '*' factor                 { $$ = createNode($1, $3, "*"); }
        |       term '/' factor         { $$ = createNode($1, $3, "/"); }
        |       factor                  { $$ = $1; }
        ;

factor:
        '(' expr ')'                    { $$ = $2; }
        | NUM                           { $$ = createNode(0,0,$1); insertSym($1,"int"); }
        | ID                            { $$ = createNode(0,0,$1); insertSym($1,"string"); }
        ;

%%


node *createNode(node *left, node *right, char *value) { 
        node *newnode = (node *)malloc(sizeof(node)); 
        char *newstr = (char *)malloc(strlen(value)+1); 
        strcpy(newstr, value); 
        newnode->left = left; 
        newnode->right = right; 
        newnode->value = newstr; 
        return(newnode); 
}

void insertSym ( char *sym_name, char *sym_type ) { 
        symtable *s = getsym (sym_name);
        if (s == 0) s = putsym (sym_name,sym_type);
}

void printAST(node *ptr) 
{ 
        if (ptr->left || ptr->right) 
                printf("("); 
        printf(" %s ", ptr->value); 
        if (ptr->left) 
                printAST(ptr->left); 
        if (ptr->right) 
                printAST(ptr->right); 
        if (ptr->left || ptr->right) 
                printf(")"); 
}

void printST() 
{ 
        symtable *s = sym_table;
	printf("The path:\n");
        while (s != NULL) { 
                printf("(%s,%s) -> ", s->name,s->type); 
                s = s->next; 
        } 
        printf("NULL\n");
} 

char *attChecker( char *sym_name ){
        symtable *s = getsym( sym_name );
        if ( s == 0 ) return NULL;
        else return  s->type;
}

int checkOp(char *op){
        return !strcmp(op, "+") || !strcmp(op, "-") || !strcmp(op, "*") || !strcmp(op, "/");
}

char *typeChecker( node *root ){
        char *type1,*type2;
        char *type = (char *)malloc(10); 
        if(root != NULL){
                if(checkOp(root->value)){
                        type1 = typeChecker(root->left);
                        type2 = typeChecker(root->right);

                        if(strcmp(type1,"Error")==0 || strcmp(type2,"Error")==0){
                                strcpy(type,"Error");
                                return type;
                        }

                        if(strcmp(type1,type2)==0){
                                if(strcmp(type1,"int")==0) strcpy(type,"int");
                                if(strcmp(type1,"string")==0) strcpy(type,"string");
                        }
                        if(strcmp(type1,type2)!=0){
                                printf("Expected an integer got a string.\n");
                                strcpy(type,"Error");
                        }
                        return type;
                }
                return attChecker(root->value);
        }
        return NULL;
}


int main(int argc, char** argv) {
        yyparse();
        return 0;
}

