#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>
#include <assert.h>

pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;

unsigned int ncontas, maxvalor = 50;
long *cta;
long saldo_inicial = 100;

/* Transfere 'valor' da conta 'c1' para a conta 'c2' */
void transfere(unsigned int c1, unsigned int c2, long valor) {
     if ((c1 < ncontas-1) && (c2 < ncontas-1) && (c1 != c2)) {
	  pthread_mutex_lock(&mtx);
      cta[c1] -= valor;
	  cta[c2] += valor;
      pthread_mutex_unlock(&mtx);
     }
}
void thread(void *arg) {
     unsigned int c1, c2, valor;
     unsigned long i, ntransf = (unsigned long)arg;
     for (i = 0; i < ntransf; i++) {
	  c1 = random() % ncontas;
	  do {
	       c2 = random() % ncontas;
	  } while (c1 == c2);
	  valor = (random() % maxvalor) + 1;
	  //pthread_mutex_lock(&mtx);
      transfere(c1, c2, valor);
      //pthread_mutex_unlock(&mtx);
     }
     pthread_exit(NULL);
}
	  
int main(int argc, char *argv[]) {
     pthread_t *thr;
     int rc;
     unsigned int i, nthr;
     unsigned long ntransf;
     unsigned long long total_inicial, total_final;

     nthr = (argc > 1 ? atoi(argv[1]) : 100);
     thr = calloc(nthr, sizeof(pthread_t));
     assert(thr != NULL);
     ncontas = (argc > 2 ? atoi(argv[2]) : 10);
     cta = calloc(ncontas, sizeof(long));
     assert(cta != NULL);

     for (i = 0; i < ncontas; i++)
	  cta[i] = saldo_inicial;
     
     total_inicial = ncontas * saldo_inicial;
     ntransf = (argc > 3 ? atoi(argv[3]) : 100);
     for (i = 0; i < nthr; i++) {
	  rc = pthread_create(&thr[i], NULL, (void *)thread,
			      (void *)ntransf);
	  assert(rc == 0);
     }
     for (i = 0; i < nthr; i++) {
	  rc = pthread_join(thr[i], NULL);
	  assert(rc == 0);
     }
     total_final = 0;
     for (i = 0; i < ncontas; i++)
	  total_final += cta[i];
     if (total_inicial == total_final)
	  printf("OK");
     else
	  printf("ERRO");
     printf(" -- total inicial=%llu, total final=%llu\n", total_inicial,
	    total_final);
     return 0;
}