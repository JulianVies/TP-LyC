
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
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
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


