## Anotação 1: Representação Binária e Erro Relativo
**Problema:**
Dado o valor $\overline{x}=\frac{33}{20}$. 
(a) Obter a representação deste valor em formato binário, garantindo 8 algarismos corretos após a vírgula.
(b) Descobrir quantos desses algarismos binários após a vírgula são precisos para representar $\overline{x}$ com um erro relativo percentual abaixo de **5%**.

**Resolução:**
* **(a)** O valor decimal e sua conversão: $\overline{x}=\frac{33}{20}=(1,65)_{10}=(1,10\overline{1001})_{2}\approx(1,10100110)_{2}$.
* **(b) Alternativa de Solução 1:** Analisando a progressão do erro na tabela abaixo, percebe-se que são necessários no mínimo 3 algarismos após a vírgula para atingir a condição exigida.

| n | Binário | Decimal | Erro relativo percentual |
| :--- | :--- | :--- | :--- |
| 0 | $(1)_{2}$ | $(1)_{10}$ | **39,39%** |
| 1 | $(1,1)_{2}$ | $(1,5)_{10}$ | **9,09%** |
| 2 | $(1,10)_{2}$ | $(1,5)_{10}$ | **9,09%** |
| 3 | $(1,101)_{2}$ | $(1,625)_{10}$ | $1,52\%<5\%$ |

* **(b) Alternativa de Solução 2:** A exigência $\frac{|\overline{x}-1.65|}{|1.65|}$ resulta no intervalo $1.5675<\overline{x}<1.7325$.
* Podemos truncar a seguinte soma assim que ela atingir esse intervalo:
    $\overline{r}=1\times2^{0}+1\times2^{-1}+0\times2^{-2}+1\times2^{-3}+0\times2^{-4}+0\times2^{-5}+1\times2^{-6}+...$.
* O que equivale a: $\frac{1+0.5+0+0.125+0+0+0.015625+...}{=1.625}$. 
* Isso ocorre exatamente na inclusão da parcela $2^{-3}$.

---

## Anotação 2: Método da Posição Falsa
**Problema:**
(a) Fazer a interpretação geométrica do método da posição falsa e deduzir sua fórmula recursiva.
(b) Para a função $f(x)=-2+\sqrt[3]{3x}$, descobrir quantas iterações levam a um $x_{k}$ que cumpra a condição $|f(x_{k})|<10^{-4}$. A busca deve partir do intervalo $I=[2,4]$, adotando 5 casas decimais.

**Resolução:**
* **(a)** A dinâmica do método consiste em dividir um intervalo fechado que possui a raiz em dois subintervalos, selecionando um deles para o passo seguinte. 
* Diferente do método da bissecção (que usa o ponto médio de $[a,b]$), a divisão aqui ocorre pela média ponderada das extremidades, considerando os valores da função $f$ nelas.
* Geometricamente, ligamos os pontos coordenados $(a,f(a))$ e $(b,f(b))$ através de uma reta e determinamos a interseção desta reta com o eixo horizontal.
* **(b)** Iterações iniciais arredondadas na quinta casa decimal:

| $k$ | $a_{k}$ | $b_{k}$ | $f(a_{k})$ | $f(b_{k})$ | $x_{k}$ | $f(x_{k})$ | Teste $f(a_{k})\cdot f(x_{k})$ |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 0 | 2 | 4 | -0.18288 | 0.28943 | 2.77441 | 0.02658 | $>0$ |
| 1 | 2 | 2.77441 | -0.18288 | 0.02658 | 2.67614 | 0.00237 | $>0$ |
| 2 | 2 | 2.67614 | -0.18288 | 0.00237 | 2.66749 | 0.00021 | $>0$ |
| 3 | 2 | 2.66749 | -0.18288 | 0.00021 | 2.66672 | 0.00001 | $>0$ |
| 4 | 2 | 2.66672 | -0.18288 | 0.00001 | 2.66668 | 0.00000 | $=0$ |

* No passo 4, atingimos $|f(x_{4})|=0.00000<10^{-4}$.
* Conclui-se que o valor $x_{4}=2.66672$ é a aproximação desejada, necessitando assim de 4 iterações.

---

## Anotação 3: Método de Newton-Raphson
**Problema:**
Sabe-se que $f(x)=2e^{x}+3x^{3}$ tem uma única raiz $\overline{x}\in\mathbb{R}$. É preciso estipular um intervalo para essa raiz e aplicar o método de Newton-Raphson até encontrar $|f(x_{k})|<10^{-4}$. Por fim, deve-se avaliar o erro relativo percentual da estimativa utilizando 5 algarismos.

**Resolução:**
* Sendo $f$ uma função contínua, temos os valores $f(-1)=\frac{2}{e}-3\approx-2.3<0$ e $f(0)=2>0$.
* Isso garante a existência de uma raiz dentro do intervalo $I=(-1,0)$.
* Adotando $x_{0}=-1/2$ como a aproximação inicial e calculando:

| $k$ | $x_{k-1}$ | $f(x_{k-1})$ | $f^{\prime}(x_{k-1})$ | $\frac{f(x_{k-1})}{f^{\prime}(x_{k-1})}$ | $x_{k}=x_{k-1}-\frac{f(x_{k-1})}{f^{\prime}(x_{k-1})}$ |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | -0.50000 | 0.83806 | 3.46306 | 0.242 | -0.742 |
| 2 | -0.74200 | -0.27323 | 5.9074 | -0.04625 | -0.69575 |
| 3 | -0.69575 | -0.01297 | 5.35401 | -0.00242 | -0.69333 |
| 4 | -0.69333 | -0.00005 | - | - | - |

