include macros2.asm
include number.asm
.MODEL	LARGE 
.386
.STACK 200h 

.DATA 
	@b dd ?	 ; Declaracion de Variable Numerica
	@a dd ?	 ; Declaracion de Variable Numerica
	@varB dd ?	 ; Declaracion de Variable Numerica
	@var dd ?	 ; Declaracion de Variable Numerica
	@_1 dd 1.0	;Declaracion de Constant Number
	@_3 dd 3.0	;Declaracion de Constant Number
	@_FOR2 db FOR2, "$", 30 dup (?)	;Declaracion de Constant String
.CODE 
MAIN:


	 MOV AX,@DATA 	;inicializa el segmento de datos
	 MOV DS,AX 
	 MOV ES,AX 
	 FNINIT 

	 FLD @a		;comparacion, operando1 
	 FLD @b		;comparacion, operando2 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNA ETIQ_15 	;Si cumple la condicion salto a la etiqueta
	 FLD @_1 	;Cargo valor 
	 FSTP @varB 	; Se lo asigno a la variable que va a guardar el resultado 
ETIQ_8: 
	 FLD @varB		;comparacion, operando1 
	 FLD @_3		;comparacion, operando2 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JA ETIQ_15 	;Si cumple la condicion salto a la etiqueta
	 DisplayString @_FOR2 
	 newLine 
	 FLD @varB 	;Cargo operando 1
	 FLD @_3 	;Cargo operando 2
	 FADD 		;Opero
	 FSTP @_aux12 	;Almaceno el resultado en una var auxiliar
	 FLD @_aux12 	;Cargo valor 
	 FSTP @varB 	; Se lo asigno a la variable que va a guardar el resultado 
	 JMP ETIQ_8 	;Si cumple la condicion salto a la etiqueta
ETIQ_15: 
	 mov AX, 4C00h 	 ; Genera la interrupcion 21h
	 int 21h 	 ; Genera la interrupcion 21h
END MAIN
