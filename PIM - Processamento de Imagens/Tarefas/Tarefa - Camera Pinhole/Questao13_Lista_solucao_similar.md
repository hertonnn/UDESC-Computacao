# Questão 13 — Projeção perspectiva, área projetada e análise de resolução

## 0. Dados e modelo adotado

| Grandeza | Símbolo | Valor |
|---|---|---|
| Distância focal | *f* (ou *d*) | 5 mm |
| Distância do objeto (plano da peça) | *Z* | 1.500 mm |
| Lado do pixel (quadrado) | *s* | 7,5×10⁻³ mm = 0,0075 mm |
| Centro do sensor | (o_x, o_y) | (1024, 1024) px |
| Centro de projeção | — | origem [0,0,0]ᵀ |

O plano da peça é **paralelo** ao plano-de-imagem e a normal da peça é colinear com **OZc**. Logo todos os pontos do objeto têm o mesmo Z = 1500 mm e a projeção se reduz a uma **semelhança (escala pura)**.

**Modelo pinhole (plano de imagem frontal, como desenhado na Figura 5):**

$$x = f\frac{X}{Z}, \qquad y = f\frac{Y}{Z}$$

**Ampliação (fator de escala):**

$$m = \frac{f}{Z} = \frac{5}{1500} = \frac{1}{300} = 3,3333\times10^{-3}$$

Ou seja, **1 mm no objeto → 1/300 mm no sensor**.

**Conversão métrica → pixel** (origem no canto superior esquerdo, linha *v* cresce para baixo, enquanto Y cresce para cima):

$$u = o_x + \frac{x}{s} \qquad\qquad v = o_y - \frac{y}{s}$$

> Observação: se for adotado o plano de imagem *real* (atrás do foco, em z = −f), a imagem aparece rotacionada de 180° e os sinais se invertem (u = o_x − x/s, v = o_y + y/s). As **dimensões e a área não mudam**, apenas a posição dos pontos no sensor. Aqui seguiu-se o esquema da Figura 5, em que o sensor está representado à frente do foco.

**Relação útil de escala em pixels:**

$$1\ \text{mm no objeto} \;\rightarrow\; \frac{m}{s} = \frac{1/300}{0,0075} = 0,4444\ \text{px}$$

Equivalentemente: **1 pixel "enxerga" 2,25 mm do objeto** (0,0075 × 300).

---

## A) Área do quadrilátero W, R, T, S

Pontos (X; Y; Z) em mm:

- W(0,0; 2000,0; 1500,0)
- R(1304,2; 2000,0; 1500,0)
- T(1304,2; 0,0; 1500,0)
- S(0,0; 0,0; 1500,0)

É um **retângulo** contido no plano Z = 1500 mm:

- largura no objeto: ΔX = 1304,2 − 0 = **1304,2 mm**
- altura no objeto: ΔY = 2000,0 − 0 = **2000,0 mm**
- área no objeto: A_obj = 1304,2 × 2000 = **2.608.400 mm²**

### Projeção (mm no sensor)

$$\Delta x = \Delta X \cdot m = \frac{1304,2}{300} = 4,347333\ \text{mm}$$
$$\Delta y = \Delta Y \cdot m = \frac{2000}{300} = 6,666667\ \text{mm}$$

Como o plano do objeto é paralelo ao plano-de-imagem, a área escala com **m²**:

$$A_{img} = A_{obj}\cdot m^2 = \frac{2.608.400}{300^2} = \frac{2.608.400}{90.000}$$

$$\boxed{A_{img} \approx 28,9822\ \text{mm}^2}$$

(confere: 4,347333 × 6,666667 = 28,9822 mm²)

### Projeção (pixels)

$$\Delta u = \frac{4,347333}{0,0075} = 579,6444\ \text{px} \qquad \Delta v = \frac{6,666667}{0,0075} = 888,8889\ \text{px}$$

$$A_{px} = \frac{A_{img}}{s^2} = \frac{28,9822}{5,625\times10^{-5}}$$

$$\boxed{A_{px} \approx 5,1524\times10^{5}\ \text{pixels}^2 \;(\approx 515.239,5\ \text{px}^2)}$$

