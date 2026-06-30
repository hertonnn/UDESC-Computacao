# Iluminação Global e POV-Ray

Este documento resume os conceitos sobre modelos de iluminação global e a ferramenta POV-Ray, baseando-se no material das aulas.

## Modelos de Iluminação: Locais vs. Globais

Os modelos de iluminação descrevem como a luz interage com os materiais, é transportada pela cena e atinge o observador.

- **Modelos Locais (ex: OpenGL clássico):** Calculam a iluminação de forma isolada para cada objeto em relação às fontes de luz. São rápidos, mas não consideram inter-reflexões (a luz rebatendo de um objeto para outro), resultando em menor realismo.
- **Modelos Globais:** Consideram a cena como um todo e os caminhos complexos da luz, incluindo inter-reflexões. Exigem maior custo computacional, mas são a chave para gerar imagens fotorrealistas. 

As duas técnicas clássicas de Iluminação Global são **Ray Tracing** e **Radiosidade**.

---

## Ray Tracing (Traçado de Raios)

O Ray Tracing clássico (recursivo) foca no cálculo preciso da **reflexão especular** e da **transmissão (refração)** da luz. 

- **Como funciona:** Em vez de emitir raios da luz para os objetos (o que seria infinito e ineficiente), o algoritmo emite raios a partir da câmera (do olho do observador) através de cada pixel da tela em direção à cena.
- **Árvore de Raios:** Ao atingir uma superfície, o raio primário gera raios secundários:
  1. **Raio de reflexão** (baseado no ângulo de incidência).
  2. **Raio de refração/transmissão** (baseado na Lei de Snell, para materiais translúcidos).
  3. **Raios de sombra (Shadow rays)** direcionados às fontes de luz para checar oclusão.
  Esse processo continua recursivamente até atingir um limite de rebatimentos ou um objeto opaco não refletor, formando uma "árvore de raios" para cada pixel.

**Vantagens e Desvantagens:**
- Lida com sombras duras, reflexos e refrações perfeitamente.
- O custo computacional cresce exponencialmente devido ao cálculo de intersecções raio-objeto. Para otimizar, usam-se *Volumes Envolventes* (Bounding Volumes) e divisão espacial (Octrees/Grades).
- **Problemas:** Tem dificuldade em calcular inter-reflexões difusas (color bleeding) e cáusticas (luz focada através de objetos translúcidos).

---

## Radiosidade

A Radiosidade foca em resolver as **inter-reflexões difusas**, ou seja, como superfícies foscas trocam energia luminosa e transferem suas cores para objetos próximos (*color bleeding*).

- **Como funciona:** O método trata todas as superfícies não apenas como refletoras, mas como potenciais emissoras de luz. Divide a geometria da cena em malhas pequenas chamadas **patches**.
- **Fatores de Forma (Form Factors):** O cálculo mais pesado (~90% do processamento) é descobrir o quanto um *patch* consegue "enxergar" e transferir energia para os outros. O método do **Hemicubo** é uma simplificação usada para calcular esse fator projetando os patches em um cubo sobre cada superfície.
- **Sistema de Equações:** Resolve-se um sistema linear enorme usando métodos numéricos (Gauss-Seidel) para equilibrar a energia até a convergência.
- O processo é **independente do observador** (pode-se navegar na cena sem recalcular a luz difusa).
- **Refinamento Progressivo:** Uma otimização onde os patches mais brilhantes disparam energia primeiro, permitindo que a imagem comece escura e vá clareando e detalhando a cada iteração, exibindo resultados provisórios rapidamente.

*Nota:* Atualmente, a melhor estratégia é combinar ambos (Ray Tracing para especular + Radiosidade para difuso) ou usar técnicas avançadas.

---

## Path Tracing (Monte Carlo)

O Path Tracing é uma evolução baseada em métodos estatísticos (Monte Carlo) projetada para unificar o cálculo e resolver os problemas do Ray Tracing clássico (color bleeding e cáusticas).

- Para calcular a reflexão difusa de forma correta (que espalharia infinitos raios em um hemisfério), o Path Tracing dispara **apenas um raio secundário aleatório**.
- Para compensar a perda de precisão e a aleatoriedade, disparam-se dezenas, centenas ou milhares de raios primários por pixel.
- **Resultado:** Produz a iluminação global mais realista possível em uma única equação de renderização, porém, o uso de poucos raios gera "ruído" (granulação) na imagem. Requer alto poder computacional para limpar o ruído (centenas de *paths* por pixel).

---

## POV-Ray (Persistence of Vision Raytracer)

O POV-Ray é um popular software de renderização baseado em Ray Tracing, que utiliza uma linguagem própria de script (sintaxe parecida com C) para descrever a cena em vez de usar interfaces de modelagem visual.

**Características Principais:**
- Estrutura da cena feita através de blocos e declarações, com suporte a diretivas de inclusão (`#include "colors.inc"`).
- **Câmera:** Definida com posição (`location`) e direção (`look_at`).
- **Fontes de Luz:** Pode-se posicionar luzes pontuais no espaço (ex: `light_source { <20, 4, -13> color White }`).
- **Objetos Simples e Infinitos:** Possui primitivas como `sphere`, `box`, `cylinder` e até mesmo planos infinitos (`plane`).
- **Texturas e Acabamentos:** Modificados pelas propriedades `pigment` (cores ou padrões como `checker`), `finish` (para ajustar brilho e reflexividade, como `Shiny`), entre outras.
- **Geometria Construtiva de Sólidos (CSG):** Permite modelar formas complexas pela união, diferença e intersecção geométrica de formas primitivas (`union`, `difference`, `intersection`).
- **Efeitos Atmosféricos:** Pode gerar nevoeiros volumétricos e realistas com a diretiva `fog`.
- **Malhas de Polígonos:** Objetos tridimensionais facetados mais complexos podem ser definidos por listas de vértices (`mesh`, `mesh2`, `polygon`).
