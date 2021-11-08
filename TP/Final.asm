include macros2.asm
include number.asm
.MODEL	LARGE 
.386
.STACK 200h 

.DATA 
	@d dd ?	 ; Declaracion de Variable Numerica
	@c db 30 dup (?),"$"	;Declaracion de Variable String
	@b dd ?	 ; Declaracion de Variable Numerica
	@a dd ?	 ; Declaracion de Variable Numerica
	@_prueba db prueba, "$", 30 dup (?)	;Declaracion de Constant String
.CODE 
MAIN:


	 MOV AX,@DATA 	;inicializa el segmento de datos
	 MOV DS,AX 
	 MOV ES,AX 
	 FNINIT 

	 DisplayString @c 
	 newLine 
	 DisplayString @prueba 
	 newLine 
	 mov AX, 4C00h 	 ; Genera la interrupcion 21h
	 int 21h 	 ; Genera la interrupcion 21h
END MAIN
