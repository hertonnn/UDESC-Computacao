#include <stdio.h>

int main(){

    int a = 100;
    while(a!=0){
        if( (a % 2) == 0){
            printf("%i\n", a);
        }
        a = a - 1;
    }

}