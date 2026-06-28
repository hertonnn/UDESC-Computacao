# Anotações Prova 2 CGR

**1) A técnica de mapeamento de textura baseada na aplicação de uma função de perturbação no vetor normal da superfície, de forma que a iluminação desta seja afetada, é denominada:**

A) Textura procedural.

B) Textura sólida.

C) Bump mapping. *(Correta)*

D) Frame mapping.

E) Environment mapping.


Notas:

É Bump mapping, pois nela pega-se cada pixel do objeto que está sendo
renderizado e é aplicada uma perturbação em sua
superfície normal, baseada num mapa de altura,
variando a intensidade de luz "refletida" por este
pixel. 

A) Textura procedural. A Textura Procedural não é uma técnica baseada em alterar como a luz bate no objeto através de vetores normais. Em vez disso, ela é uma textura gerada matematicamente por um algoritmo (um procedimento ou código) em tempo real, em oposição a usar uma imagem bitmap estática (uma foto de madeira, por exemplo)

E) Environment mapping. Environment Mapping é: Uma técnica que usa a normal verdadeira da superfície para calcular o que ela está refletindo do cenário ao redor. 

---

**2) A unidade de processamento gráfico (GPU, graphics processing unit), originalmente projetada para síntese de imagens de alta qualidade, pode ser encontrada embarcada em uma placa de vídeo dedicada ou integrada diretamente em uma placa-mãe. Entre as suas interfaces de programação de aplicativos, destaca-se a API OpenGL. A versão OpenGL 4.0 abstrai a arquitetura da GPU como um fluxo de renderização que consegue transformar uma especificação dos vértices de objetos de interesse dados em um espaço vetorial para uma imagem digital foto-realística, tirando máximo proveito dos circuitos dedicados de renderização de primitivas básicas, como pontos, segmentos e triângulos. O diagrama a seguir mostra que o fluxo de renderização passa por vários blocos de funções.**

*(Diagrama: Especificação de Vértices -> Vertex Shader -> Tesselation Shader -> Geometry Shader -> Pós Processamento | Imagem <- Operações por Pixel <- Fragment Shader <- Rasterização <- Montagem de Primitivas Básicas)*

**Com base no diagrama apresentado e no procedimento de renderização de imagens de malhas triangulares, é correto afirmar que:**

A) Os vértices das facetas triangulares de uma malha *precisam ter suas coordenadas projetadas no plano da imagem* pela aplicação, antes do seu envio para o bloco *Vertex Shader*.

B) Há procedimentos de otimização, como o descarte de facetas não visíveis e o recorte de uma cena completa em uma subcena enquadrada pelos parâmetros de câmera, antes da passagem para o bloco de Rasterização. *(Correta)*

C) As coordenadas de textura devem ser associadas aos vértices da malha triangular quando se deseja texturizá-la, pois essas coordenadas são utilizadas no bloco *Vertex Shader* para acesso aos dados de textura.

D) O modelo de tonalização de Phong, que consiste na interpolação dos vetores normais atribuídos aos vértices, deve ser programado no bloco *Vertex Shader* para se computar a cor da superfície da malha renderizada.

E) As informações referentes a posições, cores, vetores normais da superfície, coeficientes do material da superfície e coordenadas de textura dos vértices são suficientes para geração de uma imagem foto-realística.


---

**3) Em computação gráfica, existem vários modelos de iluminação diferentes que expressam e controlam os fatores que determinam a cor de uma superfície em função de um determinado conjunto de luzes. Uma vez definido um modelo de iluminação, pode-se aplicar luz sobre as várias faces dos objetos de uma cena, processo denominado de sombreamento. As figuras a seguir ilustram a aplicação de dois modelos de iluminação, a saber: o modelo de sombreamento *flat* (à esquerda) e modelo de sombreamento de Phong (à direita).**

*(Imagens de um rosto 3D com sombreamento flat e de Phong)*
*AZEVEDO, E; CONCI, A. Computação gráfica: geração de imagens. Rio de Janeiro: Campus, 2003.*

**Em relação aos modelos de iluminação apresentados, avalie as afirmações a seguir.**
I. A aplicação do modelo de sombreamento *flat* (intensidade constante por face) causa na imagem um efeito visual denominado Bandas de Mach.

II. Embora seja útil para gerar imagens realísticas, o modelo de Phong mostra-se pouco eficiente na apresentação das reflexões especulares.

III. Modelo de sombreamento *flat* não é útil para gerar imagens realísticas porque ele dá destaque ao aspecto facetado da representação poliedral das superfícies.

IV. Para a utilização do modelo de Phong, é necessário supor que a fonte de luz localiza-se no infinito.


**É correto apenas o que se afirma em:**

a) I e II

b) I e III *(Correta)*

c) II e IV

d) I, III e IV

e) II, III e IV



Notas: 

