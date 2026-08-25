#include <stdio.h>
#include <math.h>

int main(){

    float lados[3];
    
    printf("\nInsira 3 valores para os lados de um triangulo:\n");
    
    for(int i = 0; i < 3; i++){
        scanf("%f", &lados[i]);
    }
    
    //ordenar os numeros inseridos para a hipotenusa ficar como primeira posicao
    float aux;
    for(int i = 0; i < 3; i++){
        for(int l = 0; l < 3; l++){
            if(lados[i] > lados[l]){
                aux = lados[i];
                lados[i] = lados[l];
                lados[l] = aux;
            }
        }
    }

    //salvando os lados do vetor em variaveis com nomes simples
    float a, b, c;
    a = lados[0];
    b = lados[1];
    c = lados[2];

    //comecando a analise dos lados
    if(a >= b + c){
        printf("\nNAO FORMA TRIANGULO");
    }else if(a == b && a == c){
        printf("\nTRIANGULO EQUILATERO");
    }else if(a == b || a == c || c == b){
        printf("\nTRIANGULO ISOSCELES");
    }else if(a*a == b*b + c*c){
        printf("\nTRIANGULO RETANGULO");
    }else if(a*a > b*b + c*c){
        printf("\nTRIANGULO OBTUSANGULO");
    }else if(a*a < b*b + c*c){
        printf("\nTRIANGULO ACUTANGULO");
    }



}
