#include <stdio.h>
#include <string.h>
#include <math.h>

#define MAX 100

int main(){

    int numeros[MAX];
    char entrada[MAX];
    int qnt = 0;
    int somatorio = 0;
    float somatorio_desvio = 0;

    int valor;
    printf("Digite os valores:\n");
    fgets(entrada, MAX, stdin);

    char *token = strtok(entrada, " \n");
    while(token != NULL){
        numeros[qnt++] = atoi(token);
        token = strtok(NULL, " \n");
    }

    for(int i = 0; i < qnt; i++){
        somatorio += numeros[i];
    }
    
    float media = (float)somatorio/qnt;
    for(int i = 0; i < qnt; i++){
        somatorio_desvio += (numeros[i] - media) * (numeros[i] - media);
    }

    float desvio = sqrt(somatorio_desvio/qnt);

    printf("Media: %.2f\n", media);
    printf("Desvio: %.2f\n", desvio);
    


}