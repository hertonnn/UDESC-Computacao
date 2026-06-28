# Lista 1 - Exercícios e Resoluções

Este documento agrupa os principais conceitos revisados através da Lista 1 de Computação Gráfica, servindo como um guia de estudo rápido sobre a matéria.

---

## 1. Fundamentos e Dispositivos
- A Computação Gráfica foca em **Síntese de Imagens** (criar a imagem a partir de um modelo), diferenciando-se da Visão Computacional (que tenta extrair o modelo a partir da imagem).
- Os sistemas de cor variam de acordo com o meio. **RGB** é aditivo (luz, monitores), **CMYK** é subtrativo (pigmento, impressoras) e **HSV/HLS** são modelos mais intuitivos para o ser humano (Matiz, Saturação e Valor/Luminosidade).
- Dispositivos 3D (como mouses com 6-DOF) são cruciais para navegação fluida em modeladores, permitindo translações ($X, Y, Z$) e rotações ($Roll, Pitch, Yaw$) simultaneamente.

## 2. Representação e Modelagem Geométrica
- **Superfície vs Sólidos:** Modelos de Superfície (B-Rep, Malhas Poligonais) representam apenas a "casca" oca do objeto. Modelos Sólidos (CSG, Voxels) representam volume real.
- **Validação de Sólidos:** Apenas a *Fórmula de Euler* ($V - A + F = 2$) não é suficiente para provar que uma malha poligonal forma um sólido perfeitamente fechado e sem auto-interseções. Validações adicionais (como garantir que cada aresta pertença exatamente a duas faces) são necessárias.
- **Modelos Naturais:** Fogos, nuvens e água não podem ser modelados por polígonos tradicionais rígidos. Eles exigem **Sistemas de Partículas** (como os introduzidos por William T. Reeves). Vegetações são classicamente geradas de forma procedural por **L-Systems** (Sistemas de Lindenmayer).
- **Estruturas Espaciais:**
  - *Octrees:* Partição espacial baseada em subdivisões regulares do espaço em 8 octantes. Útil para volumes e Voxels.
  - *BSP-Trees (Binary Space Partitioning):* Usa os próprios polígonos da cena como planos de corte iterativos. Excelente para ordenar polígonos (Back-to-Front) estáticos independentemente da câmera, resolvendo problemas de renderização clássicos.

## 3. Pipeline e Visibilidade
- **Algoritmos de Varredura (Rasterização de Linhas):**
  - *DDA (Incremental):* Usa aritmética de ponto flutuante, podendo ser lento.
  - *Ponto Médio (Bresenham):* Utiliza apenas matemática inteira (soma, subtração, bit-shift), o que o torna incrivelmente eficiente para implementar direto no hardware da GPU.
- **Z-Buffer vs Backface Culling:**
  - O *Backface Culling* testa a normal do polígono contra o vetor de visão. Elimina aproximadamente metade das faces traseiras que nunca serão vistas, mas **não resolve** polígonos que estão na frente, porém bloqueados por outras paredes.
  - O *Z-Buffer* testa pixel a pixel armazenando a profundidade. Resolve perfeitamente sobreposições, mas exige memória extra. Independe parcialmente da quantidade de primitivas.

## 4. Transformações Geométricas
- A adoção das **Coordenadas Homogêneas** (representar coordenadas 3D com um 4º valor, matriz 4x4) é vital pois unifica todas as transformações (Translação, Rotação, Escala) num único formato matemático, permitindo que elas sejam combinadas por sucessivas replicações de matrizes, o que o hardware resolve numa velocidade estonteante.
- Algumas operações são comutativas (Escala $\rightarrow$ Escala; Translação $\rightarrow$ Translação). Porém, combinações mistas (Translação $\rightarrow$ Rotação) **NÃO** são comutativas. A ordem das matrizes muda completamente o resultado final.

---
*Dica de estudo: Revise a matemática das matrizes de Rotação, pois entender os senos/cossenos na matriz 4x4 é essencial nas provas.*
