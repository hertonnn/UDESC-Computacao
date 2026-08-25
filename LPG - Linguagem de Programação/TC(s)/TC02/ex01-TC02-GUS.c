/*EXERCICIO PARA ALOCAR UM VETOR DINAMICAMENTE E SOMAR +1 EM CADA POSICAO*/

#include <stdio.h>
#include <stdlib.h>

int main(){

    int *p, n, i;
    printf("Quantos valores voce deseja no vetor? ");
    scanf("%d", &n);
    p = malloc( sizeof(int) * n );
    for( i = 0 ; i < n ; i++ ){
        scanf("%d", p + i);
    }
    
    //somando +1 em cada posicao
    for(i = 0; i < n; i++){
        p[i] = p[i] +1;
    }

    //printando o vetor modificado
     for( i = 0 ; i < n ; i++ ){
       printf("%d ", *(p + i));
    }

    free(p);

}