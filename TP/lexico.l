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
	
	t_lista lista_ts;
	t_info dato;

	//
%}

DIGITO			[0-9]
LETRA			[a-zA-Z]

ID				{LETRA}({LETRA}|{DIGITO})*
CTE_E		    {DIGITO}+
CTE_R		    {DIGITO}+"."{DIGITO}*|{DIGITO}*"."{DIGITO}+
CTE_S		    \"[^\"]*\"

COMENTARIO		\*\/.+\/\*	

%%

"GET"			{printf("GET\n");}
"DISPLAY"		{printf("DISPLAY\n");}

"WHILE"			{printf("WHILE\n");}
"IF"			{printf("IF\n");}
"ELSE"			{printf("ELSE\n");}

"&&"			{printf("&&\n");}
"||"			{printf("WHILE\n");}


"NOT"			{printf("NOT\n");}
"AND"			{printf("AND\n");}
"OR"			{printf("OR\n");}

":="			{printf("ASIG\n");}
","				{printf("COMA\n");}
";"				{printf("PYC\n");}
":"				{printf("DOSPUNT\n");}
"+"				{printf("MAS\n");}
"-"				{printf("MENOS\n");}
"*"				{printf("MULT\n");}
"/"				{printf("DIV\n");}

"["				{printf("BRAA\n");}
"]"				{printf("BRAC\n");}
"("				{printf("PARA\n");}
")"				{printf("PARC\n");}
"{"				{printf("CORA\n");}
"}"				{printf("CORC\n");}

"<="			{printf("MENOSIGUAL\n");}
">="			{printf("MASIGUAL\n");}
"<"				{printf("MENOR\n");}
">" 			{printf("MAYOR\n");}
"!="			{printf("DIFF\n");}
"=="			{printf("IGUAL\n");}



"DIM"			{printf("DIM\n");}
"AS"			{printf("AS\n");}

"integer"		{printf("integer\n");}
"string"		{printf("string\n");}
"real"			{printf("real\n");}

{COMENTARIO}	{
					if(strlen(yytext)<=200){
						printf("COMENTARIO\n");
						//aca no retorna token
					}else{
						printf("Error lexico: Los comentarios deben ser de menos de 50 caracteres!");
						return 1;
					}
				}


{CTE_S}			{
					if(strlen(yytext)<=30){
						printf("longitud OK!\n");
						printf("CTE_S\n");

						sacarComillas(yytext);
						
						char stringConGuion[100];
						agregarGuion(yytext,stringConGuion);
						
						//lista
						strcpy(dato.nombre, stringConGuion);
						strcpy(dato.valor, " ");
						strcpy(dato.tipodato, "STRING"); //TODO: revisar si es necesario el tipo de dato en el lexico
						dato.longitud = strlen(yytext);
						insertar_en_ts(&lista_ts, &dato);


					}
						printf("Error lexico: Los string deben ser de menos de 30 caracteres!");
						return 1;
				}

{CTE_E}			{
					if(atoll(yytext)<=2147483647){	 //convierto a long, comparo con el max de int
							entero = atoi(yytext);
							//return CTE_E;
							printf("CTE_E\n");

							char enteroConGuion[100];
							agregarGuion(yytext,enteroConGuion);
	
							//lista
							strcpy(dato.nombre, enteroConGuion);
							strcpy(dato.valor, yytext);
							strcpy(dato.tipodato, "CTE_E");
							insertar_en_ts(&lista_ts, &dato);
					}else{
						printf("Error lexico: tam de entero excedido!");
						return 1;
					}

				}
{CTE_R}			{
					if(atof(yytext)<=3.40282347e+38F){
						real = atof(yytext);
						printf("CTE_R\n");
						//return CTE_R;

						char realConGuion[100];
						agregarGuion(yytext,realConGuion);
						//lista

						strcpy(dato.nombre,realConGuion);
						strcpy(dato.valor, yytext);
						strcpy(dato.tipodato, "CTE_R");
						insertar_en_ts(&lista_ts, &dato);

					}else{
						printf("Error lexico: tam de float excedido!");
						return 1;
					}

				}

{ID}			{
						if(strlen(yytext)<=30){
							printf("ID, %s\n", yytext);
							//return ID;

						}else{
							printf("Error lexico: Los ID deben ser de menos de 30 caracteres!");
							return 1;
						}
				}


%%

int yywrap(){}
int main(int argc,char *argv[])
{

    crear_ts(&lista_ts);

    if ((yyin = fopen(argv[1], "rt")) == NULL){
        
        printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
    }
    else{
       yylex(); 

       grabar_lista(&lista_ts);

    }
    fclose(yyin);
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

void agregarGuion(char *pc, char* result){
    const char *middle = pc;
    result[0] = '\0';
    strcat(result, "_");
    strcat(result, middle);
}

void sacarComillas(char *pc){

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