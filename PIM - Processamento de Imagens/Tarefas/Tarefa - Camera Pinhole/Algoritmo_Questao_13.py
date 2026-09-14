"""
Questao 13 - Projecao perspectiva (pinhole) e analise de resolucao.

Dados:
  distancia focal f = 5 mm
  distancia do objeto Z = 1500 mm (plano do objeto paralelo ao plano-de-imagem)
  pixel quadrado de lado sp = 0,0075 mm
  centro do sensor (ox, oy) = (1024, 1024) pixels
  origem de pixels no canto superior esquerdo (linha cresce para baixo)
"""

f  = 5.0        # mm  - distancia focal
Z  = 1500.0     # mm  - distancia do objeto
sp = 0.0075     # mm  - lado do pixel
ox = oy = 1024.0  # pixels - centro do sensor

m = f / Z       # ampliacao (adimensional) = 1/300


# ----------------------------------------------------------------------
# Modelo pinhole (plano de imagem frontal) + conversao para pixels
# ----------------------------------------------------------------------
def projeta_mm(X, Y, Zp=Z):
    """Coordenadas metricas (mm) no plano de imagem."""
    return f * X / Zp, f * Y / Zp


def para_pixel(x, y):
    """Metrico (mm) -> pixel. Eixo v cresce para baixo, dai o sinal negativo."""
    return ox + x / sp, oy - y / sp


def projeta_pixel(X, Y, Zp=Z):
    x, y = projeta_mm(X, Y, Zp)
    return para_pixel(x, y)


# ----------------------------------------------------------------------
# A) Area do quadrilatero W, R, T, S
# ----------------------------------------------------------------------
W = (0.0, 2000.0, 1500.0)
R = (1304.2, 2000.0, 1500.0)
T = (1304.2, 0.0, 1500.0)
S = (0.0, 0.0, 1500.0)

larg_obj = R[0] - W[0]          # 1304,2 mm
alt_obj = W[1] - S[1]           # 2000,0 mm
area_obj = larg_obj * alt_obj   # mm^2 no objeto

larg_img = larg_obj * m         # mm no sensor
alt_img = alt_obj * m
area_img_mm2 = area_obj * m ** 2          # = larg_img * alt_img
area_img_px2 = area_img_mm2 / sp ** 2     # pixels^2

print("=== A) Area da projecao de W,R,T,S ===")
print(f"ampliacao m = f/Z = {m:.6f}")
print(f"objeto : {larg_obj} x {alt_obj} mm  ->  {area_obj:.1f} mm^2")
print(f"imagem : {larg_img:.6f} x {alt_img:.6f} mm  ->  {area_img_mm2:.6f} mm^2")
print(f"imagem : {larg_img/sp:.4f} x {alt_img/sp:.4f} px ->  {area_img_px2:.2f} px^2\n")


# ----------------------------------------------------------------------
# B) Coordenadas em pixels de S, W e R
# ----------------------------------------------------------------------
print("=== B) Coordenadas em pixels (coluna u, linha v) ===")
for nome, P in (("S", S), ("W", W), ("R", R)):
    x, y = projeta_mm(P[0], P[1], P[2])
    u, v = para_pixel(x, y)
    print(f"{nome}: X={P[0]:>8.1f} Y={P[1]:>7.1f} | x={x:8.5f} mm y={y:8.5f} mm "
          f"| u={u:9.4f} v={v:9.4f}  (arred.: {round(u)}, {round(v)})")
print()


# ----------------------------------------------------------------------
# C) Os detalhes (reentrancias) sao resolvidos?
# ----------------------------------------------------------------------
pontos = {
    "a": (650.7, 2000.0, 1500.0), "b": (653.5, 2000.0, 1500.0),
    "c": (650.7, 1990.0, 1500.0), "d": (653.5, 1990.0, 1500.0),
    "e": (645.3,  500.3, 1500.0), "f": (645.0,  500.3, 1500.0),
    "g": (645.3,  500.0, 1500.0), "h": (645.0,  500.0, 1500.0),
}

print("=== C) Projecao dos oito pontos ===")
px = {}
for k, (X, Y, Zp) in pontos.items():
    px[k] = projeta_pixel(X, Y, Zp)
    print(f"{k}: u={px[k][0]:10.4f}  v={px[k][1]:10.4f}")

detalhes = {
    "detalhe superior (a,b,c,d)": (abs(653.5 - 650.7), abs(2000.0 - 1990.0)),
    "detalhe inferior (e,f,g,h)": (abs(645.3 - 645.0), abs(500.3 - 500.0)),
}

print("\n--- dimensoes projetadas ---")
LIMITE = 2.0  # criterio de Nyquist: >= 2 pixels para resolver o detalhe
util = True
for nome, (dX, dY) in detalhes.items():
    dx_px, dy_px = dX * m / sp, dY * m / sp
    ok = (dx_px >= LIMITE) and (dy_px >= LIMITE)
    util &= ok
    print(f"{nome}: objeto {dX} x {dY} mm -> sensor {dX*m:.6f} x {dY*m:.6f} mm "
          f"-> {dx_px:.4f} x {dy_px:.4f} px  [{'RESOLVIDO' if ok else 'NAO RESOLVIDO'}]")

print(f"\nImagem util para o objetivo? {'SIM' if util else 'NAO'}\n")


# ----------------------------------------------------------------------
# D) Escolha do sensor (mesmo tamanho fisico, pixels diferentes)
# ----------------------------------------------------------------------
lado_sensor_mm = 2 * ox * sp          # 2048 px * 0,0075 mm = 15,36 mm
menor_detalhe = 0.3                   # mm no objeto

print("=== D) Comparacao de sensores ===")
print(f"lado fisico do sensor atual: {lado_sensor_mm:.2f} mm")
print(f"pixel maximo para 2 px no menor detalhe: {menor_detalhe*m/LIMITE:.6f} mm\n")
for nome, s in (("atual", sp), ("S1", 0.00042), ("S2", 0.085)):
    n = lado_sensor_mm / s
    d2 = menor_detalhe * m / s
    d1x, d1y = 2.8 * m / s, 10.0 * m / s
    print(f"{nome}: pixel={s} mm | sensor {n:.0f}x{n:.0f} px | "
          f"detalhe 0,3 mm -> {d2:.4f} px | detalhe 2,8x10 mm -> {d1x:.2f}x{d1y:.2f} px "
          f"| {'OK' if d2 >= LIMITE else 'insuficiente'}")
