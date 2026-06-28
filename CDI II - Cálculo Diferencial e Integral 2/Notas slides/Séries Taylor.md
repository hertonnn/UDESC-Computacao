# Séries de Taylor e Maclaurin

Este documento aborda a representação de funções como séries de potências por meio das **Séries de Taylor e Maclaurin**, trazendo a motivação teórica, exemplos clássicos, integrações por séries e exercícios resolvidos.

---

## 1. Motivação: Determinando os Coeficientes

Suponhamos que uma função $f(x)$ possa ser representada por uma série de potências centrada em $a$ com raio de convergência $R > 0$:
$$f(x) = \sum_{n=0}^{\infty} c_n (x - a)^n = c_0 + c_1(x - a) + c_2(x - a)^2 + c_3(x - a)^3 + c_4(x - a)^4 + \dots$$

Para encontrar os coeficientes $c_n$, avaliamos sucessivas derivadas de $f(x)$ no centro $x = a$:

1. **Termo $c_0$:**
   Substituindo $x = a$ na função original:
   $$f(a) = c_0$$

2. **Termo $c_1$:**
   Derivando $f(x)$ termo a termo:
   $$f'(x) = c_1 + 2c_2(x - a) + 3c_3(x - a)^2 + 4c_4(x - a)^3 + \dots$$
   Avaliando em $x = a$:
   $$f'(a) = c_1$$

3. **Termo $c_2$:**
   Derivando novamente:
   $$f''(x) = 2 \cdot 1 c_2 + 3 \cdot 2 c_3(x - a) + 4 \cdot 3 c_4(x - a)^2 + \dots$$
   Avaliando em $x = a$:
   $$f''(a) = 2! c_2 \implies c_2 = \frac{f''(a)}{2!}$$

4. **Termo $c_3$:**
   Derivando novamente:
   $$f'''(x) = 3 \cdot 2 \cdot 1 c_3 + 4 \cdot 3 \cdot 2 c_4(x - a) + \dots$$
   Avaliando em $x = a$:
   $$f'''(a) = 3! c_3 \implies c_3 = \frac{f'''(a)}{3!}$$

### Generalização (Fórmula de Taylor)
Repetindo este procedimento, a $n$-ésima derivada $f^{(n)}(x)$ avaliada em $x = a$ fornece:
$$f^{(n)}(a) = n! c_n \implies c_n = \frac{f^{(n)}(a)}{n!}$$

Portanto, se $f(x)$ puder ser escrita como série de potências centrada em $a$, ela terá a forma:
$$f(x) = \sum_{n=0}^{\infty} \frac{f^{(n)}(a)}{n!} (x - a)^n = f(a) + f'(a)(x - a) + \frac{f''(a)}{2!}(x - a)^2 + \frac{f'''(a)}{3!}(x - a)^3 + \dots$$

---

## 2. Definições e Conceitos

### Série de Taylor
Seja $f$ uma função que possui derivadas de todas as ordens em um ponto $a$. A **Série de Taylor** de $f$ centrada em $a$ é a série de potências:
$$\sum_{n=0}^{\infty} \frac{f^{(n)}(a)}{n!} (x - a)^n$$

### Série de Maclaurin
A **Série de Maclaurin** é o caso particular em que a série de Taylor é centrada na origem ($a = 0$):
$$\sum_{n=0}^{\infty} \frac{f^{(n)}(0)}{n!} x^n = f(0) + f'(0)x + \frac{f''(0)}{2!}x^2 + \frac{f'''(0)}{3!}x^3 + \dots$$

### Funções Analíticas
> [!NOTE]
> Uma função $f$ é dita **analítica** em $a$ se ela puder ser representada por sua série de Taylor em algum intervalo aberto contendo $a$. Ou seja, a soma da série de Taylor converge para $f(x)$ nesse intervalo.

---

## 3. Série de Maclaurin de Funções Fundamentais

### A. Função Exponencial $f(x) = e^x$
Como todas as derivadas de $e^x$ são a própria função $e^x$, avaliando em $0$:
$$f^{(n)}(0) = e^0 = 1 \quad (\forall n \ge 0)$$

A série de Maclaurin para $e^x$ é:
$$e^x = \sum_{n=0}^{\infty} \frac{x^n}{n!} = 1 + x + \frac{x^2}{2!} + \frac{x^3}{3!} + \frac{x^4}{4!} + \dots \quad (\text{para todo } x \in \mathbb{R})$$

