#include <stdio.h>

int soma_especial(int n, int k, int x){

    int cont = 0;
    int soma = 0;
    int i = 1;

    while(cont != n){
        if( (x + i) % k == 0){
            printf("%i ", x + i);
            cont++;
            soma = soma + (x+i);
        }

        i++;
    }

    printf("\nSoma: %i\n", soma);

}


int main(){

    int n, k ,x;

    printf("Insira N, K, e X:\n");
    scanf("%i %i %i", &n, &k, &x);

    soma_especial(n, k, x);
}