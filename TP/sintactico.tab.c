
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.4.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Copy the first part of user declarations.  */


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



/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ID = 258,
     CTE_S = 259,
     CTE_E = 260,
     CTE_R = 261,
     GET = 262,
     DISPLAY = 263,
     EQUMAX = 264,
     EQUMIN = 265,
     FOR = 266,
     WHILE = 267,
     BEGINW = 268,
     ENDW = 269,
     THEN = 270,
     IF = 271,
     ELSE = 272,
     ENDIF = 273,
     NOT = 274,
     AND = 275,
     OR = 276,
     OP_ASIG = 277,
     COMA = 278,
     PYC = 279,
     OP_SUM = 280,
     OP_RESTA = 281,
     OP_MULT = 282,
     OP_DIV = 283,
     CORCHA = 284,
     CORCHC = 285,
     PARA = 286,
     PARC = 287,
     LLAVEA = 288,
     LLAVEC = 289,
     MENOR_IGUAL = 290,
     MAYOR_IGUAL = 291,
     MENOR = 292,
     MAYOR = 293,
     DIFF = 294,
     IGUAL = 295,
     IGUALFOR = 296,
     DIM = 297,
     AS = 298,
     TO = 299,
     NEXT = 300,
     INTEGER = 301,
     STRING = 302,
     REAL = 303
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{


	int int_val;
	double float_val;
	char *str_val;



} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif


/* Copy the second part of user declarations.  */



#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int yyi)
#else
static int
YYID (yyi)
    int yyi;
