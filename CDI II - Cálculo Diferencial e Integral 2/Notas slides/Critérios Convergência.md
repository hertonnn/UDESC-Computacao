# Critérios de Convergência para Séries com Termos Não Negativos

Este documento apresenta alguns dos principais critérios de convergência para séries de termos não negativos, acompanhados de exemplos práticos detalhados e exercícios para fixação.

---

## 1. Critério da Comparação Direta

Sejam $\sum_{n=1}^{\infty} a_n$ e $\sum_{n=1}^{\infty} b_n$ séries reais de termos não negativos ($a_n \ge 0$ e $b_n \ge 0$, para todo $n$). Então:

1. **Se $\sum_{n=1}^{\infty} b_n$ for convergente** e $a_n \le b_n$ para todo $n$, então **$\sum_{n=1}^{\infty} a_n$ também será convergente**.
2. **Se $\sum_{n=1}^{\infty} b_n$ for divergente** e $a_n \ge b_n$ para todo $n$, então **$\sum_{n=1}^{\infty} a_n$ também será divergente**.

### Exemplos de Comparação Direta

* **Exemplo 1:** Verifique a convergência da série $\sum_{n=1}^{\infty} \frac{1}{n^3 + 1}$.
  - **Análise:** Para todo $n \in \mathbb{N}^*$, sabemos que:
    $$n^3 + 1 > n^3 \implies \frac{1}{n^3 + 1} < \frac{1}{n^3}$$
  - A série $\sum_{n=1}^{\infty} \frac{1}{n^3}$ é uma $p$-série com $p = 3 > 1$, sendo, portanto, **convergente**.
  - Pelo Critério da Comparação, a série $\sum_{n=1}^{\infty} \frac{1}{n^3 + 1}$ também é **convergente**.

* **Exemplo 2:** Verifique a convergência da série $\sum_{n=1}^{\infty} \frac{1}{n - 1/2}$.
  - **Análise:** Para todo $n \in \mathbb{N}^*$:
    $$n - \frac{1}{2} < n \implies \frac{1}{n - 1/2} > \frac{1}{n}$$
  - A série harmônica $\sum_{n=1}^{\infty} \frac{1}{n}$ é **divergente**.
  - Pelo Critério da Comparação, a série $\sum_{n=1}^{\infty} \frac{1}{n - 1/2}$ também é **divergente**.

* **Exemplo 3:** Verifique a convergência da série $\sum_{n=1}^{\infty} \frac{1}{n!}$.
  - **Análise:** O fatorial é definido por $n! = n(n-1)(n-2)\dots 3 \cdot 2 \cdot 1$. Podemos provar por indução matemática que para todo $n \ge 4$:
    $$2^{n-1} \le n! \implies \frac{1}{n!} \le \frac{1}{2^{n-1}}$$
  - A série $\sum_{n=1}^{\infty} \frac{1}{2^{n-1}}$ é uma série geométrica convergente (razão $r = \frac{1}{2} < 1$).
  - Como os primeiros termos finitos não afetam a convergência da cauda da série, pelo Critério da Comparação, a série $\sum_{n=1}^{\infty} \frac{1}{n!}$ é **convergente**.

---

## 2. Critério da Razão (ou de D'Alembert)

Seja $\sum_{n=1}^{\infty} a_n$ uma série de termos estritamente positivos ($a_n > 0$). Definimos o limite:
$$L = \lim_{n \to \infty} \frac{a_{n+1}}{a_n}$$

O critério estabelece que:
- Se **$L < 1$**, a série **converge**.
- Se **$L > 1$** (ou $L = \infty$), a série **diverge**.
- Se **$L = 1$**, o teste é **inconclusivo** (a série pode convergir ou divergir).

### Exemplos do Critério da Razão

