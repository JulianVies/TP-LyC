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
	@_21474 dd 21474.0	;Declaracion de Constant Number
	@_1 dd 1.0	;Declaracion de Constant Number
	@_2 dd 2.0	;Declaracion de Constant Number
	@_ctestring db ctestring, "$", 30 dup (?)	;Declaracion de Constant String
	@_2.5 dd 2.5	;Declaracion de Constant Number
	@_ctestrinng db ctestrinng, "$", 30 dup (?)	;Declaracion de Constant String
.CODE 
MAIN:


	 MOV AX,@DATA 	;inicializa el segmento de datos
	 MOV DS,AX 
	 MOV ES,AX 
	 FNINIT 

	 mov AX, 4C00h 	 ; Genera la interrupcion 21h
	 int 21h 	 ; Genera la interrupcion 21h
END MAIN
