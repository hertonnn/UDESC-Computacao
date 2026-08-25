#include <stdio.h>
#define RED      "\x1B[31m"
#define BLUE     "\x1B[34m"
#define GREEN  "\x1B[36m"
#define GRAY    "\x1B[30m"
#define RESET   "\x1B[0m"


void maior(int *x,int y){
    int big = x[0];
    int cont=0;
    for(int i=0; i<y;i++){
        if(big < *(x+i)){
            big = *(x+i);
        }
    }

    for (int i=0; i<y; i++){
        if(x[i]==big){
            cont++;
        }
    }

    printf(BLUE);
    printf("%i => %i ", big, cont);
    printf(RESET);    
}

int main(){

int n;
printf("Insira o numero de elementos do vetor: \n");
scanf("%i", &n);

int vetor[n];


for(int i = 0; i < n; i++){
    scanf("%i", &vetor[i]);
}
maior(vetor, n);
}
