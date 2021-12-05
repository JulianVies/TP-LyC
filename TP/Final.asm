include macros2.asm
include number.asm
.MODEL	LARGE 
.386
.STACK 200h 

.DATA 
	@b dd ?	 ; Declaracion de Variable Numerica
	@a dd ?	 ; Declaracion de Variable Numerica
	@var dd ?	 ; Declaracion de Variable Numerica
	@_1 dd 1.0	;Declaracion de Constant Number
	@_21 dd 21.0	;Declaracion de Constant Number
	@_2 dd 2.0	;Declaracion de Constant Number
	@_3 dd 3.0	;Declaracion de Constant Number
.CODE 
MAIN:


	 MOV AX,@DATA 	;inicializa el segmento de datos
	 MOV DS,AX 
	 MOV ES,AX 
	 FNINIT 

	 FLD @_1 	;Cargo valor 
	 FSTP @var 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @_21 	;Cargo operando 1
	 FLD @_2 	;Cargo operando 2
	 FADD 		;Opero
	 FSTP @_aux5 	;Almaceno el resultado en una var auxiliar
ETIQ_6: 
	 FLD @var		;comparacion, operando1 
	 FLD @_aux5		;comparacion, operando2 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JA ETIQ_15 	;Si cumple la condicion salto a la etiqueta
	 FLD @b 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @var 	;Cargo operando 1
	 FLD @_3 	;Cargo operando 2
	 FADD 		;Opero
	 FSTP @_aux12 	;Almaceno el resultado en una var auxiliar
	 FLD @var 	;Cargo valor 
	 FSTP @_aux12 	; Se lo asigno a la variable que va a guardar el resultado 
	 JMP ETIQ_6 	;Si cumple la condicion salto a la etiqueta
ETIQ_15: 
	 mov AX, 4C00h 	 ; Genera la interrupcion 21h
	 int 21h 	 ; Genera la interrupcion 21h
END MAIN
