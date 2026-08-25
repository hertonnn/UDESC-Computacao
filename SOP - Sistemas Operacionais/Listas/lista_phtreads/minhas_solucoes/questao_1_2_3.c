#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#define NUM_THREADS 99

void *PrintHello(void *arg) {
   long tid = (long)arg;
   printf("Alo da thread %ld\n", 
          tid);
   pthread_exit(NULL);
}

void *Quadrado(void *arg){
   int tid = (int)arg;
   tid = tid*tid;
   printf("Quadrado do numero: %d\n", tid);
   pthread_exit((void *)tid);

}

int main (int argc, char *argv[]) {

   pthread_t threads[NUM_THREADS];
   int rc;
   long t;
   void *retorno;
   int soma = 0;

   for (t=0; t<NUM_THREADS; t++){
      printf("main: criando thread do Quadrado %ld\n", t);
      rc = pthread_create(&threads[t], 
                          NULL, 
                          Quadrado, 
                          (void *)t);
      if (rc) {
         printf("ERRO - rc=%d\n", rc);
         exit(-1);
      }
   }

   for (t=0; t<NUM_THREADS; t++){
      rc = pthread_join(threads[t], &retorno);
      printf("main: thread %ld terminou (ret=%d)\n", t, (int)retorno);

      if (rc) {
         printf("ERRO - rc=%d\n", rc);
         exit(-1);
      }

      soma += (int)retorno;

   }

   printf("\nSoma: %d\n", soma);
   /* Ultima coisa que main() deve fazer */
   pthread_exit(NULL); 
}
