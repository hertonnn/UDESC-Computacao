#include <stdio.h>


int analise(char c){

    int x;
    int cont = 0;

    switch( c ){
        case '0':
        x = 0;
        break;

        case '1':
        x = 1;
        break;


        case '2':
        x = 2;
        break;


        case '3':
        x = 3;
        break;


        case '4':
        x = 4;
        break;


        case '5':
        x = 5;
        break;


        case '6':
        x = 6;
        break;


        case '7':
        x = 7;
        break;


        case '8':
        x = 8;
        break;


        case '9':
        x = 9;
        break;

        default:
        printf("Esse caracter inserido nao é um valor inteiro\n");
        cont++;
    } 

    if(cont == 0)
    printf("Esse caracter inserido é o digito %i\n", x);

}


int main(){

    char c;

    printf("Insira um caracter:\n");
    scanf("%c", &c);
    
    analise(c);

}