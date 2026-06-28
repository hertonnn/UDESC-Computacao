# Arquitetura e Programação com OpenGL

Este documento resume as anotações referentes à especificação e estruturação de uso da famosa API multiplataforma Open Graphics Library (OpenGL).

---

## 1. O Que é o OpenGL?
- É uma API de software, de baixo nível e interativa, focada na renderização de gráficos 2D e 3D acelarados por hardware (GPU). É independente do sistema operacional de janelas (funciona no Windows, Linux, MacOS).
- **Máquina de Estados (State Machine):** Este é o conceito central. Você define certas variáveis ou configurações na API (como cor atual de desenho, cor de fundo, ativar/desativar iluminação) e essas configurações permanecem ativas e congeladas neste "estado" até que seu código explicitamente mude a instrução.
- Não há instruções de manipulação de janelas ou mouse/teclado de forma direta, sendo comum emparelhá-lo com bibliotecas auxiliares como *GLUT, FreeGLUT, GLFW ou SDL* para cuidar do "Sistema Operacional".

## 2. A Filosofia de Vértices e Primitivas
Em OpenGL clássico (Legacy), tudo começa e gira em torno de desenhar **Vértices** (pontos no espaço).

- Envelopamos os vértices num bloco de "criação" `glBegin(...)` e finalizamos com `glEnd()`.
- O que você passa para o `glBegin` (ex: `GL_POINTS`, `GL_LINES`, `GL_TRIANGLES`, `GL_QUADS`, `GL_POLYGON`) dita como o OpenGL interpretará a "ligação" dos vértices.
  - *Exemplo:* Passando `GL_TRIANGLES`, cada 3 vértices submetidos formarão um triângulo distinto na tela.

## 3. Matrizes e o Pipeline Visivo
Assim como estudamos na Câmera Sintética, o OpenGL processa as imagens multiplicando os vértices contra diferentes Matrizes. Você diz qual matriz quer modificar chamando `glMatrixMode(...)`.

- `GL_MODELVIEW`: Onde todas as transformações espaciais do mundo ocorrem (translações, escalas, rotações de objetos) e o deslocamento da câmera.
- `GL_PROJECTION`: Como aquele "canto" do universo será visto. É aqui que definimos se a projeção é Ortogonal (`glOrtho`) ou Perspectiva (`gluPerspective`, `glFrustum`), ajustando as bordas do tronco de pirâmide (clipping plano, Near/Far).

## 4. O Comportamento do Push/Pop
Muitas vezes, queremos aplicar uma transformação num objeto específico (ex: girar o braço do robô) e depois desenhar a cabeça do robô *sem* que ela também sofra o giro do braço. Para isso, usa-se a **Pilha de Matrizes**.
- `glPushMatrix()`: Tira uma "fotografia" do estado matemático atual do mundo e a salva no topo da pilha. Modifica-se, move-se, desenha o braço.
- `glPopMatrix()`: Descarta todas as deformações e rotações aplicadas no braço e volta perfeitamente à estaca zero gravada na fotografia, pronto para desenhar a cabeça ilesa.

## 5. Culling e Z-Buffer
Para a OpenGL entender quais partes do objeto estão escondidas (Remoção de Superfícies Ocultas):
- Devemos habilitar explicitamente o teste de profundidade chamando a instrução de mudança de estado: `glEnable(GL_DEPTH_TEST)`.
- É preciso "limpar" o buffer não só de Cores (o lixo da tela antiga), mas o buffer de Profundidade no início de cada *frame* a ser renderizado: `glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)`.
- Para poupar desenho (Backface Culling), OpenGL ignora os polígonos traseiros observando a orientação da criação dos vértices (Sentido Anti-horário / Counter-Clockwise normalmente é considerado a "Frente"). Habilita-se com `glEnable(GL_CULL_FACE)`.
