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
	int mostrarListaTerceto();
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

//TERCETOS

	typedef struct
{
    int numeroTerceto;
    char primerElemento[TAM];
    char segundoElemento[TAM];
    char tercerElemento[TAM];
} t_info_terceto;

typedef struct s_nodo_terceto
{
    t_info_terceto info;
    struct s_nodo_terceto *pSig;
} t_nodo_terceto;

typedef t_nodo_terceto *t_lista_terceto;
t_lista_terceto lista_terceto;
t_info_terceto dato_terceto;
int contadorTercetos = 0;



// Variables auxiliares para tercetos //
int _flagAnd = 0;
int _aux;

char* crearIndice(int); //Recibe un numero de terceto y lo convierte en un indice
int crearTerceto(char*, char*, char*); //Se mandan los 3 strings, y se guarda el terceto creado en la lista
                                        //La posicion en la lista se lo da contadorTercetos. Variable que aumenta en 1
void guardarTercetosEnArchivo(t_lista_terceto *);
char* negarBranch(char*);	//Recibe el tipo de BRANCH y lo invierte  	
int verCompatible(char *,int, int);
int buscarEnListaDeTercetosOrdenada(t_lista_terceto *, int);
int modificarIndiceTercetoSalto(t_lista_terceto *, int, int);

void ftoa(float n, char* res, int afterpoint);
void reverse(char* str, int len);
int intToStr(int x, char str[], int d);

//INDICES
int Eind;
int EindAux1;
int EindAux2;
int Tind;
int Find;

int CompInd;
int whileFalseInd;
int InitWhileInd;
int FinWhileInd;
int Salto1;
int IndiceActual;

int* PosReservada;

/////////

char comp[3];


%}

%union {
	int int_val;
	double float_val;
	char *str_val;
}

%token <str_val>ID
%token <str_val>CTE_S
%token <int_val>CTE_E
%token <float_val>CTE_R

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
%token ENDIF			

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

%token <str_val>MENOR_IGUAL			
%token <str_val>MAYOR_IGUAL			
%token <str_val>MENOR				
%token <str_val>MAYOR 			
%token <str_val>DIFF		
%token <str_val>IGUAL
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

asignacion: ID  OP_ASIG expresion 
			{	
				BuscarEnLista(&lista_ts, $1);
				crearTerceto("=", $1, crearIndice(Eind));
			}
			|
			ID  OP_ASIG CTE_S 
			{	
				BuscarEnLista(&lista_ts, $1);
				crearTerceto("=", $1, $3);
			}
			; 	

iteracion: while { printf("Regla while\n"); }
		|  for { printf("Regla for\n"); }
		;

while: WHILE condicion
		{ 
			InitWhileInd = crearTerceto("CMP",crearIndice(EindAux1),crearIndice(EindAux2));
			whileFalseInd = crearTerceto("BGE","","");
		
			//printf("*%d*",*PosReservada);
			//crearTerceto(comp, crearIndice(*PosReservada),"_");
		} 
BEGINW programa 
		{
			IndiceActual =  crearTerceto("BI",crearIndice(InitWhileInd),"");
			printf("indice actual %d\n",IndiceActual);
			modificarIndiceTercetoSalto(&lista_terceto, whileFalseInd, IndiceActual + 1);
			//*PosReservada = contadorTercetos;
		}
ENDW  { };

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

expresion: termino						 {Eind = Tind;}
        | expresion OP_SUM termino       {Eind = crearTerceto("+",crearIndice(Eind), crearIndice(Tind));}
        | expresion OP_RESTA termino  	 {Eind=crearTerceto("-", crearIndice(Eind), crearIndice(Tind))}
		;
		
termino: factor							{Tind=Find;}
        | termino OP_MULT factor        {Tind=crearTerceto("*", crearIndice(Tind), crearIndice(Find))}
        | termino OP_DIV factor         {Tind=crearTerceto("/", crearIndice(Tind), crearIndice(Find))}
		;
		
factor: PARA expresion PARC             {Find=Eind;}
		| ID 							 { 
			Find = crearTerceto($1,"","");
		} 
		| CTE_E							 {
			char auxI[30];
			itoa($1,auxI,10);
			Find = crearTerceto(auxI,"","");
			} 
		| CTE_R							 {
			char* auxF;
			ftoa($1,auxF,2);
			Find = crearTerceto(auxF,"","");
			} 
		;

condicion: comparacion	{ printf("Regla condicion simple \n"); }
		| NOT comparacion	{ printf("Regla condicion simple NOT\n"); }
        |  comparacion AND comparacion { printf("Regla condicion compuesta And\n"); }
        |  comparacion OR comparacion { printf("Regla condicion compuesta Or\n"); }
		;	

comparacion: expresion {EindAux1=Eind} comparador expresion {EindAux2=Eind}
		|  equmax
		|  equmin
		;

comparador: MENOR_IGUAL		{strcpy(comp, "BGT");}		
			| MAYOR_IGUAL	 {strcpy(comp,"BLT");}		
			| MENOR			{strcpy(comp, "BGE");}	
			| MAYOR 		{strcpy(comp, "BLE");}	
 			| DIFF			{strcpy(comp, "BNE");}
			| IGUAL			{strcpy(comp, "BEQ");}
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
	printf("cantidad de tercetos\t:\t%d",contadorTercetos);
	mostrarListaTerceto();
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


