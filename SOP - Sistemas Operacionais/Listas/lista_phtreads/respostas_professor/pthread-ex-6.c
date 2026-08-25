#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>

int n;

void f1(void *argp) {
     int a;
     a = 20;
     n += a;
     printf("f1: a=%d\t", a);
}

void f2(void *argp) {
     int a;
     a = 10;
     n -= a;
     printf("f2: a=%d\t", a);
}

int main(void) {
     pthread_t t1, t2;
     int rc;
     n = 0;
     rc = pthread_create(&t1, NULL, (void *)f1, NULL);
     rc = pthread_create(&t2, NULL, (void *)f2, NULL);
     rc = pthread_join(t1, NULL);
     rc = pthread_join(t2, NULL);
     printf("n=%d\n", n);
     return 0;
}
