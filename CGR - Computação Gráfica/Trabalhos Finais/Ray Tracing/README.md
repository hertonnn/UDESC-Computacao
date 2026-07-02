# Anotações: Algoritmo Ray Tracing 

Este documento contém minhas anotações resumidas dos principais conceitos aprendidos no tutorial [Ray Tracing in One Weekend](https://raytracing.github.io/books/RayTracingInOneWeekend.html).

## 1. O Formato de Imagem PPM
- **Estrutura Básica:** O formato PPM é uma maneira simples de representar imagens em texto puro. 
- Usei a extensão PBM/PPM/PGM Viewer do Visual Studio Code para visualização das imagens criadas.
- O formato PPM começa com um cabeçalho (ex: `P3`), seguido pelas dimensões da imagem (largura e altura) e o valor máximo de cor (ex: `255`).
- Os pixels são escritos da esquerda para a direita, de cima para baixo. Cada pixel tem 3 valores correspondentes a Vermelho, Verde e Azul (RGB).

## 2. A Classe `vec3` (Vetores e Cores)
- A matemática 3D exige o uso constante de vetores com três componentes (`x, y, z` ou `r, g, b`).
- A classe `vec3` nos ajuda a agrupar esses valores e simplifica operações matemáticas como:
  - Adição, subtração e multiplicação por um número escalar.
  - **Dot Product (Produto Escalar):** Utilizado para projeções e cálculos de ângulos.
  - **Cross Product (Produto Vetorial):** Utilizado para encontrar vetores perpendiculares.
  - **Unit Vector:** Um vetor "normalizado", com comprimento (magnitude) exatamente igual a 1. É essencial para representar *direções* e *normais*.

## 3. Raios, Câmera e Fundo (Background)
- **A Equação do Raio:** `P(t) = A + t * b`
  - `P(t)` é uma posição 3D no espaço que o raio alcançou.
  - `A` é a origem do raio (no nosso caso, a posição da câmera).
  - `b` é a direção para a qual o raio aponta.
  - `t` é o parâmetro de "tempo" ou "distância". Se `t > 0`, o raio está viajando para a frente da câmera.
- **Viewport:** Uma "tela virtual" 3D através da qual disparamos os raios a partir da origem da câmera. O viewport tem uma largura e altura definidas; calculamos a direção de cada raio subtraindo a posição da câmera do centro do pixel no viewport.
- O plano de fundo do céu foi criado fazendo uma interpolação linear (*blend*) entre branco e azul claro com base na altura (eixo Y) de onde o raio mirou no espaço.

## 4. Interseção Raio-Esfera
- O teste de colisão entre uma reta (o raio) e a equação de uma esfera resulta em uma equação do 2º grau na forma `a*t² + b*t + c = 0`.
- Calculamos o **Discriminante** ($\Delta = b^2 - 4ac$):
  - $\Delta < 0$: O raio passa direto, sem tocar a esfera (0 raízes reais).
  - $\Delta = 0$: O raio apenas raspa na borda da esfera (1 raiz).
  - $\Delta > 0$: O raio perfura a esfera, atravessando-a de um lado a outro (2 raízes).
- **Detalhe Importante:** O cálculo da equação do 2º grau considera uma reta infinita. Para garantir que a esfera está fisicamente na *frente* da câmera, o valor de `t` encontrado pela fórmula de Bhaskara precisa ser positivo (`t > 0`). 

## 5. Normais de Superfície e Múltiplos Objetos
- **Normais:** Uma normal de superfície é um vetor unitário (tamanho = 1) que aponta na direção exatamente perpendicular à superfície da forma no ponto de colisão.
- Para uma esfera, a normal no ponto de colisão `P` é simplesmente calculada como a direção do centro até o ponto `(P - Centro)`.
- As normais possuem coordenadas entre `-1.0` e `1.0`. Convertendo esses valores para o intervalo de cores `[0.0, 1.0]` (através de `(x+1)*0.5`), conseguimos criar um mapa de cores bonito para visualizar a geometria.
- **Arquitetura (`hittable` e Polimorfismo):** O código foi refatorado para criar uma classe base abstrata `hittable`, permitindo agrupar dezenas de esferas (ou outros objetos no futuro) em uma lista (`hittable_list`).
- O raio dispara e itera sobre a lista de objetos, registrando o objeto atingido que está "mais perto" da câmera. Fazemos isso monitorando o menor valor válido de `t`. Para ignorar alvos falsos, impomos os limites `t_min` e `t_max`.

## 6. Refatoração da Câmera e Utils
- Conforme o código cresceu, a matemática solta no `main.cc` dificultou a leitura.
- Toda a lógica de proporções de imagem, cálculos do Viewport e disparo dos raios (além do loop final que gera a imagem) foi encapsulada na classe `camera`.
- Dessa forma, `main.cc` fica responsável apenas por instanciar a "cena", encher o mundo com esferas variadas e chamar `cam.render(world)`. Constantes como limite do infinito e conversão para radianos também ganharam espaço no utilitário `rtweekend.h`.

## 7. Antialiasing 
- Na versão crua, a câmera dispara **exatamente um raio por pixel**, no centro. Se a borda curva de uma esfera cai no meio do pixel, ele fica pintado "ou todo com a cor da esfera, ou todo com a cor do fundo", gerando cantos quadriculados conhecidos como *Aliasing* (serrilhado, "escadinha").
- **A Solução (MSAA):** Para cada pixel, em vez de disparar um único raio perfeitamente centralizado, disparamos **múltiplos raios amostrais (samples)** em posições vizinhas ligeiramente deslocadas/aleatórias, mas que ainda pertencem à área daquele pixel.
- O resultado final gravado naquele pixel será a **média** das cores retornadas por todos esses raios disparados. 
- O efeito resultante são bordas que misturam sutilmente a cor do objeto com o cenário, acabando com a sensação de baixa resolução e deixando as formas perfeitamente arredondadas.
- **O Custo de Performance:** Essa técnica possui um custo computacional altíssimo. Se uma imagem possui 90.000 pixels e definirmos 100 amostras (*samples*) por pixel, o sistema precisará calcular 9 milhões de raios em vez de apenas 90 mil. O trabalho da CPU aumenta na mesma proporção da quantidade de *samples*, tornando a renderização da imagem notavelmente mais lenta.

## 8. Materiais Difusos
- Superfícies difusas (foscas) não emitem luz própria; elas "espalham" a luz refletindo-a em direções aleatórias.
- **Raios Aleatórios e Recursão:** Quando um raio da câmera atinge uma esfera difusa, ele "quica" (*bounce*) gerando um novo raio em uma direção aleatória. O programa então chama a função de cor recursivamente para esse novo raio (ele bate, reflete e continua viajando).
- **Absorção e Cores:** A cada rebatida, a superfície do objeto "absorve" um percentual da luz. Em código, multiplicamos a cor do raio pela refletância da superfície. É essa perda de luz a cada impacto que forma sombras de contato macias (ambientes) e dá a cor final ao objeto.
- **Limite de Profundidade (*Max Depth*):** Para impedir que a recursão ocorra infinitamente (o raio ficar "preso" quicando para sempre entre duas esferas próximas), define-se um limite de rebatidas (ex: `max_depth = 50`). Se o raio esgotar esse limite sem atingir o céu, o percurso é abortado e retorna cor preta (sombra).
- **O Bug do *Shadow Acne* (Acne de Sombra):** Devido a problemas de arredondamento de casas decimais em programação (imprecisão de *floats/doubles*), um raio que acabou de quicar pode calcular sua posição de origem ligeiramente "dentro" da própria esfera e colidir imediatamente com ela mesma no tempo `t=0.000000001`. Isso gera pontos pretos de ruído na superfície das formas.
  - **A Solução:** Ignorar colisões imediatas. Subimos o limite de aceitação do `hit()` de `t_min = 0` para `t_min = 0.001`, eliminando essas indesejadas "auto-colisões".
- **Correção Gamma (*Gamma Correction*):** O ray tracing lida com cálculos lineares de luz, mas monitores assumem dados pré-corrigidos e exibem a imagem muito escura. A solução adotada (uma aproximação do Gamma 2.0) foi aplicar uma raiz quadrada (`sqrt()`) em todas as componentes (R, G, B) de cor do pixel antes de salvá-lo no arquivo PPM, tornando a cena clara e agradável.
