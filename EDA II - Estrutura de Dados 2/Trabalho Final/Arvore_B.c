#include <stdio.h>
#include <stdlib.h>
#include "header.h"

// esforço
int esforcoInsert;
int esforcoDelete;

// Função para alocar um novo nó
BTreeNode* allocateNode(int leaf, int t) {
    BTreeNode* node = (BTreeNode*)malloc(sizeof(BTreeNode));
    node->n = 0;
    node->T = t;
    node->leaf = leaf;
    node->keys = (int*)malloc((2 * t - 1) * sizeof(int));
    node->children = (BTreeNode**)malloc(2 * t * sizeof(BTreeNode*));
    for (int i = 0; i < 2 * t; i++) {
        node->children[i] = NULL;
    }
    return node;
}
// Divide um nó cheio
void BTreeSplitChild(BTreeNode* x, int i) {
    BTreeNode* z = allocateNode(x->children[i]->leaf, x->T);
    BTreeNode* y = x->children[i];
    int T = x->T;
    z->n = T - 1;

    for (int j = 0; j < T - 1; j++) {
        z->keys[j] = y->keys[j + T];
    }

    if (!y->leaf) {
        for (int j = 0; j < T; j++) {
            z->children[j] = y->children[j + T];
        }
    }

    y->n = T - 1;

    for (int j = x->n; j >= i + 1; j--) {
        x->children[j + 1] = x->children[j];
    }
    x->children[i + 1] = z;

    for (int j = x->n - 1; j >= i; j--) {
        x->keys[j + 1] = x->keys[j];
    }
    x->keys[i] = y->keys[T - 1];

    x->n += 1;

    esforcoInsert += 1;
}

// Insere em um nó não cheio
void BTreeInsertNonFull(BTreeNode* x, int k) {
    int i = x->n - 1;
    int T = x->T;

    if (x->leaf) {
        while (i >= 0 && k < x->keys[i]) {
            x->keys[i + 1] = x->keys[i];
            i--;
        }
        x->keys[i + 1] = k;
        x->n += 1;
    } else {
        while (i >= 0 && k < x->keys[i]) {
            i--;
        }
        i++;
        if (x->children[i]->n == 2 * T - 1) {
            BTreeSplitChild(x, i);
            if (k > x->keys[i]) {
                i++;
            }
        }
        BTreeInsertNonFull(x->children[i], k);
        esforcoInsert += 1;
    }
}

// Insere uma chave na B-Tree
int BTreeInsert(BTreeNode** root, int k) {
    BTreeNode* r = *root;
    esforcoInsert = 0;

    if (r->n == 2 * r->T - 1) {
        BTreeNode* s = allocateNode(0, r->T);
        *root = s;
        s->children[0] = r;
        BTreeSplitChild(s, 0);
        BTreeInsertNonFull(s, k);
    } else {
        BTreeInsertNonFull(r, k);
    }

    return esforcoInsert;
}

// Remove uma chave da B-Tree
int BTreeDelete(BTreeNode** root, int k) {
    BTreeNode* x = *root;
    int idx = 0;

    esforcoDelete = 0;

    while (idx < x->n && k > x->keys[idx]) {
        idx++;
    }

    if (idx < x->n && x->keys[idx] == k) {
        if (x->leaf) {
            deleteFromLeaf(x, idx);
        } else {
            deleteFromNonLeaf(x, idx);
        }
    } else {
        if (x->leaf) {
            printf("Chave %d não encontrada na árvore.\n", k);
            return 0;
        }

        int flag = (idx == x->n);

        if (x->children[idx]->n < x->T) {
            fill(x, idx);
        }

        if (flag && idx > x->n) {
            BTreeDelete(&(x->children[idx - 1]), k);
        } else {
            BTreeDelete(&(x->children[idx]), k);
        }
        esforcoDelete += 1;
    }

    if (x->n == 0) {
        BTreeNode* temp = x;
        if (x->leaf) {
            *root = NULL;
        } else {
            *root = x->children[0];
        }
        free(temp);
    }

    return esforcoDelete;
}

void deleteFromLeaf(BTreeNode* x, int idx) {
    esforcoDelete += 1;
    for (int i = idx + 1; i < x->n; ++i) {
        x->keys[i - 1] = x->keys[i];
    }
    x->n--;
}

