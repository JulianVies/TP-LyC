%{
	#include <string.h>

	int entero;
	float real;
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

{COMENTARIO}	{
					if(strlen(yytext)<=200){
						printf("COMENTARIO\n");
						//aca no retorna token
					}else{
						printf("Error lexico: Los comentarios deben ser de menos de 50 caracteres!");
						return 1;
					}
				}


{CTE_S}			{
					if(strlen(yytext)<=30){
						printf("longitud OK!\n");
						printf("CTE_S\n");
					}
						printf("Error lexico: Los string deben ser de menos de 30 caracteres!");
						return 1;
				}

{CTE_E}			{
					if(atoll(yytext)<=2147483647){	 //convierto a long, comparo con el max de int
							entero = atoi(yytext);
							//return CTE_E;
							printf("CTE_E\n");
					}else{
						printf("Error lexico: tam de entero excedido!");
						return 1;
					}

				}
{CTE_R}			{
					if(atof(yytext)<=3.40282347e+38F){
						real = atof(yytext);
						printf("CTE_R\n");
						//return CTE_R;

					}else{
						printf("Error lexico: tam de float excedido!");
						return 1;
					}

				}

{ID}			{
						if(strlen(yytext)<=30){
							printf("ID, %s\n", yytext);
							//return ID;

						}else{
							printf("Error lexico: Los ID deben ser de menos de 30 caracteres!");
							return 1;
						}
				}


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