void crear_lista_terceto(t_lista_terceto *p){
	*p = NULL;
}

int insertar_en_lista_terceto(t_lista_terceto *p, const t_info_terceto *d)
{
    t_nodo_terceto* nue = (t_nodo_terceto *)malloc(sizeof(t_nodo_terceto));
    if(!nue)
        return SIN_MEMORIA;
    nue->info = *d;
    nue->pSig = NULL;
    while(*p)
        p = &(*p)->pSig;
    *p = nue;
    return 1;
}

char* crearIndice(int indice){
	
	char* resultado = (char*) malloc(sizeof(char)*7);
	char numeroTexto [4];

	strcpy(resultado,"[");
	itoa(indice,numeroTexto,10);
	strcat(resultado,numeroTexto);
	strcat(resultado,"]");
	return resultado;
}


int crearTerceto(char* primero, char* segundo, char* tercero){
	t_info_terceto nuevo;
	strcpy(nuevo.primerElemento,primero);
	strcpy(nuevo.segundoElemento,segundo);
	strcpy(nuevo.tercerElemento,tercero);
	nuevo.numeroTerceto = contadorTercetos;
	//printf("%d %s %s %s\n",nuevo.numeroTerceto,nuevo.primerElemento,nuevo.segundoElemento,nuevo.tercerElemento);
	insertar_en_lista_terceto(&lista_terceto,&nuevo);
  	contadorTercetos++;
  	return nuevo.numeroTerceto;
}

int mostrarListaTerceto(){
	t_nodo_terceto *aux;
    aux = lista_terceto;
    if(aux==NULL)
        return 0;
    while(aux->pSig!=NULL)
    {	
        printf("\n[%d], (%s, %s, %s)\n",aux->info.numeroTerceto,aux->info.primerElemento, aux->info.segundoElemento,aux->info.tercerElemento);
		aux = aux->pSig;
    }
	printf("\n[%d], (%s, %s, %s)\n",aux->info.numeroTerceto,aux->info.primerElemento, aux->info.segundoElemento,aux->info.tercerElemento);
}

void guardarTercetosEnArchivo(t_lista_terceto *pl){
  FILE * pf = fopen("intermedia.txt","wt");

  while(*pl) {
		fprintf(pf,"%d (%s,%s,%s) \n", (*pl)->info.numeroTerceto, (*pl)->info.primerElemento, (*pl)->info.segundoElemento, (*pl)->info.tercerElemento);
		pl=&(*pl)->pSig;
  }
  
  fclose(pf);
} 
/*
int buscarEnListaDeTercetosOrdenada(t_lista_terceto *pl, int indiceTerceto)
{
    int cmp;
    t_nodo_terceto aux;
    char segundoElem[TAM];
    printf("-----------------INDICE TERCETO: %d\n",indiceTerceto);

    while(pl && (cmp = indiceTerceto - (pl)->info.numeroTerceto) >0)
        pl=&(pl)->pSig;
    if(pl && cmp==0)
    {
        return 1;
    }

    return 0;
}
*/
int modificarIndiceTercetoSalto(t_lista_terceto *pl, int indiceTerceto, int indiceAColocar)
{
    int cmp;
    char segundoElem[TAM];
	//itero hasta encontrar terceto a modificar
	while(pl && (cmp = indiceTerceto - (*pl)->info.numeroTerceto) >0)
        pl=&(*pl)->pSig;
    if(pl && cmp==0)
    {
        // Modifico terceto
        strcpy((*pl)->info.segundoElemento, crearIndice(indiceAColocar));
        return 1;
    }

    return 0;
}


// -- fin funciones tercetos --


void ftoa(float n, char* res, int afterpoint)
{
    // Extract integer part
    int ipart = (int)n;
  
    // Extract floating part
    float fpart = n - (float)ipart;
  
    // convert integer part to string
    int i = intToStr(ipart, res, 0);
  
    // check for display option after point
    if (afterpoint != 0) {
        res[i] = '.'; // add dot
  
        // Get the value of fraction part upto given no.
        // of points after dot. The third parameter 
        // is needed to handle cases like 233.007
        fpart = fpart * pow(10, afterpoint);
  
        intToStr((int)fpart, res + i + 1, afterpoint);
    }
}

// Reverses a string 'str' of length 'len'
void reverse(char* str, int len)
{
    int i = 0, j = len - 1, temp;
    while (i < j) {
        temp = str[i];
        str[i] = str[j];
        str[j] = temp;
        i++;
        j--;
    }
}

// Converts a given integer x to string str[]. 
// d is the number of digits required in the output. 
// If d is more than the number of digits in x, 
// then 0s are added at the beginning.
int intToStr(int x, char str[], int d)
{
    int i = 0;
    while (x) {
        str[i++] = (x % 10) + '0';
        x = x / 10;
    }
  
    // If number of digits required is more, then
    // add 0s at the beginning
    while (i < d)
        str[i++] = '0';
  
    reverse(str, i);
    str[i] = '\0';
    return i;
}