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
	@_1 dd 1.0	;Declaracion de Constant Number
	@_2 dd 2.0	;Declaracion de Constant Number
	@varB dd ?	 ; Declaracion de Variable Numerica
	@_21 dd 21.0	;Declaracion de Constant Number
	@_3 dd 3.0	;Declaracion de Constant Number
	@_0 dd 0.0	;Declaracion de Constant Number
	@varc dd ?	 ; Declaracion de Variable Numerica
	@_9 dd 9.0	;Declaracion de Constant Number
	@_Funciona db "Funciona", "$", 30 dup (?)	;Declaracion de Constant String
	@_20 dd 20.0	;Declaracion de Constant Number
	@_FOR2 db "FOR2", "$", 30 dup (?)	;Declaracion de Constant String
	@_else db "else", "$", 30 dup (?)	;Declaracion de Constant String
	@_Funcion db "Funcion", "$", 30 dup (?)	;Declaracion de Constant String
	@_primero db "primero", "$", 30 dup (?)	;Declaracion de Constant String
	@_segundo db "segundo", "$", 30 dup (?)	;Declaracion de Constant String
	@EquVal dd ?	 ; Declaracion de Variable Numerica
	@_28 dd 28.0	;Declaracion de Constant Number
	@_40 dd 40.0	;Declaracion de Constant Number
	@_30 dd 30.0	;Declaracion de Constant Number
	@_cadena db "cadena", "$", 30 dup (?)	;Declaracion de Constant String
	@_aux24 dd ?	 ; Declaracion de Variable Numerica
	@_aux35 dd ?	 ; Declaracion de Variable Numerica
	@_aux42 dd ?	 ; Declaracion de Variable Numerica
	@_aux46 dd ?	 ; Declaracion de Variable Numerica
	@_aux57 dd ?	 ; Declaracion de Variable Numerica
	@_aux63 dd ?	 ; Declaracion de Variable Numerica
	@_aux64 dd ?	 ; Declaracion de Variable Numerica
	@_aux68 dd ?	 ; Declaracion de Variable Numerica
	@_aux69 dd ?	 ; Declaracion de Variable Numerica
	@_aux70 dd ?	 ; Declaracion de Variable Numerica
	@_aux72 dd ?	 ; Declaracion de Variable Numerica
	@_aux117 dd ?	 ; Declaracion de Variable Numerica
.CODE 
MAIN:


	 MOV AX,@DATA 	;inicializa el segmento de datos
	 MOV DS,AX 
	 MOV ES,AX 
	 FNINIT 

ETIQ_2: 
	 FLD @a		;comparacion, operando1 
	 FLD @b		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNA ETIQ_19 	;Si cumple la condicion salto a la etiqueta
	 FLD @_1 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
ETIQ_9: 
	 FLD @a		;comparacion, operando1 
	 FLD @b		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNE ETIQ_15 	;Si cumple la condicion salto a la etiqueta
	 FLD @_2 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
	 JMP ETIQ_9 	;Si cumple la condicion salto a la etiqueta
ETIQ_15: 
	 FLD @_2 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
	 JMP ETIQ_2 	;Si cumple la condicion salto a la etiqueta
ETIQ_19: 
	 FLD @_1 	;Cargo valor 
	 FSTP @varB 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @_21 	;Cargo operando 1
	 FLD @_2 	;Cargo operando 2
	 FADD 		;Opero
	 FSTP @_aux24 	;Almaceno el resultado en una var auxiliar
ETIQ_25: 
	 FLD @varB		;comparacion, operando1 
	 FLD @_aux24		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JA ETIQ_49 	;Si cumple la condicion salto a la etiqueta
	 FLD @b 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @_1 	;Cargo valor 
	 FSTP @varB 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @_21 	;Cargo operando 1
	 FLD @_2 	;Cargo operando 2
	 FADD 		;Opero
	 FSTP @_aux35 	;Almaceno el resultado en una var auxiliar
ETIQ_36: 
	 FLD @varB		;comparacion, operando1 
	 FLD @_aux35		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JA ETIQ_45 	;Si cumple la condicion salto a la etiqueta
	 FLD @b 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @varB 	;Cargo operando 1
	 FLD @_3 	;Cargo operando 2
	 FADD 		;Opero
	 FSTP @_aux42 	;Almaceno el resultado en una var auxiliar
	 FLD @_aux42 	;Cargo valor 
	 FSTP @varB 	; Se lo asigno a la variable que va a guardar el resultado 
	 JMP ETIQ_36 	;Si cumple la condicion salto a la etiqueta
ETIQ_45: 
	 FLD @varB 	;Cargo operando 1
	 FLD @_3 	;Cargo operando 2
	 FADD 		;Opero
	 FSTP @_aux46 	;Almaceno el resultado en una var auxiliar
	 FLD @_aux46 	;Cargo valor 
	 FSTP @varB 	; Se lo asigno a la variable que va a guardar el resultado 
	 JMP ETIQ_25 	;Si cumple la condicion salto a la etiqueta
