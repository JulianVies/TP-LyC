include macros2.asm
include number.asm
.MODEL	LARGE 
.386
.STACK 200h 

.DATA 
	@c dd ?	 ; Declaracion de Variable Numerica
	@b dd ?	 ; Declaracion de Variable Numerica
	@a dd ?	 ; Declaracion de Variable Numerica
	@_20 dd 20.0	;Declaracion de Constant Number
	@_30 dd 30.0	;Declaracion de Constant Number
	@EquVal dd ?	 ; Declaracion de Variable Numerica
	@_28 dd 28.0	;Declaracion de Constant Number
.CODE 
MAIN:


	 MOV AX,@DATA 	;inicializa el segmento de datos
	 MOV DS,AX 
	 MOV ES,AX 
	 FNINIT 

	 FLD @_20 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @_20 	;Cargo valor 
	 FSTP @b 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @_30 	;Cargo valor 
	 FSTP @c 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @b 	;Cargo valor 
	 FSTP @EquVal 	; Se lo asigno a la variable que va a guardar el resultado 
	 mov si,OFFSET @a 	;Cargo en si el origen
	 mov di,OFFSET @Aux 	;Cargo en di el destino
	 STRCPY	; llamo a la macro para copiar 
	 FLD @ 	;Cargo valor 
	 FSTP @ 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @		;comparacion, operando1 
	 FLD @		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNE ETIQ_21 	;Si cumple la condicion salto a la etiqueta
	 FLD @_28 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
ETIQ_21: 
	 mov AX, 4C00h 	 ; Genera la interrupcion 21h
	 int 21h 	 ; Genera la interrupcion 21h
END MAIN
