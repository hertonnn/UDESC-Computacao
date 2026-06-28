# Funções Trigonométricas

Este documento apresenta o estudo completo das funções trigonométricas — seno, cosseno e tangente — abordando o ciclo trigonométrico, os arcos notáveis, os gráficos e suas transformações, as relações no triângulo retângulo, as identidades fundamentais e a resolução de equações trigonométricas.

---

## 1. Ciclo Trigonométrico

O ciclo trigonométrico (ou círculo unitário) é uma circunferência de raio 1 centrada na origem do plano cartesiano. Todo ângulo $\theta$ corresponde a um ponto $P(x, y)$ sobre esse círculo, onde:

$$x = \cos\theta \qquad y = \text{sen}\,\theta$$

Os ângulos podem ser medidos em **graus** ou em **radianos**. A conversão entre as unidades é dada por:

$$180° = \pi \text{ rad} \quad \Longrightarrow \quad 1° = \frac{\pi}{180} \text{ rad}$$

![Ciclo Trigonométrico](./imagens/Funções%20Trigonométricas/slide_2_img_1.png)
![Seno e Cosseno no Ciclo](./imagens/Funções%20Trigonométricas/slide_3_img_1.png)

---

## 2. Arcos Notáveis

Os ângulos notáveis são os ângulos mais utilizados em trigonometria, cujos valores de seno e cosseno são exatos.

| Ângulo | $\theta$ (rad) | $\text{sen}\,\theta$ | $\cos\theta$ | $\tan\theta$ |
|--------|----------------|----------------------|--------------|--------------|
| $0°$ | $0$ | $0$ | $1$ | $0$ |
| $30°$ | $\pi/6$ | $1/2$ | $\sqrt{3}/2$ | $\sqrt{3}/3$ |
| $45°$ | $\pi/4$ | $\sqrt{2}/2$ | $\sqrt{2}/2$ | $1$ |
| $60°$ | $\pi/3$ | $\sqrt{3}/2$ | $1/2$ | $\sqrt{3}$ |
| $90°$ | $\pi/2$ | $1$ | $0$ | indefinido |

Usando o ciclo trigonométrico, os valores dos arcos notáveis nos quatro quadrantes podem ser obtidos por simetria.

![Seno dos Arcos Notáveis - parte 1](./imagens/Funções%20Trigonométricas/slide_4_img_1.png)
![Seno dos Arcos Notáveis - parte 2](./imagens/Funções%20Trigonométricas/slide_5_img_1.png)
![Seno dos Arcos Notáveis - parte 3](./imagens/Funções%20Trigonométricas/slide_6_img_1.png)

---

## 3. Função Seno

A função seno $f(x) = \text{sen}(x)$ tem as seguintes propriedades:

- **Domínio:** $\mathbb{R}$
- **Imagem:** $[-1, 1]$
- **Período:** $2\pi$ (a função se repete a cada $2\pi$ unidades)
- **Paridade:** função ímpar — $\text{sen}(-x) = -\text{sen}(x)$
- Cruza o eixo $x$ nos múltiplos de $\pi$ e atinge os valores máximo (+1) e mínimo (−1) nos $\pi/2$ e $3\pi/2$, respectivamente.

![Função Seno - gráfico básico](./imagens/Funções%20Trigonométricas/slide_7_img_1.png)
![Função Seno - propriedades](./imagens/Funções%20Trigonométricas/slide_8_img_1.png)
![Função Seno - ciclo completo](./imagens/Funções%20Trigonométricas/slide_9_img_1.png)

---

## 4. Transformações da Função Seno

A forma geral da função seno transformada é:

$$f(x) = A \cdot \text{sen}(Bx + C) + D$$

Onde cada parâmetro controla um aspecto do gráfico:

| Parâmetro | Efeito |
|-----------|--------|
| $D > 0$ | Deslocamento vertical para **cima** |
| $D < 0$ | Deslocamento vertical para **baixo** |
| $\|A\| > 1$ | **Alongamento vertical** (aumenta a amplitude) |
| $0 < \|A\| < 1$ | **Compressão vertical** (reduz a amplitude) |
| $A < 0$ | **Reflexão** em relação ao eixo horizontal |
| $C < 0$ | Deslocamento horizontal para a **esquerda** |
| $C > 0$ | Deslocamento horizontal para a **direita** |
| $\|B\| > 1$ | **Compressão horizontal** (período menor: $T = 2\pi/B$) |
| $0 < \|B\| < 1$ | **Alongamento horizontal** (período maior) |
| $B < 0$ | **Reflexão** em relação ao eixo vertical |

