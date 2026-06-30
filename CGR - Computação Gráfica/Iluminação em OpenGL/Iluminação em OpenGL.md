# Iluminação em OpenGL

Este documento resume os principais conceitos sobre iluminação em OpenGL, baseado no material da disciplina.

## Conceitos Básicos de Iluminação

O OpenGL trabalha com fontes pontuais de luz, que podem ser classificadas em:
- **Omnidirecionais (Pontuais):** Emitem luz em todas as direções a partir de um ponto (ex: lâmpada incandescente).
- **Direcionais:** A fonte está posicionada no infinito, de modo que todos os raios de luz são paralelos (ex: luz do sol).
- **Spot:** Emitem um feixe cônico de luz em uma direção específica (ex: lanterna, holofote).

A interação da luz com as superfícies é definida pelo **Modelo de Iluminação de Phong**, que decompõe a luz nas seguintes componentes:
1. **Emissão:** Luz emitida pelo próprio material do objeto.
2. **Ambiente:** Luz difusa proveniente de várias direções que rebate no ambiente, não possuindo uma direção clara.
3. **Difusa:** Luz que atinge a superfície e se espalha uniformemente em todas as direções. Depende do ângulo de incidência.
4. **Especular:** O brilho que reflete intensamente em uma direção (reflexão), formando o "ponto de brilho" em superfícies lisas. Depende do ângulo de visão.

O modelo de iluminação do OpenGL é calculado **apenas nos vértices** das superfícies. A cor dos pixels situados no interior dos polígonos é obtida por interpolação linear, técnica conhecida como **Sombreamento Gouraud (Gouraud Shading)**. Além disso, a biblioteca tem suporte a efeitos atmosféricos como atenuação pela distância e névoa (fog).

## Configurando Luzes

Para que a iluminação funcione no OpenGL, é necessário habilitar o uso global de luzes e, em seguida, habilitar cada fonte de luz desejada. A API garante pelo menos 8 fontes simultâneas (`GL_LIGHT0` a `GL_LIGHT7`).

```c
glEnable(GL_LIGHTING); // Liga o cálculo de cores pelo modelo de iluminação
glEnable(GL_LIGHT0);   // Liga a fonte de luz 0
```

As propriedades de uma luz específica são configuradas com a função `glLightfv(fonte, propriedade, valor)`:
- **Componentes de cor:** `GL_AMBIENT`, `GL_DIFFUSE`, `GL_SPECULAR`.
- **Posicionamento e Geometria:** `GL_POSITION`. Se a coordenada w do vetor for `0.0`, o OpenGL tratará a luz como **direcional**; se for `1.0`, será uma luz de posição (pontual). Para luzes spot, utiliza-se `GL_SPOT_DIRECTION`, `GL_SPOT_CUTOFF` e `GL_SPOT_EXPONENT`.
- **Atenuação:** `GL_CONSTANT_ATTENUATION`, `GL_LINEAR_ATTENUATION`, `GL_QUADRATIC_ATTENUATION`.

### Exemplo de Configuração de Luz
```c
GLfloat light0_position[] = {1.0, 2.0, 3.0, 1.0}; // Luz posicional
glLightfv(GL_LIGHT0, GL_POSITION, light0_position);
```

## Configurando Materiais

Assim como as fontes de luz, os materiais dos objetos também precisam ser configurados para interagir adequadamente com a iluminação, usando `glMaterialfv(face, propriedade, valor)`:
- **Face:** Pode ser `GL_FRONT` (frente), `GL_BACK` (verso) ou `GL_FRONT_AND_BACK` (ambos).
- **Propriedades do material:** Determinam a porcentagem de reflexão para as componentes `GL_AMBIENT`, `GL_DIFFUSE`, `GL_SPECULAR` e `GL_EMISSION`. Além destas, a propriedade `GL_SHININESS` dita o quão concentrado e intenso será o brilho especular do material.

## Modelos de Sombreamento (Shading)

Podemos definir como as cores das faces serão exibidas com a função `glShadeModel(modo)`:
- `GL_FLAT` (Flat Shading): A cor de toda a face do polígono não varia, sendo definida por um único vértice. Dá um aspecto "facetado" ao objeto.
- `GL_SMOOTH` (Smooth / Gouraud Shading): A cor é calculada nos vértices e os pixels intermediários recebem uma interpolação suave dessas cores. É o valor padrão do OpenGL.