* **Exemplo 4:** Verifique a convergência da série $\sum_{n=1}^{\infty} \left(\frac{2}{3}\right)^n$.
  - **Análise:**
    $$L = \lim_{n \to \infty} \frac{a_{n+1}}{a_n} = \lim_{n \to \infty} \frac{\left(\frac{2}{3}\right)^{n+1}}{\left(\frac{2}{3}\right)^n} = \lim_{n \to \infty} \frac{2}{3} = \frac{2}{3}$$
  - Como $L = \frac{2}{3} < 1$, a série **converge**.

* **Exemplo 5:** Verifique a convergência da série $\sum_{n=1}^{\infty} \frac{3^n}{n^2}$.
  - **Análise:**
    $$L = \lim_{n \to \infty} \left[ \frac{3^{n+1}}{(n+1)^2} \cdot \frac{n^2}{3^n} \right] = \lim_{n \to \infty} \left[ 3 \cdot \left(\frac{n}{n+1}\right)^2 \right] = 3 \cdot 1^2 = 3$$
  - Como $L = 3 > 1$, a série **diverge**.

* **Exemplo 6:** Verifique a convergência da série $\sum_{n=1}^{\infty} \frac{2^n}{n!}$.
  - **Análise:**
    $$L = \lim_{n \to \infty} \left[ \frac{2^{n+1}}{(n+1)!} \cdot \frac{n!}{2^n} \right] = \lim_{n \to \infty} \left[ \frac{2 \cdot 2^n}{(n+1) \cdot n!} \cdot \frac{n!}{2^n} \right] = \lim_{n \to \infty} \frac{2}{n+1} = 0$$
  - Como $L = 0 < 1$, a série **converge**.

---

## 3. Critério da Raiz (ou de Cauchy)

Seja $\sum_{n=1}^{\infty} a_n$ uma série de termos não negativos ($a_n \ge 0$). Definimos o limite:
$$L = \lim_{n \to \infty} \sqrt[n]{a_n}$$

O critério estabelece que:
- Se **$L < 1$**, a série **converge**.
- Se **$L > 1$** (ou $L = \infty$), a série **diverge**.
- Se **$L = 1$**, o teste é **inconclusivo**.

### Exemplos do Critério da Raiz

* **Exemplo 7:** Verifique a convergência da série $\sum_{n=1}^{\infty} \left(\frac{2}{3}\right)^n$.
  - **Análise:**
    $$L = \lim_{n \to \infty} \sqrt[n]{\left(\frac{2}{3}\right)^n} = \lim_{n \to \infty} \frac{2}{3} = \frac{2}{3}$$
  - Como $L = \frac{2}{3} < 1$, a série **converge**.

* **Exemplo 8:** Verifique a convergência da série $\sum_{n=1}^{\infty} \left(\frac{n + 1}{2n}\right)^n$.
  - **Análise:**
    $$L = \lim_{n \to \infty} \sqrt[n]{\left(\frac{n + 1}{2n}\right)^n} = \lim_{n \to \infty} \frac{n + 1}{2n} = \frac{1}{2}$$
  - Como $L = \frac{1}{2} < 1$, a série **converge**.

### Proposição Auxiliar Importante
> [!NOTE]
> Para qualquer constante real $p$ e $a > 0$:
> $$\lim_{n \to \infty} \sqrt[n]{n^p} = 1$$

* **Demonstração:**
  Seja $y = \lim_{n \to \infty} (n^p)^{1/n}$. Aplicando logaritmo natural ($\ln$):
  $$\ln(y) = \ln\left( \lim_{n \to \infty} n^{p/n} \right) = \lim_{n \to \infty} \ln(n^{p/n}) = \lim_{n \to \infty} \frac{p \ln(n)}{n}$$
  Aplicando a Regra de L'Hôpital para o limite $\lim_{n \to \infty} \frac{\ln(n)}{n}$:
  $$\lim_{n \to \infty} \frac{\frac{1}{n}}{1} = 0 \implies \ln(y) = p \cdot 0 = 0 \implies y = e^0 = 1$$
  Logo, $\lim_{n \to \infty} \sqrt[n]{n^p} = 1$.

