%{
	#include <string.h>

	int entero;
	float real;
	
    
    //lista
	#include <stdio.h>
	#include <stdlib.h>
	#include <math.h>

	#define TAM 35
	#define DUPLICADO 2
	#define SIN_MEMORIA 3
	#define ID_EN_LISTA 4

	typedef struct
	{
		char nombre[TAM];
		char tipodato[TAM];
		char valor[TAM];
		int longitud;
	} t_info;

	typedef struct s_nodo
	{
		t_info info;
		struct s_nodo *pSig;
	} t_nodo;

	typedef t_nodo *t_lista;

	typedef int (*t_cmp)(const void *, const void *);
	int compararPorNombre(const void *, const void *);

	void crear_lista(t_lista *p);
	int insertarEnListaEnOrdenSinDuplicados(t_lista *l_ts, t_info *d, t_cmp);
	int BuscarEnLista(t_lista *pl, char *cadena);

	void crear_ts(t_lista *l_ts);
	int insertar_en_ts(t_lista *l_ts, t_info *d);

	void grabar_lista(t_lista *);
	void agregarGuion(char *pc, char* result);
	void sacarComillas(char *pc);
	void yyerror();
	t_lista lista_ts;
	t_info dato;

%}


%%

ID

GET			
DISPLAY	

EQUMAX		
EQUMIN		

WHILE
THEN			
IF			
ELSE			

NOT			
AND			
OR			

OP_ASIG			
COMA				
PYC				
:				
OP_SUM				
OP_RESTA				
OP_MULT				
OP_DIV				

CORCHA				
CORCHC				
PARA				
PARC				
{				
}				

MENOS_IGUAL			
MAS_IGUAL			
MENOR				
MAYOR 			
DIFF		
IGUAL

DIM		
AS		

INTEGER		
STRING		
FLOAT

%%

inicio: programa 
programa: sentencia 
        | programa sentencia 

sentencia: asignacion
        | iteracion
        | seleccion 
        | declaracion //va aca?

asignacion: ID OP_ASIG expresion

expresion: termino
        | expresion OP_SUM termino          
        | expresion OP_RESTA termino

termino: factor
        | termino OP_MULT factor
        | termino OP_DIV factor


iteracion: WHILE condicion THEN programa

condicion: comparacion 
        |  condicion AND comparacion
        |  condicion OR comparacion

comparacion: expresion 
//a<b AND b


seleccion: IF condicion THEN programa
        |  IF condicion THEN programa ELSE programa

