# UDESC–CCT–DCC — Prova #1 (PIM) — Soluções

---

# Questão 1 (2,0) — Cross-fading entre duas fotos de 1937

## 1.1 O problema

Existem duas fotos da mesma fachada, tomadas com **a mesma câmera, do mesmo ponto de vista, com mesmas dimensões e mesmo enquadramento**:

- **I₁** → 01/01/1937
- **I₂** → 31/12/1937

Deseja-se **sintetizar** uma imagem **I(t)** que represente (aproximadamente) a fachada em uma data **t** qualquer dentro desse intervalo.

Como o enquadramento e as dimensões são idênticos, os **pixels das duas imagens são correspondentes um a um**: o pixel (linha *i*, coluna *j*) de I₁ e o de I₂ retratam **o mesmo ponto físico da fachada**. Isso é exatamente a hipótese que o *cross-fading* (mistura/blending) exige — não é necessário registro (alinhamento) prévio.

## 1.2 A ideia do cross-fading

O *cross-fading* é uma **interpolação linear (LERP) pixel a pixel** entre as duas imagens, controlada por um peso α ∈ [0, 1]:

$$I(i,j) = (1-\alpha)\cdot I_1(i,j) + \alpha\cdot I_2(i,j)$$

- α = 0 → devolve exatamente I₁ (01/01/1937)
- α = 1 → devolve exatamente I₂ (31/12/1937)
- 0 < α < 1 → uma fachada "meio caminho": as regiões que mudaram (tinta desbotando, vegetação crescendo, rachadura surgindo) aparecem em transição gradual; as regiões que **não** mudaram permanecem idênticas (pois (1−α)·v + α·v = v).

Se as imagens forem coloridas, aplica-se a **mesma α em cada canal** R, G e B separadamente.

```
I1 (01/01)          I(t) = mistura            I2 (31/12)
┌──────────┐        ┌──────────┐              ┌──────────┐
│  ▓▓▓▓▓▓  │        │  ▒▒▒▒▒▒  │              │  ░░░░░░  │
│  ▓ fachada        │  ▒ fachada              │  ░ fachada
│  ▓▓▓▓▓▓  │  ───►  │  ▒▒▒▒▒▒  │  ◄───        │  ░░░░░░  │
└──────────┘        └──────────┘              └──────────┘
   α = 0            α = dias/364                 α = 1
```

## 1.3 A escala baseada nos dias decorridos

O peso α deve ser **proporcional ao tempo decorrido**:

$$\alpha = \frac{\text{dias entre } 01/01/1937 \text{ e } t}{\text{dias entre } 01/01/1937 \text{ e } 31/12/1937}$$

1937 **não foi bissexto** → fevereiro com 28 dias → o ano tem **365 dias**, e:

- dia-do-ano(01/01/1937) = **1**
- dia-do-ano(31/12/1937) = **365**
- **Denominador = 365 − 1 = 364 dias**

$$\boxed{\alpha(t) = \frac{\text{diaDoAno}(t) - 1}{364}}$$

Dias acumulados até o final de cada mês em 1937 (não bissexto):

| Mês | Dias | Acumulado |
|---|---|---|
| Jan | 31 | 31 |
| Fev | 28 | 59 |
| Mar | 31 | 90 |
| Abr | 30 | 120 |
| Mai | 31 | 151 |
| Jun | 30 | 181 |
| Jul | 31 | 212 |
| Ago | 31 | 243 |
| Set | 30 | 273 |
| Out | 31 | 304 |
| Nov | 30 | 334 |
| Dez | 31 | 365 |

**Exemplo:** t = 15/07/1937 → diaDoAno = 181 + 15 = 196 → α = (196 − 1)/364 = 195/364 ≈ **0,5357**.
Um pixel que valia 60 em I₁ e 200 em I₂ resulta em 0,4643·60 + 0,5357·200 = **175**.

## 1.4 Pseudocódigo

