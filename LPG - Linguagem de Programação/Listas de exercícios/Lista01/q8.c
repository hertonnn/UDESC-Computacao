#include <stdio.h>

int main(){

    int n;
    scanf("%i", &n);
    for(int i = 0; i <1001; i++){
        printf("%i x %i = %i\n", i, n, i*n);

    }

}