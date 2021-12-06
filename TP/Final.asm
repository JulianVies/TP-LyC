include macros2.asm
include number.asm
.MODEL	LARGE 
.386
.STACK 200h 

.DATA 
	@x dd ?	 ; Declaracion de Variable Numerica
	@u dd ?	 ; Declaracion de Variable Numerica
	@z dd ?	 ; Declaracion de Variable Numerica
	@b dd ?	 ; Declaracion de Variable Numerica
	@a dd ?	 ; Declaracion de Variable Numerica
	@_5 dd 5.0	;Declaracion de Constant Number
.CODE 
MAIN:


	 MOV AX,@DATA 	;inicializa el segmento de datos
	 MOV DS,AX 
	 MOV ES,AX 
	 FNINIT 

	 GetString @a
	 displayString @a 
	 newLine 
	 FLD @_5 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
	 GetFloat @a
	 DisplayFloat @a,2 
	 newLine 
	 mov AX, 4C00h 	 ; Genera la interrupcion 21h
	 int 21h 	 ; Genera la interrupcion 21h
END MAIN