-  O que é o sombreamento Flat: Ele calcula a iluminação apenas uma vez por polígono (usando a normal do centro do triângulo, por exemplo) e pinta a face inteira com aquela exata mesma  
  cor/intensidade.                                                                                                                                                                         
- O que são as Bandas de Mach (Mach Bands): É uma ilusão de ótica natural do olho humano. Quando vemos duas faixas de cores/cinzas de intensidades diferentes colocadas lado a lado,     
  nosso cérebro exagera o contraste exatamente na borda (a linha divisória) entre elas. A parte escura parece ainda mais escura na borda, e a parte clara parece ainda mais clara.         
 
- A relação: Como o Flat Shading cria mudanças abruptas de cor de uma face para a outra (sem suavização na transição), ele aciona agressivamente essa ilusão de ótica. Isso faz com que  
  as arestas dos polígonos fiquem muito destacadas e visíveis aos nossos olhos, prejudicando ainda mais a qualidade da imagem.

- O modelo de Phong (neste caso, referindo-se tanto ao sombreamento de Phong quanto ao modelo de reflexão de Phong) ficou famoso na computação gráfica justamente por resolver o problema do brilho especular (aquele ponto branco de luz refletida em superfícies plásticas ou metálicas).  

-  Uma "fonte de luz no infinito" é o que chamamos de luz direcional (como o Sol), cujos raios são paralelos e não têm uma posição específica, apenas direção.                            
-  O modelo de Phong não tem essa restrição. Ele funciona perfeitamente com luzes direcionais (infinito), mas também é amplamente utilizado e projetado para funcionar com luzes pontuais (como uma lâmpada num quarto) e spotlights (como um farol de carro ou lanterna), que possuem posições bem específicas (pontos locais em 3D, não no infinito) e onde a direção da luz muda para cada pixel iluminado. 
---

**4) Analise as assertivas abaixo sobre técnicas de renderização e iluminação e assinale a alternativa correta.**

I. Ray Tracing é uma técnica que visa simular a propagação da luz no ambiente, avaliando a sua interação com os objetos que o compõem e considerando a interação da luz com as suas superfícies. Esta técnica é frequentemente *utilizada em jogos digitais, dado o seu grau de realismo e o fato de a velocidade de renderização ser eficiente para aplicações de tempo real.*

II. *Z-Buffer* é uma técnica que visa armazenar a profundidade dos objetos em relação à câmera, fazendo com que se *grave, para cada pixel, qual objeto está mais distante.* Essa técnica é utilizada para reduzir o tempo de rendering, especialmente para aplicações que exigem muito do hardware, como no caso das cenas ultrarrealistas geradas *no âmbito cinematográfico*, uma vez que essa técnica representa o estado da arte da geração de cenas tridimensionais ultrarrealistas.

III. O Modelo de Reflexão de Phong é utilizado para renderização da iluminação de objetos. Sua característica principal é a combinação da reflexão difusa, especular e ambiente para formar uma iluminação mais realista. Como esta é uma *técnica de iluminação global* e considera o cálculo tanto da *incidência de luz direta quanto indireta*, *não é muito utilizada em jogos digitais ou aplicações de tempo real, devido ao seu alto custo de tempo de processamento.*

A) Todas as assertivas estão corretas.

B) Todas as assertivas estão incorretas. *(Correta)*

C) Apenas as assertivas I e II estão corretas.

D) Apenas as assertivas I e III estão corretas.

E) Apenas as assertivas II e III estão corretas.

---

**5) Qual é o modelo de tonalização que realiza a interpolação dos vetores normais em uma superfície, produzindo um resultado mais realista dos pontos de brilho (highlights) da superfície?**

A) Tonalização de Gouraud.

B) Tonalização de Phong. *(Correta)*

C) Tonalização constante.

D) Tonalização linear.

E) Tonalização com correção gama.

Notas: 

-  A resposta é B) Tonalização de Phong justamente por sua característica principal: calcular a luz em cada pixel (fragmento) ao interpolar os vetores normais dos vértices, o que garante a precisão necessária para criar pontos de brilho (highlights especulares) redondos e realistas, independentemente do tamanho do polígono.


-  A) Tonalização de Gouraud: Incorreta porque ela interpola a cor/intensidade da luz, e não o vetor normal. A luz é calculada apenas nos vértices (pontas do triângulo) e o resultado é borrado pelo meio. Isso frequentemente destrói os pontos de brilho (highlights), deixando-os feios, distorcidos ou fazendo-os sumir completamente se caírem no meio da face.      

-  C) Tonalização constante (Flat Shading): Incorreta porque não realiza nenhuma interpolação. Ela usa apenas um único vetor normal para o polígono inteiro, pintando a face toda com uma 
  cor só. Deixa o objeto com aspecto "quadriculado" ou facetado.    