ETIQ_49: 
	 FLD @_0 	;Cargo valor 
	 FSTP @varc 	; Se lo asigno a la variable que va a guardar el resultado 
ETIQ_53: 
	 FLD @varc		;comparacion, operando1 
	 FLD @_9		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JA ETIQ_60 	;Si cumple la condicion salto a la etiqueta
	 displayString @_Funciona 
	 newLine 
	 FLD @varc 	;Cargo operando 1
	 FLD @_3 	;Cargo operando 2
	 FADD 		;Opero
	 FSTP @_aux57 	;Almaceno el resultado en una var auxiliar
	 FLD @_aux57 	;Cargo valor 
	 FSTP @varc 	; Se lo asigno a la variable que va a guardar el resultado 
	 JMP ETIQ_53 	;Si cumple la condicion salto a la etiqueta
ETIQ_60: 
	 FLD @b 	;Cargo operando 1
	 FLD @c 	;Cargo operando 2
	 FMUL 		;Opero
	 FSTP @_aux63 	;Almaceno el resultado en una var auxiliar
	 FLD @a 	;Cargo operando 1
	 FLD @_aux63 	;Cargo operando 2
	 FADD 		;Opero
	 FSTP @_aux64 	;Almaceno el resultado en una var auxiliar
	 FLD @e 	;Cargo operando 1
	 FLD @f 	;Cargo operando 2
	 FADD 		;Opero
	 FSTP @_aux68 	;Almaceno el resultado en una var auxiliar
	 FLD @d 	;Cargo operando 1
	 FLD @_aux68 	;Cargo operando 2
	 FDIV 		;Opero
	 FSTP @_aux69 	;Almaceno el resultado en una var auxiliar
	 FLD @_aux64 	;Cargo operando 1
	 FLD @_aux69 	;Cargo operando 2
	 FSUB 		;Opero
	 FSTP @_aux70 	;Almaceno el resultado en una var auxiliar
	 FLD @_aux70 	;Cargo operando 1
	 FLD @_20 	;Cargo operando 2
	 FADD 		;Opero
	 FSTP @_aux72 	;Almaceno el resultado en una var auxiliar
	 FLD @_aux72 	;Cargo valor 
	 FSTP @z 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @a		;comparacion, operando1 
	 FLD @b		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNA ETIQ_86 	;Si cumple la condicion salto a la etiqueta
	 FLD @a		;comparacion, operando1 
	 FLD @b		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNE ETIQ_86 	;Si cumple la condicion salto a la etiqueta
	 FLD @_2 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
ETIQ_86: 
ETIQ_86: 
	 FLD @a		;comparacion, operando1 
	 FLD @b		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNA ETIQ_102 	;Si cumple la condicion salto a la etiqueta
	 FLD @a		;comparacion, operando1 
	 FLD @b		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNE ETIQ_98 	;Si cumple la condicion salto a la etiqueta
	 FLD @_1 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
	 JMP ETIQ_101 	;Si cumple la condicion salto a la etiqueta
ETIQ_98: 
	 FLD @_2 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
ETIQ_101: 
	 JMP ETIQ_105 	;Si cumple la condicion salto a la etiqueta
ETIQ_102: 
	 FLD @_3 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
ETIQ_105: 
	 FLD @a		;comparacion, operando1 
	 FLD @b		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNA ETIQ_120 	;Si cumple la condicion salto a la etiqueta
	 FLD @_1 	;Cargo valor 
	 FSTP @varB 	; Se lo asigno a la variable que va a guardar el resultado 
ETIQ_113: 
	 FLD @varB		;comparacion, operando1 
	 FLD @_3		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JA ETIQ_120 	;Si cumple la condicion salto a la etiqueta
	 displayString @_FOR2 
	 newLine 
	 FLD @varB 	;Cargo operando 1
	 FLD @_3 	;Cargo operando 2
	 FADD 		;Opero
	 FSTP @_aux117 	;Almaceno el resultado en una var auxiliar
	 FLD @_aux117 	;Cargo valor 
	 FSTP @varB 	; Se lo asigno a la variable que va a guardar el resultado 
	 JMP ETIQ_113 	;Si cumple la condicion salto a la etiqueta
ETIQ_120: 
ETIQ_120: 
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
	 JNA ETIQ_140 	;Si cumple la condicion salto a la etiqueta
	 FLD @a		;comparacion, operando1 
	 FLD @b		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JAE ETIQ_138 	;Si cumple la condicion salto a la etiqueta
	 FLD @b 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
	 JMP ETIQ_139 	;Si cumple la condicion salto a la etiqueta
ETIQ_138: 
	 displayString @_else 
	 newLine 
ETIQ_139: 
	 JMP ETIQ_143 	;Si cumple la condicion salto a la etiqueta
ETIQ_140: 
	 FLD @_3 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
