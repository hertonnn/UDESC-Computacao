#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>
#include <assert.h>

int done = 0;

pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;

void *f1(void *arg) {
    pthread_mutex_lock(&mtx);
    done++; // regiao critica
    pthread_mutex_unlock(&mtx);
    pthread_exit(NULL);
}

int main(int argc, char *argv[]) {
    pthread_t *thr;
    int rc, i, nthr;

    nthr = (argc > 1 ? atoi(argv[1]) : 100);
    thr = calloc(nthr, sizeof(pthread_t));
    assert(thr != NULL);

    for (i = 0; i < nthr; i++) {
        rc = pthread_create(&thr[i], NULL, f1, NULL);
        assert(rc == 0);
    }

    for (i = 0; i < nthr; i++) {
        rc = pthread_join(thr[i], NULL);
        assert(rc == 0);
    }

    printf("done=%d\n", done);
    return 0;
}
