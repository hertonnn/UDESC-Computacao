# Geometria Computacional

Este documento contém um resumo com minhas próprias palavras dos principais tópicos abordados no material de Geometria Computacional.

## O que é Geometria Computacional?
A Geometria Computacional é uma área focada na busca por algoritmos e estruturas de dados eficientes para a resolução de problemas geométricos que escalam em tamanho. Suas aplicações práticas são vastas e englobam Computação Gráfica, Robótica, Sistemas de Informação Geográfica (SIG) e projetos de CAD/CAM.

## Tópicos e Algoritmos Principais

### 1. Sobreposição de Mapas Temáticos (Interseção de Linhas)
* **O Problema:** Como encontrar todas as interseções entre vários segmentos de linha, algo muito comum ao sobrepor mapas (ex: ruas cruzando com rios).
* **Solução:** O método bruto testa todos os pares de linhas, gerando uma complexidade alta. A abordagem inteligente utiliza o algoritmo de **Plane Sweep (Varredura de Plano)**. Uma linha de varredura imaginária percorre o cenário e o algoritmo só testa interseções entre os segmentos que estão adjacentes nesse momento, otimizando muito o desempenho.

### 2. Envoltória Convexa (Convex Hull)
* **O Problema:** Dado um conjunto de pontos (uma nuvem), encontrar o menor polígono convexo que engloba todos esses pontos (imagine esticar um elástico ao redor de todos os pontos e soltá-lo).
* **Solução:** Existem várias formas de resolver. Soluções rudimentares testam a direcionalidade de cada ponto em relação aos segmentos (chegando a $O(n^3)$). Soluções eficientes muitas vezes envolvem pré-ordenar os pontos cronológica ou angularmente, permitindo encontrar a envoltória em tempo otimizado ($O(n \log n)$).

### 3. Problema da Galeria de Arte (O Museu)
* **O Problema:** Qual é o número mínimo de guardas estacionários para ter visibilidade de todos os cantos de um museu, cujo formato é um polígono simples de $n$ vértices?
* **Solução (Teorema):** É provado matematicamente que precisamos de, no máximo, $\lfloor n/3 \rfloor$ guardas.
* O processo de determinação envolve **Triangulação** (dividir o polígono em $n-2$ triângulos usando diagonais) e, em seguida, a aplicação de coloração de grafos com 3 cores. Os guardas são posicionados na cor que menos foi utilizada.

### 4. Triangulação de Delaunay
* **O que é:** É a "melhor" triangulação possível para uma nuvem de pontos, muito utilizada na geração de malhas em 3D.
* **Propriedade Fundamental:** Ela obedece à regra do circuncírculo vazio: nenhum ponto da nuvem pode estar dentro da circunferência circunscrita formada por qualquer triângulo da malha. Isso maximiza os ângulos internos, evitando triângulos distorcidos ou alongados.
* Uma curiosidade é que a triangulação de Delaunay em 2D pode ser calculada projetando os pontos em um paraboloide em 3D e extraindo a Envoltória Convexa (Convex Hull) dessa projeção, uma relação matemática lindíssima.

### 5. Diagrama de Voronoi
* **O que é:** Uma forma de subdividir o espaço em diversas células convexas em torno de pontos de origem, chamados de "sítios". Qualquer posição dentro da célula de um sítio está mais próxima desse sítio do que de qualquer outro no mapa.
* **Construção:** É feito a partir das mediatrizes (bissetores) de distâncias. Uma célula de Voronoi nada mais é que a interseção de múltiplos semi-espaços limitados por esses bissetores. 
* Um dos algoritmos mais famosos e rápidos para computá-lo também usa *Plane Sweep*, sendo chamado de **Algoritmo de Fortune** ($O(n \log n)$).

### 6. LOD (Level Of Detail - Nível de Detalhe)
* Conceito de Computação Gráfica que dita que, se um objeto está muito longe do observador, podemos renderizar uma malha com uma quantidade drasticamente menor de triângulos, economizando processamento computacional sem afetar perceptivelmente a visualização.

### 7. Problema do Molde
* Foca na análise e na descoberta de direções viáveis para conseguir extrair um objeto sólido de dentro de um molde em uma única peça rígida através de simples translação (sem rotacionar).

### 8. Movimento de Robôs
* Trabalha com o "Espaço de Configuração". Em vez de calcular colisões com o formato real do robô percorrendo o mapa, é mais fácil aplicar a **Soma de Minkowski**, que essencialmente dilata todos os obstáculos (paredes) do cenário pelo tamanho do raio do robô.
* Com esse mapa de obstáculos "engordados", o robô passa a ser simulado como se fosse apenas um pequeno "ponto" no espaço, simplificando bastante a busca por rotas de caminho mais curto, como no algoritmo A*.

### 9. Árvores BSP (Binary Space Partitioning)
* Estrutura que divide o mundo recursivamente usando planos. É excelente para calcular visibilidade 3D de cenários poligonais.
