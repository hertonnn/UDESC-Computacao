# Análise de Estruturas de Dados Balanceadas

Trabalho final da disciplina de **Estrutura de Dados II**, com foco na análise das operações de **inserção** e **remoção** em três tipos de árvores balanceadas: **AVL**, **Rubro-Negra (Red-Black)** e **Árvore B**.

## 📌 Objetivo

Avaliar e comparar a **complexidade algorítmica** das operações de inserção e remoção, considerando o balanceamento interno de cada estrutura de árvore.

## 👨‍💻 Autores

- Adriano Silva  
- Gustavo Gonçalves  
- Herton da Silveira  
- Matheus Freitas  
- Victor Alexandre Perim  

Joinville-SC — 2024  
Centro de Ciências Tecnológicas – CCT  
Ciência da Computação

---

## 🧱 Estrutura do Código

### Base de Código

- Todas as `structs` das árvores foram unificadas para facilitar a reutilização e modularização.
- Funções compartilhadas foram adaptadas para suportar múltiplas árvores.
- Foi criada uma função geradora de árvores de base com dados randômicos.

---

## ⚙️ Funcionalidades

### `incrementarEsforcoInsercao`
Calcula o esforço de inserção baseado na árvore utilizada:

- **AVL**: usa `esforcoInserirAVL`.
- **Rubro-Negra**: usa `esforcoInserirRB`.

### `incrementarEsforcoRemocao`
Calcula o esforço de remoção da árvore:

- Reseta o contador de esforço.
- Executa a remoção.
- Retorna o esforço computado.

### `contabilizarEsforco`
Contabiliza e retorna o esforço de inserção ou remoção:

- Suporta AVL e Rubro-Negra.
- Não aplicável para árvores B.

---

## 🌳 Estruturas de Dados Implementadas

### AVL
- Árvore Binária de Busca balanceada.
- Complexidade: `O(log n)` em inserção e remoção.
- Remoções envolvem atualização de altura e rotações.

### Rubro-Negra
- Utiliza cores e rotações para manter balanceamento.
- Altura máxima: `2 * log₂(n)`.
- Operações envolvem: `transplantar`, `balancearRubroNegra`, `balancearRemocao`.

### Árvore B
- Utilizada em bases de dados e sistemas de arquivos.
- Nós com múltiplos filhos.
- A remoção pode envolver fusão de nós ou redistribuição de chaves (`fundirNos`, `balancearAposRemocao`).

---

## 📚 Discussão Teórica

![img-remocao]()
![img-insercao]()

| Estrutura     | Altura Máxima        | Vantagem                                                  |
|---------------|----------------------|------------------------------------------------------------|
| AVL           | ~1.44 * log₂(n)      | Melhor desempenho em buscas rápidas                        |
| Rubro-Negra   | ≤ 2 * log₂(n)        | Inserção/remoção com menos rotações                        |
| Árvore B      | O(logₘ(n))           | Ideal para grande volume de dados (menos acessos a disco) |

- As operações em todas as estruturas mantêm complexidade **logarítmica**.
- Árvores B são mais eficientes em larga escala por diminuírem a altura da árvore.

---

## 📊 Análise Gráfica

- Os dados coletados foram representados em **nuvens de pontos**.
- Curvas de ajuste: `α * log₂(n)` para representar o comportamento teórico.
- **AVL**: maior esforço devido ao balanceamento rigoroso.
- **Rubro-Negra** e **B**: esforço menor, principalmente com aumento da ordem da árvore B.

---

## 🧠 Conclusão

- **AVL**: indicada para aplicações que exigem **buscas eficientes**, mas com custo maior de manutenção.
- **Rubro-Negra**: bom equilíbrio entre **eficiência e simplicidade**.
- **Árvore B**: mais adequada para **grandes volumes de dados**, especialmente em ambientes com acesso a disco.

---

## 🛠️ Como Usar

1. Compile o código com `gcc` ou outro compilador C.
2. Execute os testes de inserção e remoção.
3. Analise os resultados de esforço computado via logs ou gráficos (se implementado).

---


