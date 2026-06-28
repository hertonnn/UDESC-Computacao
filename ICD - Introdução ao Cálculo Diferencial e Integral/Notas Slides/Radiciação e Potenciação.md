# Radiciação e Potenciação

## Radicais

### Definição: Raiz $n$-ésima de um número real
Dado um número $n$ inteiro maior do que $1$, e $a$ e $b$ números reais:

1. Se $b^n = a$, então $b$ é uma **raiz $n$-ésima** de $a$. Escrevemos:
   $$\sqrt[n]{a} = b \iff b^n = a$$
   *(Para $n$ par, convenciona-se que $\sqrt[n]{a} \ge 0$)*
2. O símbolo $\sqrt{\quad}$ é conhecido por **radical**, $a$ é o **radicando** e $n$ é o **índice** do radical.
3. Se $a$ possui uma raiz $n$-ésima real, então a sua **principal raiz $n$-ésima** terá o mesmo sinal de $a$ (para $n$ ímpar).

---

### Exemplo 1: Verificação das raízes $n$-ésimas principais
* **a)** $\sqrt{36} = 6$, pois $6^2 = 36$.
* **b)** $\sqrt[3]{\frac{27}{8}} = \frac{3}{2}$, pois $\left(\frac{3}{2}\right)^3 = \frac{27}{8}$.
* **c)** $\sqrt[3]{-\frac{27}{8}} = -\frac{3}{2}$, pois $\left(-\frac{3}{2}\right)^3 = -\frac{27}{8}$.
* **d)** $\sqrt[4]{-625}$ não é um número real, pois o índice $4$ é par e o radicando $-625$ é negativo (não existe número real cuja quarta potência seja negativa).

---

## Propriedades dos Radicais
Considere $u$ e $v$ números reais (variáveis ou expressões algébricas) e $m$ e $n$ inteiros positivos maiores do que $1$. Supomos que todas as raízes consideradas são números reais e todos os denominadores são diferentes de zero.

| Propriedade | Exemplo |
| :--- | :--- |
| **1.** $\sqrt[n]{uv} = \sqrt[n]{u} \cdot \sqrt[n]{v}$ | $\sqrt{75} = \sqrt{25 \cdot 3} = \sqrt{25} \cdot \sqrt{3} = 5\sqrt{3}$ |
| **2.** $\sqrt[n]{\frac{u}{v}} = \frac{\sqrt[n]{u}}{\sqrt[n]{v}}$ | $\frac{\sqrt[4]{96}}{\sqrt[4]{6}} = \sqrt[4]{\frac{96}{6}} = \sqrt[4]{16} = 2$ |
| **3.** $\sqrt[m]{\sqrt[n]{u}} = \sqrt[m \cdot n]{u}$ | $\sqrt{\sqrt[3]{7}} = \sqrt[2 \cdot 3]{7} = \sqrt[6]{7}$ |
| **4.** $\left(\sqrt[n]{u}\right)^n = u$ | $\left(\sqrt[4]{5}\right)^4 = 5$ |
| **5.** $\sqrt[n]{u^m} = \left(\sqrt[n]{u}\right)^m$ | $\sqrt[3]{27^2} = \left(\sqrt[3]{27}\right)^2 = 3^2 = 9$ |
| **6.** $\sqrt[n]{u^n} = \begin{cases} \lvert u \rvert, & \text{se } n \text{ for par} \\ u, & \text{se } n \text{ for ímpar} \end{cases}$ | $\sqrt{(-6)^2} = \lvert -6 \rvert = 6$<br>$\sqrt[3]{(-6)^3} = -6$ |

---

## Simplificação de Expressões com Radicais

### Exemplo 2: Remoção de fatores dos radicandos
* **a)**
  $$\sqrt[4]{80} = \sqrt[4]{16 \cdot 5} = \sqrt[4]{2^4 \cdot 5} = \sqrt[4]{2^4} \cdot \sqrt[4]{5} = 2\sqrt[4]{5}$$
* **b)**
  $$\sqrt{18x^5} = \sqrt{9x^4 \cdot 2x} = \sqrt{(3x^2)^2 \cdot 2x} = 3x^2\sqrt{2x}$$
* **c)**
  $$\sqrt[4]{x^4y^4} = \sqrt[4]{(xy)^4} = \lvert xy \rvert$$
