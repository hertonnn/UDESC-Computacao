#include <stdio.h>

int tipo_triangulo(float x, float y, float z){

    if(x >= y + z){
       printf("0. Os lados não formam um triângulo (ou seja, a soma de dois deles é menor ou igual ao outro lad.\n");
    }else if(x == y && y == z){
         printf("1. Triângulo equilátero.\n");
    }else if(x == y || y ==  z || z ==x){
       printf("2. Triângulo isóceles.\n");
    }else if( x != y && y != z && x != z){
        printf("3. Triângulo escaleno.\n");
       }

}

int main(){

    float vetor[3], x, y, z;
    printf("Insira 3 lados de um triangulo:\n");
    for(int i = 0; i < 3; i++){
        scanf("%f", &vetor[i]);
    }

    //ordenando em ordem decrescente o vetor dos lados:
    float aux;
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
    x = vetor[0];
    y = vetor[1];
    z = vetor[2];

    tipo_triangulo(x, y, z);

}