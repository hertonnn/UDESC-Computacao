# Resumo de Curvas e Superfícies

Este documento apresenta um resumo dos principais conceitos abordados nos slides sobre Curvas e Superfícies, da disciplina de Computação Gráfica.

## 1. Representação de Curvas
As curvas podem ser representadas computacionalmente de três maneiras principais:
* **Arrays de Coordenadas:** Difícil controle e ocupa muita memória.
* **Equações Analíticas:** Podem ser **implícitas** (ex: $F(x,y,z)=0$, onde uma mesma equação pode ter múltiplas soluções não desejadas) ou **explícitas** (ex: $x=F(y,z)$, ruins para curvas fechadas).
* **Equações Paramétricas:** Expressam a curva com base em um parâmetro extra $t$ ou $u$. Essa é a melhor forma para Computação Gráfica, pois é independente do sistema de coordenadas, facilita o cálculo computacional através de matrizes e as transformações geométricas (como rotação e escala) podem ser aplicadas com facilidade.

## 2. Definições e Características
Para modelar curvas paramétricas, definem-se alguns conceitos base:
* **Pontos de Controle (PC):** Os pontos que guiam o formato da curva. A curva em si é gerada calculando os **Pontos de Traçado**.
* **Grau da Curva:** Dita a suavidade e flexibilidade da curva. A curva de grau **Cúbico** (grau 3) é a mais utilizada na prática, pois permite mudanças de concavidade (inflexão) sem ser tão pesada e demorada quanto uma curva bi-quadrática.

### Comportamentos:
* **Curvas Interpoladoras:** O traçado da curva passa exatamente por cima de todos os pontos de controle (Ex: Spline, Hermite, Catmull-Rom).
* **Curvas Aproximadoras:** A curva apenas "tende" ou é "atraída" em direção aos pontos de controle, mas não necessariamente passa por cima deles (Ex: Bézier, B-Spline, NURBS).
* **Controle Local vs Global:** Se ao movermos um ponto de controle apenas um trecho da curva mudar, ela tem controle local. Se a curva inteira for alterada, tem controle global.

## 3. Famílias de Curvas (As principais)

### Curvas de Hermite (Interpoladora)
Curvas modeladas através da definição de dois Pontos de Controle e dois vetores Tangentes para guiar a inclinação nos pontos iniciais e finais da curva.

### Catmull-Rom (Interpoladora)
É um tipo específico que baseia o cálculo de suas tangentes nos pontos vizinhos. Ela garante continuidade simples e permite o ajuste de um parâmetro extra, a **tensão** da curva, que define quão arredondada ela é nos pontos de controle.

### Curvas de Bézier (Aproximadora)
Criada por Piérre Bézier na Renault (muito usada em fontes da Adobe, por exemplo).
* Tem **controle global**.
* O grau da curva dita o número mínimo de Pontos de Controle (Sempre: *Grau = Número de PCs - 1*).
* O primeiro e o último ponto da curva são sempre interpolados (a curva obrigatoriamente encosta neles).
* As tangentes iniciais e finais apontam na mesma direção dos primeiros e últimos PCs.

### B-Spline (Aproximadora)
Pode ser vista como uma evolução que emenda várias curvas de Bézier em sequência. 
Sua grande vantagem em relação à Bézier clássica é possuir **controle local** e o grau da curva não depender da quantidade de pontos de controle usados (podemos colocar 50 pontos para formar uma curva de grau 3 tranquilamente).

### NURBS (Aproximadora)
São as *Non-Uniform Rational B-Splines*. Considerada a "super curva", muito usada em CADs industriais de precisão.
* Além de ter controle local como a B-Spline, permite a variação de "pesos" específicos para cada Ponto de Controle de forma independente.
* Ao contrário das aproximações simples, a NURBS é capaz de descrever formas analíticas perfeitamente (como círculos e cilindros exatos, não apenas aproximados).

## 4. Formulações da Curva
Para processar e calcular cada ponto da curva, o computador normalmente recorre a um desdobramento matricial no formato:
**$P(t) = T \cdot M \cdot G$**
Sendo $T$ a matriz do parâmetro (ex: $[t^3, t^2, t, 1]$), $M$ a matriz base do tipo da curva escolhida (a matriz de Hermite, matriz de Bézier, etc.) e $G$ o vetor contendo a geometria (os pontos de controle propriamente ditos).

## 5. Modelagem de Superfícies
Ao expandirmos os conceitos dessas curvas para um ambiente de grade em 3 dimensões (normalmente adicionando um segundo parâmetro chamado de $v$, onde tínhamos o $u$), conseguimos os *Patches Paramétricos*.
Um patch de Bézier Cúbico muito conhecido é formado por uma matriz de 4x4 (16 pontos de controle). Esses *patches* podem ser unidos para formular carcaças lisas e aerodinâmicas de carros, navios ou o famoso objeto da computação gráfica, o "Bule de Utah" (*Utah Teapot*).
