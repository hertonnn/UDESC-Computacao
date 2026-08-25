#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <pthread.h>
#include <stdint.h>


#define T_PAR 1
#define T_IMPAR 2

#define NELEM 2000000

//int vet[NELEM];

typedef struct {
    int *vet;
    int tipo;
} args_conta_t;


void *conta(void *arg) 
{
    args_conta_t *args = (args_conta_t *)arg;
    int *vet = args->vet;
    int tipo = args->tipo;

     int i, total = 0;
     
     for (i = 0; i < NELEM; i++) {
	  if ((tipo == T_PAR) && ((vet[i] % 2) == 0))
	      total++;
	  else if ((tipo == T_IMPAR) && ((vet[i] % 2) != 0))
	      total++;
     }
      pthread_exit((void *)(intptr_t)total);
}


int main(int argc, char *argv[])
{
     int vet[NELEM];
     int i, pares, impares, rc;
     struct timeval tv_ini, tv_fim;
     unsigned long time_diff, sec_diff, usec_diff, msec_diff;
     pthread_t thread_impar;
     pthread_t thread_par;

    args_conta_t args_par, args_impar;
    args_par.vet = vet;
    args_par.tipo = T_PAR;

    args_impar.vet = vet;
    args_impar.tipo = T_IMPAR;


     void *total_pares, *total_impares;

     srandom(time(NULL));
     for (i = 0; i < NELEM; i++) {
	  vet[i] = (int)random();
     }
     
     /* marca o tempo de inicio */
     rc = gettimeofday(&tv_ini, NULL);
     if (rc != 0) {
	  perror("erro em gettimeofday()");
	  exit(1);
     }

     /* faz o processamento de interesse */
     rc = pthread_create(&thread_par, NULL, conta, &args_par);
     rc = pthread_create(&thread_impar, NULL, conta, &args_impar);
     
     rc = pthread_join(thread_par, &total_pares);
     rc = pthread_join(thread_impar, &total_impares);

     /* marca o tempo de final */
     rc = gettimeofday(&tv_fim, NULL);
     if (rc != 0) {
	  perror("erro em gettimeofday()");
	  exit(1);
     }
     /* calcula a diferenca entre os tempos, em usec */
     time_diff = (1000000L*tv_fim.tv_sec + tv_fim.tv_usec) - 
  	         (1000000L*tv_ini.tv_sec + tv_ini.tv_usec);
     /* converte para segundos + microsegundos (parte fracionária) */
     sec_diff = time_diff / 1000000L;
     usec_diff = time_diff % 1000000L;
     
     /* converte para msec */
     msec_diff = time_diff / 1000;
     
     printf("O vetor tem %ld numeros pares e %ld numeros impares.\n", (intptr_t)total_pares,
	    (intptr_t)total_impares);
/*     printf("Tempo de execucao: %lu.%06lu seg\n", sec_diff, usec_diff);*/
     printf("Tempo de execucao: %lu.%03lu mseg\n", msec_diff, usec_diff%1000);
     return 0;
}