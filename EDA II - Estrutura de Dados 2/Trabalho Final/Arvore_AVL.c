#include "header.h"

No *removerNoAVL(Arvore *arvore, No *no, int valor)
{
    if (no == NULL || no == arvore->nulo)
    {
        return no;
    }

    contabilizarEsforco(arvore, 1);

    if (valor < no->valor)
    {
        no->esq = removerNoAVL(arvore, no->esq, valor);
    }
    else if (valor > no->valor)
    {
        no->dir = removerNoAVL(arvore, no->dir, valor);
    }
    else
    {
        // Caso 1: nó com um ou nenhum filho
        if (no->esq == NULL || no->esq == arvore->nulo)
        {
            No *temp = no->dir;
            if (temp)
                temp->pai = no->pai;
            free(no);
            return temp;
        }
        else if (no->dir == NULL || no->dir == arvore->nulo)
        {
            No *temp = no->esq;
            if (temp)
                temp->pai = no->pai;
            free(no);
            return temp;
        }

        // Caso 2: nó com dois filhos
        No *temp = minimo(no->dir, arvore->nulo);
        no->valor = temp->valor;
        no->dir = removerNoAVL(arvore, no->dir, temp->valor);
    }

    // Atualiza altura
    atualizarAltura(no);

    // Verifica balanceamento
    int balance = fb(no);

    // Casos de rotação
    if (balance > 1)
    {
        if (fb(no->esq) >= 0)
        {
            return rsd(arvore, no);
        }
        no->esq = rse(arvore, no->esq);
        return rsd(arvore, no);
    }

    if (balance < -1)
    {
        if (fb(no->dir) <= 0)
        {
            return rse(arvore, no);
        }
        no->dir = rsd(arvore, no->dir);
        return rse(arvore, no);
    }

    return no;
}

No *balancearAVL(Arvore *arvore, No *no, int tipoOperacao)
{
    if (no == NULL || no == arvore->nulo)
    {
        return no;
    }

    // Atualiza altura
    atualizarAltura(no);
    int fator = fb(no);

    // Desequilíbrio à esquerda
    if (fator > 1)
    {
        if (fb(no->esq) >= 0)
        {
            contabilizarEsforco(arvore, tipoOperacao);
            return rsd(arvore, no); // Rotação Simples Direita
        }
        else
        {
            contabilizarEsforco(arvore, tipoOperacao);
            return rdd(arvore, no); // Rotação Dupla Direita
        }
    }

    // Desequilíbrio à direita
    if (fator < -1)
    {
        if (fb(no->dir) <= 0)
        {
            contabilizarEsforco(arvore, tipoOperacao);
            return rse(arvore, no); // Rotação Simples Esquerda
        }
        else
        {
            contabilizarEsforco(arvore, tipoOperacao);
            return rde(arvore, no); // Rotação Dupla Esquerda
        }
    }

    return no;
}

No *rse(Arvore *arvore, No *no)
{
    No *dir = no->dir;
    no->dir = dir->esq;

    if (dir->esq != NULL)
        dir->esq->pai = no;

    dir->pai = no->pai;

    if (no->pai == NULL)
        arvore->raiz = dir;
    else if (no == no->pai->esq)
        no->pai->esq = dir;
    else
        no->pai->dir = dir;

    dir->esq = no;
    no->pai = dir;

    atualizarAltura(no);
    atualizarAltura(dir);

    return dir;
}

No *rsd(Arvore *arvore, No *no)
{
    No *esq = no->esq;
    no->esq = esq->dir;

    if (esq->dir != NULL)
        esq->dir->pai = no;

    esq->pai = no->pai;

    if (no->pai == NULL)
        arvore->raiz = esq;
    else if (no == no->pai->esq)
        no->pai->esq = esq;
    else
        no->pai->dir = esq;

    esq->dir = no;
    no->pai = esq;

    atualizarAltura(no);
    atualizarAltura(esq);

    return esq;
}

No *rde(Arvore *arvore, No *no)
{
    no->dir = rsd(arvore, no->dir);
    return rse(arvore, no);
}

No *rdd(Arvore *arvore, No *no)
{
    no->esq = rse(arvore, no->esq);
    return rsd(arvore, no);
}

void atualizarAltura(No *no)
{
    if (no == NULL)
        return;

    int alturaEsq = (no->esq != NULL) ? altura(no->esq) : -1;
    int alturaDir = (no->dir != NULL) ? altura(no->dir) : -1;
    no->caracteristica.AVL.altura = 1 + (alturaEsq > alturaDir ? alturaEsq : alturaDir);
}

int altura(No *no)
{
    if (no == NULL)
        return 0;
    return no->caracteristica.AVL.altura;
}

int fb(No *no)
{
    if (no == NULL)
    {
        return 0;
    }
    return altura(no->esq) - altura(no->dir);
}