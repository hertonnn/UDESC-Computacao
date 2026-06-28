# Transformações Geométricas

Neste documento, consolidamos os conceitos matemáticos que permitem mover, redimensionar e girar objetos no espaço 2D e 3D.

---

## 1. Transformações Básicas (Afins)
Para animar ou posicionar um objeto (um carro numa pista, por exemplo), não alteramos a modelagem da malha poligonal; nós aplicamos matrizes matemáticas em todos os seus vértices originais.

- **Translação:** Mover um objeto ao longo dos eixos X, Y e Z. (Ex: Carro indo pra frente). É uma operação de adição vetorial.
- **Escala:** Aumentar ou diminuir o objeto. Multiplica-se o X, Y e Z por um fator. Se o fator for negativo, ocorre uma *Reflexão* (espelhamento).
- **Rotação:** Girar o objeto em torno de um eixo específico ou um eixo arbitrário no espaço usando funções trigonométricas (seno e cosseno).

*Nota sobre Cisalhamento (Shear):* É uma deformação onde "inclinamos" o objeto amarrando a base e empurrando o topo (como uma fonte *itálica*).

## 2. A Mágica das Coordenadas Homogêneas
**O Problema:** Matematicamente, Escala e Rotação são resolvidas com Multiplicação de Matrizes. Porém, a Translação é resolvida com Soma Vetorial. Se quisermos mover e depois girar um objeto 3D, teremos que fazer uma soma e depois uma multiplicação, o que é ineficiente para as placas de vídeo calcularem repetidamente.

**A Solução:** Adicionamos uma 4ª dimensão "falsa" aos nossos vértices $X, Y, Z$, chamando-a de $W$ (onde $W=1$). Agora, o vértice 3D virou um vetor 4D $[X, Y, Z, 1]$.
Com as Coordenadas Homogêneas, as matrizes de transformação 3x3 crescem para 4x4. O segredo brilhante disso é que agora a **Translação se transformou numa Multiplicação de Matriz!**

Isso padroniza todo o pipeline matemático. Qualquer movimentação, rotação, câmera ou projeção pode ser expressa como uma matriz 4x4.

## 3. Composição de Transformações
Como agora tudo é Matriz 4x4, se quisermos que um robô ande para frente, dobre de tamanho e vire a cabeça, não aplicamos a matemática 3 vezes no robô. Nós multiplicamos a *Matriz de Translação* pela *Matriz de Escala* pela *Matriz de Rotação*.
O resultado é uma única "Matriz Mestra" 4x4. O computador só precisará multiplicar cada vértice do robô por essa matriz mestra UMA vez para aplicar todos os efeitos de uma só vez. 

**Cuidado com a Ordem (Não Comutatividade):**
Na multiplicação de matrizes, $A \times B \neq B \times A$.
- Se você Rotacionar e depois Transladar, o robô vai girar no próprio eixo e depois andar reto naquela direção.
- Se você Transladar primeiro (tirar ele do eixo central do mundo) e depois Rotacionar, ele vai girar fazendo uma órbita larga em torno da origem do mundo, como a Terra gira ao redor do Sol.
