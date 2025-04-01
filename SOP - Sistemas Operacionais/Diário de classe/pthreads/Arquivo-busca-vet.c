#include <stdio.h>
#include <stdlib.h>

#define NELEM 40000000

long v[NELEM];

long busca_inc(long n) {
     long i, ret = -1;

     for (i = 0; i < NELEM; i++) {
	  if (v[i] == n) {
	       ret = i;
	       break;
	  }
     }
     return ret;
}

int main(int argc, char *argv[])
{
     long i, n;

     if (argc < 2) {
	  fprintf(stderr, "e o n, querido?\n");
	  exit(1);
     }
     n = atoi(argv[1]);
     for (i = 0; i < NELEM; i++) 
	  v[i] = i+1;
     i = busca_inc(n);
     if (i >= 0)
	  printf("O numero %ld esta' na posicao %ld do vetor\n", n, i);
     else
	  printf("O numero %ld nao foi encontrado no vetor\n", n);
     return 0;
}
