# Modelagem Geométrica

Este documento reúne a transcrição autoral dos conceitos sobre os paradigmas e técnicas matemáticas usadas para descrever as formas tridimensionais (Modelagem Geométrica).

---

## 1. Paradigmas de Modelagem

Para que o computador consiga desenhar um objeto, precisamos de formas precisas para armazenar sua geometria. Há três enfoques principais:
- **Modelagem Sólida:** Foco na "massa" interna e volume do objeto. Essencial para simulações de engenharia (peso, centro de massa). A técnica mais famosa é o **CSG** (Constructive Solid Geometry).
- **Modelagem de Superfície (B-Rep):** Foco exclusivo na "casca" externa que separa o interior do exterior. É o modelo amplamente adotado em jogos e animações, focado em desenhar e pintar malhas de polígonos visíveis.
- **Modelagem Paramétrica e Baseada em Imagem:** Foca na matemática procedural (curvas, equações paramétricas como Bézier/NURBS) e no uso de texturas complexas para dar a ilusão de detalhes.

## 2. Técnicas de Construção e Edição

### CSG (Constructive Solid Geometry)
Abordagem onde formas complexas são construídas através de operações lógicas sobre primitivas geométricas simples (esferas, cilindros, caixas).
- As operações aplicadas são a matemática booleana clássica: **União** (soma as formas), **Intersecção** (mantém só onde coincidem) e **Diferença / Subtração** (um objeto "morde" ou esculpe o outro).
- Matematicamente, a forma final é mantida na memória computacional como uma Árvore de CSG, guardando o histórico das operações.

### B-Rep (Boundary Representation)
Baseia-se em estruturar os Limites (faces, arestas, vértices) que desenham a superfície.
- **Malha Poligonal:** A mais famosa. Uma coleção de triângulos ou quadriláteros interligados. Sofre com a "ilusão de curvas", exigindo alta densidade de polígonos para simular suavidade.
- **Modelagem por Varredura (Sweep):**
  - *Extrusão (Translational Sweep):* Pega um desenho 2D e o "estica" linearmente pelo eixo Z para formar um sólido 3D.
  - *Revolução (Rotational Sweep):* Pega um contorno 2D e o rotaciona 360º ao redor de um eixo. (Como fazer uma garrafa ou um vaso de barro).

## 3. Subdivisão Espacial e Estruturas Ocultas
Para otimizarmos detecção de colisão ou a renderização, os modeladores subdividem o espaço ao redor ou dentro dos objetos:
- **Voxels e Octrees:** Dividem um cubo-mãe sucessivamente em 8 cubinhos menores até atingir a resolução desejada. Perfeito para volumes densos (como exames médicos de ressonância ou terrenos estilo *Minecraft*).
- **BSP-Trees:** Usam as faces de um objeto para fatiar o universo iterativamente em "Frente" e "Atrás". Muito usadas nos motores de jogos clássicos (Doom, Quake) para otimizar os níveis (Level Design).
- **B-Splines e NURBS:** Para gerar curvas aerodinâmicas exatas, em vez de polígonos serrilhados, usa-se matemática paramétrica onde o animador manipula "pontos de controle", e a curva gerada é sempre suave independente da aproximação da câmera.

---
*A grande pergunta da Modelagem: Qual método é melhor? A resposta não é exata; para o cinema usa-se muito NURBS, para a engenharia CSG, e para videogames a Malha Poligonal combinada à texturização pesada impera incontestável.*
