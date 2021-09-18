%{
	#include <string.h>
    //lista
	#include <stdio.h>
	#include <stdlib.h>
	#include <math.h>
	#include "y.tab.h"

	#define TAM 35
	#define DUPLICADO 2
	#define SIN_MEMORIA 3
	#define ID_EN_LISTA 4
	
	int yyerror(char* mensaje);

	extern char * yytext;

	FILE  *yyin;

	// Estructuras para la tabla de simbolos
	typedef struct
	{
			char nombre[TAM];
			char tipodato[TAM];
			char valor[TAM];
			int longitud;
	}t_info;

	typedef struct s_nodo
	{
		t_info info;
		struct s_nodo *pSig;
	}t_nodo;

	typedef t_nodo *t_lista;

	typedef int (*t_cmp)(const void *, const void *);
	int compararPorNombre(const void *, const void *);

	void crear_lista(t_lista *p);
	int insertarEnListaEnOrdenSinDuplicados(t_lista *l_ts, t_info *d, t_cmp);
	int BuscarEnLista(t_lista *pl, char* cadena );

	void crear_ts(t_lista *l_ts);
	int insertar_en_ts(t_lista *l_ts, t_info *d);

	void grabar_lista(t_lista *);
	void reemplazar_blancos_por_guiones_y_quitar_comillas(char *);
	void quitar_comillas(char *);
	void agregarGuion(char *pc, char* result);

	t_lista lista_ts;
	t_info dato;
%}


%token ID
%token CTE_S
%token CTE_E
%token CTE_R

%token GET			
%token DISPLAY	

%token EQUMAX		
%token EQUMIN		

%token WHILE
%token THEN			
%token IF			
%token ELSE			

%token NOT			
%token AND			
%token OR			

%token OP_ASIG			
%token COMA				
%token PYC						
%token OP_SUM				
%token OP_RESTA				
%token OP_MULT				
%token OP_DIV				

%token CORCHA				
%token CORCHC				
%token PARA				
%token PARC				
%token LLAVEA				
%token LLAVEC				

%token MENOR_IGUAL			
%token MAYOR_IGUAL			
%token MENOR				
%token MAYOR 			
%token DIFF		
%token IGUAL

%token DIM		
%token AS		

%token INTEGER		
%token STRING		
%token REAL

%%
inicio: programa ;

programa: sentencia 
        | programa sentencia 
		;

sentencia: asignacion
        | iteracion
        | seleccion 
		| declaracion
		| display
		| get
		| equmax
		| equmin
		;

equmax: IF EQUMAX PARA expresionEqu PYC CORCHA listaEqu CORCHC PARC {printf("equmax");} ;
equmin: IF EQUMIN PARA expresionEqu PYC CORCHA listaEqu CORCHC PARC {printf("equmin");};

listaEqu: factorEqu
			| listaEqu COMA factorEqu
			;

expresionEqu: terminoEqu
        | expresionEqu OP_SUM terminoEqu       
        | expresionEqu OP_RESTA terminoEqu  
		;
		

terminoEqu: factorEqu 
        | terminoEqu OP_MULT factorEqu
        | terminoEqu OP_DIV factorEqu
		;

factorEqu: ID
			| CTE_E
			| CTE_R
			;


declaracion: DIM CORCHA listaVarDec CORCHC AS CORCHA listaVarType CORCHC {printf("declaracion regla");} ;

listaVarDec: ID
			| listaVarDec COMA ID
			;

listaVarType: TYPE
			| listaVarType COMA TYPE
			;

TYPE: INTEGER | STRING | REAL;
		

asignacion: ID OP_ASIG expresion {printf("asignacion regla\n");}
		;
		

expresion: termino
        | expresion OP_SUM termino       
        | expresion OP_RESTA termino  
		;
		

termino: factor 
        | termino OP_MULT factor
        | termino OP_DIV factor
		;
		

factor: PARA expresion PARC
		| ID
		| CTE_E {
			char enteroConGuion[100];
			agregarGuion(yytext,enteroConGuion);
			//lista
			strcpy(dato.nombre, enteroConGuion);
			strcpy(dato.valor, yytext);
			strcpy(dato.tipodato, "CTE_E");
			insertar_en_ts(&lista_ts, &dato);
		}
		| CTE_R {
			char realConGuion[100];
			agregarGuion(yytext,realConGuion);
			//lista
			strcpy(dato.nombre,realConGuion);
			strcpy(dato.valor, yytext);
			strcpy(dato.tipodato, "CTE_R");
			insertar_en_ts(&lista_ts, &dato);
		}
		| CTE_S {
			quitar_comillas(yytext);
			char stringConGuion[100];
			agregarGuion(yytext,stringConGuion);
			//lista
			strcpy(dato.nombre, stringConGuion);
			strcpy(dato.valor, yytext);
			strcpy(dato.tipodato, "STRING"); //TODO: revisar si es necesario el tipo de dato en el lexico
			dato.longitud = strlen(yytext);
			insertar_en_ts(&lista_ts, &dato);
		}
		;

