#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <errno.h>

#define MAX_NTHR 100
#define VALOR (1L<<31)

unsigned long total = 0;

void *soma(void *arg) {
   unsigned long parcela = (unsigned long)arg;
   unsigned long total_thr = 0;
   
   for (; parcela; parcela--)
	total_thr++;
   pthread_exit((void *)total_thr);
}

int main(int argc, char *argv[])
{
     long nthr, t;
     char *ptrfim;
     pthread_t *thr;
     int rc;
     unsigned long parc, resto, total_thr;
     void *ret;

     /* o numero de threads e' passado na linha de comando */
     if (argc < 2) {
	  fprintf(stderr, "uso: %s <num-threads>", argv[0]);
	  fprintf(stderr, " (entre 1 e %u)\n", MAX_NTHR);
	  exit(1);
     }

     /* valida o numero de threads */
     errno = 0;
     nthr = strtol(argv[1], &ptrfim, 10);
     if ((errno != 0) || (ptrfim != NULL && *ptrfim != '\0') || (nthr < 1) ||
	 (nthr > MAX_NTHR)) {
	  fprintf(stderr, "erro: numero de threads invalido\n");
	  exit(1);
     }

     /* aloca os descritores de thread */
     thr = (pthread_t *)calloc(nthr, sizeof(pthread_t));
     if (thr == NULL) {
	  fprintf(stderr, "erro em calloc()\n");
	  exit(1);
     }

     /* quanto cada thread contribui para o total */
     parc = VALOR / nthr;

     /* cria as threads */
     for (t = 0; t < nthr; t++) {
	  rc = pthread_create(&thr[t], NULL, soma, (void *)parc);
	  if (rc != 0) {
	       fprintf(stderr, "erro em pthread_create()\n");
	       exit(1);
	  }
     }

     /* acrescenta a parcela do main() */
     for (resto = VALOR % nthr; resto; resto--)
	  total++;

     /* espera as threads terminarem e recupera o valor de retorno */
     for (t = 0; t < nthr; t++) {
     	  pthread_join(thr[t], &ret);
	  total_thr = (unsigned long)ret;
	  total += total_thr;
     }
     
     pthread_exit(NULL);
}
