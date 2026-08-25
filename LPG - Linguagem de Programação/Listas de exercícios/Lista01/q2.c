#include <stdio.h>

//Leia 3 valores inteiros e ordene-os em ordem crescente. No final, mostre os valores em ordem crescente, uma linha em branco e em seguida, os valores na sequência como foram lidos.

int main(){
    
    int vetor[3];
    int aux;
    printf("Digite 3 numeros inteiros: ");
    
    for(int i = 0; i < 3; i++){
    scanf("%i", &vetor[i]);
    }
    
    //ordenando vetor em ordem descrecente

    for(int i = 0; i < 3; i++){
        for(int n = 0; n < 3; n++){
            if(vetor[i] < vetor[n]){
                aux = vetor[i];
                vetor[i] = vetor[n];
                vetor[n] = aux;
            }
        }
    }
    
    printf("\nVetor ordenado:\n");
    for(int i = 0; i < 3; i++){
    printf("%i\n", vetor[i]);
    }
    
    
    
    return 0;
}