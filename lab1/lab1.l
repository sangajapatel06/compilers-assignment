/*** Definition Section***/
%{
int count = 0;
int newLines = 0;
int blankLines = 0;
int braces= 0;
int keyWords = 0;
int count_code =0;
int just_comments = 0;
int multi = 0;

%}

/*** Rule Section***/
%%
^[ \t]*\/\/  {++count;newLines++;}
^[ \t]*\n {++blankLines;newLines++;}
[(\[{] {braces++;newLines++;}
int|long|for|return|cout|using  {keyWords++;}


^[ \t]*"/*".*\n {multi = 1,just_comments++;newLines++;}

.*"*/"\n {multi = 0,just_comments++;newLines++;}

[^[(\[{][int|long|for|return|cout|using]]*\n { if(multi == 1) {just_comments++;newLines++;}
else
{newLines++;}}




%%

int yywrap(){}
int main(){


 FILE *fp;
 char filename[50];
 printf("Enter the filename: \n");
 scanf("%s",filename);
 fp = fopen(filename,"r");
 yyin = fp;

yylex();
printf("\n OUTPUT \n");
printf("\nno of lines with  comments %d",count);
printf("\nno of lines with code %d",newLines-blankLines-count-just_comments);
printf("\nno of blank lines %d\n",blankLines);
printf("no of bracket pairs %d\n",braces);
printf("no of keywords %d\n",keyWords);
printf("no of lines with multi-line comments %d\n",just_comments);



return 0;
}