-  D) Tonalização linear: Incorreta pois este não é o nome de um modelo clássico de iluminação focado em highlights. Em computação gráfica, interpolação linear é apenas o cálculo        
  matemático usado dentro de outros modelos (como a forma que Gouraud espalha as cores).    

-  E) Tonalização com correção gama: Incorreta porque correção gama não é um modelo de iluminação 3D. É uma técnica matemática (filtro 2D) aplicada no final do processo (pós-processamento) para ajustar os tons de claro e escuro de uma imagem para que ela seja exibida corretamente no brilho de um monitor. Não tem relação com vetores normais ou cálculo de brilho na superfície 3D.



---

**6) Considerando as técnicas para aplicação de texturas, analise as seguintes assertivas:**

I. O mapeamento de imagens como textura (textura de superfície) é uma técnica que utiliza um sistema de coordenadas 2D.

II. A técnica denominada textura procedural evita o gasto com o armazenamento de texturas muito grandes em memória.

III. Bump mapping é uma técnica que se baseia na perturbação da cor nos vértices de uma superfície.


**Quais estão corretas?**

A) Apenas I.

B) Apenas III.

C) Apenas I e II. *(Correta)*

D) Apenas II e III.

E) I, II e III.

---

**7) Cite e comente as principais diferenças entre o modelo de iluminação local e o modelo de iluminação global. Descreva o processo realizado para geração das imagens resultantes dos Trabalhos Complementares 4 e 5. Qual técnica foi utilizada para iluminação local? Explique sucintamente a técnica usada de iluminação global usada no trabalho.**

Resposta:

• Iluminação Local: Calcula apenas a luz direta, ou seja, a luz que viaja diretamente da fonte luminosa (lâmpada, sol) e bate na superfície do objeto para os olhos do observador. Ela   
não considera o rebate da luz em outros objetos. É muito mais rápida de calcular, mas não gera sombras suaves naturais, refrações complexas ou reflexos de luz entre objetos vizinhos. 

• Iluminação Global: Calcula tanto a luz direta quanto a luz indireta. Ela simula a física real de como a luz rebate em uma superfície e ilumina os objetos ao redor (fenômeno conhecido 
como Color Bleeding). Exige um processamento matemático pesadíssimo, mas o resultado é fotorrealista.                                                                                    
                                                                                                                                                                                          
Eu realizei o trabalho no blender: 
O processo prático no Blender envolveu a montagem e configuração da cena (Setup). Basicamente:                                                                                           
                                                                                                                                                                                          
1. Posicionamento: Inserção e organização dos modelos 3D e da Câmera Sintética na cena.   

2. Configuração de Materiais: Atribuição de propriedades aos objetos (ex: brilho, rugosidade, cor difusa) que dizem como eles devem reagir à luz.     

3. Setup de Iluminação: A adição manual de fontes de luz virtuais na cena (como Point Lights / luzes pontuais, Spotlights, ou Area Lights). O processo exigiu ajustar a intensidade, cor 
e posição de cada luz para compor o sombreamento desejado.    

4. Renderização: O acionamento do motor de renderização do Blender para calcular a imagem final convertendo a cena 3D para uma imagem 2D.                                                
                                                                                                                                                                                          
A iluminação Local foi o Modelo de Phong (ou suas variações modernas baseadas em física - PBR). Esse modelo soma a luz ambiente, a difusa e o brilho especular gerado diretamente pelas luzes que posicionei na cena, interpolando as normais para criar sombreamento suave nos modelos.

No Blender, a renderização com iluminação global é feita pelo motor Cycles. A técnica utilizada por ele é o Monte Carlo Path Tracing. De forma sucinta, o Path Tracing dispara raios a partir da câmera virtual, passando por cada pixel da imagem e entrando na cena. Quando o raio bate em um objeto, ele rebate de forma aleatória (estocástica).

---

**Responda uma das três questões abaixo (2 pontos):**

**8a)** Explique como é calculada a componente difusa no algoritmo Ray Tracing. Mostre uma árvore de intersecções e explique como é composta a componente difusa.

**8b)** Descreva as diferenças e semelhanças entre o algoritmo de Monte Carlo Path Tracing e o Ray Tracing distribuído, que dispara diversos raios difusos no ambiente em direções aleatórias ao redor da normal.

**8c)** Como o método do hemicubo auxilia no aumento de desempenho computacional no cálculo da Radiosidade?

**Resumo (Resposta 8b):**
- **Semelhanças:** Ambos são métodos estocásticos de Iluminação Global, baseados em traçado de raios a partir da câmera, exigindo alto custo computacional para amostrar luz com precisão.

- **Diferenças (A Ramificação):** O *Ray Tracing Distribuído* **divide** o raio principal em vários ao atingir uma superfície difusa (causando explosão exponencial de raios). O *Monte Carlo Path Tracing* **nunca divide** o raio, escolhendo um caminho por vez (evitando a explosão de raios e permitindo realismo extremo com muitos rebotes).

