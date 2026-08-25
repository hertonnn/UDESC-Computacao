#include <stdio.h>

int primo(int x){

    int cont2 = 0;

    for(int i = 1; i < x+1; i++){
        if(x % i == 0){
            cont2++;
        }
    }

    if(cont2 == 2){
        printf("%i ", x);
        return 1;
    }else{
        return 0;
    }
}

int main(){

    int k, n;
    printf("Insira dois digitos:\n");
    scanf("%i %i", &k, &n);

    int cont = 0;
    int i = 1;
    while(cont != n){
        if( primo(k + i) == 1 ){
        cont++;
        }
        i++;
    }
}