```
// ---------- utilitários de data ----------
FUNÇÃO ehBissexto(ano):
    RETORNE (ano mod 4 == 0 E ano mod 100 != 0) OU (ano mod 400 == 0)

FUNÇÃO diasDoMes(mes, ano):
    SE mes EM {4, 6, 9, 11}          ENTÃO RETORNE 30
    SE mes == 2                      ENTÃO RETORNE (ehBissexto(ano) ? 29 : 28)
    SENÃO                                  RETORNE 31          // 1,3,5,7,8,10,12

FUNÇÃO diaDoAno(dia, mes, ano):
    n ← dia
    PARA m ← 1 ATÉ mes-1 FAÇA
        n ← n + diasDoMes(m, ano)
    RETORNE n

// ---------- cross-fading ----------
ENTRADA : I1 (imagem de 01/01/1937), I2 (imagem de 31/12/1937),
          data-alvo t = (dia, mes, ano=1937)
SAÍDA   : I (imagem sintetizada para a data t)

INÍCIO
    // 0) pré-condições
    SE dimensoes(I1) != dimensoes(I2) ENTÃO ERRO "imagens incompatíveis"
    SE t < 01/01/1937 OU t > 31/12/1937 ENTÃO ERRO "data fora do intervalo"

    // 1) escala temporal
    D_total  ← diaDoAno(31,12,1937) - diaDoAno(1,1,1937)   // 365 - 1 = 364
    D_passado← diaDoAno(dia,mes,1937) - diaDoAno(1,1,1937) // 0 .. 364
    alpha    ← D_passado / D_total                          // 0.0 .. 1.0

    // 2) mistura pixel a pixel (por canal)
    PARA i ← 0 ATÉ altura-1 FAÇA
        PARA j ← 0 ATÉ largura-1 FAÇA
            PARA CADA canal k EM {R, G, B} FAÇA
                v ← (1 - alpha) * I1[i][j][k] + alpha * I2[i][j][k]
                I[i][j][k] ← arredonda( limita(v, 0, 255) )
            FIM PARA
        FIM PARA
    FIM PARA

    RETORNE I
FIM
```

## 1.5 Observações / limitações (parte da justificativa)

1. **Só funciona porque há correspondência pixel-a-pixel.** Mesma câmera, mesmo ponto de vista e mesmo enquadramento garantem isso. Se houvesse deslocamento, seria necessário **registro** (homografia / alinhamento) antes do blending.
2. O resultado é uma **estimativa**, não uma fotografia real: o cross-fading assume que **toda mudança na fachada ocorreu de forma linear e contínua ao longo do ano**. Se a casa foi repintada em um único dia de setembro, o modelo linear produzirá um resultado irreal (a tinta "aparece" gradualmente desde janeiro).
3. Regiões que não mudaram são reproduzidas **exatamente**, sem borrão — é uma propriedade desejável da combinação convexa.
4. Em regiões que mudaram, ocorre o efeito de **fantasma/transparência** (as duas aparências coexistem com pesos complementares); é o comportamento esperado do cross-fading.
5. Os cálculos devem ser feitos em **ponto flutuante** e só então arredondados e saturados para [0, 255], evitando erro de truncamento acumulado.

---

# Questão 2 (2,0) — Padrão Bayer: interpolação por média dos vizinhos

## 2.1 A matriz CFA (Color Filter Array)

|  | 0 | 1 | 2 | 3 | 4 |
|---|---|---|---|---|---|
| **0** | 120 **R** | 150 **G** | 120 **R** | 150 **G** | 120 **R** |
| **1** | 150 **G** | 120 **B** | 240 **G** | 120 **B** | 150 **G** |
| **2** | 120 **R** | 240 **G** | 120 **R** | 240 **G** | 120 **R** |
| **3** | 150 **G** | 120 **B** | 240 **G** | 120 **B** | 150 **G** |
| **4** | 120 **R** | 150 **G** | 120 **R** | 150 **G** | 120 **R** |

Padrão: **R** em (linha par, coluna par), **B** em (linha ímpar, coluna ímpar), **G** nas demais posições (padrão RGGB, com o dobro de amostras de verde).

**Região pedida:** linhas 1–3, colunas 1–3 (o bloco destacado).

## 2.2 Expressões de interpolação (média dos vizinhos)

Cada pixel mede **apenas um** canal; os outros dois são **estimados** pela média dos vizinhos que possuem o canal faltante. Sendo (i,j) a posição:

