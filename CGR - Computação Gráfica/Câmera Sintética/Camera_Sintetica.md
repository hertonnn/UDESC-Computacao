# Câmera Sintética e Animação 3D

Este documento reúne as anotações teóricas dos tópicos de "Sistemas de Partículas" e "Câmera Sintética/Pipeline de Visualização 3D", cobrindo conceitos fundamentais sobre como objetos tridimensionais são simulados e exibidos em um dispositivo 2D.

---

## 1. Sistemas de Partículas e Vida Artificial

Os **sistemas de partículas** foram criados por William T. Reeves (1982, *Star Trek II*) e são amplamente utilizados para modelar objetos "confusos" (fuzzy) e amorfos, como **fogo, nuvens, fumaça e água**.

Diferente de objetos geométricos rígidos:
- O volume **não** é representado por uma única entidade, mas sim por uma nuvem de primitivas (partículas).
- As partículas são **dinâmicas**: elas se movem, nascem e morrem constantemente durante a animação.
- O formato final do objeto é **não-determinístico** e possui forte componente estocástico (aleatoriedade).

### Atributos das Partículas
Cada partícula em uma simulação possui as seguintes características individuais:
- **Posição, Velocidade e Aceleração** no espaço tridimensional ($\mathbb{R}^3$).
- **Massa** (valor real).
- **Cor** (padrão RGB) e **Transparência**.
- **Forma e Tamanho**.
- **Tempo de Vida** (medido em quadros ou tempo contínuo).

### Modelos de Dinâmica
A interação entre as partículas define como o sistema é classificado:
- **Sistemas Desacoplados**: O movimento de uma partícula não é influenciado pelas outras. A partícula responde apenas ao seu próprio estado e ao ambiente. É uma abordagem rápida ($O(n)$) e altamente paralelizável.
- **Sistemas Acoplados**: O movimento depende ativamente das interações com outras partículas e com o ambiente. Embora mais realista, é computacionalmente mais pesado. Para reduzir a complexidade, costuma-se usar a decomposição espacial em células (grid).

### O Modelo de Boids (Reynolds, 1987)
Criado por Craig Reynolds, é o algoritmo fundamental para a simulação de *flocks* (bandos de pássaros, peixes, manadas). Diferente dos sistemas de partículas tradicionais de Reeves, onde as partículas apenas aparecem e somem, nos **Boids**:
- Existe um **número fixo** de agentes.
- Cada boid possui inteligência local para evitar colisões e navegar.
- O comportamento global elegante de um bando **emerge** da combinação de 3 regras locais simples:
  1. **Separation (Collision Avoidance)**: Evitar aglomeração excessiva com os vizinhos mais próximos.
  2. **Alignment (Velocity Matching)**: Alinhar sua velocidade e direção com as dos vizinhos.
  3. **Cohesion (Flock Centering)**: Tentar mover-se em direção ao centro de massa dos vizinhos.

Para simular multidões humanas, destaca-se o **Modelo de Helbing** (2000), que adiciona forças físicas e socio-psicológicas (força motivadora, atrito de contato e desvio).

---

## 2. Pipeline de Visualização 3D e Câmera Sintética

Passar do mundo tridimensional para a tela bidimensional exige um processo estruturado conhecido como **Pipeline de Visualização 3D**. Ele transforma as coordenadas do mundo em coordenadas de imagem.

### Etapas do Pipeline 3D
1. **Instanciamento**: Posicionar e escalar os objetos locais no Sistema de Referência do Universo (SRU).
2. **Transformações de Câmera**: Converter as coordenadas do SRU para o Sistema de Referência da Câmera (SRC).
3. **Recorte 3D (Clipping)**: Descartar aquilo que não será visível.
4. **Projeção**: Transformar 3D em 2D.
5. **Mapeamento (Window-to-Viewport)**: Escalar as coordenadas projetadas para a janela da tela.

### A Câmera Virtual / Sintética
A câmera atua como uma metáfora de observação. Ao configurá-la, definimos:
- O **Ponto de Observação** (onde a câmera está).
- A **Direção da Projeção** (para onde aponta).
- O **Plano de Projeção** e a **Janela de Visualização**.
- O **Volume de Visualização** (o espaço que a câmera enxerga, também chamado de *View Frustum*). O que estiver fora desse volume será descartado (Clipping).

### Tipos de Projeção
A projeção reduz as dimensões (de 3D para 2D), mapeando os raios originados no centro de projeção até o plano de visualização. Existem duas categorias principais:
- **Projeção Paralela/Ortográfica**: Os raios de projeção são paralelos. O tamanho dos objetos é preservado, independentemente da distância. Útil para desenhos técnicos.
- **Projeção Perspectiva**: Os raios de projeção convergem para um único ponto de fuga. Objetos distantes parecem menores, oferecendo forte realismo simulando o olho humano.

### Recorte 3D e Normalização
O sistema visual só renderiza o que está à frente da câmera e dentro do tronco da pirâmide (em perspectiva). Para facilitar os cálculos matemáticos:
1. O volume de visualização é distorcido para um volume canônico com limites de $[-1, 1]$ em $x, y$ e $-z_{min}, -1$ em $z$.
2. O **Algoritmo de Cohen-Sutherland** expandido (utilizando 6 bits) classifica os vértices contra o cubo de recorte.
3. Polígonos que cruzam os planos são interceptados matematicamente e apenas suas porções visíveis seguem em frente.

### Remoção de Faces Ocultas
Antes de desenhar na tela, precisamos saber qual objeto está na frente de qual. Existem diversos métodos:
- **Backface Culling**: Ignora automaticamente as faces ("costas") dos polígonos cujas normais apontam na direção contrária à câmera. Apesar de descartar quase 50% do processamento rapidamente, não resolve oclusões entre objetos distintos.
- **Algoritmo do Pintor (Painter's Algorithm)**: Ordena os polígonos baseados na distância $Z$ e pinta do mais longe para o mais perto. Lento e sofre com ambiguidades complexas.
- **Z-Buffer (Depth-Buffer)**: O mais comum na computação gráfica moderna (usado pelo OpenGL). Um buffer de memória armazena a profundidade ($Z$) do último pixel pintado naquela coordenada. Um novo pixel só é renderizado se estiver fisicamente "mais perto" da tela do que o pixel que está armazenado no Z-Buffer para aquela posição. Requer muita memória, mas é extremamente rápido e fácil de implementar em hardware.
