#include <stdio.h>

int main(){

    int a, b, tempo;
    printf("\nInsira o horario que iniciou e terminou o jogo respectivamnete:\n");
    scanf("%i %i", &a, &b);
    if(a > b){
    tempo = 24 - (a - b);
    }else{
        tempo = (b - a);
    }
    printf("\nO JOGO DUROU %i HORAS\n", tempo);
}