![Deslocamento Vertical para Cima](./imagens/Funções%20Trigonométricas/slide_10_img_1.png)
![Deslocamento Vertical para Baixo](./imagens/Funções%20Trigonométricas/slide_11_img_1.png)
![Alongamento Vertical](./imagens/Funções%20Trigonométricas/slide_12_img_1.png)
![Compressão Vertical](./imagens/Funções%20Trigonométricas/slide_13_img_1.png)
![Reflexão em relação ao Eixo Horizontal](./imagens/Funções%20Trigonométricas/slide_14_img_1.png)
![Deslocamento Horizontal para a Esquerda](./imagens/Funções%20Trigonométricas/slide_15_img_1.png)
![Deslocamento Horizontal para a Direita](./imagens/Funções%20Trigonométricas/slide_16_img_1.png)
![Compressão Horizontal](./imagens/Funções%20Trigonométricas/slide_17_img_1.png)
![Alongamento Horizontal](./imagens/Funções%20Trigonométricas/slide_18_img_1.png)
![Reflexão em relação ao Eixo Vertical](./imagens/Funções%20Trigonométricas/slide_19_img_1.png)

### Exemplo — Transformações do Seno

![Exemplo de Transformação](./imagens/Funções%20Trigonométricas/slide_20_img_1.png)

---

## 5. Função Cosseno

A função cosseno $f(x) = \cos(x)$ possui características análogas ao seno, com a diferença de fase $\pi/2$:

$$\cos(x) = \text{sen}\!\left(x + \frac{\pi}{2}\right)$$

Propriedades:
- **Domínio:** $\mathbb{R}$
- **Imagem:** $[-1, 1]$
- **Período:** $2\pi$
- **Paridade:** função **par** — $\cos(-x) = \cos(x)$
- Começa no valor máximo $\cos(0) = 1$ e cruza o eixo $x$ em $\pi/2$ e $3\pi/2$.

Os arcos notáveis para cosseno obedecem a mesma lógica do seno, utilizando o ciclo trigonométrico para determinar os sinais em cada quadrante.

![Cosseno dos Arcos Notáveis - parte 1](./imagens/Funções%20Trigonométricas/slide_21_img_1.png)
![Cosseno dos Arcos Notáveis - parte 2](./imagens/Funções%20Trigonométricas/slide_22_img_1.png)
![Cosseno dos Arcos Notáveis - parte 3](./imagens/Funções%20Trigonométricas/slide_23_img_1.png)
![Função Cosseno - gráfico básico](./imagens/Funções%20Trigonométricas/slide_24_img_1.png)
![Função Cosseno - propriedades](./imagens/Funções%20Trigonométricas/slide_25_img_1.png)

### Exemplo — Função Cosseno

![Exemplo Cosseno](./imagens/Funções%20Trigonométricas/slide_26_img_1.png)

---

## 6. Função Tangente

A tangente é definida como o quociente entre seno e cosseno:

$$\tan(x) = \frac{\text{sen}(x)}{\cos(x)}$$

Propriedades:
- **Domínio:** $\mathbb{R} \setminus \left\{\frac{\pi}{2} + k\pi, \; k \in \mathbb{Z}\right\}$ (excluídos os pontos onde $\cos(x) = 0$)
- **Imagem:** $\mathbb{R}$
- **Período:** $\pi$ (metade do período do seno e cosseno)
- **Paridade:** função **ímpar** — $\tan(-x) = -\tan(x)$
- Possui **assíntotas verticais** em $x = \frac{\pi}{2} + k\pi$

No ciclo trigonométrico, a tangente representa o comprimento de um segmento sobre a reta tangente ao círculo no ponto $(1, 0)$, projetando o raio até essa reta.

![Tangente no Ciclo Trigonométrico](./imagens/Funções%20Trigonométricas/slide_27_img_1.png)
![Função Tangente - gráfico](./imagens/Funções%20Trigonométricas/slide_28_img_1.png)

### Exemplos — Função Tangente

![Exemplo Tangente 1](./imagens/Funções%20Trigonométricas/slide_29_img_1.png)
![Exemplo Tangente 2](./imagens/Funções%20Trigonométricas/slide_30_img_1.png)

### Exercícios Intermediários

![Exercícios Seno/Cosseno/Tangente](./imagens/Funções%20Trigonométricas/slide_31_img_1.png)

---

## 7. Relações Trigonométricas no Triângulo Retângulo

Em um triângulo retângulo com ângulo $\theta$, hipotenusa $h$, cateto oposto $co$ e cateto adjacente $ca$, as razões trigonométricas são definidas como:

$$\text{sen}\,\theta = \frac{\text{cateto oposto}}{\text{hipotenusa}} = \frac{co}{h}$$

$$\cos\theta = \frac{\text{cateto adjacente}}{\text{hipotenusa}} = \frac{ca}{h}$$

