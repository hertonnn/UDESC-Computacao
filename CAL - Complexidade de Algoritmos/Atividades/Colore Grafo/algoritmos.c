#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h> // Para atoi, exit

#define V 25 // Número de vértices

// --- Funções de Leitura e Impressão (Mantidas) ---

// Função para ler o arquivo CSV e preencher a matriz de adjacência
void lerGrafoDoCSV(const char *nomeArquivo, int grafo[V][V]) {
    FILE *arquivo = fopen(nomeArquivo, "r");
    if (arquivo == NULL) {
        perror("Erro ao abrir o arquivo CSV");
        exit(EXIT_FAILURE);
    }

    char linha[V * 2 + 2]; // V * 2 para os números e vírgulas, +2 para '\n' e '\0'
    int i = 0; // Índice da linha da matriz

    while (fgets(linha, sizeof(linha), arquivo) != NULL && i < V) {
        linha[strcspn(linha, "\n")] = 0; // Remover o caractere de nova linha

        char *token = strtok(linha, ",");
        int j = 0; // Índice da coluna da matriz

        while (token != NULL && j < V) {
            grafo[i][j] = atoi(token); // Converte a string para inteiro
            token = strtok(NULL, ",");
            j++;
        }
        i++;
    }

    fclose(arquivo);
}

// Função para imprimir a matriz de adjacência (opcional, para verificar)
void imprimirGrafo(int grafo[V][V]) {
    printf("Matriz de Adjacência:\n");
    for (int i = 0; i < V; i++) {
        for (int j = 0; j < V; j++) {
            printf("%d ", grafo[i][j]);
        }
        printf("\n");
    }
}

// --- Funções de Coloração Backtracking ( ---

// Função para verificar se uma cor pode ser atribuída a um vértice
bool pode_colorir_bt(int grafo[V][V], int cores[], int vertice, int cor) {
    for (int i = 0; i < V; i++) {
        if (grafo[vertice][i] == 1 && cores[i] == cor) {
            return false;  // Vértices adjacentes não podem ter a mesma cor
        }
    }
    return true;
}

// Função recursiva para tentar colorir o grafo com 'm' cores
bool colorir_grafo_bt(int grafo[V][V], int cores[], int vertice, int m) {
    if (vertice == V) {
        return true;  // Todos os vértices foram coloridos
    }

    // Tenta colorir o vértice com diferentes cores (de 1 a m)
    for (int cor = 1; cor <= m; cor++) {
        if (pode_colorir_bt(grafo, cores, vertice, cor)) {
            cores[vertice] = cor;
            if (colorir_grafo_bt(grafo, cores, vertice + 1, m)) {
                return true;
            }
            cores[vertice] = 0;  // Desfaz a coloração (backtrack)
        }
    }
    return false;  // Não é possível colorir com m cores
}

// --- Algoritmo Guloso para Coloração de Grafo ---

// Função para encontrar a menor cor disponível para um vértice
int encontrar_menor_cor_disponivel(int grafo[V][V], int cores[], int vertice, int max_cores_usadas_ate_agora) {
    // Vetor auxiliar para marcar cores já usadas pelos vizinhos
    bool cores_usadas[max_cores_usadas_ate_agora + 2]; // +2 para garantir espaço, caso o max_cores seja 0
    for (int k = 0; k < max_cores_usadas_ate_agora + 2; k++) {
        cores_usadas[k] = false;
    }

    // Marca as cores usadas pelos vizinhos do vértice atual
    for (int i = 0; i < V; i++) {
        if (grafo[vertice][i] == 1 && cores[i] != 0) { // Se for adjacente e já tiver cor
            if (cores[i] < max_cores_usadas_ate_agora + 2) { // Evita acesso inválido
                cores_usadas[cores[i]] = true;
            }
        }
    }

    // Encontra a menor cor disponível (começando de 1)
    for (int cor = 1; cor < max_cores_usadas_ate_agora + 2; cor++) {
        if (!cores_usadas[cor]) {
            return cor;
        }
    }
    return max_cores_usadas_ate_agora + 1; // Deve sempre encontrar uma cor, mas fallback para segurança
}


void colorir_grafo_guloso(int grafo[V][V], int cores[]) {
    // Inicializa todas as cores como 0 (sem cor)
    for (int i = 0; i < V; i++) {
        cores[i] = 0;
    }

    int max_cores_usadas = 0; // Para rastrear o número máximo de cores necessárias

    // Itera sobre cada vértice
    for (int vertice = 0; vertice < V; vertice++) {
        // Encontra a menor cor disponível para o vértice atual
        int cor_escolhida = encontrar_menor_cor_disponivel(grafo, cores, vertice, max_cores_usadas);
        cores[vertice] = cor_escolhida;

        if (cor_escolhida > max_cores_usadas) {
            max_cores_usadas = cor_escolhida;
        }
    }
}

// --- Main ---

int main() {
    int grafo[V][V]; // Matriz de adjacência para 25 nós

    // Inicializa a matriz com zeros
    for (int i = 0; i < V; i++) {
        for (int j = 0; j < V; j++) {
            grafo[i][j] = 0;
        }
    }

    // Nome do arquivo CSV (ou .txt, desde que o formato seja CSV)
    const char *nomeArquivo = "grafo_25nos.csv"; 

    // Chama a função para ler o grafo do arquivo CSV
    lerGrafoDoCSV(nomeArquivo, grafo);

    // Imprime o grafo para verificar se foi lido corretamente
    imprimirGrafo(grafo);

    // --- Coloração Gulosa ---
    int cores_guloso[V];
    printf("\n--- Coloração Gulosa ---\n");
    colorir_grafo_guloso(grafo, cores_guloso);

    int max_cor_guloso = 0;
    printf("Coloração do grafo (Guloso): \n");
    for (int i = 0; i < V; i++) {
        printf("Vértice %d -> Cor %d\n", i, cores_guloso[i]);
        if (cores_guloso[i] > max_cor_guloso) {
            max_cor_guloso = cores_guloso[i];
        }
    }
    printf("Número de cores usadas (Guloso): %d\n", max_cor_guloso);

    // --- Coloração Backtracking para o menor número de cores ---
    printf("\n--- Coloração com Backtracking (menor número de cores) ---\n");
    int cores_bt[V];
    int menor_m_bt = V; // Começa tentando com o numero de vertices(obviamente vai colorir) cor

    while (menor_m_bt > 1) { 
        // Inicializa as cores como 0 para cada nova tentativa de 'm'
        for (int i = 0; i < V; i++) {
            cores_bt[i] = 0;
        }

        printf("Tentando colorir com %i cores\n", menor_m_bt);
        if (colorir_grafo_bt(grafo, cores_bt, 0, menor_m_bt)) {
            printf("Foi possível colorir!\n");
            printf("Coloração do grafo (Backtracking): \n");
            for (int i = 0; i < V; i++) {
                printf("Vértice %d -> Cor %d\n", i, cores_bt[i]);
            }
        }
        menor_m_bt--;
    }

    return 0;
}