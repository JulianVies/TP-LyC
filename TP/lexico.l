%{
	#include <string.h>
	int entero;
	float real;
	#include <stdio.h>
	#include <stdlib.h>
	#include <math.h>
	#include "sintactico.tab.h"
%}
%option noyywrap
%option yylineno

DIGITO					[0-9]
LETRA					[a-zA-Z]
SIMBOLOEXTRA			[" "|"#"|"%"|"?"|"¿"|","|";"|"!"|"¡"|"@"|"."|":"|"_"|'\-'|'/'|"="|"“"|"”"|"("|")"]
CARACTERESCOMENTARIO	[" "|"#"|"%"|"?"|"¿"|"°"|","|";"|"!"|"¡"|"\\"|"@"|"."|":"|"_"|'\-'|'+'|'*'|'/'|"["|'\]'|'{'|'}'|"="|"“"|"”"|"("|")"]

ID				{LETRA}({LETRA}|{DIGITO}|_)*
CTE_E		    {DIGITO}+
CTE_R		    {DIGITO}+"."{DIGITO}*|{DIGITO}*"."{DIGITO}+

/*CTE_S		    \"[^\"]*\"	*/
CTE_S		\"({LETRA}|{DIGITO}|{SIMBOLOEXTRA})*\"

/*COMENTARIO		\*\/.+\/\*	*/
COMENTARIO		\*\/({LETRA}|{DIGITO}|{CARACTERESCOMENTARIO})*\/\*


%%

"GET"			{ return (GET);}
"DISPLAY"		{ return (DISPLAY);}

"EQUMAX"		{return (EQUMAX);}
"EQUMIN"		{return (EQUMIN);}
"FOR"			{return (FOR);}


"WHILE"			{return (WHILE);}
"BEGINW"		{return (BEGINW);}
"ENDW"			{return (ENDW);}
"IF"			{return (IF);}
"THEN"			{return (THEN);}
"ELSE"			{return (ELSE);}
"ENDIF"			{return (ENDIF);}

"NOT"			{return (NOT);}
"AND"			{return (AND);}
"OR"			{return (OR);}

":="			{return (OP_ASIG);}
","				{return (COMA);}
";"				{return (PYC);}
"+"				{return (OP_SUM);}
"-"				{return (OP_RESTA);}
"*"				{return (OP_MULT);}
"/"				{return (OP_DIV);}

"["				{return (CORCHA);}
"]"				{return (CORCHC);}
"("				{return (PARA);}
")"				{return (PARC);}
"{"				{return (LLAVEA);}
"}"				{return (LLAVEC);}

"<="			{return (MENOR_IGUAL);}
">="			{return (MAYOR_IGUAL);}
"<"				{return (MENOR);}
">" 			{return (MAYOR);}
"!="			{return (DIFF);}
"=="			{return (IGUAL);}
"="				{return (IGUALFOR);}



"DIM"			{return (DIM);}
"AS"			{return (AS);}
"TO"			{return (TO);}
"NEXT"			{return (NEXT);}

"integer"		{return (INTEGER);}
"string"		{return (STRING);}
"real"			{return (REAL);}

{COMENTARIO}	{
					if(strlen(yytext)<=200){
						printf("COMENTARIO\n");
					}else{
						yyerror("Error Lexico,Los comentarios deben ser de menos de 50 caracteres!");
					}
				}


{CTE_S}			{	
					// se cambia 30 por 31 por que cuenta las comillas que valen por 2 caracteres 
					// ( y 30 no es valido).
					if(strlen(yytext)<=31){
						quitar_comillas(yytext);
						char stringConGuion[100];
						agregarGuion(yytext,stringConGuion);
						nuevoSimbolo(stringConGuion,yytext,"CTE_S",strlen(yytext));
						yylval.str_val = strdup(yytext);
						return CTE_S;
					}else{
						yyerror("Error Lexico,Los string deben ser de menos de 30 caracteres!");
					}
				}

{CTE_E}			{	
					if(atoll(yytext)<=2147483647){	 //convierto a long, comparo con el max de int
						char enteroConGuion[100];
						agregarGuion(yytext,enteroConGuion);
                    	yylval.int_val = atoi(yytext);
						nuevoSimbolo(enteroConGuion,yytext,"CTE_E",strlen(yytext));
						return CTE_E;
					}else{
						yyerror("Error Lexico,tam de entero excedido!");
					}

				}
{CTE_R}			{
					if(atof(yytext)<=3.4e+38){
						char realConGuion[100];
						agregarGuion(yytext,realConGuion);
						yylval.float_val = atof(yytext);
						nuevoSimbolo(realConGuion,yytext,"CTE_R",strlen(yytext)-1);
						return CTE_R;
					}else{
						yyerror("Error Lexico,tam de float excedido!");
					}

				}

{ID}			{
						if(strlen(yytext)<=30){
							yylval.str_val = strdup(yytext);
							return ID;
						}else{
							yyerror("Error Lexico,Los ID deben ser de menos de 30 caracteres!");
						}
				}

\n
\t
" "
. {printf("Caracter invalido!!\n");}
%%