iteracion: WHILE condicion THEN programa ;

seleccion: IF condicion THEN programa {printf("seleccion sin else\n");}
        |  IF condicion THEN programa ELSE programa  {printf("seleccion con else\n");}
		;

condicion: comparacion {printf("condicion\n");}
        |  condicion AND comparacion
        |  condicion OR comparacion ;

comparacion: expresion comparador expresion {printf("comparacion\n");} ;

comparador: MENOR_IGUAL			
			| MAYOR_IGUAL			
			| MENOR				
			| MAYOR 			
 			| DIFF		
			| IGUAL
			;
			
display: DISPLAY factor;

get:GET	factor;

%%
int main(int argc,char *argv[])
{
  if ((yyin = fopen(argv[1], "rt")) == NULL)
  {
	printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
  }
  else
  {
	yyparse();
	grabar_lista(&lista_ts);

  	fclose(yyin);
  }
  return 0;
}

int yywrap(){}
int yyerror(char* mensaje)
 {
	printf("Error sintactico: %s\n", mensaje );
	system ("Pause");
	exit (1);
 }

 void agregarGuion(char *pc, char* result)
{
    const char *middle = pc;
    result[0] = '\0';
    strcat(result, "_");
    strcat(result, middle);
}

void quitar_comillas(char *pc){

	// Cadena del tipo "" (sin nada)
	if(strlen(pc) == 2){
		*pc='\0';
	}
	else{
		*pc = *(pc+1);
		pc++;
		while(*(pc+1) != '"'){
			*pc = *(pc+1);		
			pc++;
		}
		*pc='\0';
	}	
}
void crear_ts(t_lista *l_ts) {
	crear_lista(l_ts);

	printf("\n");
	printf("Creando tabla de simbolos...\n");	
	printf("Tabla de simbolos creada\n");
}

int insertar_en_ts(t_lista *l_ts, t_info *d) {
	insertarEnListaEnOrdenSinDuplicados(l_ts, d, compararPorNombre);
	
	// Un reinicio de la estructura dato para que vuelva a ser reutilizada sin problemas (quizas no hace falta) .
	strcpy(d->nombre,"\0");
	strcpy(d->tipodato,"\0");
	strcpy(d->valor,"\0");	
	d->longitud=0;
}

void crear_lista(t_lista *p) {
    *p=NULL;
}

int insertarEnListaEnOrdenSinDuplicados(t_lista *pl, t_info *d, t_cmp comparar)
{
    int cmp;
    t_nodo *nuevo;
    while(*pl && (cmp=comparar(d, &(*pl)->info))!=0)
        pl=&(*pl)->pSig;
    if(*pl && cmp==0)
        return DUPLICADO;
    nuevo=(t_nodo*)malloc(sizeof(t_nodo));
    if(!nuevo)
        return SIN_MEMORIA;
    nuevo->info=*d;
    nuevo->pSig=*pl;
    *pl=nuevo;
    return 1;
}

int BuscarEnLista(t_lista *pl, char* cadena )
{
    int cmp;

    while(*pl && (cmp=strcmp(cadena,(*pl)->info.nombre))!=0)
        pl=&(*pl)->pSig;
    if(cmp==0)
	{
        return ID_EN_LISTA;
	}
	printf("\nVariable sin declarar: %s \n",cadena);
    exit(1);
}

int compararPorNombre(const void *d1, const void *d2)
{
    t_info *dato1=(t_info*)d1;
    t_info *dato2=(t_info*)d2;

    return strcmp(dato1->nombre, dato2->nombre);
}

void grabar_lista(t_lista *pl){
	FILE *pf;

	pf = fopen("ts.txt", "wt");

	// Cabecera de la tabla
	fprintf(pf,"%-35s %-16s %-35s %-35s", "NOMBRE", "TIPO DE DATO", "VALOR", "LONGITUD");
	// Datos
	while(*pl) {
		fprintf(pf,"\n%-35s %-16s %-35s %-35d", (*pl)->info.nombre, (*pl)->info.tipodato, (*pl)->info.valor, (*pl)->info.longitud);
		pl=&(*pl)->pSig;
	}

	fclose(pf);
}

void reemplazar_blancos_por_guiones_y_quitar_comillas(char *pc){

	quitar_comillas(pc);

	char *aux = pc;
	
	while(*aux != '\0'){
		if(*aux == ' '){
			*aux= '_';
		}
		aux++;
	}
}