**(a) Em um pixel R** — faltam G e B:
$$G(i,j)=\frac{G(i-1,j)+G(i+1,j)+G(i,j-1)+G(i,j+1)}{4} \quad \text{(4 vizinhos em cruz)}$$
$$B(i,j)=\frac{B(i-1,j-1)+B(i-1,j+1)+B(i+1,j-1)+B(i+1,j+1)}{4} \quad \text{(4 diagonais)}$$

**(b) Em um pixel B** — faltam G e R (simétrico ao anterior):
$$G(i,j)=\frac{G(i-1,j)+G(i+1,j)+G(i,j-1)+G(i,j+1)}{4}$$
$$R(i,j)=\frac{R(i-1,j-1)+R(i-1,j+1)+R(i+1,j-1)+R(i+1,j+1)}{4}$$

**(c) Em um pixel G** — faltam R e B, e a média é de **apenas 2 vizinhos**, na direção em que eles existem:

- G em **linha par** (vizinhos R à esquerda/direita, B acima/abaixo):
$$R(i,j)=\frac{R(i,j-1)+R(i,j+1)}{2}, \qquad B(i,j)=\frac{B(i-1,j)+B(i+1,j)}{2}$$
- G em **linha ímpar** (vizinhos B à esquerda/direita, R acima/abaixo):
$$R(i,j)=\frac{R(i-1,j)+R(i+1,j)}{2}, \qquad B(i,j)=\frac{B(i,j-1)+B(i,j+1)}{2}$$

**(d)** O canal **medido** no próprio pixel é mantido sem alteração.

## 2.3 Cálculos para a região (linhas 1–3, colunas 1–3)

### Canal **R**

Todas as amostras R da matriz valem **120** — (0,0), (0,2), (0,4), (2,0), (2,2), (2,4), (4,0), (4,2), (4,4). Logo qualquer média (de 2 ou de 4 vizinhos) resulta em 120. Exemplos:

- (2,2) é pixel R → **R = 120** (valor medido)
- (1,2) é G de linha ímpar → R = [R(0,2)+R(2,2)]/2 = (120+120)/2 = **120**
- (2,1) é G de linha par → R = [R(2,0)+R(2,2)]/2 = (120+120)/2 = **120**
- (1,1) é B → R = [R(0,0)+R(0,2)+R(2,0)+R(2,2)]/4 = 480/4 = **120**

$$R=\begin{bmatrix}120&120&120\\120&120&120\\120&120&120\end{bmatrix}$$

### Canal **G**

- (1,1) **B** → G = [G(0,1)+G(2,1)+G(1,0)+G(1,2)]/4 = (150+240+150+240)/4 = 780/4 = **195**
- (1,2) **G** → **240** (medido)
- (1,3) **B** → G = [G(0,3)+G(2,3)+G(1,2)+G(1,4)]/4 = (150+240+240+150)/4 = **195**
- (2,1) **G** → **240** (medido)
- (2,2) **R** → G = [G(1,2)+G(3,2)+G(2,1)+G(2,3)]/4 = (240+240+240+240)/4 = **240**
- (2,3) **G** → **240** (medido)
- (3,1) **B** → G = [G(2,1)+G(4,1)+G(3,0)+G(3,2)]/4 = (240+150+150+240)/4 = **195**
- (3,2) **G** → **240** (medido)
- (3,3) **B** → G = [G(2,3)+G(4,3)+G(3,2)+G(3,4)]/4 = (240+150+240+150)/4 = **195**

$$G=\begin{bmatrix}195&240&195\\240&240&240\\195&240&195\end{bmatrix}$$

### Canal **B**

Todas as amostras B — (1,1), (1,3), (3,1), (3,3) — valem **120**. Logo:

- (1,1), (1,3), (3,1), (3,3) → **120** (medidos)
- (1,2) G de linha ímpar → B = [B(1,1)+B(1,3)]/2 = **120**
- (2,1) G de linha par → B = [B(1,1)+B(3,1)]/2 = **120**
- (2,2) R → B = [B(1,1)+B(1,3)+B(3,1)+B(3,3)]/4 = **120**

$$B=\begin{bmatrix}120&120&120\\120&120&120\\120&120&120\end{bmatrix}$$

## 2.4 Resultado (imagem RGB 3×3)

