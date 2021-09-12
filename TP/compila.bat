c:\GnuWin32\bin\flex lexico.l
pause
c:\GnuWin32\bin\bison -dyv sintactico.y
pause
c:\MinGW\bin\gcc.exe lex.yy.c y.tab.c -o Primera.exe
pause
pause
Primera.exe prueba.txt
pause