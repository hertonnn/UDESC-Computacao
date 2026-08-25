#include <stdio.h>
//Questão 1

int main()
{
    float x, y;
    
    printf("\nDigite a coordenada x: ");
    scanf("%f", &x);
    printf("\nDigite a coordenada Y: ");
    scanf("%f", &y);
    printf("\nPonto fornecido tem coordenada (%.1f, %.1f)", x, y);
    
    if(x == 0 && y == 0){
    printf("\n -- Origem -- ");
    }else if(x == 0 && y != 0){
        printf("\n -- Eixo Y -- ");
    }else if(x != 0 && y == 0){
        printf("\n -- Eixo X -- ");
    }

    return 0;
}