void deleteFromNonLeaf(BTreeNode* x, int idx) {
    esforcoDelete += 1;
    int k = x->keys[idx];

    if (x->children[idx]->n >= x->T) {
        int pred = getPredecessor(x, idx);
        x->keys[idx] = pred;
        BTreeDelete(&(x->children[idx]), pred);
    } else if (x->children[idx + 1]->n >= x->T) {
        int succ = getSuccessor(x, idx);
        x->keys[idx] = succ;
        BTreeDelete(&(x->children[idx + 1]), succ);
    } else {
        merge(x, idx);
        BTreeDelete(&(x->children[idx]), k);
    }
}

int getPredecessor(BTreeNode* x, int idx) {
    BTreeNode* cur = x->children[idx];
    while (!cur->leaf) {
        cur = cur->children[cur->n];
    }
    return cur->keys[cur->n - 1];
}

int getSuccessor(BTreeNode* x, int idx) {
    BTreeNode* cur = x->children[idx + 1];
    while (!cur->leaf) {
        cur = cur->children[0];
    }
    return cur->keys[0];
}

void fill(BTreeNode* x, int idx) {
    if (idx != 0 && x->children[idx - 1]->n >= x->T) {
        borrowFromPrev(x, idx);
    } else if (idx != x->n && x->children[idx + 1]->n >= x->T) {
        borrowFromNext(x, idx);
    } else {
        if (idx != x->n) {
            merge(x, idx);
        } else {
            merge(x, idx - 1);
        }
    }
}

void borrowFromPrev(BTreeNode* x, int idx) {
    BTreeNode* child = x->children[idx];
    BTreeNode* sibling = x->children[idx - 1];

    for (int i = child->n - 1; i >= 0; --i) {
        child->keys[i + 1] = child->keys[i];
    }

    if (!child->leaf) {
        for (int i = child->n; i >= 0; --i) {
            child->children[i + 1] = child->children[i];
        }
    }

    child->keys[0] = x->keys[idx - 1];

    if (!child->leaf) {
        child->children[0] = sibling->children[sibling->n];
    }

    x->keys[idx - 1] = sibling->keys[sibling->n - 1];

    child->n += 1;
    sibling->n -= 1;
}

void borrowFromNext(BTreeNode* x, int idx) {
    BTreeNode* child = x->children[idx];
    BTreeNode* sibling = x->children[idx + 1];

    child->keys[child->n] = x->keys[idx];

    if (!child->leaf) {
        child->children[child->n + 1] = sibling->children[0];
    }

    x->keys[idx] = sibling->keys[0];

    for (int i = 1; i < sibling->n; ++i) {
        sibling->keys[i - 1] = sibling->keys[i];
    }

    if (!sibling->leaf) {
        for (int i = 1; i <= sibling->n; ++i) {
            sibling->children[i - 1] = sibling->children[i];
        }
    }

    child->n += 1;
    sibling->n -= 1;
}

void merge(BTreeNode* x, int idx) {
    BTreeNode* child = x->children[idx];
    BTreeNode* sibling = x->children[idx + 1];

    int T = x->T;

    child->keys[T - 1] = x->keys[idx];

    for (int i = 0; i < sibling->n; ++i) {
        child->keys[i + T] = sibling->keys[i];
    }

    if (!child->leaf) {
        for (int i = 0; i <= sibling->n; ++i) {
            child->children[i + T] = sibling->children[i];
        }
    }

    for (int i = idx + 1; i < x->n; ++i) {
        x->keys[i - 1] = x->keys[i];
    }

    for (int i = idx + 2; i <= x->n; ++i) {
        x->children[i - 1] = x->children[i];
    }

    child->n += sibling->n + 1;
    x->n--;

    free(sibling);
}

// Função para imprimir a B-Tree
void printTree(BTreeNode* root, int level) {
    if (root != NULL) {
        printf("Nível %d: ", level);
        for (int i = 0; i < root->n; i++) {
            printf("%d ", root->keys[i]);
        }
        printf("\n");
        for (int i = 0; i <= root->n; i++) {
            printTree(root->children[i], level + 1);
        }
    }
}

// // Função principal
// int main() {
//     printf("Digite o grau da B-Tree (T >= 2): ");
//     scanf("%d", &T);

//     if (T < 2) {
//         printf("O grau mínimo deve ser 2.\n");
//         return 1;
//     }

//     BTreeNode* root = allocateNode(1); // Cria a raiz como uma folha

//     int values[] = {10, 20, 5, 6, 12, 30, 7, 17};
//     int size = sizeof(values) / sizeof(values[0]);

//     for (int i = 0; i < size; i++) {
//         BTreeInsert(&root, values[i]);
//     }

//     printf("Estrutura inicial da B-Tree:\n");
//     printTree(root, 0);

//     BTreeDelete(&root, 6);
//     printf("\nApós deletar 6:\n");
//     printTree(root, 0);

//     return 0;
// }