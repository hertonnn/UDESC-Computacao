#include "header.h"

void balancearRubroNegra(Arvore *arvore, No *no)
{
    while (no->pai != arvore->nulo && no->pai->caracteristica.RUBRO_NEGRA.cor == VERMELHO)
    {
        if (no->pai == no->pai->pai->esq)
        {
            No *tio = no->pai->pai->dir;

            if (tio->caracteristica.RUBRO_NEGRA.cor == VERMELHO)
            {
                tio->caracteristica.RUBRO_NEGRA.cor = PRETO;
                no->pai->caracteristica.RUBRO_NEGRA.cor = PRETO;
                no->pai->pai->caracteristica.RUBRO_NEGRA.cor = VERMELHO;
                no = no->pai->pai;
                contabilizarEsforco(arvore, 0); // Mudança de cor
            }
            else
            {
                if (no == no->pai->dir)
                {
                    no = no->pai;
                    rotacionaresq(arvore, no);
                    contabilizarEsforco(arvore, 0); // Rotação à esquerda
                }
                no->pai->caracteristica.RUBRO_NEGRA.cor = PRETO;
                no->pai->pai->caracteristica.RUBRO_NEGRA.cor = VERMELHO;
                rotacionardir(arvore, no->pai->pai);
                contabilizarEsforco(arvore, 0); // Rotação à direita
            }
        }
        else
        {
            No *tio = no->pai->pai->esq;

            if (tio->caracteristica.RUBRO_NEGRA.cor == VERMELHO)
            {
                tio->caracteristica.RUBRO_NEGRA.cor = PRETO;
                no->pai->caracteristica.RUBRO_NEGRA.cor = PRETO;
                no->pai->pai->caracteristica.RUBRO_NEGRA.cor = VERMELHO;
                no = no->pai->pai;
                contabilizarEsforco(arvore, 0); // Mudança de cor
            }
            else
            {
                if (no == no->pai->esq)
                {
                    no = no->pai;
                    rotacionardir(arvore, no);
                    contabilizarEsforco(arvore, 0); // Rotação à direita
                }
                no->pai->caracteristica.RUBRO_NEGRA.cor = PRETO;
                no->pai->pai->caracteristica.RUBRO_NEGRA.cor = VERMELHO;
                rotacionaresq(arvore, no->pai->pai);
                contabilizarEsforco(arvore, 0); // Rotação à esquerda
            }
        }
    }
    arvore->raiz->caracteristica.RUBRO_NEGRA.cor = PRETO;
}

void rotacionaresq(Arvore *arvore, No *no)
{
    No *dir = no->dir;
    no->dir = dir->esq;

    if (dir->esq != arvore->nulo)
    {
        dir->esq->pai = no;
    }

    dir->pai = no->pai;

    if (no->pai == arvore->nulo)
    {
        arvore->raiz = dir;
    }
    else if (no == no->pai->esq)
    {
        no->pai->esq = dir;
    }
    else
    {
        no->pai->dir = dir;
    }

    dir->esq = no;
    no->pai = dir;
}

void rotacionardir(Arvore *arvore, No *no)
{
    No *esq = no->esq;
    no->esq = esq->dir;

    if (esq->dir != arvore->nulo)
    {
        esq->dir->pai = no;
    }

    esq->pai = no->pai;

    if (no->pai == arvore->nulo)
    {
        arvore->raiz = esq;
    }
    else if (no == no->pai->esq)
    {
        no->pai->esq = esq;
    }
    else
    {
        no->pai->dir = esq;
    }

    esq->dir = no;
    no->pai = esq;
}

