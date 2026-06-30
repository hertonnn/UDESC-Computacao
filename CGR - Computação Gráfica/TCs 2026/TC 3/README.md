# Steering Behaviors & Sistemas Complexos em C / OpenGL

Este projeto é uma implementação em **C puro e OpenGL (GLUT)** dos conceitos de Agentes Autônomos e *Steering Behaviors* (Comportamentos de Direção). Todo o embasamento teórico e matemático foi retirado da literatura clássica de simulação natural.

## 📚 O que aprendemos com "The Nature of Code"

O livro **[The Nature of Code](https://natureofcode.com/)**, de Daniel Shiffman, explora como simular comportamentos naturais, física e sistemas biológicos através de código. Neste projeto, focamos intensamente no Capítulo 6 (*Autonomous Agents*), onde aprendemos os seguintes conceitos:

* **Agentes Autônomos:** Entidades que percebem seu ambiente e tomam decisões de movimento de forma independente, sem um "cérebro central" controlando tudo.
* **Física de Direção de Reynolds:** O movimento não é definido simplesmente teletransportando a posição. Em vez disso, aplicamos a fórmula `Força de Manobra = Velocidade Desejada - Velocidade Atual`. Essa força é limitada por uma `Força Máxima`, gerando um movimento extremamente orgânico e com inércia, como um carro de verdade fazendo uma curva.
* **Seek (Buscar):** Um comportamento agressivo onde o agente calcula um vetor diretamente para o alvo e tenta viajar na sua `maxspeed`. Resulta em movimentos bruscos que geralmente "orbitam" o alvo.
* **Arrive (Chegar):** Uma evolução do *Seek*, onde o agente monitora a distância. Ao entrar num raio de freio, a velocidade desejada diminui proporcionalmente. Isso permite que ele estacione perfeitamente no alvo.
* **Separate (Separar):** Essencial para evitar que dezenas de veículos se transformem num único ponto amontoado. O agente varre o espaço ao redor e, se alguém entrar no seu espaço pessoal, gera uma força de repulsão inversamente proporcional à distância.
* **Sistemas Complexos (Comportamentos Emergentes):** A magia real de *The Nature of Code*. Ao invés de o código ditar o que a multidão faz, ele diz ao indivíduo: *"Vá até o mouse, mas tente não bater em ninguém"*. Calculamos as forças separadamente, aplicamos multiplicadores de importância (Pesos/Weights), e somamos na aceleração. O efeito de enxame orgânico "emerge" naturalmente!

## 🛠️ O que foi criado aqui

Dividimos a evolução do projeto em três fases:

1. **Simulação 2D Simples (`VehicleClass.c` e `DisplayVehicle.c`)**
   A fundação matemática (`Vector2D`) em C e a aplicação do comportamento fundamental de **Arrive**, onde um veículo persegue a posição do mouse e freia suavemente.

2. **Simulação 3D com Perspectiva Cavaleira (`VehicleClass3D.c` e `DisplayVehicle3D.c`)**
   Elevamos o conceito para o espaço vetorial tridimensional (`Vector3D`). Aqui foi introduzido o cálculo de **Produto Vetorial (Cross Product)** para descobrir eixos perpendiculares e o **Produto Escalar (Dot Product)** para definir os ângulos (Pitch e Yaw), permitindo alinhar a ponta do veículo (Cone 3D) com a velocidade no ar. A câmera foi manipulada através de uma matriz de cisalhamento (Shear Matrix) acoplada a uma projeção ortográfica para criar uma autêntica **Perspectiva Cavaleira**.

3. **Sistemas Complexos 2D (`DisplayComplexSystem.c`)**
   Uma simulação com um número maciço de agentes (como os 200 que testamos). Eles buscam ativamente o mouse, mas a força do `Separate` age simultaneamente e com peso maior, espalhando os triângulos como um autêntico cardume ou formigueiro. Variações aleatórias na velocidade e agilidade entre os clones garantem que nenhum se comporte roboticamente de forma igual ao outro.

## 🚀 Como executar o projeto

Você pode rodar qualquer um dos cenários alterando qual arquivo principal será compilado. O comando abaixo usa a base padrão de importações de bibliotecas em sistemas Windows preparados com o MinGW:

```bash
gcc DisplayComplexSystem.c src/glad.c -Iinclude -Llib -lfreeglut -lopengl32 -lglu32 -lwinmm -lgdi32 -o o.exe && ./o
```

*(Se quiser testar os outros scripts, basta substituir o `DisplayComplexSystem.c` no comando acima por `DisplayVehicle.c` ou `DisplayVehicle3D.c`)*