* **Exemplo 1:** Expresse a função $f(x) = e^{-x^2}$ como série de potências centrada em zero.
  - **Resolução:** Substituímos $x$ por $-x^2$ na série de $e^x$:
    $$e^{-x^2} = \sum_{n=0}^{\infty} \frac{(-x^2)^n}{n!} = \sum_{n=0}^{\infty} \frac{(-1)^n x^{2n}}{n!} = 1 - x^2 + \frac{x^4}{2!} - \frac{x^6}{3!} + \frac{x^8}{4!} - \dots$$

* **Exemplo 2:** Calcule $\int_0^1 e^{-x^2} \, dx$ na forma de uma série numérica infinita.
  - **Resolução:** Integrando termo a termo no intervalo $[0, 1]$:
    $$\int_0^1 e^{-x^2} \, dx = \int_0^1 \left( \sum_{n=0}^{\infty} \frac{(-1)^n x^{2n}}{n!} \right) \, dx = \sum_{n=0}^{\infty} \frac{(-1)^n}{n!} \left[ \frac{x^{2n+1}}{2n+1} \right]_0^1 = \sum_{n=0}^{\infty} \frac{(-1)^n}{(2n+1)n!}$$
    A série expandida é:
    $$1 - \frac{1}{3} + \frac{1}{10} - \frac{1}{42} + \frac{1}{216} - \dots$$

---