#endif
{
  return yyi;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)				\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack_alloc, Stack, yysize);			\
	Stack = &yyptr->Stack_alloc;					\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  40
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   138

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  49
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  38
/* YYNRULES -- Number of rules.  */
#define YYNRULES  73
/* YYNRULES -- Number of states.  */
#define YYNSTATES  135

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   303

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint8 yyprhs[] =
{
       0,     0,     3,     5,     7,    10,    12,    14,    16,    18,
      20,    22,    26,    30,    32,    34,    35,    36,    44,    50,
      51,    52,    62,    71,    74,    77,    80,    81,    82,    93,
      94,    95,   106,   108,   112,   114,   116,   118,   120,   124,
     126,   130,   132,   134,   136,   138,   142,   146,   148,   152,
     156,   160,   162,   164,   166,   168,   171,   175,   179,   180,
     185,   187,   189,   191,   193,   195,   197,   199,   201,   202,
     203,   204,   218,   221
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      50,     0,    -1,    51,    -1,    52,    -1,    51,    52,    -1,
      53,    -1,    54,    -1,    58,    -1,    61,    -1,    62,    -1,
      63,    -1,     3,    22,    75,    -1,     3,    22,     4,    -1,
      55,    -1,    82,    -1,    -1,    -1,    12,    78,    56,    13,
      51,    57,    14,    -1,    16,    78,    15,    51,    18,    -1,
      -1,    -1,    16,    78,    15,    51,    59,    17,    60,    51,
      18,    -1,    42,    29,    72,    30,    43,    29,    73,    30,
      -1,     8,     3,    -1,     8,     4,    -1,     7,     3,    -1,
      -1,    -1,     9,    65,    31,    75,    66,    24,    29,    70,
      30,    32,    -1,    -1,    -1,    10,    68,    31,    75,    69,
      24,    29,    70,    30,    32,    -1,    71,    -1,    70,    23,
      71,    -1,     3,    -1,     5,    -1,     6,    -1,     3,    -1,
      72,    23,     3,    -1,    74,    -1,    73,    23,    74,    -1,
      46,    -1,    47,    -1,    48,    -1,    76,    -1,    75,    25,
      76,    -1,    75,    26,    76,    -1,    77,    -1,    76,    27,
      77,    -1,    76,    28,    77,    -1,    31,    75,    32,    -1,
       3,    -1,     5,    -1,     6,    -1,    79,    -1,    19,    79,
      -1,    79,    20,    79,    -1,    79,    21,    79,    -1,    -1,
      75,    80,    81,    75,    -1,    64,    -1,    67,    -1,    35,
      -1,    36,    -1,    37,    -1,    38,    -1,    39,    -1,    40,
      -1,    -1,    -1,    -1,    11,     3,    41,    75,    83,    44,
      75,    84,    86,    85,    51,    45,     3,    -1,    29,    30,
      -1,    29,     5,    30,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   263,   263,   269,   270,   273,   274,   275,   276,   277,
     278,   281,   288,   295,   296,   300,   307,   299,   317,   323,
     333,   323,   341,   367,   372,   377,   382,   382,   382,   384,
     384,   384,   386,   387,   397,   400,   405,   412,   413,   416,
     417,   420,   420,   420,   422,   423,   424,   427,   428,   429,
     432,   433,   436,   441,   448,   454,   455,   456,   459,   459,
     460,   461,   464,   465,   466,   467,   468,   469,   472,   472,
     472,   472,   498,   499
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "ID", "CTE_S", "CTE_E", "CTE_R", "GET",
  "DISPLAY", "EQUMAX", "EQUMIN", "FOR", "WHILE", "BEGINW", "ENDW", "THEN",
  "IF", "ELSE", "ENDIF", "NOT", "AND", "OR", "OP_ASIG", "COMA", "PYC",
  "OP_SUM", "OP_RESTA", "OP_MULT", "OP_DIV", "CORCHA", "CORCHC", "PARA",
  "PARC", "LLAVEA", "LLAVEC", "MENOR_IGUAL", "MAYOR_IGUAL", "MENOR",
  "MAYOR", "DIFF", "IGUAL", "IGUALFOR", "DIM", "AS", "TO", "NEXT",
  "INTEGER", "STRING", "REAL", "$accept", "inicio", "programa",
  "sentencia", "asignacion", "iteracion", "while", "$@1", "$@2",
  "seleccion", "$@3", "$@4", "declaracion", "display", "get", "equmax",
  "$@5", "$@6", "equmin", "$@7", "$@8", "listaEqu", "itemEqu",
  "listaVarDec", "listaType", "TYPE", "expresion", "termino", "factor",
  "condicion", "comparacion", "$@9", "comparador", "for", "$@10", "$@11",
  "$@12", "salto", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    49,    50,    51,    51,    52,    52,    52,    52,    52,
      52,    53,    53,    54,    54,    56,    57,    55,    58,    59,
      60,    58,    61,    62,    62,    63,    65,    66,    64,    68,
      69,    67,    70,    70,    71,    71,    71,    72,    72,    73,
      73,    74,    74,    74,    75,    75,    75,    76,    76,    76,
      77,    77,    77,    77,    78,    78,    78,    78,    80,    79,
      79,    79,    81,    81,    81,    81,    81,    81,    83,    84,
      85,    82,    86,    86
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     1,     2,     1,     1,     1,     1,     1,
       1,     3,     3,     1,     1,     0,     0,     7,     5,     0,
       0,     9,     8,     2,     2,     2,     0,     0,    10,     0,
       0,    10,     1,     3,     1,     1,     1,     1,     3,     1,
       3,     1,     1,     1,     1,     3,     3,     1,     3,     3,
       3,     1,     1,     1,     1,     2,     3,     3,     0,     4,
       1,     1,     1,     1,     1,     1,     1,     1,     0,     0,
       0,    13,     2,     3
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     0,     0,     0,     0,     0,     0,     2,
       3,     5,     6,    13,     7,     8,     9,    10,    14,     0,
      25,    23,    24,     0,    51,    52,    53,    26,    29,     0,
       0,    60,    61,    58,    44,    47,    15,    54,     0,     0,
       1,     4,    12,    11,     0,     0,     0,    55,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,    37,     0,
      68,     0,     0,    50,    45,    46,    62,    63,    64,    65,
      66,    67,     0,    48,    49,     0,    56,    57,    19,     0,
       0,     0,    27,    30,    59,    16,    18,     0,    38,     0,
       0,     0,     0,     0,    20,     0,    69,     0,     0,    17,
       0,    41,    42,    43,     0,    39,     0,     0,     0,     0,
       0,    22,     0,    70,    34,    35,    36,     0,    32,     0,
      21,    40,     0,    72,     0,     0,     0,     0,    73,     0,
      33,    28,    31,     0,    71
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     8,     9,    10,    11,    12,    13,    54,    93,    14,
      87,   100,    15,    16,    17,    31,    45,    91,    32,    46,
      92,   117,   118,    59,   104,   105,    33,    34,    35,    36,
      37,    51,    72,    18,    81,   106,   124,   113
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -55
static const yytype_int16 yypact[] =
{
      71,     0,    10,    13,    28,    -1,    -1,     7,    53,    71,
     -55,   -55,   -55,   -55,   -55,   -55,   -55,   -55,   -55,    34,
     -55,   -55,   -55,    57,   -55,   -55,   -55,   -55,   -55,    58,
      85,   -55,   -55,    16,    30,   -55,   -55,    60,    56,    82,
     -55,   -55,   -55,    16,    85,    70,    81,   -55,    67,    85,
      85,    68,    85,    85,    62,    58,    58,    71,   -55,     4,
      16,    85,    85,   -55,    30,    30,   -55,   -55,   -55,   -55,
     -55,   -55,    85,   -55,   -55,    71,   -55,   -55,    17,   114,
      78,    79,    16,    16,    16,    71,   -55,   105,   -55,    95,
      85,   101,   102,   113,   -55,    63,    16,    99,   100,   -55,
      71,   -55,   -55,   -55,    43,   -55,   103,    91,    91,    44,
      63,   -55,     2,   -55,   -55,   -55,   -55,    54,   -55,    72,
     -55,   -55,   104,   -55,    71,    91,    98,   106,   -55,     3,
     -55,   -55,   -55,   128,   -55
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -55,   -55,   -54,    -9,   -55,   -55,   -55,   -55,   -55,   -55,
     -55,   -55,   -55,   -55,   -55,   -55,   -55,   -55,   -55,   -55,
     -55,    25,    11,   -55,   -55,    27,   -18,    65,    66,   129,
      -6,   -55,   -55,   -55,   -55,   -55,   -55,   -55
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -1
static const yytype_uint8 yytable[] =
{
      41,    43,    24,    78,    25,    26,     1,   122,    27,    28,
       2,     3,    48,    20,     4,     5,    21,    22,    29,     6,
       1,    85,    19,    47,     2,     3,    60,    79,     4,     5,
      30,    23,   123,     6,    80,    86,    39,    24,    42,    25,
      26,    49,    50,    82,    83,     7,   109,     1,   133,    76,
      77,     2,     3,    40,    84,     4,     5,    52,    53,     7,
       6,    24,   120,    25,    26,    30,   110,    27,    28,    41,
     129,    57,    96,   111,     1,    75,    41,   125,     2,     3,
      55,    56,     4,     5,   126,    58,     7,     6,    24,    30,
      25,    26,    49,    50,   114,   125,   115,   116,    44,    63,
      41,    61,   127,    66,    67,    68,    69,    70,    71,   101,
     102,   103,    62,     7,    64,    65,    30,    88,    73,    74,
      41,    89,    94,    90,    95,    97,    98,    99,   107,   108,
     131,   134,   112,   119,   128,    38,   130,   121,   132
};

static const yytype_uint8 yycheck[] =
{
       9,    19,     3,    57,     5,     6,     3,     5,     9,    10,
       7,     8,    30,     3,    11,    12,     3,     4,    19,    16,
       3,    75,    22,    29,     7,     8,    44,    23,    11,    12,
      31,     3,    30,    16,    30,    18,    29,     3,     4,     5,
       6,    25,    26,    61,    62,    42,   100,     3,    45,    55,
      56,     7,     8,     0,    72,    11,    12,    27,    28,    42,
      16,     3,    18,     5,     6,    31,    23,     9,    10,    78,
     124,    15,    90,    30,     3,    13,    85,    23,     7,     8,
      20,    21,    11,    12,    30,     3,    42,    16,     3,    31,
       5,     6,    25,    26,     3,    23,     5,     6,    41,    32,
     109,    31,    30,    35,    36,    37,    38,    39,    40,    46,
      47,    48,    31,    42,    49,    50,    31,     3,    52,    53,
     129,    43,    17,    44,    29,    24,    24,    14,    29,    29,
      32,     3,    29,   108,    30,     6,   125,   110,    32
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,     7,     8,    11,    12,    16,    42,    50,    51,
      52,    53,    54,    55,    58,    61,    62,    63,    82,    22,
       3,     3,     4,     3,     3,     5,     6,     9,    10,    19,
      31,    64,    67,    75,    76,    77,    78,    79,    78,    29,
       0,    52,     4,    75,    41,    65,    68,    79,    75,    25,
      26,    80,    27,    28,    56,    20,    21,    15,     3,    72,
      75,    31,    31,    32,    76,    76,    35,    36,    37,    38,
      39,    40,    81,    77,    77,    13,    79,    79,    51,    23,
      30,    83,    75,    75,    75,    51,    18,    59,     3,    43,
      44,    66,    69,    57,    17,    29,    75,    24,    24,    14,
      60,    46,    47,    48,    73,    74,    84,    29,    29,    51,
      23,    30,    29,    86,     3,     5,     6,    70,    71,    70,
      18,    74,     5,    30,    85,    23,    30,    30,    30,    51,
      71,    32,    32,    45,     3
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
#else
static void
yy_stack_print (yybottom, yytop)
    yytype_int16 *yybottom;
    yytype_int16 *yytop;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}

/* Prevent warnings from -Wmissing-prototypes.  */
#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */


/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*-------------------------.
| yyparse or yypush_parse.  |
`-------------------------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{


    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       `yyss': related to states.
       `yyvs': related to semantic values.

       Refer to the stacks thru separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yytoken = 0;
  yyss = yyssa;
  yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */
  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;

	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),
		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss_alloc, yyss);
	YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:

    {
	genera_asm();
	printf("\nEnd programa.\n");	
	;}
    break;

  case 5:

    { printf("Regla asignacion\n"); ;}
    break;

  case 8:

    { printf("Regla declaracion\n"); ;}
    break;

  case 9:

    { printf("Regla display\n"); ;}
    break;

  case 10:

    { printf("Regla get\n"); ;}
    break;

  case 11:

    {	
				BuscarEnLista(&lista_ts, (yyvsp[(1) - (3)].str_val));
				int auxPos = crearTerceto((yyvsp[(1) - (3)].str_val), "", "");
				crearTerceto(":=", crearIndice(auxPos), crearIndice(Eind));
			;}
    break;

  case 12:

    {	
				BuscarEnLista(&lista_ts, (yyvsp[(1) - (3)].str_val));
				crearTerceto("=", (yyvsp[(1) - (3)].str_val), (yyvsp[(3) - (3)].str_val));
			;}
    break;

  case 13:

    { printf("Regla while\n"); ;}
    break;

  case 14:

    { printf("Regla for\n"); ;}
    break;

  case 15:

    { 	
			t_info_p whileCmp;
			verTope(&pilaComp,&whileCmp);
			whileCmp.posicion--;
			apilar(&pilaWhilesCmp,&whileCmp);
		;}
    break;

  case 16:

    {	t_info_p whileCmpAux;
			desapilar(&pilaWhilesCmp,&whileCmpAux);
			IndiceActual =  crearTerceto("BI",crearIndice(whileCmpAux.posicion),"");
			t_info_p whileFalseAux;
			desapilar(&pilaComp,&whileFalseAux);
			modificarIndiceTercetoSalto(&lista_terceto, whileFalseAux.posicion, IndiceActual + 1);
			//*PosReservada = contadorTercetos;
		;}
    break;

  case 18:

    { printf("Regla If\n");
			t_info_p ifCmpAux;
			desapilar(&pilaComp,&ifCmpAux);
			printf("Desapilar primer branch: %d",ifCmpAux.posicion);
			modificarIndiceTercetoSalto(&lista_terceto, ifCmpAux.posicion, contadorTercetos);
;}
    break;

  case 19:

    {			
				//Creo BI y apilo en pila else
				t_info_p elseBI;
				elseBI.posicion = crearTerceto("BI","","");
				apilar(&pilaElse,&elseBI);

				//Modifico el branch del comparador con BI+1
				t_info_p CmpAux;
				desapilar(&pilaComp,&CmpAux);
				modificarIndiceTercetoSalto(&lista_terceto, CmpAux.posicion, contadorTercetos);
			;}
    break;

  case 20:

    {
			;}
    break;

  case 21:

    { printf("Regla If con Else\n"); 
				t_info_p elseBranchAux;
				desapilar(&pilaElse,&elseBranchAux);
				modificarIndiceTercetoSalto(&lista_terceto, elseBranchAux.posicion, contadorTercetos);
			;}
    break;

  case 22:

    {
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
;}
    break;

  case 23:

    { 
	int indiceTerceto=crearTerceto("DISPLAY",(yyvsp[(2) - (2)].str_val),"");
	char* tipo = BuscarEnListaYDevolverTipo(&lista_ts,(yyvsp[(2) - (2)].str_val));
	modificarIndiceTercetoTipo(&lista_terceto, indiceTerceto, tipo);
;}
    break;

  case 24:

    {
			int indiceTerceto=crearTerceto("DISPLAY",(yyvsp[(2) - (2)].str_val),"");
			modificarIndiceTercetoTipo(&lista_terceto, indiceTerceto, "string");
		;}
    break;

  case 25:

    { int indiceTercetoGet=crearTerceto("GET",(yyvsp[(2) - (2)].str_val),"");
			char* tipoGet = BuscarEnListaYDevolverTipo(&lista_ts,(yyvsp[(2) - (2)].str_val));
			modificarIndiceTercetoTipo(&lista_terceto, indiceTercetoGet, tipoGet);
			;}
    break;

  case 26:

    {strcpy(compEqu, "BLE");;}
    break;

  case 27:

    {indVal=Eind;;}
    break;

  case 28:

    { printf("Regla equmax\n"); indMax=crearTerceto("@Val","","");;}
    break;

  case 29:

    {strcpy(compEqu, "BGE");;}
    break;

  case 30:

    {indVal=Eind;;}
    break;

  case 31:

    { printf("Regla equmin\n"); indMin=crearTerceto("@Val","","");;}
    break;

  case 32:

    {crearTerceto(":=", "@Val", crearIndice(indItem));;}
    break;

  case 33:

    { 
			int indAux;
			indAux = crearTerceto(":=", "@Aux", crearIndice(indItem));
			crearTerceto("CMP", "@Aux", "@Val");
			char textoIndAux[10];
			itoa(indAux+4,textoIndAux,10);
			crearTerceto(compEqu, textoIndAux, "");
			crearTerceto(":=", "@Val","@Aux"); ;}
    break;

  case 34:

    { 
			indItem = crearTerceto((yyvsp[(1) - (1)].str_val),"","");
		;}
    break;

  case 35:

    {
			char auxI[30];
			itoa((yyvsp[(1) - (1)].int_val),auxI,10);
			indItem = crearTerceto(auxI,"","");
			;}
    break;

  case 36:

    {
			char auxF[30];
			ftoa((yyvsp[(1) - (1)].float_val),auxF,2);
			indItem = crearTerceto(auxF,"","");
			;}
    break;

  case 37:

    {strcpy(info_p.text, yytext); apilar(&pilaVar, &info_p);;}
    break;

  case 38:

    {strcpy(info_p.text, yytext); apilar(&pilaVar, &info_p);;}
    break;

  case 39:

    {strcpy(info_p.text, yytext); apilar(&pilaType, &info_p);;}
    break;

  case 40:

    {strcpy(info_p.text, yytext); apilar(&pilaType, &info_p);;}
    break;

  case 44:

    {Eind = Tind;;}
    break;

  case 45:

    {Eind = crearTerceto("+",crearIndice(Eind), crearIndice(Tind));;}
    break;

  case 46:

    {Eind=crearTerceto("-", crearIndice(Eind), crearIndice(Tind));}
    break;

  case 47:

    {Tind=Find;;}
    break;

  case 48:

    {Tind=crearTerceto("*", crearIndice(Tind), crearIndice(Find));}
    break;

  case 49:

    {Tind=crearTerceto("/", crearIndice(Tind), crearIndice(Find));}
    break;

  case 50:

    {Find=Eind;;}
    break;

  case 51:

    { 
			Find = crearTerceto((yyvsp[(1) - (1)].str_val),"","");
		;}
    break;

  case 52:

    {
			char auxI[30];
			itoa((yyvsp[(1) - (1)].int_val),auxI,10);
			Find = crearTerceto(auxI,"","");
			;}
    break;

  case 53:

    {
			char auxF[30];
			ftoa((yyvsp[(1) - (1)].float_val),auxF,2);
			Find = crearTerceto(auxF,"","");
			;}
    break;

  case 54:

    { printf( "Regla condicion simple \n");
			t_info_p SaltoComp;
			crearTerceto("CMP",crearIndice(EindAux1),crearIndice(EindAux2));
			SaltoComp.posicion = crearTerceto(comp,"","");
			apilar(&pilaComp,&SaltoComp);
;}
    break;

  case 55:

    { printf("Regla condicion simple NOT\n"); ;}
    break;

  case 56:

    { printf("Regla condicion compuesta And\n"); ;}
    break;

  case 57:

    { printf("Regla condicion compuesta Or\n"); ;}
    break;

  case 58:

    {EindAux1=Eind;;}
    break;

  case 59:

    {EindAux2=Eind;;}
    break;

  case 60:

    {EindAux1=indVal; EindAux2=indMax; strcpy(comp, "BNE");;}
    break;

  case 61:

    {EindAux1=indVal; EindAux2=indMin; strcpy(comp, "BNE");;}
    break;

  case 62:

    {strcpy(comp, "BGT");;}
    break;

  case 63:

    {strcpy(comp,"BLT");;}
    break;

  case 64:

    {strcpy(comp, "BGE");;}
    break;

  case 65:

    {strcpy(comp, "BLE");;}
    break;

  case 66:

    {strcpy(comp, "BEQ");;}
    break;

  case 67:

    {strcpy(comp, "BNE");;}
    break;

  case 68:

    {EindAux1 = Eind;;}
    break;

  case 69:

    {EindAux2 = Eind;;}
    break;

  case 70:

    {
	t_info_p forCmp;
	nuevoSimbolo((yyvsp[(2) - (9)].str_val),"-","integer",-1);
	crearTerceto("=",(yyvsp[(2) - (9)].str_val),crearIndice(EindAux1));

	forCmp.posicion = crearTerceto("CMP",(yyvsp[(2) - (9)].str_val),crearIndice(EindAux2));
	apilar(&pilaForsCmp,&forCmp);
	forCmp.posicion = crearTerceto("BGT","","");
	apilar(&pilaForsFalse,&forCmp);
	
	;}
    break;

  case 71:

    {
		t_info_p forCmpAux;
		int indiceAuxSalto;
		char numeroTexto [4];
		itoa(saltoConst,numeroTexto,10);
		indiceAuxSalto = crearTerceto("+",(yyvsp[(2) - (13)].str_val),numeroTexto);
		crearTerceto("=",(yyvsp[(2) - (13)].str_val),crearIndice(indiceAuxSalto));
		desapilar(&pilaForsCmp,&forCmpAux);
		IndiceActual =  crearTerceto("BI",crearIndice(forCmpAux.posicion),"");
		t_info_p forFalseAux;
		desapilar(&pilaForsFalse,&forFalseAux);
		modificarIndiceTercetoSalto(&lista_terceto, forFalseAux.posicion, IndiceActual + 1);
	;}
    break;

  case 72:

    { saltoConst = 1; ;}
    break;

  case 73:

    { saltoConst = (yyvsp[(2) - (3)].int_val); ;}
    break;



      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined(yyoverflow) || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}




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
	strcpy(nuevo.tipodato,"");
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
	for (j=0;j<=cant_etiquetas;j++) {
		if (auxNodo->info.numeroTerceto == lista_etiquetas[j])
		{
			sprintf(etiqueta_aux, "ETIQ_%d", lista_etiquetas[j]);
			fprintf(pf_asm, "%s: \n", etiqueta_aux);
		}
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
		return "JAE";
	}
	else if(!strcmp(token, "BGT"))
	{
		return "JA";
	}
	else if(!strcmp(token, "BLE"))
	{
		return "JNA";
	}
	else if(!strcmp(token, "BLT"))
	{
		return "JB";
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
	else if (strcmp(auxNodo->info.primerElemento, "CMP" ) == 0)
	{
		// int tipo = buscarTipoTS(op1);
		char* tipo = BuscarEnListaYDevolverTipo(&lista_ts,op1);
		
		if ( strcmp(tipo,"float") | strcmp(tipo,"integer")) 
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

		strcpy(ult_op1_cmp, auxNodo->info.segundoElemento);
	}
	else
	{
	
		char* tipo = BuscarEnListaYDevolverTipo(&lista_ts,op1);
		if (tipo == "string") 
		{
			yyerror("Ops! No estan soportadas las operaciones entre cadenas\n");
		}
		// sprintf(aux, "_aux%d", i); // auxiliar relacionado al terceto
		// insertar_ts_si_no_existe(aux, "FLOAT", "", ""); 
		fflush(pf_asm);
		fprintf(pf_asm, "\t FLD %s \t;Cargo operando 1\n", getNombreAsm(op1));
		fprintf(pf_asm, "\t FLD %s \t;Cargo operando 2\n", getNombreAsm(op2));
		fflush(pf_asm);
		
		// lista_terceto
		
		
		fprintf(pf_asm, "\t %s \t\t;Opero\n", getCodOp(auxNodo->info.primerElemento));
		// fprintf(pf_asm, "\t FSTP %s \t;Almaceno el resultado en una var auxiliar\n", getNombreAsm(aux));
		// cant_op++;
		// strcpy(lista_operandos_assembler[cant_op], aux);
	
	}
	
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
