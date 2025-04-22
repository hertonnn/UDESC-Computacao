#include "header.h"
#include <time.h>

#define NUM_CONJUNTOS 10
#define MAX_CHAVES 10000

void analisarComplexidadeRB();

int main()
{
    srand(time(NULL));
    analisarComplexidadeRB();
    return 0;
}

void analisarComplexidadeRB()
{
    int i, j, k;
    int chaves[MAX_CHAVES];
    int totalInsercoes, totalRemocoes;
    double mediaInsercoes, mediaRemocoes;

    for (i = 1; i <= MAX_CHAVES; i *= 10)
    {
        totalInsercoes = 0;
        totalRemocoes = 0;

        for (j = 0; j < NUM_CONJUNTOS; j++)
        {
            Arvore *arvore = criarArvore(RUBRO_NEGRA, 0);

            // Gera chaves aleatórias
            for (k = 0; k < i; k++)
            {
                chaves[k] = rand() % (MAX_CHAVES * 10);
            }

            // Insere chaves na árvore
            for (k = 0; k < i; k++)
            {
                incrementarEsforcoInsercao(arvore, chaves[k]);
            }

            totalInsercoes += arvore->esforcoInserirRB;

            // Remove chaves da árvore
            for (k = 0; k < i; k++)
            {
                incrementarEsforcoRemocao(arvore, chaves[k]);
            }

            totalRemocoes += arvore->esforcoRemoverRB;

            liberarArvore(arvore);
        }

        mediaInsercoes = (double)totalInsercoes / NUM_CONJUNTOS;
        mediaRemocoes = (double)totalRemocoes / NUM_CONJUNTOS;

        printf("Para %d chaves:\n", i);
        printf("Média de operações de inserção: %.2f\n", mediaInsercoes);
        printf("Média de operações de remoção: %.2f\n", mediaRemocoes);
        printf("\n");
    }
}