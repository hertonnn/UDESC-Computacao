#include <stdio.h>

int main(int argc, char *argv[]){

    printf("Contador de elementos: %i\n", argc);
    
    for(int i = argc - 1; i >= 0; i--){
        printf("%s\n", argv[i]);
    }
}