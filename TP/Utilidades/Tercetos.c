#define TAM 35
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define SIN_MEMORIA 3


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


// Tercetos

char* crearIndice(int); //Recibe un numero de terceto y lo convierte en un indice
int crearTerceto(char*, char*, char*); //Se mandan los 3 strings, y se guarda el terceto creado en la lista
                                        //La posicion en la lista se lo da contadorTercetos. Variable que aumenta en 1
void guardarTercetosEnArchivo(t_lista_terceto *);
char* negarBranch(char*);	//Recibe el tipo de BRANCH y lo invierte  	
int verCompatible(char *,int, int);							   


///////////////////////////////////////////////


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

void guardarTercetosEnArchivo(t_lista_terceto *pl){
  FILE * pf = fopen("intermedia.txt","wt");

  while(*pl) {
		fprintf(pf,"%d (%s,%s,%s) \n", (*pl)->info.numeroTerceto, (*pl)->info.primerElemento, (*pl)->info.segundoElemento, (*pl)->info.tercerElemento);
		pl=&(*pl)->pSig;
  }
  
  fclose(pf);
} 