#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void agregarGuion(char *pc, char* result)
{
    const char *middle = pc;
    result[0] = '\0';
    strcat(result, "_");
    strcat(result, middle);
}

void sacarComillas(char *pc){

	// Cadena del tipo "" (sin nada)
	if(strlen(pc) == 2){
		*pc='\0';
	}
	else{
		*pc = *(pc+1);
		pc++;
		while(*(pc+1) != '"'){
			*pc = *(pc+1);		
			pc++;
		}
		*pc='\0';
	}	
}


int main(int argc, char *argv[])
{
    char result[100];
    agregarGuion("asdfdfdf",result);
    printf("%s\n",result );
}


