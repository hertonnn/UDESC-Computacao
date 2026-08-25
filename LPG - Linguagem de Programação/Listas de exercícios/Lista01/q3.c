#include <stdio.h>

//Ler dois numeros inteiros e ver se são multiplos ou não:

int main(){

    int a, b;
    printf("Digite dois numeros: ");
    scanf("%i %i", &a, &b);
    if(((a % b)== 0) || ((b % a)== 0)){
        printf("\nSão multiplos");
    }else{
        printf("\nNão são multiplos");
    }

    return 0;
}