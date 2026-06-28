# Fundamentos da Computação Gráfica

Este documento reúne os conceitos básicos introduzidos na disciplina, desde o histórico até as principais áreas de atuação da Computação Gráfica (CG).

---

## 1. O que é Computação Gráfica?
A Computação Gráfica é o conjunto de técnicas matemáticas e algorítmicas utilizadas para converter dados brutos em representações visuais (imagens) em dispositivos gráficos. 

Enquanto a **Visão Computacional** realiza a *Análise* (transformando imagens em dados/modelos), a Computação Gráfica cuida da *Síntese* (transformando modelos/dados em imagens).

O processo envolve criar **Objetos**, **Fontes de Luz** e aplicar **Transformações**.

## 2. Áreas Fundamentais da CG
A Computação Gráfica é dividida em grandes temas:
- **Forma (Modelagem Geométrica):** Como criar, representar e armazenar matematicamente os objetos (CSG, representações poligonais, paramétricas).
- **Aparência (Renderização):** A matemática da luz. O cálculo de como a energia luminosa interage com o ambiente 3D para gerar uma imagem 2D final realista ou não (NPR).
- **Ação (Animação):** Como os objetos se movem ao longo do tempo (cinemática, captura de movimento, simulação física).
- **Interface (Realidade Virtual/Aumentada):** Técnicas e hardware para inserir o usuário dentro do ambiente modelado ou misturar o virtual com o real.

## 3. Breve Histórico
- **Anos 60-70:** Ivan Sutherland cria o *Sketchpad* (1963). O hardware era vetorial (raster era inviável por falta de memória). Modelagem puramente estrutural (*wireframe*).
- **Anos 80:** Viabilização das telas raster (matriz de pixels). Criação do revolucionário **Z-Buffer** (1975). Primeiras interfaces gráficas e primeiros efeitos CG no cinema (*Tron*, 1982).
- **Anos 90 em diante:** Consolidação do raster, renderização fotorealista, captura de movimento e os primeiros longas 100% computação gráfica (*Toy Story*, *Cassiopéia*).

## 4. O Paradigma da Percepção
> A primeira lei da programação gráfica: **Se parece correto, então está correto.**

Em CG, nosso objetivo frequentemente é convencer o olho e o cérebro humanos. Por isso, a CG mistura fortemente Matemática e Física (para simular a luz e geometria) com Biologia e Óptica (para entender como o olho é enganado pelas cores e pelos quadros contínuos de uma animação). 