| | col 1 | col 2 | col 3 |
|---|---|---|---|
| **linha 1** | (120, 195, 120) | (120, 240, 120) | (120, 195, 120) |
| **linha 2** | (120, 240, 120) | (120, 240, 120) | (120, 240, 120) |
| **linha 3** | (120, 195, 120) | (120, 240, 120) | (120, 195, 120) |

Interpretação: R e B são **constantes**, logo toda a variação da imagem está no **verde** — a região é um padrão em "cruz" mais verde (240) sobre um fundo de verde menor (195) nas quinas.

---

# Questão 3 (2,0) — Conversão RGB → tons de cinza

## 3.1 Expressão utilizada

Média aritmética dos três canais (média simples, que trata os canais com pesos iguais):

$$\boxed{\,\text{Cinza}(i,j)=\frac{R(i,j)+G(i,j)+B(i,j)}{3}\,}$$

## 3.2 Cálculos

Como R = B = 120 em toda a região, o resultado depende só de G:

- Onde G = 195: (120 + 195 + 120)/3 = 435/3 = **145**
- Onde G = 240: (120 + 240 + 120)/3 = 480/3 = **160**

## 3.3 Imagem de saída em tons de cinza

$$\text{Cinza}=\begin{bmatrix}145&160&145\\160&160&160\\145&160&145\end{bmatrix}$$

> **Alternativa (luminância ponderada, ITU-R BT.601):** Cinza = 0,299·R + 0,587·G + 0,114·B, que reflete melhor a sensibilidade do olho ao verde. Daria 0,299·120 + 0,587·195 + 0,114·120 = **164** e 0,299·120 + 0,587·240 + 0,114·120 = **190**. O padrão da resposta (145/160) corresponde à **média simples**; qualquer das duas é válida desde que a expressão seja declarada — e, importante, **ambas preservam a mesma ordenação** (cruz mais clara que as quinas), então a questão 4 chega ao mesmo resultado binário.

---

# Questão 4 (2,0) — Limiarização por Isodata

## 4.1 O algoritmo Isodata (limiar iterativo)

Ideia: o limiar ideal separa a imagem em dois grupos (objeto e fundo) de modo que ele fique **exatamente no ponto médio entre as médias dos dois grupos**. Isso é obtido iterativamente:

1. Escolhe-se um limiar inicial T₀ (usualmente (mín + máx)/2 ou a média da imagem).
2. Particiona-se a imagem: G₁ = {p ≤ T} e G₂ = {p > T}.
3. Calculam-se as médias μ₁ e μ₂ de cada grupo.
4. T_novo = (μ₁ + μ₂)/2.
5. Repete-se de 2 até |T_novo − T| < ε (convergência).

## 4.2 Pseudocódigo do Isodata

```
ENTRADA: imagem em tons de cinza  I[M][N],  tolerância ε (ex.: 0.5)
SAÍDA  : limiar L

INÍCIO
    T ← ( min(I) + max(I) ) / 2            // ou T ← média(I)
    REPITA
        soma1 ← 0 ; n1 ← 0                 // grupo "escuro"  (p <= T)
        soma2 ← 0 ; n2 ← 0                 // grupo "claro"   (p >  T)

        PARA i ← 0 ATÉ M-1 FAÇA
            PARA j ← 0 ATÉ N-1 FAÇA
                SE I[i][j] <= T ENTÃO
                    soma1 ← soma1 + I[i][j] ; n1 ← n1 + 1
                SENÃO
                    soma2 ← soma2 + I[i][j] ; n2 ← n2 + 1
                FIM SE
            FIM PARA
        FIM PARA

        SE n1 == 0 OU n2 == 0 ENTÃO PARE    // partição degenerada
        mu1 ← soma1 / n1
        mu2 ← soma2 / n2
        T_novo ← (mu1 + mu2) / 2

        delta ← |T_novo - T|
        T ← T_novo
    ATÉ QUE delta < ε

    L ← T
    RETORNE L
FIM
```

## 4.3 Pseudocódigo da limiarização (binarização)

```
ENTRADA: imagem em tons de cinza I[M][N], limiar L
SAÍDA  : imagem binária B[M][N]

INÍCIO
    PARA i ← 0 ATÉ M-1 FAÇA
        PARA j ← 0 ATÉ N-1 FAÇA
            SE I[i][j] > L ENTÃO
                B[i][j] ← 1          // pixel de interesse (objeto)
            SENÃO
                B[i][j] ← 0          // fundo
            FIM SE
        FIM PARA
    FIM PARA
    RETORNE B
FIM
```

