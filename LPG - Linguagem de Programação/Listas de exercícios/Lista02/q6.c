#include <stdio.h>

int fibo(int n){

    int cont = 0;
    int num = 1;
    int suc = 0;
    int aux;

    while(cont != n){
        printf("%i ", num);
        aux = num;
        num = num + suc;
        suc = aux;
        cont++;
    }


}

int main(){

    int n;

    printf("Insira a quantidade que quiser da sequencia de Fibonacci:\n");
    scanf("%i", &n);

    fibo(n);

}