$$\tan\theta = \frac{\text{cateto oposto}}{\text{cateto adjacente}} = \frac{co}{ca}$$

![Relações - Triângulo Retângulo Seno](./imagens/Funções%20Trigonométricas/slide_32_img_1.png)
![Relações - Triângulo Retângulo Cosseno](./imagens/Funções%20Trigonométricas/slide_33_img_1.png)
![Relações - Triângulo Retângulo Tangente](./imagens/Funções%20Trigonométricas/slide_34_img_1.png)
![Relações Trigonométricas Gerais](./imagens/Funções%20Trigonométricas/slide_35_img_1.png)

---

## 8. Identidades Trigonométricas

As identidades trigonométricas são igualdades válidas para todos os valores do domínio. As principais são:

**Identidade Fundamental (Pitágoras):**
$$\text{sen}^2(x) + \cos^2(x) = 1$$

**Derivadas da identidade fundamental:**
$$1 + \tan^2(x) = \sec^2(x) \qquad 1 + \cot^2(x) = \csc^2(x)$$

**Fórmulas de Adição e Subtração:**
$$\text{sen}(x \pm y) = \text{sen}(x)\cos(y) \pm \cos(x)\text{sen}(y)$$
$$\cos(x \pm y) = \cos(x)\cos(y) \mp \text{sen}(x)\text{sen}(y)$$
$$\tan(x \pm y) = \frac{\tan(x) \pm \tan(y)}{1 \mp \tan(x)\tan(y)}$$

**Fórmulas do Ângulo Duplo:**
$$\text{sen}(2x) = 2\,\text{sen}(x)\cos(x)$$
$$\cos(2x) = \cos^2(x) - \text{sen}^2(x) = 2\cos^2(x) - 1 = 1 - 2\,\text{sen}^2(x)$$

![Identidades Trigonométricas - parte 1](./imagens/Funções%20Trigonométricas/slide_36_img_1.png)
![Identidades Trigonométricas - parte 2](./imagens/Funções%20Trigonométricas/slide_37_img_1.png)

---

## 9. Equações Trigonométricas

Uma equação trigonométrica é uma equação que envolve funções trigonométricas de uma variável. Para encontrar as soluções, usamos os arcos notáveis, as identidades e o ciclo trigonométrico para identificar todos os ângulos que satisfazem a equação no intervalo pedido.

### Exemplo 1 — $\text{sen}(x) = \frac{1}{2}$ no intervalo $[0, 2\pi]$

Os arcos cujo seno vale $\frac{1}{2}$ são os ângulos de $30°$ ($\pi/6$) e $150°$ ($5\pi/6$):

$$x_1 = \frac{\pi}{6}, \qquad x_2 = \pi - \frac{\pi}{6} = \frac{5\pi}{6}$$

![Equação Trigonométrica - Exemplo 1](./imagens/Funções%20Trigonométricas/slide_38_img_1.png)

### Exemplo 2 — $\text{sen}(x) + \cos(x) = 1$ no intervalo $[0, 2\pi]$

Elevando ambos os lados ao quadrado após isolar: $\text{sen}(x) = 1 - \cos(x)$:

$$\text{sen}^2(x) = 1 - 2\cos(x) + \cos^2(x)$$
$$1 - \cos^2(x) = 1 - 2\cos(x) + \cos^2(x)$$
$$2\cos^2(x) - 2\cos(x) = 0 \implies 2\cos(x)(\cos(x) - 1) = 0$$

Portanto $\cos(x) = 0$ ou $\cos(x) = 1$, ou seja: $x \in \left\{0,\, \frac{\pi}{2},\, \frac{3\pi}{2},\, 2\pi\right\}$.

Verificando na equação original (para eliminar as soluções espúrias introduzidas ao elevar ao quadrado), as soluções válidas são $x = 0$, $x = \frac{\pi}{2}$ e $x = 2\pi$.

![Equação Trigonométrica - Exemplo 2](./imagens/Funções%20Trigonométricas/slide_39_img_1.png)

### Exemplo 3 — $\tan^2(x) - \tan(x) = 6$ no intervalo $[0, 2\pi]$

Fazendo $u = \tan(x)$:

$$u^2 - u - 6 = 0 \implies (u - 3)(u + 2) = 0$$

Portanto $\tan(x) = 3$ ou $\tan(x) = -2$.

Ambas as equações possuem soluções no intervalo $[0, 2\pi]$ determinadas por $\arctan$ e sua simetria de período $\pi$.

![Equação Trigonométrica - Exemplo 3](./imagens/Funções%20Trigonométricas/slide_40_img_1.png)

---

## 10. Exercícios
1) Lista de Exercícios postada no Moodle.