## 4.4 Execução sobre a matriz da questão 3

Imagem: quatro pixels de **145** (quinas) e cinco pixels de **160** (cruz). Histograma: {145 → 4, 160 → 5}.

**Inicialização:** T₀ = (mín + máx)/2 = (145 + 160)/2 = **152,5**

**Iteração 1:**
- G₁ = {p ≤ 152,5} = {145, 145, 145, 145} → μ₁ = **145,0**
- G₂ = {p > 152,5} = {160, 160, 160, 160, 160} → μ₂ = **160,0**
- T₁ = (145,0 + 160,0)/2 = **152,5**

**|T₁ − T₀| = 0 → convergiu na primeira iteração.**

$$\boxed{L = 152,5 \;(\approx 152\ \text{após truncamento})}$$

> Partindo da média da imagem (1380/9 = 153,33) chega-se ao mesmo ponto fixo em uma iteração — o resultado é **independente da inicialização** neste caso, porque só existem dois níveis de cinza.

## 4.5 Imagem binária de saída

Aplicando `B = 1 se Cinza > 152,5, senão 0`:

| Cinza | | | | | Binária | | |
|---|---|---|---|---|---|---|---|
| 145 | 160 | 145 | → | | **0** | **1** | **0** |
| 160 | 160 | 160 | → | | **1** | **1** | **1** |
| 145 | 160 | 145 | → | | **0** | **1** | **0** |

$$B=\begin{bmatrix}0&1&0\\1&1&1\\0&1&0\end{bmatrix}$$

A cruz central (regiões com maior componente verde) foi separada corretamente do fundo das quinas.

---

# Questão 5 (2,0) — Câmera pinhole, projeção e escolha de sensor

## 5.1 Parâmetros

| Grandeza | Valor |
|---|---|
| Distância focal *d* | 10 mm |
| Lado do pixel *s* | 0,1 mm |
| Centro do sensor (O_x, O_y) | (4096, 4096) px |
| Sensor | binário (aceso/apagado) |
| Distância do objeto (Z dos pontos) | 10,0 mm |

Matriz de projeção:

$$M_{projecao}=\begin{pmatrix}1&0&0\\0&1&0\\0&0&1/d\end{pmatrix}$$

**Pontos (Tabela 1, em mm):**

| Ponto | X | Y | Z |
|---|---|---|---|
| a | 10,24 | 10,24 | 10,0 |
| b | 10,25 | 10,25 | 10,0 |
| c | 10,24 | 10,25 | 10,0 |

---

## A) Coordenadas em pixels das projeções de a, b e c

### Passo 1 — aplicar a matriz (coordenadas homogêneas)

$$M_{proj}\begin{pmatrix}X\\Y\\Z\end{pmatrix}=\begin{pmatrix}X\\Y\\Z/d\end{pmatrix}=\begin{pmatrix}x'\\y'\\w\end{pmatrix}$$

### Passo 2 — divisão homogênea (normalização por w)

$$x=\frac{x'}{w}=\frac{X}{Z/d}=d\frac{X}{Z}, \qquad y=\frac{y'}{w}=d\frac{Y}{Z}$$

Com **d = 10 mm e Z = 10 mm**, a ampliação é

$$m=\frac{d}{Z}=\frac{10}{10}=1$$

ou seja, **a imagem tem o mesmo tamanho do objeto** (1 mm no objeto = 1 mm no sensor).

| Ponto | w = Z/d | x = dX/Z (mm) | y = dY/Z (mm) |
|---|---|---|---|
| a | 1,0 | 10,24 | 10,24 |
| b | 1,0 | 10,25 | 10,25 |
| c | 1,0 | 10,24 | 10,25 |

### Passo 3 — métrico → pixel

Com origem no canto superior esquerdo (a linha *v* cresce para baixo, Y cresce para cima):

$$u = O_x + \frac{x}{s} \qquad\qquad v = O_y - \frac{y}{s}$$

