#ifndef HEADER_H
#define HEADER_H

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <string.h>
#include <assert.h>

typedef enum
{
    AVL,
    RUBRO_NEGRA,
    B
} tipoArvore;

typedef enum
{
    VERMELHO,
    PRETO
} Cor;

typedef struct No
{
    struct No *pai;
    struct No **filhos;
    struct No *esq;
    struct No *dir;
    int *chaves;
    int valor;
    int total;

    tipoArvore tipo;

    union
    {
        struct
        {
            int altura;
        } AVL;
        struct
        {
            Cor cor;
        } RUBRO_NEGRA;
        struct
        {
            int ordem;
        } B;
    } caracteristica;
} No;

typedef struct Arvore
{
    No *raiz;
    No *nulo;
    tipoArvore tipo;
    int ordem;
    int esforcoInserirAVL;
    int esforcoRemoverAVL;
    int esforcoInserirRB;
    int esforcoRemoverRB;
} Arvore;

// funcoesGerais.c
Arvore *criarArvore(tipoArvore tipo, int ordem);
No *criarNo(Arvore *arvore, No *pai, int valor);
int vazia(Arvore *arvore);
No *adicionar(Arvore *arvore, int valor);
No *remover(Arvore *arvore, int valor);
void visitar(int valor);
No *criaNoB(Arvore *arvore);
No *adicionarNo(Arvore *arvore, No *no, int valor);
No *localizar(Arvore *arvore, int valor);
int incrementarEsforcoInsercao(Arvore *arvore, int valor);
int incrementarEsforcoRemocao(Arvore *arvore, int valor);
int contabilizarEsforco(Arvore *arvore, int tipo);
void liberarNo(Arvore *arvore, No *no);
void liberarArvore(Arvore *arvore);
// void verificarArvore(Arvore *arvore);
// void imprimirEstado(No *no, No *nulo, int nivel);
// void imprimirValoresArvore(No *no, No *nulo);
void liberarNoB(No *no);

// Arvore_AVL.c
No *removerNoAVL(Arvore *arvore, No *no, int valor);
No *balancearAVL(Arvore *arvore, No *no, int tipoOperacao);
No *rse(Arvore *arvore, No *no);
No *rsd(Arvore *arvore, No *no);
No *rde(Arvore *arvore, No *no);
No *rdd(Arvore *arvore, No *no);
int altura(No *no);
int fb(No *no);
void atualizarAltura(No *no);
No *minimo(No *no, No *nulo);

// Arvore_RB.c
No *removerNoRB(Arvore *arvore, No *z, int valor);
void balancearRubroNegra(Arvore *arvore, No *no);
void transplantar(Arvore *arvore, No *u, No *v);
void balancearRemocao(Arvore *arvore, No *x);
void rotacionaresq(Arvore *arvore, No *no);
void rotacionardir(Arvore *arvore, No *no);

// Arvore_B.c
void percorreArvore(No *no, void(visita)(int chave));
No *localizaChave(Arvore *arvore, int chave);
int pesquisaBinaria(No *no, int chave);
int encontrarIndiceChave(No *no, int chave);
int obterSucessor(No *no);
No *balancearAposRemocao(Arvore *arvore, No *pai, int idx);
No *fundirNos(Arvore *arvore, No *pai, int idx);
int removeChaveIterativa(Arvore *arvore, int chave);
void imprimirArvoreB(No *no, int nivel);
int ehFolha(No *no);
int transbordo(Arvore *arvore, No *no);
void adicionaChaveNo(No *no, No *direita, int chave);
No *divideNo(Arvore *arvore, No *no);
void adicionaChaveRecursivo(Arvore *arvore, No *no, No *novoFilho, int chave);
int adicionaChave(Arvore *arvore, int chave);

int subfluxo(Arvore *arvore, No *no);
No *fundirComIrmaoEsquerdo(Arvore *arvore, No *pai, int idx);
No *fundirComIrmaoDireito(Arvore *arvore, No *pai, int idx);
int encontrarIndicePai(No *pai, No *filho);
No *emprestarDoIrmaoEsquerdo(No *pai, int idx, No *filho, No *irmaoEsq);
No *emprestarDoIrmaoDireito(No *pai, int idx, No *filho, No *irmaoDir);



// Arvore b
typedef struct BTreeNode {
    int n; // Número de chaves
    int *keys; // Chaves
    struct BTreeNode **children; // Ponteiros para os filhos
    int leaf; // 1 se for folha, 0 caso contrário
    int T;
} BTreeNode;

// Declaração de funções
BTreeNode* allocateNode(int leaf, int t);
void BTreeSplitChild(BTreeNode* x, int i);
void BTreeInsertNonFull(BTreeNode* x, int k);
int BTreeInsert(BTreeNode** root, int k);
void printTree(BTreeNode* root, int level);
int BTreeDelete(BTreeNode** root, int k);
void deleteFromLeaf(BTreeNode* x, int idx);
void deleteFromNonLeaf(BTreeNode* x, int idx);
int getPredecessor(BTreeNode* x, int idx);
int getSuccessor(BTreeNode* x, int idx);
void fill(BTreeNode* x, int idx);
void borrowFromPrev(BTreeNode* x, int idx);
void borrowFromNext(BTreeNode* x, int idx);
void merge(BTreeNode* x, int idx);

#endif