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
	char* BuscarEnListaYDevolverTipo(t_lista *pl, char* cadena);

	void crear_ts(t_lista *l_ts);
	int insertar_en_ts(t_lista *l_ts, t_info *d);
	int nuevoSimbolo(char* nombre,char* valor,char* tipoDato, int longitud);
	void insertar_ts_si_no_existe(char *nombre, char *tipo, char *valor, char *longitud);


	void grabar_lista(t_lista *);

	//----Fin estructuras para la lista----


	//----Estructuras para la pila----
	typedef struct
	{
		char text[32];
		int posicion;
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
	t_pila pilaWhilesCmp;
	t_pila pilaWhilesFalse;
	t_pila pilaForsCmp;
	t_pila pilaForsFalse;

	t_pila pilaComp;
	t_pila pilaElse;



//TERCETOS

	typedef struct
{
    int numeroTerceto;
    char primerElemento[TAM];
    char segundoElemento[TAM];
    char tercerElemento[TAM];
	char tipodato[TAM];
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


/**** Inicio assembler ****/
char lista_operandos_assembler[100][100];
int cant_op = 0;

void genera_asm();
char* getNombreAsm(char *cte_o_id);
char* getCodOp(char*);
char * buscaDatoEnTerceto(int datoUNODOSTRES, int i);
void generaSegmDatosAsm(FILE* pf_asm,t_lista *pl);
int sacarValorDeEtiqueta(char *etiqueta);


int generarListaEtiquetas(int lista_etiquetas[]);
void escribirTercetoEnAsm(FILE* pf_asm, t_nodo_terceto *auxNodo, char etiqueta_aux[]);
int cant_etiquetas = 0;
/**** Fin assembler ****/



// Variables auxiliares para tercetos //
int _flagAnd = 0;
int _aux;

char* crearIndice(int); //Recibe un numero de terceto y lo convierte en un indice
int crearTerceto(char*, char*, char*); //Se mandan los 3 strings, y se guarda el terceto creado en la lista
                                        //La posicion en la lista se lo da contadorTercetos. Variable que aumenta en 1
void guardarTercetosEnArchivo(t_lista_terceto *);
char* negarBranch(char*);	//Recibe el tipo de BRANCH y lo invierte  	
int verCompatible(char *,int, int);
int buscarEnListaDeTercetosOrdenada(t_lista_terceto *, int,t_info_terceto*);
int modificarIndiceTercetoSalto(t_lista_terceto *, int, int);
int modificarIndiceTercetoTipo(t_lista_terceto *, int, char*);


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
// int InitForInd;
// int FinForInd;
int Salto1;
int IndiceActual;

int* PosReservada;

/////////

char comp[3];
int saltoConst;

int indVal;
int indItem;
int indMax;
int indMin;
char compEqu[3];
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
inicio: programa {
	genera_asm();
	printf("\nEnd programa.\n");	
	}
		;

programa: sentencia 
        | programa sentencia 
		;

sentencia: asignacion { printf("Regla asignacion\n"); }
        | iteracion
        | seleccion
		| declaracion { printf("Regla declaracion\n"); }
		| display { printf("Regla display\n"); }
		| get { printf("Regla get\n"); }
		;

asignacion: ID  OP_ASIG expresion 
			{	
				BuscarEnLista(&lista_ts, $1);
				int auxPos = crearTerceto($1, "", "");
				crearTerceto(":=", crearIndice(auxPos), crearIndice(Eind));
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
			t_info_p whileCmp;
			verTope(&pilaComp,&whileCmp);
			whileCmp.posicion--;
			apilar(&pilaWhilesCmp,&whileCmp);
		} 
BEGINW programa 
		{	t_info_p whileCmpAux;
			desapilar(&pilaWhilesCmp,&whileCmpAux);
			IndiceActual =  crearTerceto("BI",crearIndice(whileCmpAux.posicion),"");
			t_info_p whileFalseAux;
			desapilar(&pilaComp,&whileFalseAux);
			modificarIndiceTercetoSalto(&lista_terceto, whileFalseAux.posicion, IndiceActual + 1);
			//*PosReservada = contadorTercetos;
		}
ENDW;

seleccion: IF condicion THEN programa ENDIF	{ printf("Regla If\n");
			t_info_p ifCmpAux;
			desapilar(&pilaComp,&ifCmpAux);
			printf("Desapilar primer branch: %d",ifCmpAux.posicion);
			modificarIndiceTercetoSalto(&lista_terceto, ifCmpAux.posicion, contadorTercetos);
}
        |  IF condicion THEN programa {			
				//Creo BI y apilo en pila else
				t_info_p elseBI;
				elseBI.posicion = crearTerceto("BI","","");
				apilar(&pilaElse,&elseBI);

				//Modifico el branch del comparador con BI+1
				t_info_p CmpAux;
				desapilar(&pilaComp,&CmpAux);
				modificarIndiceTercetoSalto(&lista_terceto, CmpAux.posicion, contadorTercetos);
			} ELSE {
			} programa ENDIF { printf("Regla If con Else\n"); 
				t_info_p elseBranchAux;
				desapilar(&pilaElse,&elseBranchAux);
				modificarIndiceTercetoSalto(&lista_terceto, elseBranchAux.posicion, contadorTercetos);
			}
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

display: DISPLAY ID { 
	int indiceTerceto=crearTerceto("DISPLAY",$2,"");
	char* tipo = BuscarEnListaYDevolverTipo(&lista_ts,$2);
	modificarIndiceTercetoTipo(&lista_terceto, indiceTerceto, tipo);
}
		| DISPLAY CTE_S {
			int indiceTerceto=crearTerceto("DISPLAY",$2,"");
			modificarIndiceTercetoTipo(&lista_terceto, indiceTerceto, "string");
		};

get:GET	ID { int indiceTercetoGet=crearTerceto("GET",$2,"");
			char* tipoGet = BuscarEnListaYDevolverTipo(&lista_ts,$2);
			modificarIndiceTercetoTipo(&lista_terceto, indiceTercetoGet, tipoGet);
			};

equmax: EQUMAX {strcpy(compEqu, "BLE");} PARA expresion {indVal=Eind;} PYC CORCHA listaEqu CORCHC PARC { printf("Regla equmax\n"); indMax=crearTerceto("@Val","","");};

equmin: EQUMIN {strcpy(compEqu, "BGE");} PARA expresion {indVal=Eind;} PYC CORCHA listaEqu CORCHC PARC { printf("Regla equmin\n"); indMin=crearTerceto("@Val","","");};

listaEqu: itemEqu {crearTerceto(":=", "@Val", crearIndice(indItem));}
		| listaEqu COMA itemEqu { 
			int indAux;
			indAux = crearTerceto(":=", "@Aux", crearIndice(indItem));
			crearTerceto("CMP", "@Aux", "@Val");
			char textoIndAux[10];
			itoa(indAux+4,textoIndAux,10);
			crearTerceto(compEqu, textoIndAux, "");
			crearTerceto(":=", "@Val","@Aux"); }
		;

itemEqu: ID 							 { 
			indItem = crearTerceto($1,"","");
		} 
		| CTE_E							 {
			char auxI[30];
			itoa($1,auxI,10);
			indItem = crearTerceto(auxI,"","");
			} 
		| CTE_R							 {
			char auxF[30];
			ftoa($1,auxF,2);
			indItem = crearTerceto(auxF,"","");
			} 
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
			char auxF[30];
			ftoa($1,auxF,2);
			Find = crearTerceto(auxF,"","");
			} 
		;

condicion: comparacion	{ printf( "Regla condicion simple \n");
			t_info_p SaltoComp;
			crearTerceto("CMP",crearIndice(EindAux1),crearIndice(EindAux2));
			SaltoComp.posicion = crearTerceto(comp,"","");
			apilar(&pilaComp,&SaltoComp);
}
		| NOT comparacion	{ printf("Regla condicion simple NOT\n"); }
        |  comparacion AND comparacion { printf("Regla condicion compuesta And\n"); }
        |  comparacion OR comparacion { printf("Regla condicion compuesta Or\n"); }
		;	

comparacion: expresion {EindAux1=Eind;} comparador expresion {EindAux2=Eind;}
		|  equmax {EindAux1=indVal; EindAux2=indMax; strcpy(comp, "BNE");}
		|  equmin {EindAux1=indVal; EindAux2=indMin; strcpy(comp, "BNE");}
		;

comparador: MENOR_IGUAL		{strcpy(comp, "BGT");}		
			| MAYOR_IGUAL	 {strcpy(comp,"BLT");}		
			| MENOR			{strcpy(comp, "BGE");}	
			| MAYOR 		{strcpy(comp, "BLE");}	
 			| DIFF			{strcpy(comp, "BEQ");}
			| IGUAL			{strcpy(comp, "BNE");}
			;

for:FOR ID IGUALFOR expresion {EindAux1 = Eind;} TO expresion {EindAux2 = Eind;} salto {
	t_info_p forCmp;
	crearTerceto("=",$2,crearIndice(EindAux1));

	forCmp.posicion = crearTerceto("CMP",$2,crearIndice(EindAux2));
	apilar(&pilaForsCmp,&forCmp);
	forCmp.posicion = crearTerceto("BGT","","");
	apilar(&pilaForsFalse,&forCmp);
	
	} programa NEXT ID {
		t_info_p forCmpAux;
		int indiceAuxSalto;
		char numeroTexto [4];
		itoa(saltoConst,numeroTexto,10);
		indiceAuxSalto = crearTerceto("+",$2,numeroTexto);
		crearTerceto("=",$2,crearIndice(indiceAuxSalto));
		desapilar(&pilaForsCmp,&forCmpAux);
		IndiceActual =  crearTerceto("BI",crearIndice(forCmpAux.posicion),"");
		t_info_p forFalseAux;
		desapilar(&pilaForsFalse,&forFalseAux);
		modificarIndiceTercetoSalto(&lista_terceto, forFalseAux.posicion, IndiceActual + 1);
	}
	;


salto : CORCHA CORCHC { saltoConst = 1; }
		| CORCHA CTE_E CORCHC  { saltoConst = $2; }
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
	crearPila(&pilaWhilesCmp);
	crearPila(&pilaWhilesFalse);
	yyparse();

	mostrarPila(&pilaVar);
	mostrarPila(&pilaType);
	// t_lista* lista_ts;
	// crear_ts(lista_ts);
	printf("cantidad de tercetos\t:\t%d",contadorTercetos);
	mostrarListaTerceto();
	grabar_lista(&lista_ts);
	guardarTercetosEnArchivo(&lista_terceto);
	

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
char* BuscarEnListaYDevolverTipo(t_lista *pl, char* cadena){
    int cmp;
    while(*pl && (cmp=strcmp(cadena,(*pl)->info.nombre)) != 0 && (cmp=strcmp(cadena,(*pl)->info.valor)) != 0) {
        pl=&(*pl)->pSig;
	}
	if (cmp == 0)
    	return (*pl)->info.tipodato;
	else
		return "";
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

int sacarValorDeIndice(char* indice) {
	int i=0;
	char cadena[strlen(indice)];
	while (indice[i+1] != ']') {
		cadena[i] = indice[i+1];
		i++;
	}
	cadena[i] = '\0';
	return atoi(cadena);
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
	printf("\n[%d], (%s, %s, %s, %s)\n",aux->info.numeroTerceto,aux->info.primerElemento, aux->info.segundoElemento,aux->info.tercerElemento,aux->info.tipodato);
		aux = aux->pSig;
    }
	printf("\n[%d], (%s, %s, %s, %s)\n",aux->info.numeroTerceto,aux->info.primerElemento, aux->info.segundoElemento,aux->info.tercerElemento,aux->info.tipodato);
}

void guardarTercetosEnArchivo(t_lista_terceto *pl){
  FILE * pf = fopen("intermedia.txt","wt");

  while(*pl) {
		fprintf(pf,"%d (%s,%s,%s) \n", (*pl)->info.numeroTerceto, (*pl)->info.primerElemento, (*pl)->info.segundoElemento, (*pl)->info.tercerElemento);
		pl=&(*pl)->pSig;
  }
  
  fclose(pf);
} 

int buscarEnListaDeTercetosOrdenada(t_lista_terceto *pl, int indiceTerceto, t_info_terceto *info)
{
    int cmp;

    while(pl && (cmp = indiceTerceto - (*pl)->info.numeroTerceto) >0)
        pl=&(*pl)->pSig;
    if(pl && cmp==0)
    {
		info->numeroTerceto = (*pl)->info.numeroTerceto;
		strcpy(info->primerElemento, (*pl)->info.primerElemento);
		strcpy(info->segundoElemento, (*pl)->info.segundoElemento);
		strcpy(info->tercerElemento, (*pl)->info.tercerElemento);

        return 1;
    }

    return 0;
}

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

int modificarIndiceTercetoTipo(t_lista_terceto *pl, int indiceTerceto, char* tipoAColocar)
{
    int cmp;
    char segundoElem[TAM];
	//itero hasta encontrar terceto a modificar
	while(pl && (cmp = indiceTerceto - (*pl)->info.numeroTerceto) >0)
        pl=&(*pl)->pSig;
    if(pl && cmp==0)
    {
        // Modifico terceto
        strcpy((*pl)->info.tipodato, tipoAColocar);
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






/************************************************************************************************************/
void genera_asm()
{
	char* file_asm = "Final.asm";
	FILE* pf_asm;
	int j;
	int lista_etiquetas[1000] = {-1};
	char etiqueta_aux[10];

	if((pf_asm = fopen(file_asm, "w")) == NULL)
	{
		printf("Error al generar el asembler \n");
		exit(1);
	}
	
	 /* generamos el principio del assembler, que siempre es igual */

	fprintf(pf_asm, "include macros2.asm\n");
	fprintf(pf_asm, "include number.asm\n");
	fprintf(pf_asm, ".MODEL	LARGE \n");
	fprintf(pf_asm, ".386\n");
	fprintf(pf_asm, ".STACK 200h \n");
	//  generamos bloque data
	generaSegmDatosAsm(pf_asm,&lista_ts);
	fprintf(pf_asm, ".CODE \n");
	fprintf(pf_asm, "MAIN:\n");
	fprintf(pf_asm, "\n");

    fprintf(pf_asm, "\n");
    fprintf(pf_asm, "\t MOV AX,@DATA 	;inicializa el segmento de datos\n");
    fprintf(pf_asm, "\t MOV DS,AX \n");
    fprintf(pf_asm, "\t MOV ES,AX \n");
    fprintf(pf_asm, "\t FNINIT \n");;
    fprintf(pf_asm, "\n");
	int cant_etiquetas = generarListaEtiquetas(lista_etiquetas);
	// // Armo el assembler
	t_nodo_terceto *auxNodo;
    auxNodo = lista_terceto;
    if(auxNodo==NULL)
    	exit(1);
	
    while(auxNodo->pSig!=NULL)
	{
		for (j=0;j<=cant_etiquetas;j++) {
			if (auxNodo->info.numeroTerceto == lista_etiquetas[j])
			{
				sprintf(etiqueta_aux, "ETIQ_%d", lista_etiquetas[j]);
				fprintf(pf_asm, "%s: \n", etiqueta_aux);
			}
		}
		escribirTercetoEnAsm(pf_asm, auxNodo, etiqueta_aux);
		auxNodo = auxNodo->pSig;
	}
	escribirTercetoEnAsm(pf_asm, auxNodo, etiqueta_aux);
	for (j=0;j<=cant_etiquetas;j++) {
		if(lista_etiquetas[j] == contadorTercetos) {
			sprintf(etiqueta_aux, "ETIQ_%d", lista_etiquetas[j]);
			fprintf(pf_asm, "%s: \n", etiqueta_aux);
		}
	}
	/*generamos el final */
	fprintf(pf_asm, "\t mov AX, 4C00h \t ; Genera la interrupcion 21h\n");
	fprintf(pf_asm, "\t int 21h \t ; Genera la interrupcion 21h\n");
	fprintf(pf_asm, "END MAIN\n");
	fclose(pf_asm);
}


/*
char * buscaDatoEnTerceto(int datoUNODOSTRES, int i){
	char  auxilia1[5]={'\0','\0','\0','\0','\0'};
	char *parentecisCierra;
	char *parentecisHabre;
	int num;
	int num2;
	if(datoUNODOSTRES==1){		
		if(strstr(tercetos[i].uno,"]")){ //TODO: revisar q onda tercetos[i]
			parentecisHabre  = (strstr(tercetos[i].uno,"[")+1);
			parentecisCierra = strstr(tercetos[i].uno,"]");
			num = (int) &(*parentecisCierra);
			num2 = (int) &(*parentecisHabre);
			//*(auxilia1) = '\0';
			strncpy(auxilia1,parentecisHabre,(num-num2));
			return tercetos[(atoi(auxilia1))].uno;
		}
		else return tercetos[i].uno;
	}
}
*/
// sirve para agregar @ como variable assembler
char* getNombreAsm(char *cte_o_id) {
	char* nombreAsm = (char*) malloc(sizeof(char)*200);
	nombreAsm[0] = '\0';
	char* tipo = BuscarEnListaYDevolverTipo(&lista_ts,cte_o_id);
	if (strstr(tipo,"CTE") != NULL && strstr(cte_o_id,"_") == NULL) {
		strcat(nombreAsm, "@_"); // prefijo agregado
	} else {
		strcat(nombreAsm, "@"); // prefijo agregado
	}
	
	strcat(nombreAsm, cte_o_id); // agrego nombre
	return nombreAsm;
}

char* getCodOp(char* token)
{
	if(!strcmp(token, "+"))
	{
		return "FADD";
	}
	else if(!strcmp(token, "="))
	{
		return "MOV";
	}
	else if(!strcmp(token, "-"))
	{
		return "FSUB";
	}
	else if(!strcmp(token, "*"))
	{
		return "FMUL";
	}
	else if(!strcmp(token, "/"))
	{
		return "FDIV";
	}
	else if(!strcmp(token, "BNE"))
	{
		return "JNE";
	}
	else if(!strcmp(token, "BEQ"))
	{
		return "JE";
	}
	else if(!strcmp(token, "BGE"))
	{
		return "JNA";
	}
	else if(!strcmp(token, "BGT"))
	{
		return "JNAE";
	}
	else if(!strcmp(token, "BLE"))
	{
		return "JNB";
	}
	else if(!strcmp(token, "BLT"))
	{
		return "JNBE";
	}
	else if (!strcmp(token, "BI")) {
		return "JMP";
	}
}


/*
	Generacion segmento datos a partir de la ts
*/
void generaSegmDatosAsm(FILE* pf_asm,t_lista *pl)
{
	FILE *pf;
	
	pf = fopen("ts.txt", "wt");
	fprintf(pf_asm, "\n.DATA \n");

	while(*pl) {
		char* tipoDato = (*pl)->info.tipodato;

		if(strcmpi(tipoDato, "integer") == 0 || strcmpi(tipoDato, "real") == 0)
		{
			fprintf(pf_asm, "\t%s dd ?\t ; Declaracion de Variable Numerica\n", getNombreAsm((*pl)->info.nombre));
		}
		else if(strcmpi(tipoDato, "string") == 0)
		{
			fprintf(pf_asm, "\t%s db 30 dup (?),\"$\"\t;Declaracion de Variable String\n", getNombreAsm((*pl)->info.nombre));
		}
		else if(strcmpi(tipoDato, "CTE_S") == 0)
		{
			fprintf(pf_asm, "\t%s db %s, \"$\", 30 dup (?)\t;Declaracion de Constant String\n", getNombreAsm((*pl)->info.nombre), (*pl)->info.valor);
		}
		else if(strcmpi(tipoDato, "CTE_E") == 0 || strcmpi(tipoDato, "CTE_R") == 0)
		{
			if(strstr((*pl)->info.valor,".")){
				fprintf(pf_asm, "\t%s dd %s\t;Declaracion de Constant Number\n", getNombreAsm((*pl)->info.nombre), (*pl)->info.valor);
			}else{
				fprintf(pf_asm, "\t%s dd %s.0\t;Declaracion de Constant Number\n", getNombreAsm((*pl)->info.nombre), (*pl)->info.valor);
			}
		}
		else{
			printf("tipo sin identificar");
		}
		pl=&(*pl)->pSig;
	}

	fclose(pf);
}

int generarListaEtiquetas(int lista_etiquetas[])
{
	// Guardo todos los tercetos donde tendria que poner etiquetas
	int cant_etiquetas = 0;
	t_nodo_terceto *auxNodoTerceto;
    auxNodoTerceto = lista_terceto;
    if(auxNodoTerceto==NULL)
        return;
    while(auxNodoTerceto->pSig!=NULL)
    {	
		if (strcmp(auxNodoTerceto->info.segundoElemento, "") != 0 && strcmp(auxNodoTerceto->info.tercerElemento, "") == 0)
		{
			if (strcmp(auxNodoTerceto->info.primerElemento, "GET") != 0 && strcmp(auxNodoTerceto->info.primerElemento, "DISPLAY") != 0)
			{
				int found = -1;
				int j;
				for (j = 1; j<=cant_etiquetas; j++)
				{
					if (lista_etiquetas[j] == atoi(auxNodoTerceto->info.segundoElemento))
					{
						found = 1;
					}
				}
				if (found == -1) 
				{
					cant_etiquetas++;
					lista_etiquetas[cant_etiquetas] = sacarValorDeEtiqueta(auxNodoTerceto->info.segundoElemento);
				}
			}
		}
		auxNodoTerceto = auxNodoTerceto->pSig;
    }
	return cant_etiquetas;
}

int sacarValorDeEtiqueta(char *etiqueta) {
	char dest[12];
	memset(dest, '\0', sizeof(dest));
	return atoi(strncpy(dest, etiqueta+1, strlen(etiqueta)-2));
}

void escribirTercetoEnAsm(FILE* pf_asm, t_nodo_terceto *auxNodo, char etiqueta_aux[]) 
{
	int cont=0;
	char aux[10];
	char ult_op1_cmp[30];
	strcpy(ult_op1_cmp, "");
	char op1_guardado[30];


	// Formato terceto Unario (x,  ,  ) | Ids, constantes

	if (strcmp("", auxNodo->info.segundoElemento) == 0) { 
		printf("cantop %d\n",cant_op);
		cant_op++;
		strcpy(lista_operandos_assembler[cant_op], auxNodo->info.primerElemento);
		return;
	}

	
	// Formato terceto Binario (x, x,  ) | Saltos, write, read

	if (strcmp("", auxNodo->info.tercerElemento) == 0) { 
		if (strcmp("DISPLAY", auxNodo->info.primerElemento) == 0) 
		{	
			char* tipoDato = auxNodo->info.tipodato;
			if (strcmpi(tipoDato, "real") == 0) 
			{	
				fprintf(pf_asm, "\t DisplayFloat %s,2 \n", getNombreAsm(auxNodo->info.segundoElemento));
			}
			else if (strcmpi(tipoDato, "integer") == 0) 
			{
				fprintf(pf_asm, "\t DisplayFloat %s,2 \n", getNombreAsm(auxNodo->info.segundoElemento));
			} else 
			{
				fprintf(pf_asm, "\t DisplayString %s \n", getNombreAsm(auxNodo->info.segundoElemento));
			}
			// Siempre inserto nueva linea despues de mostrar msj
			fprintf(pf_asm, "\t newLine \n");
		}
		else if (strcmp("GET", auxNodo->info.primerElemento) == 0) 
		{
			char* tipoDato = auxNodo->info.tipodato;


			if (strcmpi(tipoDato, "real") == 0) 
			{
				fprintf(pf_asm, "\t GetFloat %s\n", getNombreAsm(auxNodo->info.segundoElemento));
			} 
			else if (strcmpi(tipoDato, "integer") == 0) 
			{
				// pongo getfloat para manejar todo con fld en las operaciones
				fprintf(pf_asm, "\t GetFloat %s\n", getNombreAsm(auxNodo->info.segundoElemento));
			}	
			else 
			{
				fprintf(pf_asm, "\t GetString %s\n", getNombreAsm(auxNodo->info.segundoElemento));
			}
		}
		else // saltos
		{
			char *codigo = getCodOp(auxNodo->info.primerElemento);
			sprintf(etiqueta_aux, "ETIQ_%d", sacarValorDeIndice(auxNodo->info.segundoElemento));
			fprintf(pf_asm, "\t %s %s \t;Si cumple la condicion salto a la etiqueta\n", codigo, etiqueta_aux);
		}
		return;
	}


	
	//Formato terceto Ternario (x, x, x) | Expresiones ; Comparaciones ; Asignacion
	char *op2 = (char*) malloc(100*sizeof(char));
	strcpy(op2, lista_operandos_assembler[cant_op]);
	cant_op--;
	char *op1 = (char*) malloc(100*sizeof(char));

	if (strcmp(auxNodo->info.primerElemento, "CMP" ) == 0 && strcmp(ult_op1_cmp, auxNodo->info.segundoElemento) == 0 )
	{
		strcpy(op1, op1_guardado);
	}
	else 
	{
		strcpy(op1, lista_operandos_assembler[cant_op]); 
		cant_op--;
		strcpy(op1_guardado, op1);
	}

	if (strcmp(auxNodo->info.primerElemento, ":=" ) == 0)
	{
		//se busca el tipo de dato del ID a la izq de la asignacion
		t_info_terceto *idInfo = (t_info_terceto *)malloc(sizeof(t_info_terceto));
	    if(!idInfo) {
    	    printf("Error: SIN_MEMORIA");
			exit(1);
		}
		int indiceId = sacarValorDeIndice(auxNodo->info.segundoElemento);
		buscarEnListaDeTercetosOrdenada(&lista_terceto,indiceId,idInfo);
		char* tipo = BuscarEnListaYDevolverTipo(&lista_ts,idInfo->primerElemento);

		//se compara ese tipo
		if (strcmp(tipo, "float") == 0 || strcmp(tipo,"integer") == 0) 
		{
			fprintf(pf_asm, "\t FLD %s \t;Cargo valor \n", getNombreAsm(op1));
			fprintf(pf_asm, "\t FSTP %s \t; Se lo asigno a la variable que va a guardar el resultado \n", getNombreAsm(op2));
		}
		else
		{
			fprintf(pf_asm, "\t mov si,OFFSET %s \t;Cargo en si el origen\n", getNombreAsm(op1));
			fprintf(pf_asm, "\t mov di,OFFSET %s \t; cargo en di el destino \n", getNombreAsm(op2));
			fprintf(pf_asm, "\t STRCPY\t; llamo a la macro para copiar \n");
		}	
	}
	/*else if (strcmp(auxNodo->info.primerElemento, "CMP" ) == 0)
	{
		//int tipo = buscarTipoTS(op1);
		char* tipo = BuscarEnListaYDevolverTipo(&lista_ts,op1);
		
		if (tipo == "float" | tipo == "integer") 
		{
			fprintf(pf_asm, "\t FLD %s\t\t;comparacion, operando1 \n", getNombreAsm(op1));
			fprintf(pf_asm, "\t FLD %s\t\t;comparacion, operando2 \n", getNombreAsm(op2));
			fprintf(pf_asm, "\t FCOMP\t\t;Comparo \n");
			fprintf(pf_asm, "\t FFREE ST(0) \t; Vacio ST0\n");
			fprintf(pf_asm, "\t FSTSW AX \t\t; mueve los bits C a FLAGS\n");
			fprintf(pf_asm, "\t SAHF \t\t\t;Almacena el registro AH en el registro FLAGS \n");
		}
		else
		{
			fprintf(pf_asm, "\t mov si,OFFSET %s \t;Cargo operando1\n", getNombreAsm(op1));
			fprintf(pf_asm, "\t mov di,OFFSET %s \t; cargo operando2 \n", getNombreAsm(op2));
			fprintf(pf_asm, "\t STRCMP\t; llamo a la macro para comparar \n");	
		}

		strcpy(ult_op1_cmp, tercetos[i].dos);
	}
	else
	{
	
		
		
		char* tipo = BuscarEnListaYDevolverTipo(&lista_ts,op1);
		char* auxx;		
		if (tipo == "string") 
		{
			yyerror("Ops! No estan soportadas las operaciones entre cadenas\n");
		}
		sprintf(aux, "_aux%d", i); // auxiliar relacionado al terceto
		//insertar_ts_si_no_existe(aux, "FLOAT", "", ""); 
		fflush(pf_asm);
		fprintf(pf_asm, "\t FLD %s \t;Cargo operando 1\n", getNombreAsm(op1));
		fprintf(pf_asm, "\t FLD %s \t;Cargo operando 2\n", getNombreAsm(op2));
		fflush(pf_asm);
		
		////lista_terceto
		
		
		auxx=buscaDatoEnTerceto(1,i);


		fprintf(pf_asm, "\t %s \t\t;Opero\n", getCodOp(auxx));
		fprintf(pf_asm, "\t FSTP %s \t;Almaceno el resultado en una var auxiliar\n", getNombreAsm(aux));
		cant_op++;
		strcpy(lista_operandos_assembler[cant_op], aux);
	
	}
	*/
}
/*
void insertar_ts_si_no_existe(char *nombre, char *tipo, char *valor, char *longitud) {
	char* aux = (char*) malloc(10*sizeof(char));
	*aux='\0';
	strcpy(aux, nombre);
	if(nombre_existe_en_ts(aux)==-1) {
		insertar_tabla_simbolos(aux,tipo,valor,longitud);
	}
}
*/