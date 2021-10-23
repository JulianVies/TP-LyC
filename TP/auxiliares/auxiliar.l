%{
	#include <string.h>
%}

DIGITO			[0-9]
LETRA			[a-zA-Z]

ID				{LETRA}({LETRA}|{DIGITO})*
CTE_E		    {DIGITO}+
CTE_R		    {DIGITO}+"."{DIGITO}*|{DIGITO}*"."{DIGITO}+
CTE_S		    \"[^\"]*\"

COMENTARIO		\*\/.+\/\*		 

%%

"INTEGER"		{printf("%s\n", yytext);}
"FLOAT"			{printf("%s\n", yytext);}
"STRING"		{printf("%s\n", yytext);}

"GET"			{printf("%s\n", yytext);}
"DISPLAY"		{printf("%s\n", yytext);}

"WHILE"			{printf("%s\n", yytext);}
"IF"			{printf("%s\n", yytext);}
"ELSE"			{printf("%s\n", yytext);}

"&&"			{printf("%s\n", yytext);}
"||"			{printf("%s\n", yytext);}

"NOT"			{printf("%s\n", yytext);}
"AND"			{printf("%s\n", yytext);}
"OR"			{printf("%s\n", yytext);}

":="			{printf("%s\n", yytext);}
","				{printf("%s\n", yytext);}
";"				{printf("%s\n", yytext);}
":"				{printf("%s\n", yytext);}
"+"				{printf("%s\n", yytext);}
"-"				{printf("%s\n", yytext);}
"*"				{printf("%s\n", yytext);}
"\"				{printf("%s\n", yytext);}

"["				{printf("%s\n", yytext);}
"]"				{printf("%s\n", yytext);}
"("				{printf("%s\n", yytext);}
")"				{printf("%s\n", yytext);}
"{"				{printf("%s\n", yytext);}
"}"				{printf("%s\n", yytext);}

"<="			{printf("%s\n", yytext);}
">="			{printf("%s\n", yytext);}
"<"				{printf("%s\n", yytext);}
">" 			{printf("%s\n", yytext);}
"!="			{printf("%s\n", yytext);}
"=="			{printf("%s\n", yytext);}

{DIGITO}		{printf("%s\n", yytext);}
{LETRA}			{printf("%s\n", yytext);}
{ID}			{printf("%s\n", yytext);}

{CTEE_S}	{if(strlen(yytext)<=30){
						
						return CTE_STRING;
						}
					printf("Error lexico: Los string deben ser de menos de 30 caracteres!");
                    return 1;
					}
{CTEE_E}       //validar rango entero

{COMENTARIO}    //validar longitud

{CTE_R}         //validar rango


int yywrap(){}

int main(int argc,char *argv[])
{
    if((yyin = fopen(argv[1], "rt")) == NULL){
        
        printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
    }
    else{
       
       yylex(); //ejecuta analisis lexico
    }
    fclose(yyin);
}