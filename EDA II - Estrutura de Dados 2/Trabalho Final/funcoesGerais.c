#include "header.h"

Arvore *criarArvore(tipoArvore tipo, int ordem)
{
    Arvore *arvore = (Arvore *)malloc(sizeof(Arvore));

    arvore->raiz = arvore->nulo = NULL;
    arvore->tipo = tipo;
    arvore->ordem = ordem; // Necessário apenas para árvores B

    if (tipo == B)
    {
        arvore->raiz = criaNoB(arvore);
    }

    else if (tipo == RUBRO_NEGRA)
    {
        arvore->nulo = criarNo(arvore, NULL, 0);
        arvore->nulo->caracteristica.RUBRO_NEGRA.cor = PRETO;
        arvore->esforcoInserirRB = 0;
        arvore->esforcoRemoverRB = 0;
    }
    else // Para AVL
    {
        arvore->nulo = criarNo(arvore, NULL, 0);
        arvore->esforcoInserirAVL = 0;
        arvore->esforcoRemoverAVL = 0;
    }

    return arvore;
}

No *criarNo(Arvore *arvore, No *pai, int valor)
{
    No *novoNo = (No *)malloc(sizeof(No));
    novoNo->pai = pai;
    novoNo->valor = valor;
    novoNo->esq = arvore->nulo;
    novoNo->dir = arvore->nulo;
    novoNo->tipo = arvore->tipo;

    if (arvore->tipo == AVL)
    {
        novoNo->caracteristica.AVL.altura = 1;
    }
    else if (arvore->tipo == RUBRO_NEGRA)
    {
        novoNo->caracteristica.RUBRO_NEGRA.cor = VERMELHO;
    }

    return novoNo;
}

int incrementarEsforcoInsercao(Arvore *arvore, int valor)
{
    if (arvore->tipo == AVL)
    {
        arvore->esforcoInserirAVL = 0;
        adicionar(arvore, valor);
        return arvore->esforcoInserirAVL;
    }
    else if (arvore->tipo == RUBRO_NEGRA)
    {
        arvore->esforcoInserirRB = 0;
        adicionar(arvore, valor);
        return arvore->esforcoInserirRB;
    }
    return 0;
}

int incrementarEsforcoRemocao(Arvore *arvore, int valor)
{
    if (arvore == NULL)
    {
        return 0;
    }

    if (arvore->tipo == AVL)
    {
        arvore->esforcoRemoverAVL = 0;
        remover(arvore, valor);
        return arvore->esforcoRemoverAVL;
    }
    else if (arvore->tipo == RUBRO_NEGRA)
    {
        arvore->esforcoRemoverRB = 0;
        remover(arvore, valor);
        return arvore->esforcoRemoverRB;
    }
    return 0;
}

int contabilizarEsforco(Arvore *arvore, int tipo)
{
    if (arvore->tipo == AVL)
    {
        if (tipo == 0) // Esforço de Inserção
        {
            return arvore->esforcoInserirAVL++;
        }
        else if (tipo == 1) // Esforço de Remoção
        {
            return arvore->esforcoRemoverAVL++;
        }
    }
    else if (arvore->tipo == RUBRO_NEGRA)
    {
        if (tipo == 0) // Esforço de Inserção
        {
            return arvore->esforcoInserirRB++;
        }
        else if (tipo == 1) // Esforço de Remoção
        {
            return arvore->esforcoRemoverRB++;
        }
    }
    return 0;
}

int vazia(Arvore *arvore)
{
    return arvore->raiz == NULL;
}

No *adicionar(Arvore *arvore, int valor)
{
    if (vazia(arvore))
    {
        contabilizarEsforco(arvore, 0); // Esforço para criar raiz
        arvore->raiz = criarNo(arvore, arvore->nulo, valor);

        if (arvore->tipo == RUBRO_NEGRA)
        {
            contabilizarEsforco(arvore, 0); // Esforço para ajustar cor da raiz
            arvore->raiz->caracteristica.RUBRO_NEGRA.cor = PRETO;
        }
        return arvore->raiz;
    }
    else
    {
        No *novoNo = adicionarNo(arvore, arvore->raiz, valor);

        if (novoNo == NULL)
        {
            return NULL;
        }

        if (arvore->tipo == RUBRO_NEGRA)
        {
            contabilizarEsforco(arvore, 0); // Esforço inicial do balanceamento RB
            balancearRubroNegra(arvore, novoNo);
        }
        else if (arvore->tipo == AVL)
        {
            contabilizarEsforco(arvore, 0); // Esforço inicial do balanceamento AVL
            balancearAVL(arvore, novoNo->pai, 0);
        }
        return novoNo;
    }
}

No *adicionarNo(Arvore *arvore, No *no, int valor)
{
    contabilizarEsforco(arvore, 0); // Esforço para cada nível visitado

    if (no == arvore->nulo)
    {
        No *novoNo = criarNo(arvore, no->pai, valor);
        contabilizarEsforco(arvore, 0); // Esforço para criar novo nó
        if (!novoNo)
        {
            return NULL;
        }
        return novoNo;
    }

    // Esforço para comparação
    contabilizarEsforco(arvore, 0);
    if (valor < no->valor)
    {
        if (no->esq == arvore->nulo || no->esq == NULL)
        {
            No *novoNo = criarNo(arvore, no, valor);
            contabilizarEsforco(arvore, 0); // Esforço para criar e conectar novo nó
            if (!novoNo)
            {
                return NULL;
            }
            no->esq = novoNo;
            return no->esq;
        }
        return adicionarNo(arvore, no->esq, valor);
    }
    else if (valor > no->valor)
    {
        if (no->dir == arvore->nulo || no->dir == NULL)
        {
            No *novoNo = criarNo(arvore, no, valor);
            contabilizarEsforco(arvore, 0); // Esforço para criar e conectar novo nó
            if (!novoNo)
            {
                return NULL;
            }
            no->dir = novoNo;
            return no->dir;
        }
        return adicionarNo(arvore, no->dir, valor);
    }

    return NULL; // Valor duplicado
}

