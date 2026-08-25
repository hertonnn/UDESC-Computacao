#include <stdio.h>

int main(){

    int a, b;
    scanf("%i %i", &a, &b);

    int impares;

    if(b > a){
    for(int i = a + 1; i < b; i++){
        if(i % 2 != 0){
            impares = impares + i;
            printf("\nImpar = %i", i);
            }
        }
    }else if(a > b){
        for(int i = b + 1; i < a; i++){
        if(i % 2 != 0){
            impares = impares + i;
            printf("\nImpar = %i", i);
            }
        }
    }

    printf("\nSOMA: %i\n", impares);

}