> Comentário: o sensor tem 2048×2048 px (centro em 1024,1024), ou seja 15,36 × 15,36 mm. A projeção da peça (4,35 × 6,67 mm ≈ 580 × 889 px) **cabe folgadamente** no sensor — o campo de visão não é o problema desta câmera.

---

## B) Coordenadas em pixels de S, W e R

| Ponto | X (mm) | Y (mm) | x = fX/Z (mm) | y = fY/Z (mm) | u = 1024 + x/s | v = 1024 − y/s | arredondado (u, v) |
|---|---|---|---|---|---|---|---|
| **S** | 0,0 | 0,0 | 0,00000 | 0,00000 | 1024,000 | 1024,000 | **(1024, 1024)** |
| **W** | 0,0 | 2000,0 | 0,00000 | 6,66667 | 1024,000 | 135,111 | **(1024, 135)** |
| **R** | 1304,2 | 2000,0 | 4,34733 | 6,66667 | 1603,644 | 135,111 | **(1604, 135)** |

Justificativa: **S** está sobre o eixo óptico (X = Y = 0), portanto projeta-se exatamente no centro do sensor. **W** está 2000 mm acima de S → sobe 888,89 px na imagem (linha menor, pois *v* cresce para baixo). **R** está ainda 1304,2 mm à direita → desloca 579,64 px em coluna.

*(Para referência, T(1304,2; 0; 1500) → u = 1603,644, v = 1024,000.)*

---

## C) A imagem capturada é útil para identificar os detalhes?

### C.1 Projeção dos oito pontos da Tabela 1

| Ponto | X (mm) | Y (mm) | u (px) | v (px) |
|---|---|---|---|---|
| a | 650,7 | 2000,0 | 1313,2000 | 135,1111 |
| b | 653,5 | 2000,0 | 1314,4444 | 135,1111 |
| c | 650,7 | 1990,0 | 1313,2000 | 139,5556 |
| d | 653,5 | 1990,0 | 1314,4444 | 139,5556 |
| e | 645,3 | 500,3 | 1310,8000 | 801,6444 |
| f | 645,0 | 500,3 | 1310,6667 | 801,6444 |
| g | 645,3 | 500,0 | 1310,8000 | 801,7778 |
| h | 645,0 | 500,0 | 1310,6667 | 801,7778 |

### C.2 Dimensão dos detalhes (reentrâncias) na imagem

| Detalhe | No objeto | No sensor (mm) | No sensor (pixels) |
|---|---|---|---|
| Superior (a,b,c,d) | 2,8 × 10,0 mm | 0,009333 × 0,033333 | **1,244 × 4,444 px** |
| Inferior (e,f,g,h) | 0,3 × 0,3 mm | 0,001 × 0,001 | **0,133 × 0,133 px** |

### C.3 Conclusão — **NÃO, a imagem não é útil**

1. **Detalhe inferior (0,3 × 0,3 mm):** projeta-se em 0,001 mm no sensor, ou seja **0,133 pixel**, cerca de **7,5 vezes menor que um único pixel**. Um sensor binário só registra "aceso/apagado": esse detalhe, na melhor das hipóteses, acende **um** pixel que já estaria aceso pela peça ao redor — não gera nenhuma variação detectável na imagem. **Ele é invisível.**
2. **Detalhe superior (2,8 × 10 mm):** projeta-se em **1,24 × 4,44 px**. A largura de ~1,2 px está abaixo do critério de amostragem (**Nyquist: são necessários ≥ 2 px** para distinguir uma feição). Dependendo do alinhamento da reentrância com a grade de pixels, ela pode acender uma única coluna — ou se diluir e desaparecer. Medição confiável é impossível.
3. **Causa raiz:** cada pixel cobre **2,25 mm do objeto** (0,0075 mm × 300). Qualquer detalhe menor que ~4,5 mm (2 pixels) é irrecuperável. Os detalhes de interesse têm 0,3 mm a 2,8 mm.

Para o objetivo declarado (identificar reentrâncias para decisão em projeto mecânico), **a câmera/ótica atual é inadequada**. Seria necessário reduzir o pixel, aumentar a distância focal ou aproximar a câmera do objeto de modo que o menor detalhe (0,3 mm) ocupe pelo menos 2 pixels:

