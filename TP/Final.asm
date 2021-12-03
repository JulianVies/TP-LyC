include macros2.asm
include number.asm
.MODEL	LARGE 
.386
.STACK 200h 

.DATA 
	@b dd ?	 ; Declaracion de Variable Numerica
	@a dd ?	 ; Declaracion de Variable Numerica
<<<<<<< HEAD
	@_prueba db prueba, "$", 30 dup (?)	;Declaracion de Constant String
=======
	@_2 dd 2.0	;Declaracion de Constant Number
>>>>>>> f0087812aaef3b2ef8b51d68b558d585d8ea0340
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
