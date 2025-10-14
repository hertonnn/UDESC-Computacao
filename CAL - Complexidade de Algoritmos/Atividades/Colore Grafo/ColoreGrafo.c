#include <stdio.h>
#include <stdbool.h>

#define V 5  // Número de vértices no grafo

// Função para verificar se uma cor pode ser atribuída a um vértice
bool pode_colorir(int grafo[V][V], int cores[], int vertice, int cor) {
    for (int i = 0; i < V; i++) {
        if (grafo[vertice][i] == 1 && cores[i] == cor) {
            return false;  // Vértices adjacentes não podem ter a mesma cor
        }
    }
    return true;
}

// Função recursiva para tentar colorir o grafo
bool colorir_grafo(int grafo[V][V], int cores[], int vertice, int m) {
    if (vertice == V) {
        return true;  // Todos os vértices foram coloridos
    }

    // Tenta colorir o vértice com diferentes cores
    for (int cor = 1; cor <= m; cor++) {
        if (pode_colorir(grafo, cores, vertice, cor)) {
            cores[vertice] = cor;
            if (colorir_grafo(grafo, cores, vertice + 1, m)) {
                return true;
            }
            cores[vertice] = 0;  // Desfaz a coloração (backtrack)
        }
    }
    return false;  // Não é possível colorir com m cores
}

int main() {
    // Grafo representado por uma matriz de adjacência (1 se houver aresta, 0 se não houver)
    int grafo[V][V] = {
        {0, 1, 1, 1, 0},
        {1, 0, 1, 0, 1},
        {1, 1, 0, 1, 0},
        {1, 0, 1, 0, 1},
        {0, 1, 0, 1, 0}
    };

    int m = 3;  // Número de cores permitidas
    int cores[V];  // Vetor que armazena a cor de cada vértice

    // Inicializa as cores como 0 (sem cor)
    for (int i = 0; i < V; i++) {
        cores[i] = 0;
    }

    // Chama a função recursiva para tentar colorir o grafo
    if (colorir_grafo(grafo, cores, 0, m)) {
        printf("Coloração do grafo encontrada: \n");
        for (int i = 0; i < V; i++) {
            printf("Vértice %d -> Cor %d\n", i, cores[i]);
        }
    } else {
        printf("Não é possível colorir o grafo com %d cores.\n", m);
    }

    return 0;
}