$$s \le \frac{0,3 \cdot m}{2} = 0,0005\ \text{mm} \quad\text{(mantidos } f=5\text{ mm e } Z=1500\text{ mm)}$$

### C.4 Script Python

```python
"""
Questao 13 - Projecao perspectiva (pinhole) e analise de resolucao.
"""

f  = 5.0          # mm  - distancia focal
Z  = 1500.0       # mm  - distancia do objeto
sp = 0.0075       # mm  - lado do pixel
ox = oy = 1024.0  # px  - centro do sensor

m = f / Z         # ampliacao = 1/300


def projeta_mm(X, Y, Zp=Z):
    """Coordenadas metricas (mm) no plano de imagem."""
    return f * X / Zp, f * Y / Zp


def para_pixel(x, y):
    """Metrico (mm) -> pixel. v cresce para baixo, dai o sinal negativo."""
    return ox + x / sp, oy - y / sp


def projeta_pixel(X, Y, Zp=Z):
    x, y = projeta_mm(X, Y, Zp)
    return para_pixel(x, y)


# ---------------- A) Area do quadrilatero W, R, T, S ----------------
W = (0.0, 2000.0, 1500.0)
R = (1304.2, 2000.0, 1500.0)
T = (1304.2, 0.0, 1500.0)
S = (0.0, 0.0, 1500.0)

larg_obj = R[0] - W[0]                 # 1304,2 mm
alt_obj  = W[1] - S[1]                 # 2000,0 mm
area_obj = larg_obj * alt_obj          # mm^2 no objeto

larg_img = larg_obj * m
alt_img  = alt_obj * m
area_img_mm2 = area_obj * m ** 2       # = larg_img * alt_img
area_img_px2 = area_img_mm2 / sp ** 2

print("=== A) Area da projecao de W,R,T,S ===")
print(f"ampliacao m = f/Z = {m:.6f}")
print(f"objeto : {larg_obj} x {alt_obj} mm -> {area_obj:.1f} mm^2")
print(f"imagem : {larg_img:.6f} x {alt_img:.6f} mm -> {area_img_mm2:.6f} mm^2")
print(f"imagem : {larg_img/sp:.4f} x {alt_img/sp:.4f} px -> {area_img_px2:.2f} px^2\n")

# ---------------- B) Coordenadas em pixels de S, W e R ----------------
print("=== B) Coordenadas em pixels (coluna u, linha v) ===")
for nome, P in (("S", S), ("W", W), ("R", R)):
    x, y = projeta_mm(P[0], P[1], P[2])
    u, v = para_pixel(x, y)
    print(f"{nome}: x={x:8.5f} mm y={y:8.5f} mm | u={u:9.4f} v={v:9.4f} "
          f"-> ({round(u)}, {round(v)})")
print()

# ---------------- C) Os detalhes sao resolvidos? ----------------
pontos = {
    "a": (650.7, 2000.0), "b": (653.5, 2000.0),
    "c": (650.7, 1990.0), "d": (653.5, 1990.0),
    "e": (645.3,  500.3), "f": (645.0,  500.3),
    "g": (645.3,  500.0), "h": (645.0,  500.0),
}

print("=== C) Projecao dos oito pontos ===")
for k, (X, Y) in pontos.items():
    u, v = projeta_pixel(X, Y)
    print(f"{k}: u={u:10.4f}  v={v:10.4f}")

detalhes = {
    "detalhe superior (a,b,c,d)": (2.8, 10.0),
    "detalhe inferior (e,f,g,h)": (0.3, 0.3),
}

LIMITE = 2.0   # Nyquist: >= 2 pixels para resolver o detalhe
util = True
print("\n--- dimensoes projetadas ---")
for nome, (dX, dY) in detalhes.items():
    dx_px, dy_px = dX * m / sp, dY * m / sp
    ok = dx_px >= LIMITE and dy_px >= LIMITE
    util &= ok
    print(f"{nome}: {dX} x {dY} mm -> {dX*m:.6f} x {dY*m:.6f} mm "
          f"-> {dx_px:.4f} x {dy_px:.4f} px  "
          f"[{'RESOLVIDO' if ok else 'NAO RESOLVIDO'}]")
print(f"\nImagem util para o objetivo? {'SIM' if util else 'NAO'}\n")

# ---------------- D) Escolha do sensor ----------------
lado_sensor_mm = 2 * ox * sp        # 2048 px * 0,0075 = 15,36 mm
menor_detalhe = 0.3                 # mm no objeto

print("=== D) Comparacao de sensores ===")
print(f"lado fisico do sensor: {lado_sensor_mm:.2f} mm")
print(f"pixel maximo para 2 px no menor detalhe: {menor_detalhe*m/LIMITE:.6f} mm\n")
for nome, s in (("atual", sp), ("S1", 0.00042), ("S2", 0.085)):
    n   = lado_sensor_mm / s
    d2  = menor_detalhe * m / s
    d1x, d1y = 2.8 * m / s, 10.0 * m / s
    print(f"{nome}: pixel={s} mm | sensor {n:.0f}x{n:.0f} px | "
          f"detalhe 0,3 mm -> {d2:.4f} px | detalhe 2,8x10 mm -> "
          f"{d1x:.2f}x{d1y:.2f} px | {'OK' if d2 >= LIMITE else 'insuficiente'}")
```

