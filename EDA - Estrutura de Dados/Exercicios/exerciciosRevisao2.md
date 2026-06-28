# Exercícios de Revisão

Responda Verdadeiro ou Falso para as questões:

a) _____ Um elemento de vetor `b[3]` pode ser referenciado alternativamente por `*(bPt + 3)`, onde 3 é o valor de deslocamento referente ao ponteiro `bPt`, uma vez que `bPt = &b[0]`;

Dado o Algoritmo 1:

```c
#include <stdio.h>
#include <locale.h>
#define ARRAY_SIZE 4

int main(void) {
  int b[] = { 10, 20, 30, 40 };
  int *bPtr = b;
  int i, desloca;

  setlocale(LC_ALL, "Portuguese");

  for (i = 0; i < ARRAY_SIZE; ++i)
    printf("\nb[%i] = %d", i, b[i]);

  printf("\nA notação de ponteiro ou deslocamento:\n");
  for (desloca = 0; desloca < ARRAY_SIZE; ++desloca)
    printf("\n*(b + %i) = %d", desloca, *(b + desloca));

  printf("\nNotação de índice no ponteiro:\n");
  for (i = 0; i < ARRAY_SIZE; ++i)
    printf("bPtr[%i] = %d\n", i, bPtr[i]);

  printf("\nNotação de ponteiro:\n");
  for (desloca = 0; desloca < ARRAY_SIZE; ++desloca)
    printf("*(bPtr + %i) = %d\n", desloca, *(bPtr + desloca));

  return 0;
}
```

b) _______ O código do Algoritmo 1 está correto.

c) _______ No Algoritmo 1, a linha `int *bPtr = b;` pode ser substituída sem prejuízos por:
```c
int *bPtr; 
bPtr = &b[0];
```

Dada a Figura 1:
*(Estrutura de dados não visível no texto)*

c) _____ O código correto para a Figura 1 é:
```c
const char *suit[4] = {"Hearts", "Diamonds", "Clubs", "Spades"};
```

d) ______ O código da Figura 1 consiste em um array de ponteiros para várias strings.

Seja o algoritmo 2:

```c
#include <stdio.h>
#include <stdlib.h>

#define MAX_STRINGS 5
#define MAX_STRING_LENGTH 20

int main() {   
    char *vector[MAX_STRINGS];

    for (int i = 0; i < MAX_STRINGS; ++i) {
        vector[i] = (char *)malloc(MAX_STRING_LENGTH * sizeof(char));
        if (vector[i] == NULL) {
            printf(" falhou\n");            
            return 1;
        }
    }

    printf("Enter %d strings for the vector:\n", MAX_STRINGS);
    for (int i = 0; i < MAX_STRINGS; ++i)
        scanf("%s", vector[i]);

    printf("The vector of strings is:\n");
    for (int i = 0; i < MAX_STRINGS; ++i)
        printf("%s\n", vector[i]);
    
    for (int i = 0; i < MAX_STRINGS; ++i)
        free(vector[i]);

    return 0;
}
```

f) ____ O Algoritmo 2 realiza a alocação dinâmica de memória corretamente.

g) _____ No bloco de verificação `if (vector[i] == NULL)`, verifica-se o sucesso ou falha na alocação da memória.

h) _____ O loop de escaneamento manipula a string de forma incorreta.

Seja o Algoritmo 3:

```c
#include <stdio.h>
#include <stdlib.h>
#include "tipos.h"

#define PESS "pessoaB.dat"

int main() {
  FILE *arq;
  PF pes;
  int i = 0, num;

/* trecho para gerar um arquivo binário 
  arq = fopen (PESS, "ab");
  if (arq==NULL) {
      perror ("Erro ao abrir arquivo.");
      exit (1);
  }
  for (i = 0; i < 3; i++) {
      printf ("Nome : ");
      scanf ("%[^\n]", pes.nome);
      getchar();
      printf ("CPF : ");
      scanf ("%s", pes.cpf);
      getchar ();
      printf ("Idade: ");
      scanf ("%i", &pes.idade);
      getchar ();
      printf ("\n");
      fwrite (&pes, sizeof(PF),1, arq);
  }
  fclose (arq);
*/
  arq = fopen(PESS, "rb");
  if (arq == NULL) exit(1);
  
  while (!feof(arq)) {
      fread(&pes, sizeof(pes), 1, arq);
      printf("%i Nome:%s cpf:%s idade:%i\n", i, pes.nome, pes.cpf, pes.idade);
      i++;
  }
 
  printf("\n\nEscolha um número de 1 a %i:\n", i);
  scanf("%d", &num);
    
  fseek(arq, (-num) * sizeof(pes), SEEK_END);
  fread(&pes, sizeof(pes), 1, arq);
  printf("Nome:%s cpf:%s idade:%i\n", pes.nome, pes.cpf, pes.idade);

  fclose(arq);
  return 0;
}
```

Considere `PESS` com os dados abaixo, alimentados como um arquivo binário:

```text
Nome:Dunga cpf:123456 idade:30
Nome:Atchim cpf:34567 idade:29
Nome:Zangado cpf:9087931 idade:31
Nome:Mestre cpf:382910 idade:40
Nome:Feliz cpf:97383 idade:50
Nome:Soneca cpf:9294857331 idade:46
```

g) Qual a saída quando `num = 3`? Por quê?

No Algoritmo 4, observe o funcionamento usando `fseek` com outro parâmetro:

```c
#include <stdio.h>
#include <stdlib.h> 
#include "tipos.h"

#define PESS "pessoaB.dat"

int main() {
  FILE *arq;
  PF pes;
  int i = 0, num;

  arq = fopen(PESS, "rb");
  if (arq == NULL) exit(1);

  while (!feof(arq)) {
      fread(&pes, sizeof(pes), 1, arq);
      printf("%i Nome:%s cpf:%s idade:%i\n", i, pes.nome, pes.cpf, pes.idade);
      i++;
  }
 
  printf("\n\nEscolha um número de 1 a %i:\n", i);
  scanf("%d", &num);
    
  fseek(arq, (num) * sizeof(pes), SEEK_SET);
  fread(&pes, sizeof(pes), 1, arq);
  printf("Nome:%s cpf:%s idade:%i\n", pes.nome, pes.cpf, pes.idade);

  fclose(arq);
  return 0;
}
```

Compare a linha do `fseek` do Algoritmo 3 com a do Algoritmo 4. Revise a descrição da função `fseek`.

**Sugestões de estudo:**
- https://www.inf.ufpr.br/roberto/ci067/12_arquivos.html
- https://www.youtube.com/watch?v=cdXGEy-6jMU&ab_channel=Programa%C3%A7%C3%A3oDescomplicada%7CLinguagemC
- https://www.youtube.com/watch?v=hK5JSQWwI4A&ab_channel=ProfRomersonOliveira