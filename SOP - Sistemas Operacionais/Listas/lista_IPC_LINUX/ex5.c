#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <pthread.h>
#include <stdint.h>
#include <semaphore.h>

#define N 10   // tamanho do vetor
#define nthr 4 // num de threads

pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;

int *vet;  // vetor dos numeros
int *fila; // vetor da fila
int topo = 0;

void *acao(void *arg)
{
    int id = (intptr_t)arg;
    int valor;
    valor = vet[0];
    if (id % 2 == 0)
    {
        for (int i = 0; i < N; i++)
        {
            if (vet[i] > valor)
                valor = vet[i];
        }
    }
    else
    {
        for (int i = 0; i < N; i++)
        {
            if (vet[i] < valor)
                valor = vet[i];
        }
    }

    pthread_mutex_lock(&mtx);
    fila[topo] = id; //regiao critica
    topo++; //regiao critica
    pthread_mutex_unlock(&mtx);
    pthread_exit((void *)(intptr_t)valor);
}

int main()
{

    vet = malloc(N * sizeof(int));
    fila = malloc(nthr * sizeof(int));
    pthread_t threads[N];
    void *retorno;

    srandom(time(NULL));
    for (int i = 0; i < N; i++)
    {
        vet[i] = ( (int)random() % 100 ) + 1; // gera valores de 1 a 100
    }

    printf("\nVetor Gerado: ");
    for (int i = 0; i < N; i++)
    {
        printf("%d ", vet[i]);
    }

    int rc;

    for (int i = 0; i < N; i++)
    {
        rc = pthread_create(&threads[i], NULL, acao, (void *)i);
    }

    for (int i = 0; i < nthr; i++)
    {
        rc = pthread_join(threads[i], &retorno);
        printf("\nDa thread %d foi encontrado: %ld", i, (intptr_t)retorno);
    }

    printf("\nOrdem: ");
    for(int i = 0; i < nthr; i ++){
        printf(" %d ", fila[i]);
    }

}
