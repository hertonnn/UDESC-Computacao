# Resumo de Redes Neurais Convolucionais

Este documento traz um resumo dos conceitos apresentados nos slides sobre Redes Neurais Convolucionais (CNNs) na disciplina de Computação Gráfica.

## 1. Classificação Linear e Perceptron
Antes de entrar nas CNNs propriamente ditas, é preciso entender as bases:
* **LDA (Análise Discriminante Linear):** Técnica que busca projetar os dados em um espaço onde as classes fiquem o mais separadas possível.
* **Funções Discriminantes Lineares:** Funções que traçam hiperplanos para separar classes no espaço de características.
* **Perceptron:** O neurônio artificial mais simples, que recebe entradas ponderadas, soma tudo e aplica uma função de ativação para produzir uma saída. É a unidade fundamental das Redes Neurais Artificiais (RNAs).

## 2. O que é uma CNN?
As Redes Neurais Convolucionais são inspiradas no modelo biológico da visão humana e utilizam o conceito de redes multi-camadas. Foram idealizadas no início dos anos 90 por Yann LeCun, mas ganharam força após 2006 com a popularização das GPUs, que permitiram treinar modelos cada vez maiores.
* O treinamento requer alto custo computacional e um volume grande de dados (às vezes necessitando técnicas de aumento de dados artificiais — *Data Augmentation*).

## 3. Camadas de uma CNN
Uma CNN é composta por camadas empilhadas sequencialmente:

### Camada Convolucional
* Os neurônios desta camada compartilham os mesmos pesos para realizar a operação de convolução (mesma ideia dos filtros de processamento de imagens).
* Todos os neurônios detectam a mesma característica (bordas, texturas, etc.) em todas as posições da imagem, o que pode ser paralelizado em GPU.
* O número de filtros (convoluções) é um parâmetro da rede. Em vez de escolhermos manualmente os kernels, a rede **aprende sozinha** quais são os melhores filtros durante o treinamento.
* Em imagens coloridas, o filtro é aplicado em cada canal de cor separadamente.

### Camada de Ativação (ReLU)
* Aplica uma função de ativação não linear sem saturação: $f(x) = max(0, x)$.
* Alternativas incluem $tanh(x)$ e a função sigmóide, mas a ReLU é favorita por ser muito mais rápida.
* Aumenta as propriedades não lineares da rede sem afetar os valores da convolução.

### Camada de Pooling
* Realiza a subamostragem (redução de escala) dos mapas de características, diminuindo a quantidade de dados por filtro.
* Tipos comuns: Max Pooling (pega o valor máximo da janela) e Average Pooling (média).
* A redução de escala não altera significativamente a representação dos objetos.

### Camada Fully-Connected (FC)
* É a camada final da rede, uma MLP densa tradicional.
* Funciona como o classificador propriamente dito, tomando as características extraídas pelas camadas anteriores e mapeando-as para as classes de saída.

## 4. Treinamento
O processo de treinamento segue os passos:
1. Inicialização aleatória dos filtros e pesos da camada FC.
2. Fase de aprendizado (pode levar horas ou dias, com uso extenso de GPUs ou nuvens).
3. Validação e ajuste dos pesos via **Backpropagation**.
4. Armazenamento dos pesos e filtros otimizados ao longo do processo.

## 5. Redes Famosas

### LeNet-5 (1998)
* Primeira CNN implementada e testada com sucesso (Bell Labs, Yann LeCun).
* Aplicação: reconhecimento de dígitos manuscritos (dataset MNIST — 10 classes).
* 60 mil imagens de treino, 10 mil de teste, ~60 mil parâmetros, erro de apenas 0.95%.

### AlexNet (2012)
* Criada por Alex Krizhevsky, venceu o ImageNet 2012 Challenge (1000 classes) com erro de 15.3%, enquanto o segundo colocado (baseado em SIFT) tinha 26.2%.
* 1.2 milhão de imagens de treino, 60 milhões de parâmetros.
* Treinamento: 6 dias em 2 GPUs NVidia GTX 580 3GB.

### GoogLeNet (2014)
* Venceu o ImageNet 2014 com erro de 6.67%.
* Custo computacional apenas 2x maior que a AlexNet.
* Introduziu o conceito de **Inceptions** (redes dentro de redes), com 256 a 1024 filtros por módulo.

## 6. Ferramentas e APIs
Para quem não quer construir uma CNN do zero, existem serviços prontos:
* **Google Cloud Vision:** API REST baseada em TensorFlow, detecta rostos, objetos, OCR.
* **IBM Watson Visual Recognition:** Suporta treino de classes personalizadas, detecção NSFW e OCR.
* **Clarifai:** API REST com módulos específicos para alimentos, viagens, etc.

Para soluções personalizadas, bibliotecas como **Caffe, Torch, Keras, TensorFlow, MxNet** e **DeepLearning4J** permitem que o desenvolvedor foque nos modelos de treinamento.

## 7. Desvantagens
* As camadas convolucionais consomem mais de 67% do tempo computacional total.
* CNNs são aproximadamente 3x mais lentas que uma rede totalmente conectada do mesmo tamanho.
* Requerem grandes volumes de dados para treinamento (podendo necessitar Data Augmentation).
