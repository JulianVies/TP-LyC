include macros2.asm
include number.asm
.MODEL	LARGE 
.386
.STACK 200h 

.DATA 
	@c dd ?	 ; Declaracion de Variable Numerica
	@b dd ?	 ; Declaracion de Variable Numerica
	@a dd ?	 ; Declaracion de Variable Numerica
	@_2 dd 2.0	;Declaracion de Constant Number
	@_1 dd 1.0	;Declaracion de Constant Number
	@_primero db "primero", "$", 30 dup (?)	;Declaracion de Constant String
	@_segundo db "segundo", "$", 30 dup (?)	;Declaracion de Constant String
	@_3 dd 3.0	;Declaracion de Constant Number
.CODE 
MAIN:


	 MOV AX,@DATA 	;inicializa el segmento de datos
	 MOV DS,AX 
	 MOV ES,AX 
	 FNINIT 

	 FLD @_2 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @_1 	;Cargo valor 
	 FSTP @b 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @a		;comparacion, operando1 
	 FLD @b		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNA ETIQ_18 	;Si cumple la condicion salto a la etiqueta
	 FLD @a		;comparacion, operando1 
	 FLD @b		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JAE ETIQ_16 	;Si cumple la condicion salto a la etiqueta
	 displayString @_primero 
	 newLine 
	 JMP ETIQ_17 	;Si cumple la condicion salto a la etiqueta
ETIQ_16: 
	 displayString @_segundo 
	 newLine 
ETIQ_17: 
	 JMP ETIQ_21 	;Si cumple la condicion salto a la etiqueta
ETIQ_18: 
	 FLD @_3 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
ETIQ_21: 
	 mov AX, 4C00h 	 ; Genera la interrupcion 21h
	 int 21h 	 ; Genera la interrupcion 21h
END MAIN
