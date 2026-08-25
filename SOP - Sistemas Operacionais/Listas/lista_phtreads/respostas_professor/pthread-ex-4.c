#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <pthread.h>

#define T_PAR 1
#define T_IMPAR 2

#define NELEM 2000000

int v[NELEM];

struct arg_st {
     int *v;
     char tipo;
};

void *conta(void *arg) {
     long i, total = 0;
     struct arg_st *argp = (struct arg_st *)arg;
     int *v = argp->v;
     char tipo = argp->tipo;
     
     for (i = 0; i < NELEM; i++) {
	  if ((tipo == T_PAR) && ((v[i] % 2) == 0))
	      total++;
	  else if ((tipo == T_IMPAR) && ((v[i] % 2) != 0))
	       total++;
     }
     pthread_exit((void *)total);
}

int main(int argc, char *argv[])
{
     int i, pares, impares, rc;
     struct timeval tv_ini, tv_fim;
     unsigned long time_diff, sec_diff, usec_diff, msec_diff;
     pthread_t tpar, timpar;
     struct arg_st arg_par, arg_impar;
     void *ret;

     srandom(time(NULL));
     for (i = 0; i < NELEM; i++) {
	  v[i] = (int)random();
/*	  vetor[i] = i*2;*/
     }
     
     /* marca o tempo de inicio */
     rc = gettimeofday(&tv_ini, NULL);
     if (rc != 0) {
	  perror("erro em gettimeofday()");
	  exit(1);
     }

     /* faz o processamento de interesse */
     arg_par.v = v;
     arg_par.tipo = T_PAR;
     rc = pthread_create(&tpar, NULL, conta, (void *)&arg_par);
     if (rc != 0) { perror("pthread_create()"); exit(1); }

     arg_impar.v = v;
     arg_impar.tipo = T_IMPAR;
     rc = pthread_create(&timpar, NULL, conta, (void *)&arg_impar);
     if (rc != 0) { perror("pthread_create()"); exit(1); }

     rc = pthread_join(tpar, &ret);
     if (rc != 0) { perror("pthread_join()"); exit(1); }
     pares = (long)ret;

     rc = pthread_join(timpar, &ret);
     if (rc != 0) { perror("pthread_join()"); exit(1); }
     impares = (long)ret;

     /* marca o tempo de final */
     rc = gettimeofday(&tv_fim, NULL);
     if (rc != 0) {
	  perror("erro em gettimeofday()");
	  exit(1);
     }
     /* calcula a diferenca entre os tempos, em usec */
     time_diff = (1000000L*tv_fim.tv_sec + tv_fim.tv_usec) - 
  	         (1000000L*tv_ini.tv_sec + tv_ini.tv_usec);
     /* converte para segundos + microsegundos (parte fracion�ria) */
     sec_diff = time_diff / 1000000L;
     usec_diff = time_diff % 1000000L;
     
     /* converte para msec */
     msec_diff = time_diff / 1000;
     
     printf("O vetor tem %d numeros pares e %d numeros impares.\n", pares,
	    impares);
/*     printf("Tempo de execucao: %lu.%06lu seg\n", sec_diff, usec_diff);*/
     printf("Tempo de execucao: %lu.%03lu mseg\n", msec_diff, usec_diff%1000);
     return 0;
}
