#include <stdio.h>
#define RED      "\x1B[31m"
#define BLUE     "\x1B[34m"
#define GREEN  "\x1B[36m"
#define GRAY    "\x1B[30m"
#define RESET   "\x1B[0m"

int main(){

int n;
printf("Insira o numero de elementos do vetor: \n");
scanf("%i", &n);

int vetor[n];


for(int i = 0; i < n; i++){
    scanf("%i", &vetor[i]);
}

for(int i = 0; i < n; i++){
    if( *(vetor+i) % 2 == 0 ){
        printf("V[%i] ", i);
        printf(RED);
        printf("%p", vetor + i);
        printf(RESET);
        printf(" (%i)\n", *(vetor+i) );
    }

}



}