| Ponto | x/s (px) | y/s (px) | u | v | **truncado (u, v)** |
|---|---|---|---|---|---|
| a | 102,4 | 102,4 | 4198,4 | 3993,6 | **(4198, 3993)** |
| b | 102,5 | 102,5 | 4198,5 | 3993,5 | **(4198, 3993)** |
| c | 102,4 | 102,5 | 4198,4 | 3993,5 | **(4198, 3993)** |

$$\boxed{a \equiv b \equiv c \equiv (4198,\;3993)\ \text{pixels}}$$

> Se for adotada a convenção sem inversão do eixo (v = O_y + y/s), obtém-se a = b = c = (4198, 4198). **A conclusão é idêntica: os três pontos caem no mesmo pixel.**

---

## B) A câmera é útil? Existe evidência mínima da separação de regiões?

### **Não.**

**Justificativa quantitativa:**

1. Os três pontos **truncam para a mesma coordenada inteira (4198, 3993)** — ou seja, ocupam **um único pixel** do sensor.
2. As separações entre os pontos no objeto são de **0,01 mm** (10,25 − 10,24) em X e em Y. Com ampliação m = 1, isso corresponde a **0,01 mm no sensor**, ou seja:

$$\Delta u = \frac{0,01\ \text{mm}}{0,1\ \text{mm/px}} = \mathbf{0,1\ pixel}$$

3. Ou seja, a reentrância é **10× menor que um pixel**. Cada pixel "enxerga" 0,1 mm × 1 = **0,1 mm do objeto** — a feição de interesse tem 1/10 disso.
4. Sendo o sensor **binário**, o pixel apenas acende se **ao menos um** raio incidir sobre ele. O pixel (4198, 3993) simplesmente acende — não há variação de intensidade, não há borda, **não existe contraste** que permita a um algoritmo segmentar a reentrância.
5. Pelo **critério de amostragem (Nyquist)**, seriam necessários **pelo menos 2 pixels** sobre a menor feição para haver evidência de separação. Temos 0,1 px. Falta um fator de **20×**.

**Conclusão:** a imagem capturada não contém **nenhuma** evidência da reentrância; a análise automatizada proposta é inviável nesta configuração.

---

## C) Escolha do sensor de reposição

**Dimensões do sensor original:** 2 × 4096 = **8192 × 8192 pixels**, de 0,1 mm → **819,2 × 819,2 mm** de área sensível.

O que importa para o objetivo é a **resolução espacial sobre o objeto**, ou seja, quantos pixels a feição de 0,01 mm ocupa:

$$N_{px}=\frac{\text{tamanho da feição}\times m}{s}=\frac{0,01}{s}$$

| Opção | Tamanho do pixel | Nº de pixels (lado) | Separação da feição de 0,01 mm | Avaliação |
|---|---|---|---|---|
| **Original** | 0,1 mm | 8.192 | **0,1 px** | não resolve |
| **Sensor 1** — 4× a área, mesmo pixel | 0,1 mm | 16.384 | **0,1 px** | **não resolve** |
| **Sensor 2** — mesmas dimensões, pixel 0,01 mm | 0,01 mm | 81.920 | **1,0 px** | **única que dá evidência** |
| **Sensor 3** — mesmas dimensões, pixel 0,11 mm | 0,11 mm | 7.447 | **0,091 px** | **piora** |

### Discussão de cada opção

**Sensor 1 — quádruplo da área, mesmo tamanho de pixel.**
Quadruplicar a área (dobrar cada lado: 16384 × 16384 px) aumenta **apenas o campo de visão** — passa-se a enxergar mais do objeto, não mais detalhe. A relação "0,1 mm do objeto por pixel" permanece **inalterada**, e a reentrância continua a ocupar 0,1 px, dentro de um único pixel. **Não atende ao objetivo** (e ainda encarece e aumenta o volume de dados por imagem em 4×).

**Sensor 2 — mesmas dimensões, pixel de 0,01 mm.**
Reduz o pixel em 10×, elevando a matriz para 81.920 × 81.920 px com o mesmo tamanho físico. Agora cada pixel cobre 0,01 mm do objeto, e a separação de 0,01 mm entre os pontos corresponde a **exatamente 1 pixel**. Recalculando (novo centro: O_x = O_y = 40.960 px):