* O critério $|f(x_{4})|<10^{-4}$ é alcançado com a aproximação $x_{4}\approx-0.69333$.
* O cálculo estimado do erro nos dá a seguinte porcentagem:
    $\epsilon_{per}\approx\frac{|x_{4}-x_{3}|}{|x_{4}|}\times100\%=\frac{|-0.69333-(-0.69575)|}{|-0.69333|}\times100\%=\frac{0.00242}{0.69333}\times100\%\approx0.3490\%$.

---

## Anotação 4: Iteração de Ponto Fixo
**Problema:**
A partir de $f(x)=4e^{x}+x^{3}$.
(a) Achar uma função de iteração para a qual se garanta a convergência usando $x_{0}=-1$.
(b) Executar o método até obter um erro estimado de $|x_{k}-x_{k-1}|<0,05$, listando $x_{k}$, $f(x_{k})$ e o erro absoluto passo a passo.

**Resolução:**
* **(a)** Isolando o $x$, a equação $4e^{x}+x^{3}=0$ é adaptada para a forma $x=-\sqrt[3]{4e^{x}}=-\sqrt[3]{4}e^{x/3}$.
* Utilizando $\varphi(x)=-\sqrt[3]{4}e^{x/3}$ (uma função contínua em $\mathbb{R}$), temos a derivada $|\varphi^{\prime}(x)|=\frac{\sqrt[3]{4}}{3}e^{x/3}$.
* A condição de convergência é $|\varphi^{\prime}(x)|<1$, que se desdobra em $e^{x/3}<\frac{3}{\sqrt[3]{4}}$ e, por consequência, $x<3~ln(\frac{3}{\sqrt[3]{4}})\approx1.90954$.
* Como qualquer $x_{0}<1.9$ garante convergência, o uso de $x_{0}=-1$ cumpre a condição estipulada.
* **(b)** Construindo a sequência recursiva $x_{k}=-\sqrt[3]{4}e^{(x_{k-1})/3}$ para $k\ge1$:

| $k$ | $x_{k}$ | $f(x_{k})$ | $\|x_{k}-x_{k-1}\|$ |
| :--- | :--- | :--- | :--- |
| 0 | -1.000 | 0.472 | - |
| 1 | -1.137 | -0.187 | 0.137 |
| 2 | -1.087 | 0.065 | 0.05 |
| 3 | -1.105 | -0.024 | 0.018 |

* Atingimos a meta na iteração 3, pois $|x_{3}-x_{2}|\approx0.018<0.05$. A aproximação obtida é $x_{3}=-1.105$.

---

## Anotação 5: Método da Secante
**Problema:**
Encontrar a raiz da função $f(x)=2~ln(x)-3~ln(x-1)$ restringindo o erro relativo a $10^{-2}$.

**Resolução:**
* Levantamento de valores para delimitar a raiz:

| $X$ | 2 | 3 | 4 | 5 |
| :--- | :--- | :--- | :--- | :--- |
| $f(x)$ | 1.4 | 0.1 | -0.5 | -0.9 |

* Como há variação de sinal entre os pontos, confirmamos que a raiz está presente no intervalo $I=[3,4]$.
* Conduzindo as iterações e assumindo $x_{-1}=3$ e $x_{0}=4$, com uso de 4 dígitos decimais:

| $k$ | $x_{k-1}$ | $x_{k}$ | $x_{k}-x_{k-1}$ | $f(x_{k})$ | $f(x_{k-1})$ *(Aproximação implícita)* |
| :--- | :--- | :--- | :--- | :--- | :--- |
| -1 | - | 3.0000 | - | 0.1178 | - |
| 0 | 3.0000 | 4.0000 | -0.8163 | -0.5233 | 0.2500 |
| 1 | 4.0000 | 3.1837 | -0.0444 | -0.0270 | 0.2564 |
| 2 | 3.1837 | 3.1393 | 0.0087 | 0.0066 | 0.0141 |
| 3 | 3.1393 | 3.1480 | 0.0001 | -0.0001 | 0.0028 |

* Temos como resultado a aproximação $x_{3}=3.1393$, com a verificação de erro confirmada: $|x_{3}-x_{2}|/|x_{3}|\approx0.0028<10^{-2}$.

---

## Anotação 6: Modelação com Tanque Esférico
**Problema:**
O volume $V$ acumulado em um tanque em formato de esfera (de raio $r$) tem ligação com a profundidade $h$ por meio da fórmula $V=\frac{\pi h^{2}(3r-h)}{3}$. Determinar $h$ respeitando um erro máximo de $10^{-2}$, considerando as constantes do tanque dadas no exercício.

**Resolução:**
* Empregando os valores predefinidos de $V=2$ e $r=1$ na fórmula, temos: $2=\frac{\pi h^{2}(3-h)}{3}$.
* Essa profundidade $h$ só faz sentido real entre os valores nulo e o diâmetro da esfera, portanto deve ser um valor contido em $[0,2r]=[0,2]$.
* Podemos reescrever a situação como a busca pela raiz da função $f(x)=\frac{\pi x^{2}(3-x)}{3}-2=-\frac{\pi}{3}x^{3}+\pi x^{2}-2$.
* Solucionando via método de Newton-Raphson, encontramos:

| $k$ | $x_{k-1}$ | $f(x_{k-1})$ | $f^{\prime}(x_{k-1})$ | $\frac{f(x_{k-1})}{f^{\prime}(x_{k-1})}$ | $x_{k}=x_{k-1}-\frac{f(x_{k-1})}{f^{\prime}(x_{k-1})}$ |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 1.0000 | 0.0944 | 3.1416 | 0.0300 | 0.9700 |
| 2 | 0.9700 | 0.0002 | 3.1388 | 0.0001 | 0.9699 |

* O erro absoluto é verificado logo no segundo passo: $\epsilon_{abs}\approx|x_{2}-x_{1}|=0.0001<10^{-2}$.