# Iluminação e Sombreamento (Shading)

Este documento trata dos modelos matemáticos que determinam como a luz afeta as superfícies virtuais (iluminação) e as formas como o preenchimento de cor é aplicado aos polígonos durante a renderização (sombreamento).

---

## 1. Fontes de Luz

As fontes de luz definem de onde e como a energia luminosa incide no ambiente:
- **Puntiforme Direcional:** Os raios são paralelos, como se a fonte estivesse no infinito. Exemplo: Sol.
- **Puntiforme Omnidirecional:** Emite luz em todas as direções a partir de um único ponto $X, Y, Z$. Exemplo: Vela.
- **Spot/Focada:** Emite luz em forma de cone, perdendo intensidade com a distância. Possui posição, direção e ângulo de abertura. Exemplo: Holofote, lanterna.
- **Extensas / Área:** Objetos que têm volume e emitem luz (lâmpadas, telas). Muito caras computacionalmente para simular (geralmente aproximadas combinando múltiplas pontuais).

## 2. Modelos de Iluminação Locais

Modelos locais (usados largamente em GPUs em tempo real, como OpenGL clássico) calculam a luz num ponto dependendo **exclusivamente** da relação entre a fonte de luz, a geometria local (vetor normal) e a câmera. Elas **ignoram inter-reflexões** (um objeto refletindo luz noutro objeto) ou sombras projetadas, trocando forte realismo por muita velocidade.

O modelo clássico (baseado na equação de **Phong**, modificado para tempo real) compõe a cor final de um objeto como o somatório de diferentes interações:

$$I_{\lambda} = I_{a\lambda} k_a O_{\lambda} + \sum_{i=1}^m f_{att_i} I_{p\lambda_i} [k_d O_{d\lambda} (\vec{N} \cdot \vec{L}_i) + k_s O_{s\lambda} (\vec{R}_i \cdot \vec{V})^n ]$$

**Quebrando os Termos:**
- **Luz Ambiente ($I_a k_a$):** Um valor "falso" para simular a luz rebatida no cenário. Garante que as partes do objeto não diretamente iluminadas não fiquem completamente pretas.
- **Atenuação ($f_{att}$):** Controla a queda de intensidade com o aumento da distância da luz.
- **Reflexão Difusa / Lambertiana ($k_d (\vec{N} \cdot \vec{L})$):** Depende estritamente do cosseno do ângulo entre a Normal da superfície ($\vec{N}$) e o vetor da Luz ($\vec{L}$). Dá a percepção de volume opaco (matte) baseada na distância à luz, mas independentemente da câmera.
- **Reflexão Especular ($k_s (\vec{R} \cdot \vec{V})^n$):** É o "brilho branco" reflexivo (highlight) visto em objetos molhados ou polidos. Depende crucialmente da posição do observador ($\vec{V}$) e do vetor da luz refletida no espelho ($\vec{R}$). O expoente $n$ define quão fino e forte é o ponto de brilho (materiais metálicos possuem valor alto, plásticos valor baixo).

## 3. Modelos de Sombreamento (Shading)

Enquanto a equação de iluminação calcula a cor **num ponto**, o modelo de sombreamento dita **como preencher** um polígono inteiro.

- **Flat Shading (Constante):** Calcula a equação da luz **apenas uma vez** por polígono (usando a normal da face inteira) e pinta ele de uma cor sólida. A aparência fica altamente facetada e "quadrada", evidenciando os polígonos.
- **Interpolated Shading:** Interpola cores linearmente ao longo do triângulo, mas não resolve arestas facetadas. Sofre com a ilusão óptica das **Bandas de Mach** (Mach Bands).
- **Gouraud Shading:** Calcula a equação da luz para cada **Vértice** (encontrando a normal ponderada de cada vértice) e, ao desenhar o triângulo na tela, interpola a cor suavemente. Reduz o aspecto quadrado consideravelmente, e é rápido. A grande fraqueza do Gouraud é que, como a iluminação só ocorre nos vértices, um "ponto de brilho especular" que deveria ocorrer bem no *meio* de um polígono grande pode não aparecer.
- **Phong Shading:** (Não confundir com o modelo de reflexão especular de Phong). Este sombreamento **interpola as normais** e calcula a equação da luz matemática **pixel a pixel** do interior do polígono. É o mais custoso, mas produz brilhos especulares e curvas extremamente realistas.

## 4. Modelos de Iluminação Globais

Modelos como **Ray Tracing** e **Radiosity** são o contrário do modelo local: eles levam **todo o ambiente** em conta. A luz rebate entre as paredes, gera sombras perfeitas e causa "color bleeding" (uma parede vermelha rebate um leve tom vermelho nos objetos brancos ao lado). Custam muito processamento e tradicionalmente não funcionam em tempo real (apesar do RT em tempo real ser a atual novidade tecnológica das GPUs modernas).

- **Ray Casting (O Início do RT):** Método que "atira" um raio matematicamente formulado: $\vec{R}(t) = \vec{P_0} + t \vec{V}$ a partir de cada pixel da câmera virtual em direção à cena. Checa-se qual foi a primeira colisão com os objetos no cenário resolvendo matematicamente as equações implícitas (por exemplo, igualando a reta à função $X^2 + Y^2 + Z^2 - r = 0$ de uma esfera) e então processando a iluminação exatamente ali usando a equação normal do ponto interceptado.
