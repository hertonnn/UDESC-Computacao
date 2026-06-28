# Visualização 2D

Este documento aborda os algoritmos matemáticos básicos que desenham formas geométricas em telas pixeladas (Rasterização) e o processo de enquadramento da câmera e descarte (Clipping) dessas formas no ambiente bidimensional.

---

## 1. Rasterização: Como desenhar retas na matriz de Pixels?
O computador recebe comandos geométricos contínuos, como "desenhe uma reta de P1 a P2", mas a tela do computador é uma grade de quadradinhos discretos (pixels). Transformar equações em quadradinhos é a **Rasterização**. O desafio clássico é traçar retas perfeitas sem ficarem "esburacadas" e usando o menor processamento computacional possível.

### Algoritmo Incremental Analítico (DDA - Digital Differential Analyzer)
- **Método:** Baseado na equação matemática da reta ($y = mx + b$), onde $m$ é o coeficiente angular. Para cada coluna $X$, calcula-se analiticamente o valor exato de $Y$, e pinta-se o pixel mais próximo usando uma função de arredondamento (`round(Y)`).
- **Problema:** Usa amplamente divisão e aritmética de Ponto Flutuante (números com vírgula), o que custa muito tempo de CPU.

### Algoritmo do Ponto Médio (Bresenham)
- **Método:** Bresenham revolucionou a CG ao descobrir que não precisávamos calcular o $Y$ exato. Ao caminhar na linha, existem apenas dois pixels vizinhos possíveis para escolher: o pixel à Direita ou o pixel Diagonal-Direita-Cima. O algoritmo chuta o "Ponto Médio" exato entre esses dois vizinhos; se a reta teórica passar *acima* do ponto médio, o pixel superior deve ser pintado.
- **A Mágica:** Bresenham manipulou matematicamente o teste de "acima ou abaixo do ponto médio" para funcionar **100% com números inteiros** (sem divisão, sem ponto flutuante, apenas somas, subtrações e bit-shift). Isso permite que as retas sejam desenhadas a velocidades colossais diretamente no nível dos transistores de hardware.

## 2. Janela (Window) vs Visão (Viewport)
Quando um desenho é feito num papel virtual (com o tamanho que desejarmos), ele precisa ser mostrado na janela do sistema operacional.
- **Window (Mundo Virtual):** Qual pedaço do mundo numério eu quero focar?
- **Viewport (Mundo Físico):** Em qual pedaço da minha janela física/monitor do SO eu vou desenhar aquilo?
- **Mapeamento:** A passagem de Window para Viewport é sempre feita via uma escala diferencial e uma translação que amarra o canto inferior esquerdo virtual no físico, "espremendo" o desenho se as proporções não casarem (causando distorções de aspecto se $Width$ e $Height$ forem muito distintos).

## 3. Clipping: Cortando o que não se vê
Se há um traço enorme, mas só um pedacinho dele passa pela janela da câmera, mandar a reta inteira para Bresenham calcular custaria desempenho inútil. O algoritmo detecta as sobras e as "corta" (Clipping), enviando para rasterizar apenas o filete visível.

### Algoritmo de Cohen-Sutherland (Line Clipping)
- **O Código (Outcode):** A câmera divide o universo em 9 zonas. A janela da câmera é a zona central e ganha o código binário `0000`. As zonas ao redor ganham bandeiras Top, Bottom, Right, Left.
  - (Ex: Cima à esquerda é `1001`, que significa $Top=1, Bottom=0, Right=0, Left=1$).
- **O Teste Inteligente:**
  - **Aceitação Trivial:** Se ambos os vértices $P1$ e $P2$ da reta têm o código `0000`, a linha está inteira na tela. Mande pro Bresenham!
  - **Rejeição Trivial:** Se fizermos um "AND" binário (`&`) entre o código de $P1$ e o de $P2$ e o resultado der qualquer coisa diferente de `0000`, significa que eles compartilham uma mesma "parede" invisível fora da câmera e não cortam a tela. Jogue fora imediatamente!
  - **Cálculo da Intersecção:** Se der `0000` no AND e `!= 0000` no OR lógico, a reta atravessa a borda e precisa ser cortada através de cálculos analíticos de intersecção no limite exato da parede. É um processo recursivo fantástico e veloz.
