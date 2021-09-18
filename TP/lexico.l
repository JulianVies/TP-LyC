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

DIGITO			[0-9]
LETRA			[a-zA-Z]

ID				{LETRA}({LETRA}|{DIGITO}|_)*
CTE_E		    {DIGITO}+
CTE_R		    {DIGITO}+"."{DIGITO}*|{DIGITO}*"."{DIGITO}+
CTE_S		    \"[^\"]*\"

COMENTARIO		\*\/.+\/\*	

%%

"GET"			{ return (GET);}
"DISPLAY"		{ return (DISPLAY);}

"EQUMAX"		{return (EQUMAX);}
"EQUMIN"		{return (EQUMIN);}


"WHILE"			{return (WHILE);}
"IF"			{return (IF);}
"THEN"			{return (THEN);}
"ELSE"			{return (ELSE);}

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



"DIM"			{return (DIM);}
"AS"			{return (AS);}

"integer"		{return (INTEGER);}
"string"		{return (STRING);}
"real"			{return (REAL);}

{COMENTARIO}	{
					if(strlen(yytext)<=200){
						printf("COMENTARIO\n");
					}else{
						printf("Error lexico: Los comentarios deben ser de menos de 50 caracteres!");
						return 1;
					}
				}


{CTE_S}			{	
					// se cambia 30 por 31 por que cuenta las comillas que valen por 2 caracteres 
					// ( y 30 no es valido).
					if(strlen(yytext)<=31){
						quitar_comillas(yytext);
						char stringConGuion[100];
						agregarGuion(yytext,stringConGuion);
						nuevoSimbolo(stringConGuion,yytext,NULL,strlen(yytext));
						return CTE_S;
					}else{
						printf("Error lexico: Los string deben ser de menos de 30 caracteres!");
						return 1;
					}
				}

{CTE_E}			{
					if(atoll(yytext)<=2147483647){	 //convierto a long, comparo con el max de int
						entero = atoi(yytext);
						char enteroConGuion[100];
						agregarGuion(yytext,enteroConGuion);
						nuevoSimbolo(enteroConGuion,yytext,NULL,-1);
						return CTE_E;
					}else{
						printf("Error lexico: tam de entero excedido!");
						return 1;
					}

				}
{CTE_R}			{
					if(atof(yytext)<=3.40282347e+38F){
						real = atof(yytext);
						char realConGuion[100];
						agregarGuion(yytext,realConGuion);
						nuevoSimbolo(realConGuion,yytext,NULL,-1);
						return CTE_R;
					}else{
						printf("Error lexico: tam de float excedido!");
						return 1;
					}

				}

{ID}			{
						if(strlen(yytext)<=30){
							// strcpy(dato.nombre, yytext);
							// strcpy(dato.valor, "-");
							// strcpy(dato.tipodato, "-");
							// insertar_en_ts(&lista_ts, &dato);
							return ID;
						}else{
							printf("Error lexico: Los ID deben ser de menos de 30 caracteres!");
							return 1;
						}
				}

\n
%%