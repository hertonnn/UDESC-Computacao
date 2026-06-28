# Projeção 3D

Este documento aborda a teoria de como o Universo 3D é matematicamente "achatado" para caber no monitor 2D, processo conhecido como Projeção.

---

## 1. O Problema da Projeção
A tela do seu computador é bidimensional (X e Y). O mundo virtual modelado é tridimensional (X, Y e Z). A Projeção é a transformação matemática que converte coordenadas 3D em 2D de modo que o cérebro humano ainda reconheça a profundidade original.

## 2. Tipos de Projeção

### Projeção Paralela (Ortogonal)
- **Como funciona:** Os raios de projeção que saem dos vértices do objeto em direção à "câmera" (Plano de Projeção) são perfeitamente **paralelos**. O centro de projeção está no infinito.
- **Características:** As linhas paralelas no mundo 3D continuam paralelas na tela 2D. O tamanho do objeto não muda independente de quão perto ou longe ele esteja da câmera.
- **Uso:** Softwares de engenharia (CAD), plantas arquitetônicas e jogos isométricos (como The Sims clássico ou RollerCoaster Tycoon). Preserva medidas reais, ótimo para modelagem precisa.
- **Variações:**
  - *Ortográfica:* Os raios são perpendiculares ao plano de visão (ex: Visões "Top", "Front", "Side" no Blender).
  - *Oblíqua:* Os raios não são perpendiculares ao plano. Usada para mostrar uma face de frente, mas distorcer a profundidade (Cavaleira, Cabinet).

### Projeção Perspectiva
- **Como funciona:** Todos os raios de projeção convergem para um único ponto (o Centro de Projeção, ou "Olho").
- **Características:** Semelhança com a visão humana e com câmeras fotográficas. Ocorre o fenômeno do **Foreshortening** (Escorço): objetos mais distantes aparecem menores na tela. Linhas que são paralelas no 3D (como os trilhos de um trem) vão convergir para um Ponto de Fuga no 2D.
- **Uso:** Jogos 3D em primeira/terceira pessoa, simuladores, cinema e aplicações que exigem imersão e realismo visual.
- **Variações:** Pode ter um, dois ou três pontos de fuga, dependendo de como a câmera está alinhada em relação aos eixos principais do mundo.

## 3. Frustum de Visão (Tronco de Pirâmide)
Na projeção perspectiva, o volume do mundo que a câmera consegue "enxergar" forma um **Tronco de Pirâmide** (Frustum).
- O cume da pirâmide é o olho do observador.
- **Near Plane (Plano de Corte Frontal):** É a tela em si. Qualquer coisa antes deste plano (próxima demais do olho) não é desenhada (para evitar divisões por zero ou objetos atravessando a câmera).
- **Far Plane (Plano de Corte Traseiro):** O limite da visão. O que estiver depois disso não é renderizado para poupar processamento computacional.

Tudo que estiver fora das 6 paredes do Frustum é sumariamente descartado (etapa de *Clipping*) antes de chegar à rasterização, economizando drasticamente o esforço da GPU.
