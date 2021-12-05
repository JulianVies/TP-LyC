include macros2.asm
include number.asm
.MODEL	LARGE 
.386
.STACK 200h 

.DATA 
	@z dd ?	 ; Declaracion de Variable Numerica
	@_20 dd 20.0	;Declaracion de Constant Number
.CODE 
MAIN:


	 MOV AX,@DATA 	;inicializa el segmento de datos
	 MOV DS,AX 
	 MOV ES,AX 
	 FNINIT 

	 FLD @b 	;Cargo operando 1
	 FLD @c 	;Cargo operando 2
	 FMUL 		;Opero
	 FSTP @_aux3 	;Almaceno el resultado en una var auxiliar
	 FLD @a 	;Cargo operando 1
	 FLD @_aux3 	;Cargo operando 2
	 FADD 		;Opero
	 FSTP @_aux4 	;Almaceno el resultado en una var auxiliar
	 FLD @e 	;Cargo operando 1
	 FLD @f 	;Cargo operando 2
	 FADD 		;Opero
	 FSTP @_aux8 	;Almaceno el resultado en una var auxiliar
	 FLD @d 	;Cargo operando 1
	 FLD @_aux8 	;Cargo operando 2
	 FDIV 		;Opero
	 FSTP @_aux9 	;Almaceno el resultado en una var auxiliar
	 FLD @_aux4 	;Cargo operando 1
	 FLD @_aux9 	;Cargo operando 2
	 FSUB 		;Opero
	 FSTP @_aux10 	;Almaceno el resultado en una var auxiliar
	 FLD @_aux10 	;Cargo operando 1
	 FLD @_20 	;Cargo operando 2
	 FADD 		;Opero
	 FSTP @_aux12 	;Almaceno el resultado en una var auxiliar
	 FLD @_aux12 	;Cargo valor 
	 FSTP @z 	; Se lo asigno a la variable que va a guardar el resultado 
	 mov AX, 4C00h 	 ; Genera la interrupcion 21h
	 int 21h 	 ; Genera la interrupcion 21h
END MAIN
