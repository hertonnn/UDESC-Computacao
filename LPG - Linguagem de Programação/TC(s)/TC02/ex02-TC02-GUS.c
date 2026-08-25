/*DADO DOIS VETORES DINAMICOS, CRIE UMA FUNCAO QUE CRIE UM TERCEIRO VETOR COM A SOMA DOS DOIS(CASO TENHAM O MESMO TAMANHO)*/

#include <stdio.h>
#include <stdlib.h>

int soma_vetores(int *p, int n, int *j, int k){

    if(n == k){
        
        int vet3[n];
        printf("Mesmo tamanho\n");
        
        for( int i = 0 ; i < n ; i++ ){
        vet3[i] = (*(p + i) + *(j+i));
        }

        for( int i = 0 ; i < n ; i++ ){
        printf("%d ", vet3[i]);
        }
        printf("\n");
        return 1;

        }else{        
        printf("Tamanhos diferentes\n");
        return 0;
    }

}

int main(){

    int *p, n, i;
    printf("Quantos valores no primeiro vetor? ");
    scanf("%d", &n);
    p = malloc( sizeof(int) * n );
    for( i = 0 ; i < n ; i++ ){
        scanf("%d", p + i);
    }

    int *j, k;
    printf("Quantos valores no segundo vetor? ");
    scanf("%d", &k);
    j = malloc( sizeof(int) * k );
    for( i = 0 ; i < k ; i++ ){
        scanf("%d", j + i); 
    }

    soma_vetores(p,n,j,k);
    
    free(p);
    free(j);

}
