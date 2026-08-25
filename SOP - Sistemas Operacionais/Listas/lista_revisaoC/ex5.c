#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX 100 // num max de elementos na pilha das palavras


typedef struct {
    int cabeca;
    int cauda;
    char *vetor[MAX];
}Fila;



void iniciarFila(Fila *fila){
    fila->cabeca = 0;
    fila->cauda = 0;
}

void adicionarFila(Fila *fila, const char *string){
    //  VERIFICACAO SE A FILA TA CHEIA
    if(fila->cabeca == MAX){
        printf("Fila lotada!\n");
        return;
    }

    // ALOCA MEMORIA PARA STRING
    fila->vetor[fila->cabeca] = (char *)malloc(strlen(string) + 1);

    // COPIA O CONTEUDO DELA (faz verificacao antes)
    if( fila->vetor[fila->cabeca] == NULL){
        printf("Erro ao alocar memoria!\n");
        return;
    }
    strcpy(fila->vetor[fila->cabeca], string);
    fila->cabeca++;
}


void removerElemento(Fila *fila){
    //verificacao se ja nao esta vazia
    if(fila->cabeca == fila->cauda){
        printf("Fila ja esta vazia!\n");
        return;
    }

    free(fila->vetor[fila->cauda]);
    fila->cauda++;
    
     if(fila->cabeca == fila->cauda){
        fila->cabeca = 0;
        fila->cauda = 0;
    }

}

int main(){

    int numerosLista[MAX];
    int executar = 1;
    char elemento[15]; // string lida pelo usuario
    int numeroLido = 0;
    int cont = 0;

    Fila fila;
    iniciarFila(&fila);

    while(executar){
        scanf(" %s %d", elemento, &numeroLido);
        //printf("String: %s  |   Num: %d\n", elemento, numeros[cont]);
        

        if(!strcmp(elemento, "FIM")){
            printf("Strings:\n");
            for(int i = fila.cauda; i < fila.cabeca; i++){
                printf(" %s\n", fila.vetor[i]);   
            }
            printf("\nNumeros:\n");
            for(int i = 0; i < cont; i++){
                printf(" %d\n", numerosLista[i]);   
            }
            
              // LIMPANDO A FILA
            while( fila.cauda != fila.cabeca){
                removerElemento(&fila);
            }

            return 0;
        }

        if(!strcmp(elemento, "IGUAL")){
            printf("\nPrioridade %d: ", numeroLido);

            for(int i = 0; i < cont; i++){
                if(numerosLista[i] == numeroLido){
                    printf(" %s ", fila.vetor[i]);
                }
            }
            printf("\n");

        }

        if(!strcmp(elemento, "MENIG")){
            for(int i = 0; i < cont; i++){
                if(numerosLista[i] <= numeroLido){
                    printf("\nPrioridade %d: ", numerosLista[i]);
                    printf(" %s ", fila.vetor[i]);
                }
            }
            printf("\n");

        }

        
        adicionarFila(&fila, elemento);
        numerosLista[cont] = numeroLido;
        
        cont++;

    }




}