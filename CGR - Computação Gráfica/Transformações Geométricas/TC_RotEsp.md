# Trabalho Complementar - Rotação no Espaço 3D (Eixo Arbitrário)

Este documento registra as diretrizes clássicas do Trabalho Complementar envolvendo as complexidades da rotação em um eixo que não está alinhado com o centro do mundo (Origem).

---

## 1. O Desafio
O OpenGL (ou qualquer motor gráfico básico) possui funções para rotacionar objetos nos Eixos X, Y ou Z. Mas o que acontece se precisarmos girar um objeto ao redor de um eixo "inclinado" que está flutuando no meio do espaço (um Eixo Arbitrário)? 

O desafio deste Trabalho Complementar é aplicar, via software, os conceitos de **Composição de Transformações** para simular esse giro sem usar funções de alto nível pré-prontas que rotacionem ao redor de vetores arbitrários diretamente.

## 2. Passo a Passo da Solução
A solução clássica envolve 5 etapas de matrizes compostas (aplicadas na ordem inversa da lógica computacional devido à regra da Pilha de Matrizes):

1. **Translação (Ida):** Mova todo o universo de forma que o eixo de rotação arbitrário seja arrastado até colidir com a Origem $(0,0,0)$ do mundo.
2. **Rotações de Alinhamento (Ida):** O eixo arbitrário, agora na origem, ainda está inclinado. Aplique matrizes de rotação padrão em $X$ e $Y$ para alinhar este eixo perfeitamente em cima do eixo $Z$ do mundo.
3. **A Rotação Desejada:** Agora que seu eixo arbitrário é literalmente o Eixo $Z$, você pode executar a rotação do objeto tranquilamente usando a matriz de Rotação Z padrão pelo ângulo $\theta$ desejado.
4. **Rotações de Desalinhamento (Volta):** Aplique as rotações inversas (ângulos negativos) do Passo 2 para entortar/inclinar o eixo arbitrário de volta à sua inclinação original.
5. **Translação (Volta):** Desfaça a Translação do Passo 1 arrastando o eixo (e o objeto que acabou de girar junto com ele) de volta para o ponto onde ele flutuava no meio do espaço.

Ao final, todo esse conjunto é reduzido numa única Matriz Resultante 4x4. O aluno deve demonstrar proficiência em álgebra linear matricial e coordenadas homogêneas compreendendo a ordem matemática desse processo!
