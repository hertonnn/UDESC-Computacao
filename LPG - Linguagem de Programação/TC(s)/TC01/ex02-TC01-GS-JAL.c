#include <stdio.h>
#define RED      "\x1B[31m"
#define BLUE     "\x1B[34m"
#define GREEN  "\x1B[36m"
#define GRAY    "\x1B[30m"
#define RESET   "\x1B[0m"

int main(){

    int n1, n2;
    printf("Digite o valor de n1(n1 deve ser menor que n2):\n");
    printf(RED);
    scanf("%i", &n1);
    printf(RESET);
    printf("Digite o valor de n2(n2 deve ser maior que n1):\n");
    printf(RED);
    scanf("%i", &n2);
    printf(RESET);
    while( n1 > n2 ){
         printf("Digite o valor de n1(n1 deve ser menor que n2):\n");
    printf(RED);
    scanf("%i", &n1);
    printf(RESET);
    printf("Digite o valor de n2(n2 deve ser maior que n1):\n");
    printf(RED);
    scanf("%i", &n2);
    printf(RESET);
    }

    int vetor[n2-n1+1];

    printf("\nEntrada validada!\n");
    printf("\nn1 = %i, n2 = %i\n", n1, n2);
    for (int i=n1;i<=n2;i++){
        int fat=1, j;
        printf("%i ", i);
        for (j=1;j<=i;j++){
            fat = fat *j;
        }

        printf(GREEN);
        printf("%i\n", fat);
        printf(RESET);          

    }

    printf(">> ");
     for (int i=n1;i<=n2;i++){
        int fat=1, j;
        for (j=1;j<=i;j++){
            fat = fat *j;
        }
        printf(GRAY);
        printf("%i ", fat);
        printf(RESET);
    }


}