### B. Função Seno $f(x) = \sin(x)$
Análise das derivadas em $x = 0$:
- $f(0) = \sin(0) = 0$
- $f'(0) = \cos(0) = 1$
- $f''(0) = -\sin(0) = 0$
- $f'''(0) = -\cos(0) = -1$
- $f^{(4)}(0) = \sin(0) = 0$
- Os termos pares são nulos; os ímpares se alternam em sinal: $f^{(2n+1)}(0) = (-1)^n$.

A série de Maclaurin para $\sin(x)$ é:
$$\sin(x) = \sum_{n=0}^{\infty} \frac{(-1)^n x^{2n+1}}{(2n+1)!} = x - \frac{x^3}{3!} + \frac{x^5}{5!} - \frac{x^7}{7!} + \frac{x^9}{9!} - \dots \quad (\text{para todo } x \in \mathbb{R})$$

---

### C. Função Cosseno $f(x) = \cos(x)$
Podemos obter a série diferenciando termo a termo a série de $\sin(x)$:
$$\cos(x) = \frac{d}{dx} \sin(x) = \frac{d}{dx} \left( x - \frac{x^3}{3!} + \frac{x^5}{5!} - \frac{x^7}{7!} + \dots \right) = 1 - \frac{x^2}{2!} + \frac{x^4}{4!} - \frac{x^6}{6!} + \dots$$
$$\cos(x) = \sum_{n=0}^{\infty} \frac{(-1)^n x^{2n}}{(2n)!} \quad (\text{para todo } x \in \mathbb{R})$$

---

## 4. Exemplos Resolvidos Adicionais

### Exemplo 3:
Mostre que a série numérica $\sum_{n=0}^{\infty} \frac{(-1)^n \pi^{2n}}{(2n)!}$ converge e calcule sua soma.
- **Resolução:**
  Esta série coincide exatamente com o desenvolvimento de $\cos(x)$ avaliado em $x = \pi$:
  $$\sum_{n=0}^{\infty} \frac{(-1)^n \pi^{2n}}{(2n)!} = 1 - \frac{\pi^2}{2!} + \frac{\pi^4}{4!} - \frac{\pi^6}{6!} + \dots = \cos(\pi)$$
  Como a série de cosseno é convergente para todos os reais, a série numérica converge para:
  $$\cos(\pi) = -1$$

### Exemplo 4:
Obtenha a série de Maclaurin para $f(x) = x \sin(x)$.
- **Resolução:**
  Multiplicando a série de $\sin(x)$ por $x$:
  $$x \sin(x) = x \left( x - \frac{x^3}{3!} + \frac{x^5}{5!} - \frac{x^7}{7!} + \dots \right) = x^2 - \frac{x^4}{3!} + \frac{x^6}{5!} - \frac{x^8}{7!} + \dots = \sum_{n=0}^{\infty} \frac{(-1)^n x^{2n+2}}{(2n+1)!}$$

### Exemplo 5:
Obtenha a série de Maclaurin para $f(x) = x^2 \cos(x)$.
- **Resolução:**
  Multiplicando a série de $\cos(x)$ por $x^2$:
  $$x^2 \cos(x) = x^2 \left( 1 - \frac{x^2}{2!} + \frac{x^4}{4!} - \frac{x^6}{6!} + \dots \right) = x^2 - \frac{x^4}{2!} + \frac{x^6}{4!} - \frac{x^8}{6!} + \dots = \sum_{n=0}^{\infty} \frac{(-1)^n x^{2n+2}}{(2n)!}$$

### Exemplo 6:
Encontre a representação em série de potências para a integral $\int \frac{\sin(x)}{x} \, dx$ e para a integral definida de $0$ a $1$.
- **Resolução:**
  Primeiro reescrevemos o integrando como série:
  $$\frac{\sin(x)}{x} = \frac{1}{x} \left( x - \frac{x^3}{3!} + \frac{x^5}{5!} - \frac{x^7}{7!} + \dots \right) = 1 - \frac{x^2}{3!} + \frac{x^4}{5!} - \frac{x^6}{7!} + \dots = \sum_{n=0}^{\infty} \frac{(-1)^n x^{2n}}{(2n+1)!}$$
  Agora, integramos termo a termo:
  $$\int_{0}^{1} \frac{\sin(x)}{x} \, dx = \left[ x - \frac{x^3}{3 \cdot 3!} + \frac{x^5}{5 \cdot 5!} - \frac{x^7}{7 \cdot 7!} + \dots \right]_{0}^{1} = \sum_{n=0}^{\infty} \frac{(-1)^n}{(2n+1)(2n+1)!}$$
  A série numérica expandida é:
  $$1 - \frac{1}{18} + \frac{1}{600} - \frac{1}{35280} + \dots$$

### Exemplo 7:
Aproxime o valor de $\int_{0}^{1} \frac{\sin(x)}{x} \, dx$ somando os quatro primeiros termos de sua série.
- **Resolução:**
  Utilizando os termos do Exemplo 6:
  $$\int_{0}^{1} \frac{\sin(x)}{x} \, dx \approx 1 - \frac{1}{18} + \frac{1}{600} - \frac{1}{35280}$$
  $$\approx 1 - 0.055556 + 0.001667 - 0.000028 = 0.946083 \approx 0.9461$$

---

## 5. Exercícios Propostos

### 1. Descreva a série de Taylor, centrada em $x_0 = 0$ (Maclaurin), das seguintes funções:

#### a) $f(x) = e^{-x^3}$
- **Resolução:**
  Substituindo $x$ por $-x^3$ na série de $e^x$:
  $$e^{-x^3} = \sum_{n=0}^{\infty} \frac{(-x^3)^n}{n!} = \sum_{n=0}^{\infty} \frac{(-1)^n x^{3n}}{n!} = 1 - x^3 + \frac{x^6}{2!} - \frac{x^9}{3!} + \dots$$

#### b) $f(x) = \sin(x) \cos(x)$
- **Resolução:**
  Utilizando a identidade trigonométrica: $\sin(x) \cos(x) = \frac{1}{2} \sin(2x)$.
  Substituímos $x$ por $2x$ na série do seno:
  $$\sin(2x) = \sum_{n=0}^{\infty} \frac{(-1)^n (2x)^{2n+1}}{(2n+1)!} = \sum_{n=0}^{\infty} \frac{(-1)^n 2^{2n+1} x^{2n+1}}{(2n+1)!}$$
  Multiplicando por $\frac{1}{2}$:
  $$\sin(x)\cos(x) = \sum_{n=0}^{\infty} \frac{(-1)^n 2^{2n} x^{2n+1}}{(2n+1)!} = x - \frac{4x^3}{3!} + \frac{16x^5}{5!} - \dots$$

#### c) $f(x) = \sin(x^3)$
- **Resolução:**
  Substituindo $x$ por $x^3$ na série de $\sin(x)$:
  $$\sin(x^3) = \sum_{n=0}^{\infty} \frac{(-1)^n (x^3)^{2n+1}}{(2n+1)!} = \sum_{n=0}^{\infty} \frac{(-1)^n x^{6n+3}}{(2n+1)!} = x^3 - \frac{x^9}{3!} + \frac{x^{15}}{5!} - \dots$$

#### d) $f(x) = \cos(\sqrt{x})$ (para $x \ge 0$)
- **Resolução:**
  Substituindo $x$ por $\sqrt{x}$ na série de $\cos(x)$:
  $$\cos(\sqrt{x}) = \sum_{n=0}^{\infty} \frac{(-1)^n (\sqrt{x})^{2n}}{(2n)!} = \sum_{n=0}^{\infty} \frac{(-1)^n x^n}{(2n)!} = 1 - \frac{x}{2!} + \frac{x^2}{4!} - \frac{x^3}{6!} + \dots$$

---

### 2. Aproxime o valor das seguintes integrais utilizando os 5 primeiros termos de suas séries:

#### a) $\int_0^1 \cos(x^2) \, dx$
- **Série Integrada:**
  $$\cos(x^2) = \sum_{n=0}^{\infty} \frac{(-1)^n x^{4n}}{(2n)!} \implies \int_{0}^{1} \cos(x^2) \, dx = \sum_{n=0}^{\infty} \frac{(-1)^n}{(4n+1)(2n)!}$$
- **Cinco primeiros termos ($n = 0$ a $4$):**
  $$S_5 = \frac{1}{1 \cdot 0!} - \frac{1}{5 \cdot 2!} + \frac{1}{9 \cdot 4!} - \frac{1}{13 \cdot 6!} + \frac{1}{17 \cdot 8!}$$
  $$S_5 = 1 - \frac{1}{10} + \frac{1}{216} - \frac{1}{9360} + \frac{1}{685440} \approx 1 - 0.1 + 0.0046296 - 0.0001068 + 0.0000014 = 0.904524 \approx 0.9045$$

#### b) $\int_0^{0.5} \frac{1 - \cos(x)}{x} \, dx$
- **Série Integrada:**
  $$\frac{1 - \cos(x)}{x} = \sum_{n=1}^{\infty} \frac{(-1)^{n-1} x^{2n-1}}{(2n)!} \implies \int_{0}^{0.5} \frac{1 - \cos(x)}{x} \, dx = \sum_{n=1}^{\infty} \frac{(-1)^{n-1} (0.5)^{2n}}{(2n)(2n)!}$$
- **Cinco primeiros termos ($n = 1$ a $5$):**
  $$S_5 = \frac{(0.5)^2}{2 \cdot 2!} - \frac{(0.5)^4}{4 \cdot 4!} + \frac{(0.5)^6}{6 \cdot 6!} - \frac{(0.5)^8}{8 \cdot 8!} + \frac{(0.5)^{10}}{10 \cdot 10!}$$
  $$S_5 = \frac{0.25}{4} - \frac{0.0625}{96} + \frac{0.015625}{4320} - \frac{0.00390625}{322560} + \dots$$
  $$S_5 \approx 0.0625 - 0.000651 + 0.0000036 - 0.00000001 \approx 0.06185$$

#### c) $\int_0^1 e^{-x^2} \, dx$
- **Série Integrada (Exemplo 2):**
  $$\int_{0}^{1} e^{-x^2} \, dx = \sum_{n=0}^{\infty} \frac{(-1)^n}{(2n+1)n!}$$
- **Cinco primeiros termos ($n = 0$ a $4$):**
  $$S_5 = 1 - \frac{1}{3} + \frac{1}{10} - \frac{1}{42} + \frac{1}{216} \approx 1 - 0.333333 + 0.1 - 0.023809 + 0.004629 = 0.747487 \approx 0.7475$$

---

### 3. Calcule o valor exato das somas das seguintes séries:

#### a) $\sum_{n=0}^{\infty} \frac{1}{n!}$
- **Resolução:**
  Esta é a série de $e^x$ avaliada em $x = 1$.
  $$\text{Soma} = e^1 = e$$

#### b) $\sum_{n=0}^{\infty} \frac{(-1)^n}{n!}$
- **Resolução:**
  Esta é a série de $e^x$ avaliada em $x = -1$.
  $$\text{Soma} = e^{-1} = \frac{1}{e}$$

#### c) $\sum_{n=0}^{\infty} \frac{2^n}{n!}$
- **Resolução:**
  Esta é a série de $e^x$ avaliada em $x = 2$.
  $$\text{Soma} = e^2$$

#### d) $\sum_{n=0}^{\infty} \frac{(-1)^n \pi^{2n}}{4^n (2n)!}$
- **Resolução:**
  Podemos reescrever a série como:
  $$\sum_{n=0}^{\infty} \frac{(-1)^n \left( \frac{\pi}{2} \right)^{2n}}{(2n)!}$$
  Esta é a série de $\cos(x)$ avaliada em $x = \frac{\pi}{2}$.
  $$\text{Soma} = \cos\left( \frac{\pi}{2} \right) = 0$$

#### e) $\sum_{n=0}^{\infty} \frac{(-1)^n 2^{2n+1} \pi^{2n+1}}{(2n+1)!}$
- **Resolução:**
  Podemos reescrever a série como:
  $$\sum_{n=0}^{\infty} \frac{(-1)^n (2\pi)^{2n+1}}{(2n+1)!}$$
  Esta é a série de $\sin(x)$ avaliada em $x = 2\pi$.
  $$\text{Soma} = \sin(2\pi) = 0$$
