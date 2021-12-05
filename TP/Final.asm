include macros2.asm
include number.asm
.MODEL	LARGE 
.386
.STACK 200h 

.DATA 
	@a dd ?	 ; Declaracion de Variable Numerica
	@_1 dd 1.0	;Declaracion de Constant Number
	@_100 dd 100.0	;Declaracion de Constant Number
	@EquVal dd ?	 ; Declaracion de Variable Numerica
	@_102 dd 102.0	;Declaracion de Constant Number
	@_28 dd 28.0	;Declaracion de Constant Number
.CODE 
MAIN:


	 MOV AX,@DATA 	;inicializa el segmento de datos
	 MOV DS,AX 
	 MOV ES,AX 
	 FNINIT 

	 mov si,OFFSET @_100 	;Cargo en si el origen
	 mov di,OFFSET @@EquVal 	;Cargo en di el destino
	 STRCPY	; llamo a la macro para copiar 
	 mov si,OFFSET @a 	;Cargo en si el origen
	 mov di,OFFSET @@Aux 	;Cargo en di el destino
	 STRCPY	; llamo a la macro para copiar 
	 FLD @		;comparacion, operando1 
	 FLD @_1		;comparacion, operando2 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JAE ETIQ_10 	;Si cumple la condicion salto a la etiqueta
	 mov si,OFFSET @ 	;Cargo en si el origen
	 mov di,OFFSET @ 	;Cargo en di el destino
	 STRCPY	; llamo a la macro para copiar 
ETIQ_10: 
	 mov si,OFFSET @_102 	;Cargo en si el origen
	 mov di,OFFSET @@Aux 	;Cargo en di el destino
	 STRCPY	; llamo a la macro para copiar 
	 FLD @		;comparacion, operando1 
	 FLD @		;comparacion, operando2 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JAE ETIQ_16 	;Si cumple la condicion salto a la etiqueta
	 mov si,OFFSET @ 	;Cargo en si el origen
	 mov di,OFFSET @ 	;Cargo en di el destino
	 STRCPY	; llamo a la macro para copiar 
ETIQ_16: 
	 FLD @		;comparacion, operando1 
	 FLD @		;comparacion, operando2 
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
