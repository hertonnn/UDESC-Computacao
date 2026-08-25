#include <stdio.h>

int main(){

    int n;
    scanf("%i", &n);

    float a, b, c, media;
    while(n > 0){
    scanf("%f %f %f", &a, &b, &c);
    media = (2*a + 3*b + 5*c)/10;
       printf("\nMedia ponderada de (%.2f, %.2f, %.2f): %.2f \n", a, b, c, media );
    n = n - 1;
    }

}