No *remover(Arvore *arvore, int valor)
{
    if (vazia(arvore))
        return NULL;

    No *z = arvore->raiz;
    while (z != arvore->nulo)
    {
        contabilizarEsforco(arvore, 1); // Esforço para cada comparação
        if (valor == z->valor)
            break;
        else if (valor < z->valor)
        {
            z = z->esq;
            contabilizarEsforco(arvore, 1); // Esforço para navegar na árvore
        }
        else
        {
            z = z->dir;
            contabilizarEsforco(arvore, 1); // Esforço para navegar na árvore
        }
    }

    if (z == arvore->nulo)
    {
        return NULL;
    }

    if (arvore->tipo == AVL)
    {
        contabilizarEsforco(arvore, 1); // Esforço inicial da remoção AVL
        arvore->raiz = removerNoAVL(arvore, arvore->raiz, valor);
        return arvore->raiz;
    }
    else if (arvore->tipo == RUBRO_NEGRA)
    {
        contabilizarEsforco(arvore, 1); // Esforço inicial da remoção RB
        return removerNoRB(arvore, z, valor);
    }
    return NULL;
}

No *localizar(Arvore *arvore, int valor)
{
    if (vazia(arvore))
    {
        return NULL;
    }

    No *no = arvore->raiz;
    while (no != arvore->nulo)
    {
        if (valor == no->valor)
        {
            return no;
        }
        else if (valor < no->valor)
        {
            no = no->esq;
        }
        else
        {
            no = no->dir;
        }
    }

    printf("Valor %d não encontrado.\n", valor);
    return NULL;
}

void visitar(int valor)
{
    printf("%d ", valor);
}

No *criaNoB(Arvore *arvore)
{
    int max = arvore->ordem * 2;
    No *no = malloc(sizeof(No));
    if (no == NULL)
        return NULL;

    no->chaves = malloc(sizeof(int) * (max + 1));
    if (no->chaves == NULL)
    {
        free(no);
        return NULL;
    }

    no->filhos = malloc(sizeof(No *) * (max + 2));
    if (no->filhos == NULL)
    {
        free(no->chaves);
        free(no);
        return NULL;
    }

    no->pai = NULL;
    no->tipo = B;
    no->total = 0;

    // Inicializa todos os filhos como NULL
    for (int i = 0; i < max + 2; i++)
    {
        no->filhos[i] = NULL;
    }

    return no;
}

void liberarNo(Arvore *arvore, No *no)
{
    if (no != NULL && no != arvore->nulo)
    {
        // Libera recursivamente os filhos primeiro
        if (no->esq != NULL && no->esq != arvore->nulo)
        {
            liberarNo(arvore, no->esq);
        }
        if (no->dir != NULL && no->dir != arvore->nulo)
        {
            liberarNo(arvore, no->dir);
        }

        // Limpa as referências
        no->esq = NULL;
        no->dir = NULL;
        no->pai = NULL;

        // Libera o nó
        free(no);
    }
}

void liberarArvore(Arvore *arvore)
{
    if (arvore != NULL)
    {
        if (arvore->tipo == B)
        {
            if (arvore->raiz != NULL)
            {
                liberarNoB(arvore->raiz);
            }
        }
        else
        {
            if (arvore->raiz != NULL && arvore->raiz != arvore->nulo)
            {
                liberarNo(arvore, arvore->raiz);
            }
            if (arvore->nulo != NULL)
            {
                free(arvore->nulo);
            }
        }

        // Limpa todas as referências
        arvore->raiz = NULL;
        arvore->nulo = NULL;

        free(arvore);
    }
}

void liberarNoB(No *no)
{
    if (no != NULL)
    {
        // Libera recursivamente todos os filhos
        if (no->filhos != NULL)
        {
            for (int i = 0; i <= no->total; i++)
            { // Modificado para incluir todos os filhos
                if (no->filhos[i] != NULL)
                {
                    liberarNoB(no->filhos[i]);
                    no->filhos[i] = NULL; // Evita dupla liberação
                }
            }
            free(no->filhos);
            no->filhos = NULL;
        }

        // Libera array de chaves
        if (no->chaves != NULL)
        {
            free(no->chaves);
            no->chaves = NULL;
        }

        free(no);
    }
}

No *minimo(No *no, No *nulo)
{
    if (no == NULL)
    {
        return NULL;
    }

    // Para árvore B, procurar a menor chave
    if (no->tipo == B)
    {
        // Se não for folha, continua descendo pelo filho mais à esquerda
        return minimo(no->filhos[0], nulo);
    }

    // Para árvores binárias (AVL e RB)
    No *atual = no;
    while (atual->esq != NULL && atual->esq != nulo)
    {
        atual = atual->esq;
    }
    return atual;
}