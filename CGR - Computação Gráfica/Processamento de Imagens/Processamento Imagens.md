# Resumo de Processamento de Imagens

Este documento traz um resumo dos conceitos apresentados sobre Processamento de Imagens, uma área que altera e aprimora imagens visando facilitar sua utilização posterior (como em sistemas de Visão Computacional) ou para fins estéticos e de síntese visual.

## 1. Operações Básicas com Imagens
As operações mais comuns aplicadas a imagens incluem:
* **Filtros:** Suavização, Realce e Transformações diversas.
* **Operadores Morfológicos:** Abertura, Fechamento e Gradiente.
* **Extração de Características:** Coleta de descritores globais e locais da imagem.

### Convolução Discreta 2D
É a técnica base para a aplicação de muitos filtros espaciais (máscaras).
* Posiciona-se o centro de uma máscara (como uma matriz 3x3) sobre um pixel.
* Calcula-se uma média ponderada dos pixels vizinhos baseando-se nos valores da máscara.
* O pixel central resultante ganha essa nova "média".
* **Filtros de Convolução Comuns:** Média (passa-baixa/suavização), Laplaciana (passa-alta), Gaussiana, Sobel (excelente para detectar bordas) e filtros de Nitidez (*Sharpen*).

## 2. Transformadas (Fourier e Wavelets)

### Transformada de Fourier (FT)
Baseia-se na teoria de que qualquer sinal pode ser expresso por uma soma de senos e cossenos. Nas imagens, essas são variações da intensidade luminosa.
* Ela leva a imagem do **domínio espacial** para o **domínio da frequência**.
* Muito útil para descobrir *quão frequentemente* certas intensidades aparecem, facilitando a aplicação de filtros globais.
* **FFT (Fast Fourier Transform):** Algoritmo que otimiza o cálculo da transformada para $O(n \log n)$.
* É ótima para sinais que não mudam no tempo, mas sofre com o **Princípio da Incerteza**: ao aumentar o detalhamento no domínio da frequência, perde-se a precisão de *onde* aquilo ocorre na imagem.

### Transformada de Wavelets
Proposta para contornar o problema de Fourier, as *Ondaletas* (Wavelets) permitem que escolhamos a melhor combinação de detalhamento entre espaço e frequência para um dado objetivo (multirresolução).

## 3. Morfologia Matemática
Criada nos anos 60, serve para analisar a geometria de objetos em imagens binárias e em tons de cinza. Aplica-se um "elemento estruturante" sobre a imagem original. 
As duas operações mais primitivas são:
* **Dilatação:** "Engorda" o objeto e expande as bordas.
* **Erosão:** "Emagrece" o objeto e encolhe as bordas.
Combinando essas duas sequencialmente, criam-se as operações de **Abertura** e **Fechamento**, que são ótimas para remover ruídos pequenos sem afetar drasticamente o formato geral.

## 4. Extração de Características
É a base para sistemas que buscam e recuperam informações visuais. Os descritores extraídos podem ser:
* **Globais:** Analisam a imagem como um todo (baseado em cor, textura, formato).
* **Locais:** Calculados apenas em regiões ao redor de pontos de interesse ou contornos (Ex: SIFT, SURF).

### Principais Categorias de Descritores Globais:
1. **Cor:** Muito robusto (independe de tamanho ou orientação). Sistemas preferem espaços de cores uniformes perceptualmente (como $L^*u^*v^*, L^*a^*b^*$), já que no RGB tradicional a distância euclidiana nem sempre reflete a diferença real de cor.
2. **Textura:** Captura a periodicidade e direção dos padrões visuais (como nuvens ou pelos). Os picos no espectro de Fourier são muito utilizados para medir essa direção e frequência.
3. **Forma:** Medidas desde o perímetro e compacidade até pontos de maior curvatura (saliências) do objeto.

## 5. Rotulação e Grafos
Uma imagem pode ser modelada como um Grafo, onde cada *pixel* é um nó e as arestas são os pixels vizinhos (vizinhança de 4 ou 8). 
Com essa modelagem computacional, podemos facilmente rotular e identificar "ilhas" de pixels conectados na imagem utilizando algoritmos tradicionais de teoria dos grafos (como a busca em largura - BFS).

## 6. Preprocessamento e Ajustes
Antes de extrair características e trabalhar com a imagem, costuma-se aplicar um pré-processamento para:
* Corrigir a iluminação.
* Remover ruídos indesejados (ruído destrói a continuidade de algoritmos detectores de linhas, como a Transformada de Hough).
* Ajustar problemas de escala e rotação de perspectiva, para padronizar o que está sendo visto pelo sistema computacional.
