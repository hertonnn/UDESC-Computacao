#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#define NUM_THREADS    5

void *PrintHello(void *arg) {
   long tid = (long)arg;
   printf("Alo da thread %ld\n", 
          tid);
   sleep(tid);
   pthread_exit((void *)(tid*tid));
}

int main (int argc, char *argv[]) {
   pthread_t threads[NUM_THREADS];
   int rc;
   long t, soma = 0;
   void *ret;
   for (t=0; t<NUM_THREADS; t++){
      printf("main: criando thread %ld\n", t);
      rc = pthread_create(&threads[t], 
                          NULL, 
                          PrintHello, 
                          (void *)t);
      if (rc) {
         printf("ERRO - rc=%d\n", rc);
         exit(-1);
      }
   }
   
   for (t=0; t<NUM_THREADS; t++){
      rc = pthread_join(threads[t], &ret);
      printf("main: thread %ld terminou (ret=%ld)\n", t, (long)ret);
      if (rc) {
         printf("ERRO - rc=%d\n", rc);
         exit(-1);
      }
      soma += (long)ret;
   }
   printf("soma=%ld\n", soma);
   /* Ultima coisa que main() deve fazer */
   pthread_exit(NULL); 
}
