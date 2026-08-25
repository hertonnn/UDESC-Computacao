#include <stdio.h>
#define tam 5

int main(){

    int numeros[tam];
    for(int i = 0; i < tam; i++){
        scanf("%i", &numeros[i]);
    }

    //fazendo a analise dos nuemros

    int positivos = 0, negativos = 0, pares = 0, impares = 0;

    for(int i = 0; i < tam; i++){
        if(numeros[i] >= 0){
            positivos++;
        }else{
            negativos++;
        }

        if((numeros[i] % 2) == 0){
            pares++;
        }else{
            impares++;
        }

    }

    printf("\n%i valor(es) par(es)", pares);
    printf("\n%i valor(es) impar(es)", impares);
    printf("\n%i valor(es) positivo(s)", positivos);
    printf("\n%i valor(es) negativo(s)\n", negativos);

}