# Séries Geométricas

Este documento apresenta os conceitos fundamentais de **Progressão Geométrica (PG)** e **Séries Geométricas**, incluindo dedução de fórmulas, exemplos práticos resolvidos e exercícios propostos.

---

## 1. Progressão Geométrica (PG)

Uma **Progressão Geométrica** é uma sequência numérica em que cada termo, a partir do segundo, é igual ao produto do termo anterior por uma constante real $r$, denominada **razão** da PG.

A sequência é escrita na forma:
$$a, \, a \cdot r, \, a \cdot r^2, \, a \cdot r^3, \, \dots, \, a \cdot r^{n-1}, \, \dots$$

Onde:
- $a$ é o primeiro termo ($a \neq 0$).
- $r$ é a razão.
- $a_n = a \cdot r^{n-1}$ é o termo geral para $n \ge 1$.

### Exemplos de PG

* **Exemplo 1:** A sequência $2, 6, 18, 54, 162, \dots$
  - Primeiro termo: $a = 2$
  - Razão: $r = \frac{6}{2} = 3$
  - Termo geral: $a_n = 2 \cdot 3^{n-1}$

* **Exemplo 2:** A sequência $\frac{1}{2}, \frac{1}{4}, \frac{1}{8}, \frac{1}{16}, \dots$
  - Primeiro termo: $a = \frac{1}{2}$
  - Razão: $r = \frac{1}{2}$
  - Termo geral: $a_n = \left(\frac{1}{2}\right)^n$

* **Exemplo 3:** A sequência $5, 0, 0, 0, \dots$
  - Primeiro termo: $a = 5$
  - Razão: $r = 0$
  - Termo geral: $a_1 = 5$ e $a_n = 0$ para $n \ge 2$.

---

## 2. Definição de Série Geométrica

Uma **Série Geométrica** é a soma dos termos de uma progressão geométrica infinita:
$$S = \sum_{k=1}^{\infty} a \cdot r^{k-1} = a + a \cdot r + a \cdot r^2 + a \cdot r^3 + \dots$$

Onde:
- $a$ é o primeiro termo.
- $r$ é a razão da série.

### Exemplos de Séries Geométricas

* **Exemplo 4:** 
  $$\sum_{k=1}^{\infty} 2 \cdot 3^{k-1} = 2 + 6 + 18 + 54 + 162 + \dots$$

* **Exemplo 5:**
  $$\sum_{k=1}^{\infty} 7 \cdot \left(\frac{1}{3}\right)^{k-1} = 7 + \frac{7}{3} + \frac{7}{9} + \frac{7}{27} + \frac{7}{81} + \dots$$
  *(Neste caso, o primeiro termo é $a = 7$ e a razão é $r = \frac{1}{3}$).*

---

## 3. Dedução da Fórmula da Soma Parcial ($S_n$)

Seja $S_n$ a soma dos $n$ primeiros termos da série geométrica:
$$S_n = a + a \cdot r + a \cdot r^2 + \dots + a \cdot r^{n-2} + a \cdot r^{n-1} \quad \text{(Equação 1)}$$

Multiplicando ambos os membros da Equação 1 pela razão $r$, obtemos:
$$r \cdot S_n = a \cdot r + a \cdot r^2 + a \cdot r^3 + \dots + a \cdot r^{n-1} + a \cdot r^n \quad \text{(Equação 2)}$$

Subtraindo a Equação 2 da Equação 1 ($S_n - r \cdot S_n$):
$$S_n - r \cdot S_n = a - a \cdot r^n$$
$$S_n(1 - r) = a(1 - r^n)$$

Para $r \neq 1$, podemos isolar $S_n$:
$$S_n = a \frac{1 - r^n}{1 - r}$$

---

## 4. Estudo da Convergência e Exemplo Prático

### Exemplo 6: Análise de Soma e Limite
Considere a série do Exemplo 5:
$$\sum_{k=1}^{\infty} 7 \cdot \left(\frac{1}{3}\right)^{k-1}$$