ETIQ_143: 
	 FLD @a		;comparacion, operando1 
	 FLD @b		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNA ETIQ_157 	;Si cumple la condicion salto a la etiqueta
	 FLD @a		;comparacion, operando1 
	 FLD @b		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JAE ETIQ_155 	;Si cumple la condicion salto a la etiqueta
	 FLD @b 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
	 JMP ETIQ_156 	;Si cumple la condicion salto a la etiqueta
ETIQ_155: 
	 displayString @_Funcion 
	 newLine 
ETIQ_156: 
	 JMP ETIQ_160 	;Si cumple la condicion salto a la etiqueta
ETIQ_157: 
	 FLD @_3 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
ETIQ_160: 
	 FLD @a		;comparacion, operando1 
	 FLD @b		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNA ETIQ_172 	;Si cumple la condicion salto a la etiqueta
	 FLD @a		;comparacion, operando1 
	 FLD @b		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JAE ETIQ_170 	;Si cumple la condicion salto a la etiqueta
	 displayString @_primero 
	 newLine 
	 JMP ETIQ_171 	;Si cumple la condicion salto a la etiqueta
ETIQ_170: 
	 displayString @_segundo 
	 newLine 
ETIQ_171: 
	 JMP ETIQ_175 	;Si cumple la condicion salto a la etiqueta
ETIQ_172: 
	 FLD @_3 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
ETIQ_175: 
	 FLD @b 	;Cargo valor 
	 FSTP @EquVal 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @a		;comparacion, operando1 
	 FLD @EquVal		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNE ETIQ_184 	;Si cumple la condicion salto a la etiqueta
	 FLD @_28 	;Cargo valor 
	 FSTP @a 	; Se lo asigno a la variable que va a guardar el resultado 
ETIQ_184: 
	 FLD @_40 	;Cargo valor 
	 FSTP @EquVal 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @EquVal		;comparacion, operando1 
	 FLD @_30		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JAE ETIQ_192 	;Si cumple la condicion salto a la etiqueta
	 FLD @_30 	;Cargo valor 
	 FSTP @EquVal 	; Se lo asigno a la variable que va a guardar el resultado 
ETIQ_192: 
	 FLD @a		;comparacion, operando1 
	 FLD @EquVal		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNE ETIQ_195 	;Si cumple la condicion salto a la etiqueta
	 displayString @_Funciona 
	 newLine 
ETIQ_195: 
	 FLD @_40 	;Cargo valor 
	 FSTP @u 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @_40 	;Cargo valor 
	 FSTP @EquVal 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @EquVal		;comparacion, operando1 
	 FLD @_30		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JAE ETIQ_206 	;Si cumple la condicion salto a la etiqueta
	 FLD @_30 	;Cargo valor 
	 FSTP @EquVal 	; Se lo asigno a la variable que va a guardar el resultado 
ETIQ_206: 
	 FLD @EquVal		;comparacion, operando1 
	 FLD @_20		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JAE ETIQ_210 	;Si cumple la condicion salto a la etiqueta
	 FLD @_20 	;Cargo valor 
	 FSTP @EquVal 	; Se lo asigno a la variable que va a guardar el resultado 
ETIQ_210: 
	 FLD @u		;comparacion, operando1 
	 FLD @EquVal		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNE ETIQ_213 	;Si cumple la condicion salto a la etiqueta
	 displayString @_Funciona 
	 newLine 
ETIQ_213: 
	 FLD @_20 	;Cargo valor 
	 FSTP @x 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @_40 	;Cargo valor 
	 FSTP @EquVal 	; Se lo asigno a la variable que va a guardar el resultado 
	 FLD @EquVal		;comparacion, operando1 
	 FLD @_30		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNA ETIQ_224 	;Si cumple la condicion salto a la etiqueta
	 FLD @_30 	;Cargo valor 
	 FSTP @EquVal 	; Se lo asigno a la variable que va a guardar el resultado 
ETIQ_224: 
	 FLD @EquVal		;comparacion, operando1 
	 FLD @_20		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNA ETIQ_228 	;Si cumple la condicion salto a la etiqueta
	 FLD @_20 	;Cargo valor 
	 FSTP @EquVal 	; Se lo asigno a la variable que va a guardar el resultado 
ETIQ_228: 
	 FLD @x		;comparacion, operando1 
	 FLD @EquVal		;comparacion, operando2 
	 FXCH		;Invierto 
	 FCOMP		;Comparo 
	 FFREE ST(0) 	; Vacio ST0
	 FSTSW AX 		; mueve los bits C a FLAGS
	 SAHF 			;Almacena el registro AH en el registro FLAGS 
	 JNE ETIQ_231 	;Si cumple la condicion salto a la etiqueta
	 displayString @_Funciona 
	 newLine 
ETIQ_231: 
	 GetFloat @a
	 DisplayFloat @a,2 
	 newLine 
	 displayString @_cadena 
	 newLine 
	 mov AX, 4C00h 	 ; Genera la interrupcion 21h
	 int 21h 	 ; Genera la interrupcion 21h
END MAIN
