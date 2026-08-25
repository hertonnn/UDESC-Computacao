#include <stdio.h>
#define RED      "\x1B[31m"
#define BLUE     "\x1B[34m"
#define GREEN  "\x1B[36m"
#define GRAY    "\x1B[30m"
#define RESET   "\x1B[0m"

int main(){
    int n;
    printf("Digite o total de valores (n): ");
    scanf("%i", &n);
    int vector[n];
    for(int i=0;i<n;i++){
        printf(GRAY);
        printf("Digite o valor [%i] do vetor: ", i+1);
        scanf("%i", &vector[i]);
        printf(RESET);
    }
    int posi=0, neg=0, soma=0;
    for(int i=0;i<n;i++){
        if (vector[i]>=0){
            posi++;
        }
        else {
            neg++;
        }
        soma+= vector[i];
    }
    printf("\n>>"); 
    printf(RED);
    printf(" %i ", posi);
    printf(RESET); 
    printf("é/são valor(es) positivo(s), e "); 
    printf(RED);
    printf("%i ", neg);
    printf(RESET); 
    printf("é/são valor(es) negativo(s). Soma = ");
    printf(BLUE); 
    printf("%i.\n", soma);
    printf(RESET); 


}