#include <stdio.h>
#include <stdlib.h>

int main(){

    int *p, n, i;
    printf("Quantos valores no vetor inicialmente? ");
    scanf("%d", &n);
    p = malloc( sizeof(int) * n );
    for( i = 0 ; i < n ; i++ ){
        scanf("%d", p + i);
    }
    int stop = 0;
    int resposta;
    int tam = n;
    while(stop == 0){
        printf("Insira (0) para encerrar o vetor\n");
        printf("Insira (1) para retirar uma casa no vetor\n");
        printf("Insira (2) para adicionar uma casa no vetor\n");
        scanf("%i", &resposta);

        switch( resposta ){

            case 0:
            stop = 1;
            break;

            case 1:
            tam--;
            p = realloc(p, sizeof(int) * tam);
            if(tam == 0){
                stop = 1;
            }
            break;

            case 2:
            tam++;
            p = realloc(p, sizeof(int) * tam);
            scanf("%d", p + tam - 1);

        }



    }

    printf("\nVetor final:\n");
    for( i = 0 ; i < tam; i++ ){
        printf("%d ", *(p + i));
    }

    free(p);
}