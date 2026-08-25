#include <stdio.h>

int maior(int &vetor[3]){

       //ordenando em ordem decrescente o vetor dos lados:
    int aux;
    for(int i = 0; i<3; i++){
        for(int j = 0; j < 3; j++){
            if(vetor[i] > vetor[j]){
                aux = vetor[j];
                vetor[j] = vetor[i];
                vetor[i] = aux;
            }
        }
    }

    //salvando as posicoes do vetor em variaveis fixas
    int x = vetor[0];
    
    return x;

}

int main(){

    int vetor[3];

    printf("Insira 3 numeros inteiros:\n");
    for(int i = 0; i < 3; i++){
        scanf("%i", &vetor[i]);
    }

    maior(&vetor[3]);

}