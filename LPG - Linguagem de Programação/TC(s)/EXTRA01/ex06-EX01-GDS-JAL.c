#include <stdio.h>


int main(){

    int n;
    scanf("%i", &n);
    int v[n];
    for(int i=0; i<n; i++){
        scanf("%i", &v[i]);
    }
    int *p1;
    p1 = v;
    for (int i=0; i<n; i++){
        v[i] = *(p1+i) + 1;
    } 

    for (int i=0; i<n; i++){
        printf("%i ", v[i]);
    }

}