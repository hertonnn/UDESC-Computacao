#include <stdio.h>
#include <stdlib.h>

int negativos(float *vet, int N){

    int i;
    printf("Vetor digitado: ");
    for( i = 0 ; i < N ; i++ ){
       printf("%f ", *(vet + i));
    }

    int negativos = 0;
    for( i = 0 ; i < N ; i++ ){
       if( *(vet + i) < 0){
        negativos++;
       }
    }

    printf("\nQuantidade de negativos: %i\n", negativos);

}


int main(){

 float *p; 
 int i, n;
    printf("Quantos valores voce deseja no vetor? ");
    scanf("%d", &n);
    p = malloc( sizeof(int) * n );
    for( i = 0 ; i < n ; i++ ){
        scanf("%f", p + i);
    }

    negativos(p, n);
    
    free(p);

}