1. **Soma Parcial $S_n$:**
   $$S_n = 7 \frac{1 - \left(\frac{1}{3}\right)^n}{1 - \frac{1}{3}} = 7 \frac{1 - \left(\frac{1}{3}\right)^n}{\frac{2}{3}} = \frac{21}{2} \left[ 1 - \left(\frac{1}{3}\right)^n \right]$$

2. **Cálculo de $S_4$:**
   $$S_4 = \frac{21}{2} \left[ 1 - \left(\frac{1}{3}\right)^4 \right] = \frac{21}{2} \left( 1 - \frac{1}{81} \right) = \frac{21}{2} \cdot \frac{80}{81} = \frac{280}{27} \approx 10.3703$$

3. **Soma da Série Infinita ($S$):**
   A soma da série infinita é o limite de $S_n$ quando $n \to \infty$:
   $$S = \lim_{n \to \infty} S_n = \lim_{n \to \infty} \frac{21}{2} \left[ 1 - \left(\frac{1}{3}\right)^n \right]$$
   Como $\lim_{n \to \infty} \left(\frac{1}{3}\right)^n = 0$:
   $$S = \frac{21}{2} (1 - 0) = \frac{21}{2} = 10.5$$

---

## 5. Teorema Geral de Convergência das Séries Geométricas

Dada a série geométrica infinita com $a \neq 0$:
$$\sum_{k=1}^{\infty} a \cdot r^{k-1}$$

A soma da série é dada pelo limite da sequência de somas parciais $S_n$:
$$S = \lim_{n \to \infty} S_n = \lim_{n \to \infty} \left( \frac{a}{1 - r} \right) \left( 1 - r^n \right) = \frac{a}{1 - r} \left( 1 - \lim_{n \to \infty} r^n \right)$$

Análise do limite de $r^n$:
- Se $|r| < 1$, então $\lim_{n \to \infty} r^n = 0$. Logo, a série **converge** e sua soma é:
  $$S = \frac{a}{1 - r}$$
- Se $|r| > 1$ ou $r = -1$, o limite $\lim_{n \to \infty} r^n$ não existe ou é infinito. Logo, a série **diverge**.
- Se $r = 1$, a série é $a + a + a + \dots$, que também diverge.

### Resumo Técnico:
> [!IMPORTANT]
> A série geométrica $\sum_{k=1}^{\infty} a \cdot r^{k-1}$ **converge** se e somente se $|r| < 1$. Nesse caso, a soma é:
> $$S = \frac{a}{1 - r}$$
> Se $|r| \ge 1$, a série **diverge**.

### Exemplos Aplicados

* **Exemplo 7:** A série $\sum_{k=1}^{\infty} \left(\frac{2}{3}\right)^{k-1}$
  - Parâmetros: $a = 1$, $r = \frac{2}{3}$
  - Análise: Como $|r| = \frac{2}{3} < 1$, a série **converge**.
  - Soma:
    $$S = \frac{1}{1 - \frac{2}{3}} = \frac{1}{\frac{1}{3}} = 3$$

* **Exemplo 8:** A série $\sum_{k=1}^{\infty} \left(\frac{3}{2}\right)^{k-1}$
  - Parâmetros: $a = 1$, $r = \frac{3}{2}$
  - Análise: Como $|r| = \frac{3}{2} > 1$, a série **diverge**.
  - Comportamento: Como $a > 0$ e $r > 0$, a série diverge para $+\infty$.

---

## 6. Exercícios Resolvidos e Propostos

### 1. Calcule, quando possível, a soma das seguintes séries:

#### a) $\sum_{k=1}^{\infty} \left(\frac{3}{4}\right)^{k-1}$
- **Resolução:** $a = 1$, $r = \frac{3}{4}$. Como $|r| < 1$, converge.
  $$S = \frac{1}{1 - \frac{3}{4}} = 4$$

#### b) $\sum_{k=1}^{\infty} \left(\frac{2}{5}\right)^k$
- **Resolução:** Reescrevendo a série: $\sum_{k=1}^{\infty} \frac{2}{5} \cdot \left(\frac{2}{5}\right)^{k-1}$.
  $a = \frac{2}{5}$, $r = \frac{2}{5}$. Como $|r| < 1$, converge.
  $$S = \frac{\frac{2}{5}}{1 - \frac{2}{5}} = \frac{\frac{2}{5}}{\frac{3}{5}} = \frac{2}{3}$$

