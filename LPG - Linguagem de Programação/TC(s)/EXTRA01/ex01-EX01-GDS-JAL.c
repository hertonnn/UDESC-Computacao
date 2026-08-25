#include <stdio.h>
#define RED      "\x1B[31m"
#define BLUE     "\x1B[34m"
#define GREEN  "\x1B[36m"
#define GRAY    "\x1B[30m"
#define RESET   "\x1B[0m"

int a, b, c;

int troca(int *x, int *y){

int aux = 0;
aux = *x;
*x = *y;
*y = aux;

}

int main(){

scanf("%i %i", &a, &b);

troca(&a, &b);

printf(RED"\nA:%i\nB:%i"RESET, a, b);

}