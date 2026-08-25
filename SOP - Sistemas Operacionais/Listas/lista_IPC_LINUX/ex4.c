#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <assert.h>
#include <sys/types.h>
#include <pthread.h>
#include <semaphore.h>

#define objetivo (1LL << 31) // 2^31
#define NUM 3

pthread_barrier_t b;

void *conta(void *arg)
{
    pthread_barrier_wait(&b);
    int64_t objetivo_individual = (intptr_t)arg;
    int i;
    int64_t total = 0;

    for (i = 0; i < objetivo_individual; i++)
    {
        total++;
    }
    pthread_exit((void *)(int64_t)total);
}

int main()
{

    pthread_t threads[NUM];
    int64_t objetivo_individual = objetivo / NUM;
    int rc;
    int64_t soma_final = 0;
    void *soma;

    rc = pthread_barrier_init(&b, NULL, NUM);    assert(rc == 0);
    
    for (int i = 0; i < NUM; i++)
    {
        rc = pthread_create(&threads[i], NULL, conta, (void *)objetivo_individual);
    }

    for (int i = 0; i < NUM; i++)
    {
        rc = pthread_join(threads[i], &soma);
        printf("\nDa thread %d foi calculado: %ld\n", i, (int64_t)soma);
        soma_final += (int64_t)soma;
    }

    int resto = objetivo % NUM;
    printf("\nResto: %d\n", resto);
    if (resto != 0)
    {
        for (int i = 0; i < resto; i++)
        {
            soma_final++;
        }
    }

    printf("\nSomatorio final: %ld\n", soma_final);
}