| Ponto | u = 40960 + x/0,01 | v = 40960 − y/0,01 |
|---|---|---|
| a | 41.984 | 39.936 |
| b | 41.985 | 39.935 |
| c | 41.984 | 39.935 |

Os três pontos passam a ocupar **três pixels distintos** (em "L"), o que constitui a **evidência mínima** de separação de regiões pedida no item B. É a **única opção que altera efetivamente a amostragem**.

**Sensor 3 — mesmas dimensões, pixel de 0,11 mm.**
Pixel **maior** que o original → menos pixels (≈ 7.447 por lado), resolução espacial **pior**. A feição cai para 0,091 px. É a **pior** das três opções: degrada exatamente aquilo que já era insuficiente.

### **Escolha fundamentada: Sensor 2**

É o único que aumenta a **densidade de amostragem** sobre o objeto e o único que faz a reentrância ocupar ao menos 1 pixel, produzindo evidência detectável em um sensor binário.

**Ressalvas técnicas (que devem constar da justificativa):**

- 1 pixel de separação é o **mínimo absoluto**; o critério de Nyquist pediria ≥ 2 px, o que exigiria pixel ≤ **0,005 mm**. Com 1 px, a detecção depende do **alinhamento (fase)** entre a borda e a grade de pixels — pode falhar dependendo de onde a feição cai.
- Pixels 10× menores captam ~100× menos luz; num sensor **binário com limiar**, isso significa maior sensibilidade a ruído e necessidade de mais iluminação ou maior tempo de exposição.
- A matriz de 81.920² ≈ 6,7 × 10⁹ pixels é um volume de dados enorme — na prática seria melhor **aumentar a ampliação** (m = d/Z, aumentando *d* ou aproximando o objeto) do que reduzir o pixel, mas entre as três opções oferecidas o **Sensor 2 é a resposta correta**.

---

## 5.2 Script de conferência (Python)

```python
d, Z, s, O = 10.0, 10.0, 0.1, 4096.0      # mm, mm, mm/px, px
pts = {"a": (10.24, 10.24), "b": (10.25, 10.25), "c": (10.24, 10.25)}

def projeta(X, Y, d=d, Z=Z, s=s, O=O):
    x, y = d * X / Z, d * Y / Z            # divisão homogênea: w = Z/d
    return int(O + x / s), int(O - y / s)  # truncamento para inteiro

print("m = d/Z =", d / Z)
for k, (X, Y) in pts.items():
    print(k, projeta(X, Y))                # a, b, c -> (4198, 3993)

for nome, sp, O2 in [("original", 0.1, 4096), ("Sensor1", 0.1, 8192),
                     ("Sensor2", 0.01, 40960), ("Sensor3", 0.11, 3723.6)]:
    print(f"{nome}: feicao de 0,01 mm -> {0.01/sp:.3f} px")

print("Sensor2:", {k: projeta(X, Y, s=0.01, O=40960.0)
                   for k, (X, Y) in pts.items()})
```

**Saída:**

```
m = d/Z = 1.0
a (4198, 3993)
b (4198, 3993)
c (4198, 3993)
original: feicao de 0,01 mm -> 0.100 px
Sensor1 : feicao de 0,01 mm -> 0.100 px
Sensor2 : feicao de 0,01 mm -> 1.000 px
Sensor3 : feicao de 0,01 mm -> 0.091 px
Sensor2: {'a': (41984, 39936), 'b': (41985, 39935), 'c': (41984, 39935)}
```

---

# Resumo das respostas

| Questão | Resposta |
|---|---|
| **1** | I = (1−α)·I₁ + α·I₂, com α = (diaDoAno(t) − 1)/364 (1937 não bissexto, 365 dias) |
| **2** | R = 120 (todos); G = [[195,240,195],[240,240,240],[195,240,195]]; B = 120 (todos) |
| **3** | Cinza = (R+G+B)/3 → [[145,160,145],[160,160,160],[145,160,145]] |
| **4** | L = 152,5 (converge em 1 iteração) → binária [[0,1,0],[1,1,1],[0,1,0]] |
| **5A** | a = b = c = (4198, 3993) px |
| **5B** | Não — os três pontos caem no mesmo pixel; separação de 0,1 px |
| **5C** | **Sensor 2** (pixel de 0,01 mm) — único que gera ≥ 1 px de separação |