void balancearRemocao(Arvore *arvore, No *x)
{
    while (x != arvore->raiz && x->caracteristica.RUBRO_NEGRA.cor == PRETO)
    {
        contabilizarEsforco(arvore, 1); // Esforço para cada iteração do loop

        if (x == x->pai->esq)
        {
            No *w = x->pai->dir;
            contabilizarEsforco(arvore, 1); // Acesso ao irmão

            if (w->caracteristica.RUBRO_NEGRA.cor == VERMELHO)
            {
                contabilizarEsforco(arvore, 1); // Comparação de cor
                w->caracteristica.RUBRO_NEGRA.cor = PRETO;
                x->pai->caracteristica.RUBRO_NEGRA.cor = VERMELHO;
                rotacionaresq(arvore, x->pai);
                contabilizarEsforco(arvore, 1); // Esforço de rotação
                w = x->pai->dir;
            }

            if (w->esq->caracteristica.RUBRO_NEGRA.cor == PRETO && w->dir->caracteristica.RUBRO_NEGRA.cor == PRETO)
            {
                contabilizarEsforco(arvore, 2); // Comparações de cor
                w->caracteristica.RUBRO_NEGRA.cor = VERMELHO;
                x = x->pai;
            }
            else
            {
                if (w->dir->caracteristica.RUBRO_NEGRA.cor == PRETO)
                {
                    contabilizarEsforco(arvore, 1); // Comparação de cor
                    w->esq->caracteristica.RUBRO_NEGRA.cor = PRETO;
                    w->caracteristica.RUBRO_NEGRA.cor = VERMELHO;
                    rotacionardir(arvore, w);
                    contabilizarEsforco(arvore, 1); // Esforço de rotação
                    w = x->pai->dir;
                }
                w->caracteristica.RUBRO_NEGRA.cor = x->pai->caracteristica.RUBRO_NEGRA.cor;
                x->pai->caracteristica.RUBRO_NEGRA.cor = PRETO;
                w->dir->caracteristica.RUBRO_NEGRA.cor = PRETO;
                rotacionaresq(arvore, x->pai);
                contabilizarEsforco(arvore, 1); // Esforço de rotação
                x = arvore->raiz;
            }
        }
        else
        {
            // Caso simétrico
            No *w = x->pai->esq;
            contabilizarEsforco(arvore, 1); // Acesso ao irmão

            if (w->caracteristica.RUBRO_NEGRA.cor == VERMELHO)
            {
                contabilizarEsforco(arvore, 1); // Comparação de cor
                w->caracteristica.RUBRO_NEGRA.cor = PRETO;
                x->pai->caracteristica.RUBRO_NEGRA.cor = VERMELHO;
                rotacionardir(arvore, x->pai);
                contabilizarEsforco(arvore, 1); // Esforço de rotação
                w = x->pai->esq;
            }

            if (w->dir->caracteristica.RUBRO_NEGRA.cor == PRETO && w->esq->caracteristica.RUBRO_NEGRA.cor == PRETO)
            {
                contabilizarEsforco(arvore, 2); // Comparações de cor
                w->caracteristica.RUBRO_NEGRA.cor = VERMELHO;
                x = x->pai;
            }
            else
            {
                if (w->esq->caracteristica.RUBRO_NEGRA.cor == PRETO)
                {
                    contabilizarEsforco(arvore, 1); // Comparação de cor
                    w->dir->caracteristica.RUBRO_NEGRA.cor = PRETO;
                    w->caracteristica.RUBRO_NEGRA.cor = VERMELHO;
                    rotacionaresq(arvore, w);
                    contabilizarEsforco(arvore, 1); // Esforço de rotação
                    w = x->pai->esq;
                }
                w->caracteristica.RUBRO_NEGRA.cor = x->pai->caracteristica.RUBRO_NEGRA.cor;
                x->pai->caracteristica.RUBRO_NEGRA.cor = PRETO;
                w->esq->caracteristica.RUBRO_NEGRA.cor = PRETO;
                rotacionardir(arvore, x->pai);
                contabilizarEsforco(arvore, 1); // Esforço de rotação
                x = arvore->raiz;
            }
        }
    }
    x->caracteristica.RUBRO_NEGRA.cor = PRETO;
    contabilizarEsforco(arvore, 1); // Ajuste final
}

No *removerNoRB(Arvore *arvore, No *z, int valor)
{
    No *y = z;
    No *x;
    Cor corOriginal = y->caracteristica.RUBRO_NEGRA.cor;

    contabilizarEsforco(arvore, 1); // Esforço para acessar o nó a ser removido

    if (z->esq == arvore->nulo)
    {
        x = z->dir;
        transplantar(arvore, z, z->dir);
        contabilizarEsforco(arvore, 1); // Esforço de transplante
    }
    else if (z->dir == arvore->nulo)
    {
        x = z->esq;
        transplantar(arvore, z, z->esq);
        contabilizarEsforco(arvore, 1); // Esforço de transplante
    }
    else
    {
        y = minimo(z->dir, arvore->nulo);
        contabilizarEsforco(arvore, 1); // Esforço para encontrar o sucessor
        corOriginal = y->caracteristica.RUBRO_NEGRA.cor;
        x = y->dir;

        if (y->pai == z)
        {
            x->pai = y;
        }
        else
        {
            transplantar(arvore, y, y->dir);
            contabilizarEsforco(arvore, 1); // Esforço de transplante
            y->dir = z->dir;
            y->dir->pai = y;
        }
        transplantar(arvore, z, y);
        contabilizarEsforco(arvore, 1); // Esforço de transplante
        y->esq = z->esq;
        y->esq->pai = y;
        y->caracteristica.RUBRO_NEGRA.cor = z->caracteristica.RUBRO_NEGRA.cor;
    }
    free(z);

    if (corOriginal == PRETO)
    {
        balancearRemocao(arvore, x);
    }

    return x;
}

void transplantar(Arvore *arvore, No *u, No *v)
{
    if (u->pai == arvore->nulo)
    {
        arvore->raiz = v;
    }
    else if (u == u->pai->esq)
    {
        u->pai->esq = v;
    }
    else
    {
        u->pai->dir = v;
    }

    if (v != NULL)
    {
        v->pai = u->pai;
    }
}
