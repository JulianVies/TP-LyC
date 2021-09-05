%{
	#include <string.h>


	//lista
	
	//
%}

DIGITO			[0-9]
LETRA			[a-zA-Z]

ID				{LETRA}({LETRA}|{DIGITO})*
CTE_E		    {DIGITO}+
CTE_R		    {DIGITO}+"."{DIGITO}*|{DIGITO}*"."{DIGITO}+
CTE_S		    \"[^\"]*\"

COMENTARIO		\*\/.+\/\*	

%%

"GET"			{printf("GET\n");}
"DISPLAY"		{printf("DISPLAY\n");}

"WHILE"			{printf("WHILE\n");}
"IF"			{printf("IF\n");}
"ELSE"			{printf("ELSE\n");}

"&&"			{printf("&&\n");}
"||"			{printf("WHILE\n");}


"NOT"			{printf("NOT\n");}
"AND"			{printf("AND\n");}
"OR"			{printf("OR\n");}

":="			{printf("ASIG\n");}
","				{printf("COMA\n");}
";"				{printf("PYC\n");}
":"				{printf("DOSPUNT\n");}
"+"				{printf("MAS\n");}
"-"				{printf("MENOS\n");}
"*"				{printf("MULT\n");}
"/"				{printf("DIV\n");}

"["				{printf("BRAA\n");}
"]"				{printf("BRAC\n");}
"("				{printf("PARA\n");}
")"				{printf("PARC\n");}
"{"				{printf("CORA\n");}
"}"				{printf("CORC\n");}

"<="			{printf("MENOSIGUAL\n");}
">="			{printf("MASIGUAL\n");}
"<"				{printf("MENOR\n");}
">" 			{printf("MAYOR\n");}
"!="			{printf("DIFF\n");}
"=="			{printf("IGUAL\n");}



"DIM"			{printf("DIM\n");}
"AS"			{printf("AS\n");}

"integer"		{printf("integer\n");}
"string"		{printf("string\n");}
"real"			{printf("real\n");}

{CTE_S}	{if(strlen(yytext)<=30){
						printf("longitud OK!\n");
						printf("CTE_S\n");
						}
						else{
							printf("Error lexico: Los string deben ser de menos de 30 caracteres!");
                    		return 1;
						}


					}

{CTE_E}			{
					printf("CTE_E\n");
					int entero = atoi(yytext);
				}
{CTE_R}			{printf("CTE_R\n");
					int real = atof(yytext);}

{ID}			{printf("ID\n");}
{COMENTARIO}	{printf("COMENTARIO\n");}

%%

int yywrap(){}
int main(int argc,char *argv[])
{
    if ((yyin = fopen(argv[1], "rt")) == NULL){
        
        printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
    }
    else{
       yylex(); 
    }
    fclose(yyin);
}
