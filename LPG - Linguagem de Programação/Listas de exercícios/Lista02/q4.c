#include <stdio.h>

int soma_impares(int x, int y){

    int soma = 0;

    if(x > y){
        for(int i = y + 1; i < x; i++){
            if( (i % 2) != 0){//se o numero for impar
                printf("%i ", i);
                soma = soma + i;
            }
        }
    }else if(y > x){
        for(int i = x + 1; i < y; i++){
            if(i % 2 != 0){//se o numero for impar
                printf("%i ", i);
                soma = soma + i;
            }
        }
    }

    printf("\nSoma: %i\n", soma);

}

int main(){

    int x, y;

    printf("Insira dois valores: \n");
    scanf("%i %i", &x, &y);

    soma_impares(x, y);

}