**Saída do script (resumo):**

```
ampliacao m = f/Z = 0.003333
A) imagem: 4.347333 x 6.666667 mm -> 28.982222 mm^2 ; 579.64 x 888.89 px -> 515239.51 px^2
B) S=(1024.0000, 1024.0000)  W=(1024.0000, 135.1111)  R=(1603.6444, 135.1111)
C) detalhe superior: 1.2444 x 4.4444 px  -> NAO RESOLVIDO
   detalhe inferior: 0.1333 x 0.1333 px  -> NAO RESOLVIDO
   Imagem util? NAO
D) S1 (0,00042 mm): 2.3810 px no detalhe de 0,3 mm -> OK
   S2 (0,085 mm) : 0.0118 px -> insuficiente
```

---

## D) Escolha entre os sensores S1 e S2

O enunciado mantém **as mesmas dimensões físicas** de sensor (15,36 × 15,36 mm), alterando apenas o lado do pixel — ou seja, muda-se apenas a **densidade de amostragem**, não o campo de visão.

| Sensor | Lado do pixel | Nº de pixels (lado) | Detalhe 0,3 mm projetado | Detalhe 2,8 × 10 mm projetado |
|---|---|---|---|---|
| Atual | 0,0075 mm | 2048 | 0,133 px ❌ | 1,24 × 4,44 px ❌ |
| **S1** | **0,00042 mm** | ≈ 36.571 | **2,38 px ✅** | **22,2 × 79,4 px ✅** |
| S2 | 0,085 mm | ≈ 181 | 0,012 px ❌ | 0,11 × 0,39 px ❌ |

### Escolha: **S1 (pixel de 0,00042 mm)**

**Justificativa quantitativa:**

- Com S1, cada pixel cobre 0,00042 × 300 = **0,126 mm do objeto**. O menor detalhe (0,3 mm) ocupa **2,38 px**, satisfazendo o critério de Nyquist (≥ 2 px) — o detalhe passa a ser detectável mesmo num sensor binário.
- O detalhe maior fica com **22 × 79 px**, permitindo não só detectar como **medir** a reentrância com boa precisão.
- Com S2, cada pixel cobre 0,085 × 300 = **25,5 mm do objeto**. Nem a peça inteira seria bem amostrada (a projeção teria apenas ~51 × 78 px) e nenhum detalhe seria visível. S2 é **pior que o sensor atual** em uma ordem de grandeza.

**Ressalvas de engenharia (importante mencionar):** S1 está no limite do fisicamente razoável. Pixels de 0,42 µm captam pouquíssima luz (baixa relação sinal-ruído — crítico para um sensor binário com limiar) e, além disso, o **limite de difração** da ótica (raio de Airy ≈ 1,22·λ·N ≈ 1,3 µm para λ = 0,55 µm e f/2) já é maior que o próprio pixel, de modo que o ganho real de resolução seria menor que o teórico. Na prática, a solução mais robusta seria **aumentar a ampliação** (maior distância focal, menor distância de trabalho ou ótica telecêntrica) em vez de apenas encolher o pixel. Dentre as duas alternativas oferecidas, porém, **S1 é a única que atende ao objetivo**.
