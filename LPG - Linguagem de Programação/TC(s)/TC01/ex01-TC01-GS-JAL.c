#include <stdio.h>
#define RED      "\x1B[31m"
#define BLUE     "\x1B[34m"
#define GREEN  "\x1B[36m"
#define GRAY    "\x1B[30m"
#define RESET   "\x1B[0m"

int main(){


    int n;
    printf("Digite o valor de n:\n");
    scanf("%i", &n);
    printf("\nn = %i \n", n);


    printf("\n>> ");
    for(int i = n; i > 0; i--){
        if(( i % 4 ) == 0){
            printf(RED "[%i] ", i);
        }else{
            printf(RESET"%i ", i);
        }

    }


}