* **Exemplo 9:** Verifique a convergência da série $\sum_{n=1}^{\infty} \frac{n}{2^n}$.
  - **Análise:**
    $$L = \lim_{n \to \infty} \sqrt[n]{\frac{n}{2^n}} = \lim_{n \to \infty} \frac{\sqrt[n]{n}}{2} = \frac{1}{2}$$
  - Como $L = \frac{1}{2} < 1$, a série **converge**.

---

## 4. Exercícios Propostos

### 1. Verifique se as seguintes séries convergem ou divergem:

#### a) $\sum_{n=1}^{\infty} \frac{n!}{n^n}$
- **Resolução:** Pelo Critério da Razão:
  $$L = \lim_{n \to \infty} \frac{a_{n+1}}{a_n} = \lim_{n \to \infty} \frac{(n+1)!}{(n+1)^{n+1}} \cdot \frac{n^n}{n!} = \lim_{n \to \infty} \frac{(n+1) \cdot n! \cdot n^n}{(n+1) \cdot (n+1)^n \cdot n!} = \lim_{n \to \infty} \left( \frac{n}{n+1} \right)^n = \lim_{n \to \infty} \frac{1}{\left(1 + \frac{1}{n}\right)^n} = \frac{1}{e}$$
  Como $e \approx 2.718$, temos $L = \frac{1}{e} < 1$. Logo, a série **converge**.

#### b) $\sum_{n=1}^{\infty} \frac{3^n n!}{n^n}$
- **Resolução:** Pelo Critério da Razão:
  $$L = \lim_{n \to \infty} \frac{3^{n+1} (n+1)!}{(n+1)^{n+1}} \cdot \frac{n^n}{3^n n!} = 3 \lim_{n \to \infty} \left( \frac{n}{n+1} \right)^n = \frac{3}{e}$$
  Como $\frac{3}{e} > 1$, a série **diverge**.

#### c) $\sum_{n=1}^{\infty} \frac{3^n (n+1)}{4^{n+1}}$
- **Resolução:** Pelo Critério da Razão:
  $$L = \lim_{n \to \infty} \frac{3^{n+1} (n+2)}{4^{n+2}} \cdot \frac{4^{n+1}}{3^n (n+1)} = \lim_{n \to \infty} \frac{3}{4} \cdot \left( \frac{n+2}{n+1} \right) = \frac{3}{4} < 1$$
  Logo, a série **converge**.

#### d) $\sum_{n=1}^{\infty} \frac{4^n}{n! + n^3}$
- **Resolução:** Pelo Critério da Razão:
  $$L = \lim_{n \to \infty} \frac{4^{n+1}}{(n+1)! + (n+1)^3} \cdot \frac{n! + n^3}{4^n} = \lim_{n \to \infty} 4 \cdot \frac{n! + n^3}{(n+1)n! + (n+1)^3} = \lim_{n \to \infty} \frac{4}{n+1} \cdot \frac{1 + \frac{n^3}{n!}}{1 + \frac{(n+1)^2}{n!}} = 0$$
  Como $L = 0 < 1$, a série **converge**.

#### e) $\sum_{n=1}^{\infty} \frac{n^2}{2^n n!}$
- **Resolução:** Pelo Critério da Razão:
  $$L = \lim_{n \to \infty} \frac{(n+1)^2}{2^{n+1} (n+1)!} \cdot \frac{2^n n!}{n^2} = \lim_{n \to \infty} \frac{1}{2(n+1)} \cdot \left( \frac{n+1}{n} \right)^2 = 0$$
  Como $L = 0 < 1$, a série **converge**.

#### f) $\sum_{n=1}^{\infty} \frac{n^2}{3^n n!}$
- **Resolução:** Semelhante à anterior:
  $$L = \lim_{n \to \infty} \frac{1}{3(n+1)} \cdot \left( \frac{n+1}{n} \right)^2 = 0 < 1$$
  Logo, a série **converge**.

