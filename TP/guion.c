//TODO: hacer funcionar agregarGrion
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

char* agregarGuion(char *pc)
{
    char str1[100] = "_";
    char* str2 = pc;

    char* retu = strcat(str1, str2);
    return retu;
    //printf("%s\n", strcat(str1, str2));
}

int main(int argc, char *argv[])
{


   // concatenates str1 and str2
   // the resultant string is stored in str1.
    printf("%s\n", agregarGuion("22"));
    //agregarGuion("22");
}