#### c) $\sum_{k=1}^{\infty} \left(\frac{7}{10}\right)^k$
- **Resolução:** $a = \frac{7}{10}$, $r = \frac{7}{10}$. Como $|r| < 1$, converge.
  $$S = \frac{\frac{7}{10}}{1 - \frac{7}{10}} = \frac{\frac{7}{10}}{\frac{3}{10}} = \frac{7}{3}$$

#### d) $\sum_{k=1}^{\infty} 2 \cdot \left(\frac{3}{5}\right)^k$
- **Resolução:** $a = 2 \cdot \left(\frac{3}{5}\right) = \frac{6}{5}$, $r = \frac{3}{5}$. Como $|r| < 1$, converge.
  $$S = \frac{\frac{6}{5}}{1 - \frac{3}{5}} = \frac{\frac{6}{5}}{\frac{2}{5}} = 3$$

#### e) $\sum_{k=1}^{\infty} \left(\frac{2}{5}\right)^{k-1}$
- **Resolução:** $a = 1$, $r = \frac{2}{5}$. Como $|r| < 1$, converge.
  $$S = \frac{1}{1 - \frac{2}{5}} = \frac{5}{3}$$

#### f) $\sum_{k=1}^{\infty} \left[ 5 \cdot \left(\frac{1}{8}\right)^{k-1} + 2 \cdot \left(\frac{2}{7}\right)^k \right]$
- **Resolução:** Podemos separar a soma em duas séries convergentes:
  - Série 1: $\sum_{k=1}^{\infty} 5 \cdot \left(\frac{1}{8}\right)^{k-1} \implies a_1 = 5$, $r_1 = \frac{1}{8} \implies S_1 = \frac{5}{1 - 1/8} = \frac{40}{7}$
  - Série 2: $\sum_{k=1}^{\infty} 2 \cdot \left(\frac{2}{7}\right)^k \implies a_2 = \frac{4}{7}$, $r_2 = \frac{2}{7} \implies S_2 = \frac{4/7}{1 - 2/7} = \frac{4}{5}$
  - Soma total:
    $$S = S_1 + S_2 = \frac{40}{7} + \frac{4}{5} = \frac{200 + 28}{35} = \frac{228}{35}$$

#### g) $\sum_{k=1}^{\infty} 4 \cdot \left(\frac{4}{5}\right)^{k-3}$
- **Resolução:** Para $k = 1$: $a = 4 \cdot \left(\frac{4}{5}\right)^{-2} = 4 \cdot \frac{25}{16} = \frac{25}{4}$. A razão é $r = \frac{4}{5}$.
  $$S = \frac{\frac{25}{4}}{1 - \frac{4}{5}} = \frac{\frac{25}{4}}{\frac{1}{5}} = \frac{125}{4}$$

#### h) $\sum_{k=1}^{\infty} 8 \cdot \left(\frac{5}{8}\right)^{k-1}$
- **Resolução:** $a = 8$, $r = \frac{5}{8}$. Como $|r| < 1$, converge.
  $$S = \frac{8}{1 - \frac{5}{8}} = \frac{8}{\frac{3}{8}} = \frac{64}{3}$$

---

### 2. Problema de Aplicação:
Uma série geométrica tem como primeiro termo $a = 4$ e soma $S = 6$. Qual é a expressão desta série?

- **Resolução:**
  Sabemos que a soma de uma série geométrica convergente é dada por:
  $$S = \frac{a}{1 - r}$$
  Substituindo os valores conhecidos:
  $$6 = \frac{4}{1 - r} \implies 6(1 - r) = 4 \implies 1 - r = \frac{4}{6} = \frac{2}{3}$$
  $$r = 1 - \frac{2}{3} = \frac{1}{3}$$
  Como $|r| = \frac{1}{3} < 1$, a hipótese de convergência é válida. A expressão da série é:
  $$\sum_{k=1}^{\infty} 4 \cdot \left(\frac{1}{3}\right)^{k-1}$$