* **d)**
  $$\sqrt[3]{-24y^6} = \sqrt[3]{(-2y^2)^3 \cdot 3} = -2y^2\sqrt[3]{3}$$

---

## Racionalização
Racionalizar uma fração consiste em eliminar os radicais de seu denominador multiplicando o numerador e o denominador por um fator racionalizante adequado.

### Exemplo 3: Exemplos de racionalização
* **a)**
  $$\sqrt{\frac{2}{3}} = \frac{\sqrt{2}}{\sqrt{3}} = \frac{\sqrt{2}}{\sqrt{3}} \cdot \frac{\sqrt{3}}{\sqrt{3}} = \frac{\sqrt{6}}{3}$$
* **b)**
  $$\frac{1}{\sqrt[4]{x}} = \frac{1}{\sqrt[4]{x}} \cdot \frac{\sqrt[4]{x^3}}{\sqrt[4]{x^3}} = \frac{\sqrt[4]{x^3}}{\sqrt[4]{x^4}} = \frac{\sqrt[4]{x^3}}{\lvert x \rvert}$$
* **c)**
  $$\sqrt[5]{\frac{x^2}{y^3}} = \frac{\sqrt[5]{x^2}}{\sqrt[5]{y^3}} = \frac{\sqrt[5]{x^2}}{\sqrt[5]{y^3}} \cdot \frac{\sqrt[5]{y^2}}{\sqrt[5]{y^2}} = \frac{\sqrt[5]{x^2y^2}}{\sqrt[5]{y^5}} = \frac{\sqrt[5]{x^2y^2}}{y}$$

---

## Potenciação com Expoentes Racionais

### Definição: Expoentes Racionais
Seja $u$ um número real (ou expressão algébrica) e $n$ um inteiro maior do que $1$. Define-se:
$$u^{1/n} = \sqrt[n]{u}$$

Se $m$ é um inteiro positivo, e a fração $\frac{m}{n}$ está na sua forma reduzida:
$$u^{m/n} = \left(u^{1/n}\right)^m = \left(\sqrt[n]{u}\right)^m \quad \text{e} \quad u^{m/n} = \left(u^m\right)^{1/n} = \sqrt[n]{u^m}$$
*(Supõe-se que todas as raízes consideradas existem no conjunto dos números reais)*

---

### Exemplo 4: Conversão de radicais para potências e vice-versa
* **a)** $\sqrt{(x+y)^3} = (x+y)^{3/2}$
* **b)** $3x\sqrt[5]{x^2} = 3x \cdot x^{2/5} = 3x^{7/5}$
* **c)** $x^{2/3}y^{1/3} = (x^2y)^{1/3} = \sqrt[3]{x^2y}$
* **d)** $z^{-3/2} = \frac{1}{z^{3/2}} = \frac{1}{\sqrt{z^3}}$

---

### Exemplo 5: Simplificação de expressões com potências
* **a)**
  $$(x^2y^9)^{1/3}(xy^2) = (x^{2/3}y^3)(xy^2) = x^{2/3+1}y^{3+2} = x^{5/3}y^5$$
* **b)**
  $$\left(\frac{3x^{2/3}}{y^{1/2}}\right)\left(\frac{2x^{-1/2}}{y^{2/5}}\right) = \frac{6x^{2/3 - 1/2}}{y^{1/2 + 2/5}} = \frac{6x^{1/6}}{y^{9/10}}$$
  > **Passo a passo dos expoentes:**
  > - Numerador ($x$): $\frac{2}{3} - \frac{1}{2} = \frac{4-3}{6} = \frac{1}{6}$
  > - Denominador ($y$): $\frac{1}{2} + \frac{2}{5} = \frac{5+4}{10} = \frac{9}{10}$

---

### Exemplo 6: Simplificação de expressões com radicais
* **a)**
  $$2\sqrt{80} - \sqrt{125} = 2\sqrt{16 \cdot 5} - \sqrt{25 \cdot 5} = 2(4\sqrt{5}) - 5\sqrt{5} = 8\sqrt{5} - 5\sqrt{5} = 3\sqrt{5}$$
* **b)**
  $$\sqrt{4x^2y} - \sqrt{y^3} = \sqrt{(2x)^2y} - \sqrt{y^2y} = 2\lvert x \rvert\sqrt{y} - \lvert y \rvert\sqrt{y} = (2\lvert x \rvert - \lvert y \rvert)\sqrt{y}$$
