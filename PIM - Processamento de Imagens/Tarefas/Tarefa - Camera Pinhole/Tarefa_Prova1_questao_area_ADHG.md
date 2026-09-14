# Questão — Área do quadrilátero A, D, H, G (câmera pinhole)

## 0. Dados e modelo

| Grandeza | Símbolo | Valor |
|---|---|---|
| Distância focal | *f* (*d*) | 5 mm |
| Distância do objeto | *Z* | 1.500 mm |
| Lado do pixel (quadrado) | *s* | 7,5×10⁻³ mm = 0,0075 mm |
| Centro do sensor | (O_x, O_y) | **(4096, 4096) px** |
| Centro de projeção | — | origem [0,0,0]ᵀ |

A peça é **paralela ao plano-de-imagem** e sua normal é colinear a **OZc**. Todos os pontos da Tabela 1 têm **Z = 1500 mm**, portanto a projeção perspectiva degenera em uma **semelhança (escala uniforme)** — não há distorção perspectiva entre os pontos, e figuras planas se projetam em figuras semelhantes.

**Modelo pinhole:**

$$x = f\frac{X}{Z}, \qquad y = f\frac{Y}{Z}$$

**Ampliação:**

$$m = \frac{f}{Z} = \frac{5}{1500} = \frac{1}{300} = 3,33333\times10^{-3}$$

**Métrico → pixel** (origem no canto superior esquerdo; a linha *v* cresce para baixo, enquanto Y cresce para cima):

$$u = O_x + \frac{x}{s} \qquad\qquad v = O_y - \frac{y}{s}$$

Escala combinada: 1 mm no objeto → m/s = 0,44444 px. Equivalentemente, **1 pixel cobre 2,25 mm do objeto**.

---

## 1. Os quatro vértices

Da Tabela 1 (mm):

| Ponto | X | Y | Z |
|---|---|---|---|
| A | −300,0 | 2.000,0 | 1.500,0 |
| D | 1.304,2 | 2.000,0 | 1.500,0 |
| H | 1.304,2 | 1.000,0 | 1.500,0 |
| G | −300,0 | 1.000,0 | 1.500,0 |

A, D, H, G formam um **retângulo** no plano Z = 1500 mm (A e D compartilham Y = 2000; G e H compartilham Y = 1000; A e G compartilham X = −300; D e H compartilham X = 1304,2). A ordem A → D → H → G percorre o contorno sem cruzamentos.

- Largura: ΔX = 1304,2 − (−300,0) = **1.604,2 mm**
- Altura: ΔY = 2.000,0 − 1.000,0 = **1.000,0 mm**
- Área no objeto: A_obj = 1.604,2 × 1.000 = **1.604.200 mm²**

---

## 2. Projeção dos vértices

| Ponto | x = fX/Z (mm) | y = fY/Z (mm) | u = 4096 + x/s | v = 4096 − y/s |
|---|---|---|---|---|
| **A** | −1,00000 | 6,66667 | 3962,667 | 3207,111 |
| **D** | 4,34733 | 6,66667 | 4675,644 | 3207,111 |
| **H** | 4,34733 | 3,33333 | 4675,644 | 3651,556 |
| **G** | −1,00000 | 3,33333 | 3962,667 | 3651,556 |

*(Demais pontos, para referência: B(4096,00; 3207,11), C(4386,44; 3207,11), E(4096,00; 3211,56), F(4386,44; 3211,56).)*

O sensor tem 8192 × 8192 px (centro em 4096), ou seja **61,44 × 61,44 mm**. A projeção ocupa apenas ~713 × 444 px — **cabe inteiramente no sensor**, de modo que nenhum vértice é recortado e a área projetada é integralmente capturada.

---

## 3. Área da projeção — em mm²

Como o plano do objeto é paralelo ao plano-de-imagem, **a área escala com m²**:

$$A_{img} = A_{obj}\cdot m^{2} = \frac{1.604.200}{300^{2}} = \frac{1.604.200}{90.000}$$

$$\boxed{A_{img} \approx 17,8244\ \text{mm}^2}$$

**Verificação pelos lados projetados:**

$$\Delta x = \frac{1604,2}{300} = 5,347333\ \text{mm}, \qquad \Delta y = \frac{1000}{300} = 3,333333\ \text{mm}$$
$$5,347333 \times 3,333333 = 17,824444\ \text{mm}^2 \;\checkmark$$

---

## 4. Área da projeção — em pixels²

$$\Delta u = \frac{5,347333}{0,0075} = 712,9778\ \text{px}, \qquad \Delta v = \frac{3,333333}{0,0075} = 444,4444\ \text{px}$$

$$A_{px} = \frac{A_{img}}{s^{2}} = \frac{17,824444}{5,625\times10^{-5}}$$

$$\boxed{A_{px} \approx 3,1688\times10^{5}\ \text{pixels}^2 \;(\approx 316.879,0\ \text{px}^2)}$$

**Verificação pela fórmula do polígono (shoelace) sobre as coordenadas em pixels:**

$$A = \tfrac{1}{2}\left|\sum_i (u_i v_{i+1} - u_{i+1} v_i)\right| = 316.879,01\ \text{px}^2 \;\checkmark$$

