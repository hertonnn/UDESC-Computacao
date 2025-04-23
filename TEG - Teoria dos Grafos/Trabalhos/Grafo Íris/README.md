# Grafo-Flor-Íris

Este repositório contém a implementação de um modelo de agrupamento (clustering) utilizando grafos com base na base de dados Iris. O projeto foi desenvolvido na disciplina de **Teoria dos Grafos** do curso de Ciência da Computação da **UDESC - Joinville**, sob orientação do Prof. Gilmario Barbosa dos Santos.

## 📘 Descrição

A proposta é modelar cada observação da base Iris como um vértice de um grafo, onde as conexões (arestas) são estabelecidas com base em distâncias euclidianas normalizadas entre os dados. Após a construção do grafo, são realizadas análises de componentes conexos e clustering (K-Means), seguidas por uma avaliação estatística dos resultados com uso de métricas de aprendizado de máquina.

## 👨‍💻 Integrantes

- Adriano Pereira Silva  
- Herton Silveira  
- Victor Perim  

## 🧪 Tecnologias Utilizadas

- Linguagem C (construção do grafo, análise de componentes e métricas de avaliação, clustering com K-Means)
- Python (plotagem 2D/3D)
- Matplotlib / Seaborn (visualização)

## 🪻 Base de Dados

A base de dados utilizada é o famoso **Iris Dataset** de Fisher, contendo 150 amostras com atributos morfológicos de três espécies da flor íris:
![img-flores](https://github.com/hertonnn/UDESC-Computacao/blob/master/TEG%20-%20Teoria%20dos%20Grafos/Trabalhos/Grafo%20%C3%8Dris/src/imgs/flores.png?raw=true)

Cada amostra possui 4 atributos:
- Comprimento da sépala
- Largura da sépala
- Comprimento da pétala
- Largura da pétala

![img-atributos](https://github.com/hertonnn/UDESC-Computacao/blob/master/TEG%20-%20Teoria%20dos%20Grafos/Trabalhos/Grafo%20%C3%8Dris/src/imgs/base.png?raw=true)

## 🧮 Etapas do Projeto

### 🔹 1. Construção do Grafo
- Cada amostra = vértice
- Conexão entre vértices se a distância euclidiana normalizada ≤ 0.3
- Geração da matriz de adjacência

- Grafo obtido:

![grafo](https://github.com/hertonnn/UDESC-Computacao/blob/master/TEG%20-%20Teoria%20dos%20Grafos/Trabalhos/Grafo%20%C3%8Dris/src/imgs/grafo.png?raw=true)

### 🔹 2. Análise de Componentes Conexos
- Uso do algoritmo BFS para identificar agrupamentos (clusters)

### 🔹 3. Clustering com K-Means
- Implementação de K-Means
- Inicialização aleatória dos centroides
- Reatribuição de clusters até convergência
- Plotagem dos clusters em 2D e 3D

- Os dois grafos obtidos:
![img-grafos](https://github.com/hertonnn/UDESC-Computacao/blob/master/TEG%20-%20Teoria%20dos%20Grafos/Trabalhos/Grafo%20%C3%8Dris/src/imgs/componentes.png?raw=true)

### 🔹 4. Avaliação de Performance
- Geração de matriz de confusão
- Cálculo de acurácia (resultado: 98%)
- Análise crítica dos agrupamentos
- A matriz de confusão:
![matriz](https://github.com/hertonnn/UDESC-Computacao/blob/master/TEG%20-%20Teoria%20dos%20Grafos/Trabalhos/Grafo%20%C3%8Dris/src/imgs/m-confusao.png?raw=true)

## 📊 Resultados

- A espécie Setosa apresentou-se bem definida e separada
- Versicolor e Virginica apresentaram sobreposição
- Clustering atingiu **98% de acurácia**

## 📚 Referências

- [Wikipedia - Conjunto de dados flor Iris](https://pt.wikipedia.org/wiki/Conjunto_de_dados_flor_Iris)
- [GitHub - K-Means Iris Dataset](https://github.com/mayursrt/k-means-on-iris-dataset)
- [UFPR - Grafos e Otimização](https://docs.ufpr.br/~volmir/PO_II/A_5_A_grafos.pdf)
- [LAMFO/UnB - Introdução à clusterização](https://lamfo-unb.github.io/2017/10/05/Introducao_basica_a_clusterizacao/)
- [Primavera Garden - Íris, a Flor de Lis](https://www.primaveragarden.com.br/iris-a-flor-de-lis/)

---

**Universidade do Estado de Santa Catarina (UDESC)**  
**Departamento de Ciência da Computação – CCT/Joinville**

