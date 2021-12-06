include macros2.asm
include number.asm
.MODEL	LARGE 
.386
.STACK 200h 

.DATA 
	@c dd ?	 ; Declaracion de Variable Numerica
	@b dd ?	 ; Declaracion de Variable Numerica
	@a dd ?	 ; Declaracion de Variable Numerica
	@_40 dd 40.0	;Declaracion de Constant Number
	@_30 dd 30.0	;Declaracion de Constant Number
	@EquVal dd ?	 ; Declaracion de Variable Numerica
	@_Funciona db "Funciona", "$", 30 dup (?)	;Declaracion de Constant String
.CODE 
MAIN:


	 MOV AX,@DATA 	;inicializa el segmento de datos
	 MOV DS,AX 
	 MOV ES,AX 
	 FNINIT 

	 FLD @_40 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @_30 	;Cargo valor 
	 FSTP @b 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @_40 	;Cargo valor 
	 FSTP @EquVal 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @EquVal		;comparacion, operando1 
	 FLD @b		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNA ETIQ_14 	;Si cumple la condicion salto a la etiqueta
	 FLD @b 	;Cargo valor 
	 FSTP @EquVal 	; Se lo asigno a la variable que va a guardar el resultado 
ETIQ_14: 
	 FLD @a		;comparacion, operando1 
	 FLD @EquVal		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNE ETIQ_17 	;Si cumple la condicion salto a la etiqueta
	 displayString @_Funciona 
	 newLine 
ETIQ_17: 
	 mov AX, 4C00h 	 ; Genera la interrupcion 21h
	 int 21h 	 ; Genera la interrupcion 21h
END MAIN