> A translação do centro do sensor (4096 em vez de 1024) **não altera a área** — apenas desloca a figura no sensor. A área depende somente de *m* e de *s*.

---

## 5. Resposta final

| | Objeto | Projeção (mm) | Projeção (pixels) |
|---|---|---|---|
| Largura | 1.604,2 mm | 5,347333 mm | 712,978 px |
| Altura | 1.000,0 mm | 3,333333 mm | 444,444 px |
| **Área** | **1.604.200 mm²** | **≈ 17,8244 mm²** | **≈ 3,1688×10⁵ px²** |

---

## 6. Script Python

```python
"""
Area do quadrilatero A, D, H, G projetado por uma camera pinhole.
f = 5 mm, Z = 1500 mm, pixel = 0,0075 mm, centro do sensor = (4096, 4096).
"""

f  = 5.0          # mm - distancia focal
Z  = 1500.0       # mm - distancia do objeto
sp = 0.0075       # mm - lado do pixel
ox = oy = 4096.0  # px - centro do sensor

m = f / Z         # ampliacao = 1/300

# Tabela 1 (X, Y) em mm, todos com Z = 1500 mm
P = {
    "A": (-300.0, 2000.0), "B": (   0.0, 2000.0),
    "C": ( 653.5, 2000.0), "D": (1304.2, 2000.0),
    "E": (   0.0, 1990.0), "F": ( 653.5, 1990.0),
    "G": (-300.0, 1000.0), "H": (1304.2, 1000.0),
}


def projeta_mm(X, Y, Zp=Z):
    """Modelo pinhole: coordenadas metricas no plano de imagem."""
    return f * X / Zp, f * Y / Zp


def para_pixel(x, y):
    """Metrico -> pixel; v cresce para baixo (origem no canto sup. esquerdo)."""
    return ox + x / sp, oy - y / sp


def shoelace(pts):
    """Area de um poligono simples dado por vertices ordenados."""
    s = 0.0
    n = len(pts)
    for i in range(n):
        x1, y1 = pts[i]
        x2, y2 = pts[(i + 1) % n]
        s += x1 * y2 - x2 * y1
    return abs(s) / 2.0


print(f"ampliacao m = f/Z = {m:.8f}\n")
print("Projecao dos pontos da Tabela 1:")
print(f"{'pt':>3} {'x[mm]':>10} {'y[mm]':>10} {'u[px]':>12} {'v[px]':>12}")
proj = {}
for k, (X, Y) in P.items():
    x, y = projeta_mm(X, Y)
    u, v = para_pixel(x, y)
    proj[k] = (x, y, u, v)
    print(f"{k:>3} {x:10.5f} {y:10.5f} {u:12.4f} {v:12.4f}")

quad = ["A", "D", "H", "G"]          # ordem do contorno
mm = [(proj[k][0], proj[k][1]) for k in quad]
px = [(proj[k][2], proj[k][3]) for k in quad]

larg_obj = P["D"][0] - P["A"][0]     # 1604,2 mm
alt_obj  = P["A"][1] - P["G"][1]     # 1000,0 mm
area_obj = larg_obj * alt_obj

print(f"\nObjeto : {larg_obj} x {alt_obj} mm -> {area_obj:.1f} mm^2")
print(f"Imagem : {larg_obj*m:.6f} x {alt_obj*m:.6f} mm "
      f"-> {area_obj*m**2:.6f} mm^2")
print(f"Imagem : {larg_obj*m/sp:.4f} x {alt_obj*m/sp:.4f} px "
      f"-> {area_obj*m**2/sp**2:.2f} px^2")
print(f"\nConferencia (shoelace): {shoelace(mm):.6f} mm^2 | "
      f"{shoelace(px):.2f} px^2")
print(f"Sensor: {2*ox:.0f} x {2*oy:.0f} px = "
      f"{2*ox*sp:.2f} x {2*oy*sp:.2f} mm -> a projecao cabe no sensor")
```

**Saída:**

```
ampliacao m = f/Z = 0.00333333

A: x= -1.00000  y=  6.66667  u= 3962.6667  v= 3207.1111
D: x=  4.34733  y=  6.66667  u= 4675.6444  v= 3207.1111
H: x=  4.34733  y=  3.33333  u= 4675.6444  v= 3651.5556
G: x= -1.00000  y=  3.33333  u= 3962.6667  v= 3651.5556

Objeto : 1604.2 x 1000.0 mm -> 1604200.0 mm^2
Imagem : 5.347333 x 3.333333 mm -> 17.824444 mm^2
Imagem : 712.9778 x 444.4444 px -> 316879.01 px^2
Conferencia (shoelace): 17.824444 mm^2 | 316879.01 px^2
```

---

## 7. Observação complementar

Vale notar (mesmo não sendo perguntado) que os **detalhes** do objeto continuam mal amostrados com este pixel: a reentrância definida por B, C, E, F mede 653,5 × 10 mm no objeto, mas os pares como B–E (10 mm em Y) projetam apenas **4,44 px**, e uma feição de 0,3 mm projetaria **0,133 px**. O aumento do sensor para 8192 px ampliou apenas o **campo de visão**, não a **resolução espacial sobre o objeto**, que permanece em 2,25 mm/pixel.
