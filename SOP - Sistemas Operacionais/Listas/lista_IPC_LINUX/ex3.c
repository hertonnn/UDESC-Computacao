#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>
#include <assert.h>

pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cY = PTHREAD_COND_INITIALIZER, cZ = PTHREAD_COND_INITIALIZER;

#define TRUE 1
#define FALSE 0

int n;
int fimX = FALSE, fimZ = FALSE;

void X(void *argp) {
pthread_mutex_lock(&mtx);
n = n * 16;
fimX = TRUE;
pthread_cond_signal(&cZ);
pthread_mutex_unlock(&mtx);
}

void Y(void *argp) {
pthread_mutex_lock(&mtx);
while(!fimZ) pthread_cond_wait(&cY, &mtx);
n = n / 7;
pthread_mutex_unlock(&mtx);

}

void Z(void *argp) {
pthread_mutex_unlock(&mtx);
while(!fimX) pthread_cond_wait(&cZ, &mtx);
n = n + 40;
fimZ = TRUE;
pthread_cond_signal(&cY);
pthread_mutex_unlock(&mtx);
}

int main(void){

    pthread_t tX, tY, tZ;
    int rc;

    n = 1;
    rc = pthread_create(&tX, NULL, (void *) X, NULL);   assert(rc == 0);
    rc = pthread_create(&tY, NULL, (void *) Y, NULL);   assert(rc == 0);
    rc = pthread_create(&tZ, NULL, (void *) Z, NULL);   assert(rc == 0);
    rc = pthread_join(tX, NULL);   assert(rc == 0);
    rc = pthread_join(tY, NULL);   assert(rc == 0);
    rc = pthread_join(tZ, NULL);   assert(rc == 0);

    printf("%d\n", n);
    return 0;
}