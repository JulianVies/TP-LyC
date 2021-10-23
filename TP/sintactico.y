%{
	#include <string.h>
    //lista
	#include <stdio.h>
	#include <stdlib.h>
	#include <math.h>
	#include "sintactico.tab.h"

	#define TAM 35
	#define DUPLICADO 2
	#define SIN_MEMORIA 3
	#define ID_EN_LISTA 4
	
	int yyerror(char* mensaje);

	extern char * yytext;

	FILE  *yyin;


	//----Estructuras para la lista tabla de simbolos----
	typedef struct
	{
			char nombre[TAM];
			char tipodato[TAM];
			char valor[TAM];
			char longitud[TAM];
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
	int BuscarEnLista(t_lista *pl, char* cadena);

	void crear_ts(t_lista *l_ts);
	int insertar_en_ts(t_lista *l_ts, t_info *d);
	int nuevoSimbolo(char* nombre,char* valor,char* tipoDato, int longitud);

	void grabar_lista(t_lista *);

	//----Fin estructuras para la lista----


	//----Estructuras para la pila----
	typedef struct
	{
		char text[32];
	}t_info_p;

	typedef struct s_nodo_p
	{
		t_info_p info;
		struct s_nodo_p *sig;
	}t_nodo_p;

	typedef t_nodo_p* t_pila; //Sirve para mantener el mismo main que el de pila estatica

	void crearPila(t_pila *); //debo pasarrlo por *
	int pilaLlena(const t_pila *); //me combiene pasarlo por *
	int apilar(t_pila *, const t_info_p *);
	int pilaVacia(const t_pila *);
	int verTope(const t_pila *, t_info_p *);
	int desapilar(t_pila *, t_info_p *);
	void vaciarPila(t_pila *);
	void mostrarNodo(t_info_p *);
	int mostrarPila(t_pila *);
	int cargarInfo(t_info_p *);
	//----Fin estructuras para la pila----


	void reemplazar_blancos_por_guiones_y_quitar_comillas(char *);
	void quitar_comillas(char *);
	void agregarGuion(char *pc, char* result);
	void agregarValorAlFinal(char * array, char valor);

	t_lista lista_ts;
	t_info dato;

	t_lista lista_dup;

	t_info_p info_p;
	t_pila pilaVar;
	t_pila pilaType;
%}


%token ID
%token CTE_S
%token CTE_E
%token CTE_R

%token GET			
%token DISPLAY	

%token EQUMAX		
%token EQUMIN		
%token FOR

%token WHILE
%token BEGINW
%token ENDW
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
%token IGUALFOR

%token DIM		
%token AS		
%token TO
%token NEXT

%token INTEGER		
%token STRING		
%token REAL

%%
inicio: programa {printf("\nEnd programa.\n");}
		;

programa: sentencia 
        | programa sentencia 
		;

sentencia: asignacion { printf("Regla asignacion\n"); }
        | iteracion
        | seleccion { printf("Regla seleccion\n"); }
		| declaracion { printf("Regla declaracion\n"); }
		| display { printf("Regla display\n"); }
		| get { printf("Regla get\n"); }
		| equmax
		| equmin
		;

asignacion: ID {BuscarEnLista(&lista_ts, yytext);} OP_ASIG tipoAsig;

tipoAsig: expresion | CTE_S; 

iteracion: while { printf("Regla while\n"); }
		|  for { printf("Regla for\n"); }
		;

while: WHILE condicion BEGINW programa ENDW  ;

seleccion: IF condicion THEN programa	{ printf("Regla IF\n"); }
        |  IF condicion THEN programa ELSE programa		{ printf("Regla If con Else\n"); }
		;

declaracion: DIM CORCHA listaVarDec CORCHC AS CORCHA listaType CORCHC {
	while(!pilaVacia(&pilaVar) && !pilaVacia(&pilaType)) {
		t_info_p variable;
		desapilar(&pilaVar, &variable);

		t_info info_dup;
		strcpy(info_dup.nombre, variable.text);
		strcpy(info_dup.tipodato, "");
		strcpy(info_dup.valor, "");
		strcpy(info_dup.longitud, "");
		int respuesta = insertarEnListaEnOrdenSinDuplicados(&lista_dup, &info_dup, compararPorNombre);
		if (respuesta == DUPLICADO) {
			yyerror("Error Sintactico,Variable Duplicada en declaracion");
		}

		t_info_p tipo;
		desapilar(&pilaType, &tipo);

		nuevoSimbolo(variable.text,"-",tipo.text,-1);
	}

	if (!pilaVacia(&pilaVar) || !pilaVacia(&pilaType)) {
		yyerror("Error Sintactico,Diferencia en declaracion de cantidad de IDs con Tipos");
	}
};

display: DISPLAY ID 
		| DISPLAY CTE_S;

get:GET	ID;

equmax: EQUMAX PARA expresion PYC CORCHA listaEqu CORCHC PARC { printf("Regla equmax\n"); };

equmin: EQUMIN PARA expresion PYC CORCHA listaEqu CORCHC PARC { printf("Regla equmin\n"); };

listaEqu: itemEqu
		| listaEqu COMA itemEqu
		;

itemEqu: ID
		| CTE_E
		| CTE_R
		;

listaVarDec: ID {strcpy(info_p.text, yytext); apilar(&pilaVar, &info_p);}
			| listaVarDec COMA ID {strcpy(info_p.text, yytext); apilar(&pilaVar, &info_p);}
			;

listaType: TYPE {strcpy(info_p.text, yytext); apilar(&pilaType, &info_p);}
			| listaType COMA TYPE {strcpy(info_p.text, yytext); apilar(&pilaType, &info_p);}
			;

TYPE: INTEGER | STRING | REAL;
		
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
		| CTE_E
		| CTE_R
		;

condicion: comparacion	{ printf("Regla condicion simple \n"); }
		| NOT comparacion	{ printf("Regla condicion simple NOT\n"); }
        |  comparacion AND comparacion { printf("Regla condicion multiple And\n"); }
        |  comparacion OR comparacion { printf("Regla condicion multiple Or\n"); }
		;	

comparacion: expresion comparador expresion 
		|  equmax
		|  equmin
		;

comparador: MENOR_IGUAL			
			| MAYOR_IGUAL			
			| MENOR				
			| MAYOR 			
 			| DIFF		
			| IGUAL
			;

for:	FOR ID IGUALFOR expresion TO expresion CORCHA CTE_E CORCHC NEXT ID 
	| FOR ID IGUALFOR expresion TO expresion CORCHA CORCHC NEXT ID
	;
			


%%
int main(int argc,char *argv[]){
  if ((yyin = fopen(argv[1], "rt")) == NULL)
  {
	printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
  }
  else
  {
	crear_lista(&lista_dup);
	crearPila(&pilaVar);
	crearPila(&pilaType);

	yyparse();

	mostrarPila(&pilaVar);
	mostrarPila(&pilaType);
	// t_lista* lista_ts;
	// crear_ts(lista_ts);
	grabar_lista(&lista_ts);

  	fclose(yyin);
  }
  return 0;
}

int yywrap(){}

int yyerror(char* mensaje){
	printf("%s\n", mensaje );
	system ("Pause");
	exit (1);
 }

//Funciones utiles
void agregarGuion(char *pc, char* result){
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

int compararPorNombre(const void *d1, const void *d2){
    t_info *dato1=(t_info*)d1;
    t_info *dato2=(t_info*)d2;

    return strcmp(dato1->nombre, dato2->nombre);
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

void agregarValorAlFinal(char * array, char valor){
	// int i;
	// for(i = 0 ; i < array ; i++){
	// 	array[i] = valor;
	// }
}


// ---- Funciones de Lista ----

//funcion intermedia usada desde lexico para llegar hasta insertar_en_ts
int nuevoSimbolo(char* nombre,char* valor,char* tipoDato, int longitud){
	// printf("%s--%s--%s--%d",nombre,valor,tipoDato,longitud);
	strcpy(dato.nombre, nombre);
	strcpy(dato.valor, valor);

	if(tipoDato == NULL){strcpy(dato.tipodato,"");
	}else{strcpy(dato.tipodato,tipoDato);}

	if(longitud == -1){strcpy(dato.longitud,"");
	}else{itoa(longitud,dato.longitud,10);}
	
	insertar_en_ts(&lista_ts, &dato);
}

int insertar_en_ts(t_lista *l_ts, t_info *d) {
	insertarEnListaEnOrdenSinDuplicados(l_ts, d, compararPorNombre);
	// Un reinicio de la estructura dato para que vuelva a ser reutilizada sin problemas (quizas no hace falta) .
	strcpy(d->nombre,"\0");
	strcpy(d->tipodato,"\0");
	strcpy(d->valor,"\0");	
	strcpy(d->longitud,"\0");
}

void crear_lista(t_lista *p){
    *p=NULL;
}

int insertarEnListaEnOrdenSinDuplicados(t_lista *pl, t_info *d, t_cmp comparar){
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

int BuscarEnLista(t_lista *pl, char* cadena){
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

void crear_ts(t_lista *l_ts){
	crear_lista(l_ts);
	printf("\n");
	printf("Creando tabla de simbolos...\n");	
	printf("Tabla de simbolos creada\n");
}

void grabar_lista(t_lista *pl){
	FILE *pf;

	pf = fopen("ts.txt", "wt");
	// Cabecera de la tabla
	fprintf(pf,"%-35s %-16s %-35s %-35s", "NOMBRE", "TIPO DE DATO", "VALOR", "LONGITUD");
	// Datos
	while(*pl) {
		fprintf(pf,"\n%-35s %-16s %-35s %-35s", (*pl)->info.nombre, (*pl)->info.tipodato, (*pl)->info.valor, (*pl)->info.longitud);
		pl=&(*pl)->pSig;
	}

	fclose(pf);
}

//---- Fin Funciones de Lista ----

//---- Funciones de Pila ----

void crearPila(t_pila *p)
{
    *p=NULL;
}

int pilaVacia(const t_pila *p)
{
    return *p==NULL;
}

int pilaLlena(const t_pila *p)
{
    t_nodo_p *aux = (t_nodo_p *)malloc(sizeof(t_nodo_p));
    free(aux);
    return aux == NULL;
}


int apilar(t_pila *p, const t_info_p *d)
{
    t_nodo_p *nue=(t_nodo_p *)malloc(sizeof(t_nodo_p));
    if(nue==NULL)
        return 0;
    nue -> info = *d;
    nue -> sig = *p;
    *p = nue;
    return 1;
}

int verTope(const t_pila *p, t_info_p *d)
{
    if(*p==NULL)
        return 0;
    *d = (*p) -> info;
    return 1;
}

int desapilar(t_pila *p, t_info_p *d)
{
    t_nodo_p *aux;
    if(*p == NULL)
        return 0;
    aux = *p;
    *d = aux -> info;
    *p = aux -> sig;
    free(aux);
    return 1;
}

void vaciarPila(t_pila *p)
{
    t_nodo_p *aux;
    while(*p)
    {
        aux = *p;
        *p = aux -> sig;
        free(aux);
    }
}

/*int cargarInfo(t_info_p *d)
{
    printf("ingrse dni: ");
    scanf("%d",&d->dni);
    fflush(stdin);
    printf("\ningrese apellido y nombre: ");
    gets(d->apyn);
    return 1;
}*/

void mostrarNodo(t_info_p *d)
{
    printf("\n Texto: %s",d->text);
}

int mostrarPila(t_pila *p)
{
    t_pila *aux;
    aux = p;
    if((*aux)==NULL)
        return 0;
    while((*aux)->sig!=NULL)
    {
        printf("\n-> texto: %s ",(*aux)->info.text);
        *aux = (*aux)->sig;
    }
    printf("\n-> texto: %s ",(*aux)->info.text);
}

//---- Fin funciones de Pila ----