---

### 2. Demonstração de Limites
Utilize o fato de que "se $\sum_{n=1}^{\infty} x_n$ converge, então $\lim_{n \to \infty} x_n = 0$" para provar os limites clássicos:

1. **$\lim_{n \to \infty} \frac{a^n}{n!} = 0$**, para todo $a > 0$.
   - *Prova:* A série $\sum_{n=1}^{\infty} \frac{a^n}{n!}$ converge pelo Critério da Razão ($L = 0$). Logo, o termo geral tende a $0$.
2. **$\lim_{n \to \infty} \frac{n!}{n^n} = 0$**.
   - *Prova:* Provado no Exercício 1(a) que $\sum_{n=1}^{\infty} \frac{n!}{n^n}$ converge. Logo, o termo geral tende a $0$.
3. **$\lim_{n \to \infty} \frac{n^p}{a^n} = 0$**, para todo $p > 0$ e $a > 1$.
   - *Prova:* A série correspondente converge pelo Critério da Razão ($L = \frac{1}{a} < 1$). Logo, o termo geral tende a $0$.

---

### 3. Verifique se as seguintes séries convergem ou divergem (Comparação e outros critérios):

#### a) $\sum_{n=1}^{\infty} \frac{1}{n}$
- **Resolução:** Diverge (Série Harmônica, $p$-série com $p = 1$).

#### b) $\sum_{n=1}^{\infty} \frac{1}{3^n + 1}$
- **Resolução:** Como $\frac{1}{3^n + 1} < \frac{1}{3^n}$ e $\sum_{n=1}^{\infty} \left(\frac{1}{3}\right)^n$ é geométrica convergente, pelo Critério da Comparação, a série **converge**.

#### c) $\sum_{n=1}^{\infty} \frac{n + 1}{n^2}$
- **Resolução:** Como $\frac{n + 1}{n^2} > \frac{n}{n^2} = \frac{1}{n}$ e a série harmônica diverge, pelo Critério da Comparação, a série **diverge**.

#### d) $\sum_{n=1}^{\infty} \frac{2^n}{3^n + 1}$
- **Resolução:** Como $\frac{2^n}{3^n + 1} < \left(\frac{2}{3}\right)^n$ e $\sum_{n=1}^{\infty} \left(\frac{2}{3}\right)^n$ é geométrica convergente, pelo Critério da Comparação, a série **converge**.

#### e) $\sum_{n=1}^{\infty} \frac{4^n}{3^n - 2}$
- **Resolução:** Como $\lim_{n \to \infty} a_n = \lim_{n \to \infty} \frac{4^n}{3^n - 2} = \infty \neq 0$, pelo Teste da Divergência, a série **diverge**.

#### f) $\sum_{n=1}^{\infty} \frac{4^n}{3^n + 2^n}$
- **Resolução:** Pelo Teste da Divergência:
  $$\lim_{n \to \infty} \frac{4^n}{3^n + 2^n} = \lim_{n \to \infty} \frac{\left(\frac{4}{3}\right)^n}{1 + \left(\frac{2}{3}\right)^n} = \infty \neq 0$$
  Logo, a série **diverge**.

#### g) $\sum_{n=1}^{\infty} \frac{\ln(n)}{n^2}$
- **Resolução:** Para todo $n$ suficientemente grande, $\ln(n) < n^p$ para qualquer $p > 0$. Escolhendo $p = 0.5$, temos $\ln(n) < \sqrt{n}$.
  Logo, $\frac{\ln(n)}{n^2} < \frac{\sqrt{n}}{n^2} = \frac{1}{n^{1.5}}$.
  Como a $p$-série $\sum_{n=1}^{\infty} \frac{1}{n^{1.5}}$ converge (pois $p = 1.5 > 1$), pelo Critério da Comparação, a série original **converge**.
