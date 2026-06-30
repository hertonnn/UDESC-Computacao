# Resumo: Mapeamento de Textura em OpenGL

Este documento resume os conceitos teóricos e práticos sobre mapeamento de texturas abordados nos materiais da disciplina (aulas 19 e 20).

## O que é Mapeamento de Textura?

Apenas modelos de iluminação não são suficientes para descrever todas as variações de cor e os microdetalhes de uma superfície (como a estampa de uma roupa, as palavras em um livro ou a rugosidade de uma parede de tijolos). Em vez de modelar todos esses detalhes com milhões de pequenos polígonos — o que tornaria a renderização extremamente pesada —, utiliza-se o **mapeamento de textura**: a técnica de aplicar ("colar") uma função ou imagem bidimensional (o mapa) sobre a superfície dos objetos tridimensionais.

## Propriedades Mapeáveis

Apesar de a aplicação mais óbvia ser a definição de cores (reflexão difusa), é possível mapear inúmeras outras propriedades, como:
- Reflexão especular e do ambiente (Environment Mapping).
- Perturbação do vetor normal (Bump Mapping e Normal Mapping).
- Modificação aparente de relevo e profundidade (Displacement e Relief Mapping).
- Transparência e opacidade (Alpha Mapping).

## Coordenadas de Textura (Espaço *s* e *t*)

As texturas bidimensionais são funções com domínio no espaço 2D, representadas pelas coordenadas paramétricas **s** e **t**.
Geralmente, o mapeamento é normalizado para que a imagem inteira caiba no intervalo onde $0 \le s \le 1$ e $0 \le t \le 1$.
A técnica consiste em projetar os vértices do polígono na imagem (atribuindo a cada vértice um par $(s,t)$) e deixar que os pixels interiores tenham suas cores interpoladas (combinação afim).

## Parametrização e Funções de Mapeamento

Para aplicar uma textura plana em um objeto complexo, precisamos de uma função de mapeamento que converta os pontos $(x,y,z)$ para $(s,t)$.
- Existem parametrizações naturais clássicas para projetar a textura como se estivéssemos embrulhando o objeto: **plana**, **cilíndrica** e **esférica**.
- **Mapeamento em 2 estágios (Bier e Sloan):** Para objetos sem uma parametrização natural, a textura é mapeada primeiro sobre uma forma simples (cilindro, caixa ou esfera) que englobe o objeto, e em seguida, os pontos dessa forma simples são projetados sobre o objeto alvo (através de raios partindo do centro, ou raios normais).

## Mapeamento de Texturas no OpenGL

Passos básicos para uso de texturas planas no OpenGL clássico:
1. **Habilitar o mapeamento:** Executa-se `glEnable(GL_TEXTURE_2D);`
2. **Especificar a imagem da textura:** Carrega-se o array de *texels* (os pixels da textura) na memória de vídeo usando a função `glTexImage2D()`.
3. **Mapear nos polígonos:** Durante o desenho do objeto (`glBegin`/`glEnd`), imediatamente antes de declarar um vértice com `glVertex*()`, deve-se especificar qual ponto da textura lhe corresponde com `glTexCoord*()`. Também é possível fazer o OpenGL calcular essas coordenadas automaticamente via `glTexGen()`.
4. **Outras configurações (`glTexParameter`, `glTexEnv`):**
   - **Modos de repetição (Wrap):** `GL_REPEAT` (repete a textura quando $s,t > 1$) ou `GL_CLAMP` (estica e fixa o último pixel da borda).
   - **Aplicação/Mistura:** Define se a textura irá substituir a cor original do objeto (`GL_REPLACE`), se irá multiplicar com a iluminação (`GL_MODULATE`), etc.

## Mipmapping (Redução de Aliasing)

Quando o polígono projetado na tela tem um tamanho muito diferente da imagem de textura original, surgem problemas de amostragem e *aliasing* (distorções, serrilhados, cintilação).
A solução comum é o uso de **Texturas Mipmap**: o sistema pré-calcula versões progressivamente menores e filtradas da textura (1/4 do tamanho, 1/16, etc). O OpenGL então seleciona e aplica dinamicamente o nível de resolução correto dependendo da distância e escala do objeto na cena.

---

## Técnicas Avançadas e Tópicos Adicionais (Parte 2)

- **Mescla de Texturas e Mapeamento 3D:** É possível aplicar múltiplas texturas (Multi-texturing) e misturá-las. Além disso, texturas 3D atuam como um "bloco de mármore", onde o objeto é "esculpido", atribuindo texturas baseadas na posição $x,y,z$ real.
- **Textura Procedural:** Funções matemáticas ou algoritmos (como ruídos/noise baseados no método de Perlin) que calculam a cor, geometria ou densidade em tempo real, gerando texturas orgânicas e aleatórias (nuvens, madeira, fogo) em vez de usar imagens bitmap fixas.
- **Environment Mapping:** Permite simular reflexos espelhados de forma computacionalmente barata. Usa-se uma textura (ex: cube map) contendo a imagem do ambiente em volta, e a cor refletida é calculada a partir do vetor de visão refletido pela normal do objeto.
- **Shadow Map:** Técnica pioneira (Lance Williams, 1978) para geração de sombras dinâmicas. Funciona renderizando a cena a partir do ponto de vista da fonte de luz e salvando a profundidade ($z$) em uma textura. Na etapa de câmera normal, verifica-se se a distância do pixel até a luz é maior do que o salvo na textura; se sim, o pixel está oculto por algo e, portanto, recebe sombra.

### Simulação Avançada de Relevo

Em busca de realismo sem adicionar peso excessivo na geometria (sem aumentar o número de polígonos), surgiram métodos para perturbar a superfície:
1. **Bump Mapping:** Usa um mapa de altura em tons de cinza. A técnica perturba o cálculo do vetor normal com base nesse mapa *antes* do cálculo de iluminação. Isso afeta o sombreamento do pixel e gera uma ilusão de rugosidade, mas as bordas/silhueta do objeto continuam lisas e não há oclusão interna do próprio relevo.
2. **Normal Mapping:** Evolução que armazena os próprios vetores de perturbação diretamente nos canais (RGB) de uma imagem, correspondendo aos eixos $(X,Y,Z)$. Muito comum em games para transferir a riqueza de detalhes de um modelo de "High-Poly" para as normais de um modelo "Low-Poly". Requer cálculos no espaço tangente do modelo.
3. **Displacement Mapping (Parallax Mapping):** Aplica deslocamentos nas coordenadas paramétricas da textura baseado no ângulo de visão da câmera e num mapa de alturas, dando a impressão real de profundidade tridimensional com deslocamentos (paralaxe) na textura conforme a câmera se move.
4. **Relief Mapping:** Uma técnica ainda mais refinada que realiza testes de intersecção de raios (*ray casting*) puramente dentro da GPU (*fragment shader*) sobre os mapas de relevo. Permite detalhes extremamente profundos, com auto-sombreamento correto entre os sulcos e oclusões de paralaxe perfeitas, garantindo alto realismo sem alterar a malha 3D poligonal subjacente.
