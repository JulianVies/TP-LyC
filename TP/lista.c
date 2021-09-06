#include <stdio.h>
#include <stdlib.h>
#include <string.h>
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

t_lista lista_ts;
t_info dato;

int main(int argc, char *argv[])
{

        crear_ts(&lista_ts);

        //esto se hace N veces
        strcpy(dato.nombre, "pepe");
        strcpy(dato.valor, "AAAA");
        strcpy(dato.tipodato, "STRING");
        dato.longitud = 15;
        insertar_en_ts(&lista_ts, &dato);

        strcpy(dato.nombre, "pepe3");
        strcpy(dato.valor, "1");
        strcpy(dato.tipodato, "ASDSADASDSA");
        dato.longitud = 15;
        insertar_en_ts(&lista_ts, &dato);

        strcpy(dato.nombre, "pepe2");
        strcpy(dato.valor, "A233?");
        strcpy(dato.tipodato, "STRING");
        dato.longitud = 15;
        insertar_en_ts(&lista_ts, &dato);
        //

        //dps grabo
        grabar_lista(&lista_ts);
    return 0;
}

void crear_ts(t_lista *l_ts)
{
    crear_lista(l_ts);

    printf("\n");
    printf("Creando tabla de simbolos...\n");
    printf("Tabla de simbolos creada\n");
}

int insertar_en_ts(t_lista *l_ts, t_info *d)
{
    insertarEnListaEnOrdenSinDuplicados(l_ts, d, compararPorNombre);

    // Un reinicio de la estructura dato para que vuelva a ser reutilizada sin problemas (quizas no hace falta) .
    strcpy(d->nombre, "\0");
    strcpy(d->tipodato, "\0");
    strcpy(d->valor, "\0");
    d->longitud = 0;
}

void crear_lista(t_lista *p)
{
    *p = NULL;
}

int insertarEnListaEnOrdenSinDuplicados(t_lista *pl, t_info *d, t_cmp comparar)
{
    int cmp;
    t_nodo *nuevo;
    while (*pl && (cmp = comparar(d, &(*pl)->info)) != 0)
        pl = &(*pl)->pSig;
    if (*pl && cmp == 0)
        return DUPLICADO;
    nuevo = (t_nodo *)malloc(sizeof(t_nodo));
    if (!nuevo)
        return SIN_MEMORIA;
    nuevo->info = *d;
    nuevo->pSig = *pl;
    *pl = nuevo;
    return 1;
}

int BuscarEnLista(t_lista *pl, char *cadena)
{
    int cmp;

    while (*pl && (cmp = strcmp(cadena, (*pl)->info.nombre)) != 0)
        pl = &(*pl)->pSig;
    if (cmp == 0)
    {
        return ID_EN_LISTA;
    }
    printf("\nVariable sin declarar: %s \n", cadena);
    exit(1);
}

int compararPorNombre(const void *d1, const void *d2)
{
    t_info *dato1 = (t_info *)d1;
    t_info *dato2 = (t_info *)d2;

    return strcmp(dato1->nombre, dato2->nombre);
}

void grabar_lista(t_lista *pl)
{
    FILE *pf;

    pf = fopen("ts.txt", "wt");

    // Nombres columnas de la tabla
    fprintf(pf, "%-35s %-16s %-35s %-35s", "NOMBRE", "TIPO DE DATO", "VALOR", "LONGITUD");
    // Datos
    while (*pl)
    {
        fprintf(pf, "\n%-35s %-16s %-35s %-35d", (*pl)->info.nombre, (*pl)->info.tipodato, (*pl)->info.valor, (*pl)->info.longitud);
        pl = &(*pl)->pSig;
    }

    fclose(pf);
}