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
{CTE_E}			{printf("%s\n", yytext);}
{CTE_R}			{printf("%s\n", yytext);}

{ID}			{printf("%s\n", yytext);}
{COMENTARIO}	{printf("comentario detectado!\n");}

{CTE_S}	{if(strlen(yytext)<=30){
						printf("longitud OK!\n");
						}
						else{
							printf("Error lexico: Los string deben ser de menos de 30 caracteres!");
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
