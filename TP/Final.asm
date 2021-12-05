include macros2.asm
include number.asm
.MODEL	LARGE 
.386
.STACK 200h 

.DATA 
	@b dd ?	 ; Declaracion de Variable Numerica
	@a dd ?	 ; Declaracion de Variable Numerica
	@_2 dd 2.0	;Declaracion de Constant Number
	@_3 dd 3.0	;Declaracion de Constant Number
.CODE 
MAIN:


	 MOV AX,@DATA 	;inicializa el segmento de datos
	 MOV DS,AX 
	 MOV ES,AX 
	 FNINIT 

	 FLD @_2 	;Cargo operando 1
	 FLD @_3 	;Cargo operando 2
	 FADD 		;Opero
	 FLD @ 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
	 mov AX, 4C00h 	 ; Genera la interrupcion 21h
	 int 21h 	 ; Genera la interrupcion 21h
END MAIN
