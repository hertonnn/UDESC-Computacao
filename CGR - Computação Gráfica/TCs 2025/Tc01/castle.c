// Comanda para executar: gcc FirstOpenGL.c -lglut -lGL -lGLU -lm -o FirstOpenGL && ./FirstOpenGL
#include "GL/glut.h"

void createLittleWall(GLfloat x, GLfloat y, GLfloat z, GLfloat theta, GLfloat l, GLfloat height, 
    GLfloat depth);

// Variáveis que iremos utilizar para rotação:
static GLfloat xRot = 0.0f;
static GLfloat yRot = 0.0f;
static GLfloat zRot = 0.0f;

void ChangeSize(int w, int h)
{
    // (1) Essa é a variável que será utlizada para armazer o aspect ratio (razão largura/altura) da...
    // ... tela:
    GLfloat fAspect;

    // Obs.: esta condição evita que se h for passado como um valor muito próximo de 0 (pois ele então...
    // ... seria arrendondado para 0) ocorra divisão por 0:
    if (h == 0)
        h = 1;

    // (2) Esta função serve para ajustar a transformação afim das cordenadas x e y para as cordenadas...
    // ... x e y normalizadas (cada eixo em um intervalo de -1 à 1, ou de 0 à 1):
    glViewport(0, 0, w, h);
    // Os dois primeiros parâmetro indicam respectivamente as coordenadas x e y do canto inferior esquerdo...
    // ... da janela, enquanto w é a largura e h é a altura da mesma.

    fAspect = (GLfloat)w / (GLfloat)h;

    // (3) Esta função especifica qual é a que será alterada pelos comandos de translação, rotação e etc,...
    // ... na pilha:
    glMatrixMode(GL_PROJECTION);
    // Neste caso iremos alterar a matriz de projeção (a última a ser aplicada nos vértices na hora da rende...
    // ...rização e é a a matriz relacionada à câmera e transformação do 3D para o 2D da tela).

    // (4) Esta função troca a matriz atual (na pilha) pela matriz identidade ("reseta"):
    glLoadIdentity();
    // Note que isto é bem importante visto que sem isso as transformações se acomulariam cada vez que a cena...
    // ... é renderizada.

    // (5) Esta função configura a matriz de projeção de perspectiva (joga ela na própria pilha):
    gluPerspective(35.0f, fAspect, 1.0, 40.0);
    // Note que o primeiro argumento é o fovy (campo de ângulo de exibição, em graus, na direção y), o segundo...
    // é o aspect ratio, o terceiro é o zNear (A distância do visualizador até o plano de recorte próximo, sem-
    // ...pre positivo;  é como se fosse a distância m[inima para renderização) e o último é o zFar (A distância...
    // ... do visualizador para o plano de recorte distante, sempre positivo; é como se fosse a distância máxi...
    // ...ma de renderização).

    // (6) Função já descrita antes:
    glMatrixMode(GL_MODELVIEW);
    // Neste caso iremos alterar a matriz de modelo (a primeira a ser aplicada nos vértices na hora da rende...
    // ...rização, ou seja, a matriz que é realmente utilizada para se mexer nos objetos).

    // (7) Função já descrita antes:
    glLoadIdentity();
}

void SpecialKeys(int key, int x, int y)
{
    // (1) O seguinte corpo da função é auto-explicativo:
    if (key == GLUT_KEY_LEFT)
        yRot -= 5.0f;
    if (key == GLUT_KEY_RIGHT)
        yRot += 5.0f;
    if (key == GLUT_KEY_UP)
        xRot += 5.0f;
    if (key == GLUT_KEY_DOWN)
        xRot += -5.0f;
    yRot = (GLfloat)((const int)yRot % 360);
    xRot = (GLfloat)((const int)xRot % 360);

    // (2) Marca a janela atual como precisando ser re-renderizada, para que na seguinte iteração da função...
    // ... glutMainLoop isto ocorra:
    glutPostRedisplay();
}

void SetupRC()
{

    // (1) Este vetor define a intensidade RGBA da luz do ambiente:
    GLfloat whiteLight[] = {0.05f, 0.05f, 0.05f, 1.0f};
    // (2) Este vetor define a intensidade RGBA da luz de difusão:
    GLfloat sourceLight[] = {0.25f, 0.25f, 0.25f, 1.0f};
    // (3) Este vetor define as coordenadas na fonte de luz em coordenadas homogêneas (por isto com 4 coordenadas):
    GLfloat lightPos[] = {-10.f, 5.0f, 5.0f, 1.0f};

    // (4) Esta função ativa o buffer de teste de profundidade, que no momento da renderização verifica cada...
    // ... item a se renderizado, vendo se não há outro item (superfície) com menor profundidade (na frente):
    glEnable(GL_DEPTH_TEST);

    // (5) Esta função define de qual lado cada polígo será renderizado, de modo que estando os vértices...
    // ... ordenados no sentido horário ou anti-horário, dependendo se a direção sobre a qual a luz pode chegar...
    // ... está no sentido escolhido, a face será renderizada ou não:
    glFrontFace(GL_CCW);

    // (6) Esta função habilidade a não renderização das que estejam com os vértices sendo "visto" no sentido...
    // ... contrário ao escolhido:
    glEnable(GL_CULL_FACE);

    // (7) Esta função habilita a luz:
    glEnable(GL_LIGHTING);

    // (8) Esta função define os parâmetros do modelo de iluminação:
    glLightModelfv(GL_LIGHT_MODEL_AMBIENT, whiteLight);
    // Nesse caso o  1º parâmetro indica que o 2º contém quatro valores de ponto flutuante que especificam a...
    // ... intensidade do RGBA ambiente de toda a cena.

    // (9) Esta função define parâmetros para uma determinada luz (fonte de luz):
    glLightfv(GL_LIGHT0, GL_AMBIENT, sourceLight);
    // Nesse caso a fonte de luz é a 0 (GL_LIGHT0), e o 2º parâmetro indica que o 3º contém quatro valores de...
    // ... ponto flutuante que especificam a intensidade do RGBA ambiente da luz.

    // (10) Esta função define parâmetros para uma determinada luz (fonte de luz):
    glLightfv(GL_LIGHT0, GL_DIFFUSE, sourceLight);
    // Nesse caso a fonte de luz é a 0 (GL_LIGHT0), e o 2º parâmetro indica que o 3º contém quatro valores de...
    // ... ponto flutuante quatro valores que especificam a intensidade difusa do RGBA da luz.

    // (11) Esta função define parâmetros para uma determinada luz (fonte de luz):
    glLightfv(GL_LIGHT0, GL_POSITION, lightPos);
    // Nesse caso a fonte de luz é a 0 (GL_LIGHT0), e o 2º parâmetro indica que o 3º contém quatro valores de...
    // ... ponto flutuante quatro valores que especificam a posição da luz em coordenadas de objeto homogêneas.

    // (12) Esta função habilita a luz da fonte 0:
    glEnable(GL_LIGHT0);

    // (13) Esta função habilita para cada material ou materiais especificados por face, o parâmetro de...
    // ... material ou os parâmetros especificados pelo modo acompanham a cor atual o tempo todo.
    glEnable(GL_COLOR_MATERIAL);

    // (14) Define as propriedades que haverão junto a cor atual de cada objeto:
    glColorMaterial(GL_FRONT, GL_AMBIENT_AND_DIFFUSE);

    // (15) Define a cor do fundo do espaço:
    glClearColor(0.25f, 0.25f, 0.50f, 1.0f);
  
}

void RenderScene(void)
{
    GLUquadricObj *Ball;
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glPushMatrix();

    glTranslatef(0.0f, 0.0f, -5.0f);

    glRotatef(yRot, 0.0f, 1.0f, 0.0f);
        
    glRotatef(xRot, 1.0f, 0.0f, 0.0f);

    // (0) Raio das torres:
    GLfloat r = 0.12f;

    // (1) Criando piso (plano do castelo):
    glPushMatrix();

        // (1.2) Variável para o lado do plano quadricular:
        GLfloat l = 1.0f;
        
        // (1.3) Variável para a altura do plano quadricular:
        GLfloat h = 0.1f;      

        Ball = gluNewQuadric();

        // (1.4) Note que a largura e profundidade do plano deve é igual ao dobro do que do que as torres...
        // ... transladaram + o dobro do raio das torres:
        glScalef(l-0.08f+2*r, h/l, l-0.08f+2*r);

        glColor3f(0.396f, 0.263f, 0.129f);

        glutSolidCube(l);


    glPopMatrix();    

    // (2) Criando muro 01 (do meio ou fundo):
    glPushMatrix();
        
        // (2.1) lembre-se o centro do cubo é gerado no (0, 0, 0) por isso se o triangulo tem lado l então por...
        // ... exemplo, existe uma aresta que sai de (-l/2, -l/2, -l/2) e vai até (-l/2, l/2, -l/2).

        // (2.2) A quantidade de translação aqui é igual à 1/2(altura do chão) + 1/2(altura do muro):
        glTranslatef(0.0f, h/2 + 0.1f, 0.0f);

        // (2.3) Colocando o muro em um dos cantos do plano quadricular:
        glTranslatef(0.0f, 0.0f, -l/2 + 0.04f);

        // (2.4) Deixando a grossura do muro menor (comprimindo no eixo z) e aumentando o comprimento no eixo x...
        // ... de modo que os "muros" se encaixem (não se atrvessem) por isso o eixo x é esticado por...
        // ... largura escolhida (para encostar na quina do muro adjacente) + grossura do muro adjacente:
        glScalef((l-0.08f + 0.01)/0.20f, 1.0f, 0.1f);

        Ball = gluNewQuadric();

        glColor3f(0.62,0.63,0.62);

        glutSolidCube(0.20f);

    glPopMatrix();   

    // (3) Criando muro 02:
    glPushMatrix();
        
        // (3.1) lembre-se o centro do cubo é gerado no (0, 0, 0) por isso se o triangulo tem lado l então por...
        // ... exemplo, existe uma aresta que sai de (-l/2, -l/2, -l/2) e vai até (-l/2, l/2, -l/2).

        // (3.2) A quantidade de translação aqui é igual à 1/2(altura do chão) + 1/2(altura do muro):
        glTranslatef(0.0f, h/2 + 0.1f, 0.0f);

        // (3.3) Colocando o muro em um dos cantos do plano quadricular:
        glTranslatef(l/2 - 0.04f, 0.0f, 0.0f);

        // (3.4) Deixando a grossura do muro menor (comprimindo no eixo x) e aumentando o comprimento no eixo z:
        glScalef(0.1f, 1.0f, (l-0.08f)/0.20f);

        Ball = gluNewQuadric();

        glColor3f(0.62,0.63,0.62);

        glutSolidCube(0.20f);

    glPopMatrix();

    // (4) Criando muro 3:
    glPushMatrix();
        
        // (4.1) lembre-se o centro do cubo é gerado no (0, 0, 0) por isso se o triangulo tem lado l então por...
        // ... exemplo, existe uma aresta que sai de (-l/2, -l/2, -l/2) e vai até (-l/2, l/2, -l/2).

        // (4.2) A quantidade de translação aqui é igual à 1/2(altura do chão) + 1/2(altura do muro):
        glTranslatef(0.0f, h/2 + 0.1f, 0.0f);

        // (4.3) Colocando o muro em um dos cantos do plano quadricular:
        glTranslatef(-l/2 + 0.04f, 0.0f, 0.0f);

        // (4.4) Deixando a grossura do muro menor (comprimindo no eixo x) e aumentando o comprimento no eixo z:
        glScalef(0.1f, 1.0f, (l-0.08f)/0.20f);

        Ball = gluNewQuadric();

        glColor3f(0.62,0.63,0.62);

        glutSolidCube(0.20f);

    glPopMatrix();    

    // (5) Criando pedaço 1 do portão:
    glPushMatrix();
        
        // (5.1) lembre-se o centro do cubo é gerado no (0, 0, 0) por isso se o triangulo tem lado l então por...
        // ... exemplo, existe uma aresta que sai de (-l/2, -l/2, -l/2) e vai até (-l/2, l/2, -l/2).

        // (5.2) A quantidade de translação aqui é igual à 1/2(altura do chão) + 1/2(altura do muro):
        glTranslatef(0.0f, h/2 + 0.1f, 0.0f);

        // (5.3) Colocando o pedaço do portão em um dos cantos do plano quadricular:
        glTranslatef(l/2 - 0.04f - (l-0.08f)/(3.0f*2.0f), 0.0f, l/2 - 0.04f);

        // (5.4) Deixando a grossura do muro menor (comprimindo no eixo x) e aumentando o comprimento no eixo z:
        glScalef((l-0.08f)/(3.0f*0.20f), 1.0f, 0.1f);

        Ball = gluNewQuadric();

        glColor3f(0.62,0.63,0.62);

        glutSolidCube(0.20f);

    glPopMatrix();

    // (6) Criando pedaço 2 do portão:
    glPushMatrix();
        
        // (6.1) lembre-se o centro do cubo é gerado no (0, 0, 0) por isso se o triangulo tem lado l então por...
        // ... exemplo, existe uma aresta que sai de (-l/2, -l/2, -l/2) e vai até (-l/2, l/2, -l/2).

        // (6.2) A quantidade de translação aqui é igual à 1/2(altura do chão) + 1/2(altura do muro):
        glTranslatef(0.0f, h/2 + 0.1f, 0.0f);

        // (6.3) Colocando o pedaço do portão em um dos cantos do plano quadricular:
        glTranslatef(- l/2 + 0.04f + (l-0.08f)/(3.0f*2.0f), 0.0f, l/2 - 0.04f);

        // (6.4) Deixando a grossura do muro menor (comprimindo no eixo x) e aumentando o comprimento no eixo z:
        glScalef((l-0.08f)/(3.0f*0.20f), 1.0f, 0.1f);

        Ball = gluNewQuadric();

        glColor3f(0.62,0.63,0.62);

        glutSolidCube(0.20f);

    glPopMatrix();

    // (7) Criando pedaço 3 do portão (meio):
    glPushMatrix();
        
        // (7.1) lembre-se o centro do cubo é gerado no (0, 0, 0) por isso se o triangulo tem lado l então por...
        // ... exemplo, existe uma aresta que sai de (-l/2, -l/2, -l/2) e vai até (-l/2, l/2, -l/2).

        // (7.2) A quantidade de translação aqui é igual à 1/2(altura do chão) + 1/2(própria) + ...
        // ... altura dos outros muros - altura própria:
        glTranslatef(0.0f, h/2 + (0.25f*0.2f)/2 + (0.20f) - 0.25f*0.2f, 0.0f);

        // (7.3) Colocando o pedaço do portão em um dos cantos do plano quadricular:
        glTranslatef(0.0f, 0.0f, l/2 - 0.04f);

        // (7.4) Deixando o muro menor (comprimindo no eixo y):
        glScalef(1.0f, 0.25f, 1.0f);

        // (7.5) Deixando a grossura do muro menor (comprimindo no eixo z) e o acertando o comprimento no eixo x:
        glScalef((l-0.08f)/(3.0f*0.20f), 1.0f, 0.1f);

        Ball = gluNewQuadric();

        glColor3f(0.62,0.63,0.62);

        glutSolidCube(0.20f);

    glPopMatrix();    

    // (8) Criando torre (-l/2, 0, l/2):
    glPushMatrix();
        
        // (8.1) Jogando a torre para o canto do plano:
        glTranslatef(-(l/2 - 0.04), 0, l/2 - 0.04);

        // (8.2) Note que, como viramos o cilindro em 90 graus ele está acima do eixo xz portanto sua base...
        // ... está em (0, 0, 0):
        glTranslatef(0.0f, h/2, 0.0f);

        // (8.3) Colocando o cilindro "em pé":
        glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);

        Ball = gluNewQuadric();

        glColor3f(0.62,0.63,0.62);

        gluCylinder(Ball, r, r, 0.30f, 26, 13);

    glPopMatrix();

    // (9) Criando torre (l/2, 0, l/2):
    glPushMatrix();
        
        // (9.1) Jogando a torre para o canto do plano:
        glTranslatef(l/2 - 0.04, 0, (l/2 - 0.04));

        // (9.2) Note que, como viramos o cilindro em 90 graus ele está acima do eixo xz portanto sua base...
        // ... está em (0, 0, 0):
        glTranslatef(0.0f, h/2, 0.0f);

        // (9.3) Colocando o cilindro "em pé":
        glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);

        Ball = gluNewQuadric();

        glColor3f(0.62,0.63,0.62);

        gluCylinder(Ball, r, r, 0.30f, 26, 13);

    glPopMatrix();

    // (10) Criando torre (-l/2, 0, -l/2):
    glPushMatrix();
        
        // (10.1) Jogando a torre para o canto do plano:
        glTranslatef(-(l/2 - 0.04f), 0, -(l/2 - 0.04f));

        // (10.2) Note que, como viramos o cilindro em 90 graus ele está acima do eixo xz portanto sua base...
        // ... está em (0, 0, 0):
        glTranslatef(0.0f, h/2, 0.0f);

        // (10.3) Colocando o cilindro "em pé":
        glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);

        Ball = gluNewQuadric();

        glColor3f(0.62,0.63,0.62);

        gluCylinder(Ball, r, r, 0.30f, 26, 13);

    glPopMatrix();

    // (11) Criando torre (l/2, 0, -l/2):
    glPushMatrix();
        
        // (11.1) Jogando a torre para o canto do plano:
        glTranslatef(l/2 - 0.04, 0, -l/2 + 0.04);

        // (10.2) Note que, como viramos o cilindro em 90 graus ele está acima do eixo xz portanto sua base...
        // ... está em (0, 0, 0):
        glTranslatef(0.0f, h/2, 0.0f);

        // (10.3) Colocando o cilindro "em pé":
        glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);

        Ball = gluNewQuadric();

        glColor3f(0.62,0.63,0.62);

        gluCylinder(Ball, r, r, 0.30f, 26, 13);

    glPopMatrix();

    // (12) Criando teto de torre (-l/2, 0, l/2):
    glPushMatrix();
        
        // (12.1) Jogando o teto exatamente acima da torre:
        glTranslatef(0.0f, 0.30f, 0.0f);

        // (12.2) Jogando teto para o canto do plano:
        glTranslatef(-(l/2 - 0.04), 0, l/2 - 0.04);

        // (12.3) Note que, como viramos o cilindro em 90 graus ele está acima do eixo xz portanto sua base...
        // ... está em (0, 0, 0):
        glTranslatef(0.0f, h/2, 0.0f);

        // (12.4) Colocando o cilindro "em pé":
        glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);

        Ball = gluNewQuadric();

        glColor3f(0.4f, 0.5f, 0.8f);

        gluCylinder(Ball, r, 0.0f, 0.10f, 26, 13);

    glPopMatrix();

    // (13) Criando teto de torre (l/2, 0, l/2):
    glPushMatrix();
        
        // (13.1) Jogando o teto exatamente acima da torre:
        glTranslatef(0.0f, 0.30f, 0.0f);

        // (13.2) Jogando teto para o canto do plano:
        glTranslatef(l/2 - 0.04, 0, l/2 - 0.04);

        // (13.3) Note que, como viramos o cilindro em 90 graus ele está acima do eixo xz portanto sua base...
        // ... está em (0, 0, 0):
        glTranslatef(0.0f, h/2, 0.0f);

        // (13.4) Colocando o cilindro "em pé":
        glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);

        Ball = gluNewQuadric();

        glColor3f(0.4f, 0.5f, 0.8f);

        gluCylinder(Ball, r, 0.0f, 0.10f, 26, 13);

    glPopMatrix();

    // (14) Criando teto de torre (l/2, 0, l/2):
    glPushMatrix();
        
        // (14.1) Jogando o teto exatamente acima da torre:
        glTranslatef(0.0f, 0.30f, 0.0f);

        // (14.2) Jogando teto para o canto do plano:
        glTranslatef(l/2 - 0.04, 0, -(l/2 - 0.04));

        // (14.3) Note que, como viramos o cilindro em 90 graus ele está acima do eixo xz portanto sua base...
        // ... está em (0, 0, 0):
        glTranslatef(0.0f, h/2, 0.0f);

        // (14.4) Colocando o cilindro "em pé":
        glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);

        Ball = gluNewQuadric();

        glColor3f(0.4f, 0.5f, 0.8f);

        gluCylinder(Ball, r, 0.0f, 0.10f, 26, 13);

    glPopMatrix();

    // (15) Criando teto de torre (l/2, 0, l/2):
    glPushMatrix();
        
        // (15.1) Jogando o teto exatamente acima da torre:
        glTranslatef(0.0f, 0.30f, 0.0f);

        // (15.2) Jogando o teto para o canto do plano:
        glTranslatef(-(l/2 - 0.04), 0, -(l/2 - 0.04));

        // (15.3) Note que, como viramos o cilindro em 90 graus ele está acima do eixo xz portanto sua base...
        // ... está em (0, 0, 0):
        glTranslatef(0.0f, h/2, 0.0f);

        // (15.4) Colocando o cilindro "em pé":
        glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);

        Ball = gluNewQuadric();

        glColor3f(0.4f, 0.5f, 0.8f);

        gluCylinder(Ball, r, 0.0f, 0.10f, 26, 13);

    glPopMatrix();

    // (16) Criando tronco de árvore:
    glPushMatrix();
        
        glTranslatef(-0.18f, 0.0f, 0.0f);
        
        glTranslatef(0.0f, h/2, 0.0f);

        glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);

        glColor3f(0.5f, 0.2f, 0.2f);

        gluCylinder(Ball, 0.05f, 0.05f, 0.4f, 26, 13);

    glPopMatrix();

    // (17) Criando cone de árvore (de baixo):
    glPushMatrix();
        
        glTranslatef(-0.18f, 0.0f, 0.0f);
        
        glTranslatef(0.0f, h/2 + 0.2f, 0.0f);

        glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);

        glColor3f(0.2f, 0.8f, 0.2f);

        gluCylinder(Ball, 0.08f, 0.04f, 0.2f, 26, 13);

    glPopMatrix();

    // (18) Criando cone de árvore (de cima):
    glPushMatrix();
        
        glTranslatef(-0.18f, 0.0f, 0.0f);
        
        glTranslatef(0.0f, h/2 + 0.3f, 0.0f);

        glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);

        glColor3f(0.2f, 0.8f, 0.2f);

        gluCylinder(Ball, 0.08f, 0.0f, 0.3f, 26, 13);

    glPopMatrix();

    // (19) Criando cubo da torre central:
    glPushMatrix();
        
        glTranslatef(0.01f, h/2 + 0.2f*(0.8f/0.2f)/2, 0.0f);

        glScalef(1.0f, 0.8f/0.2f, 1.0f);

        glColor3f(0.01f, 0.01f, 0.01f);

        glutSolidCube(0.2f);

    glPopMatrix();

    // (21) Criando apoio 1 do Sauron:
    glPushMatrix();
        
        glTranslatef(0.01f + 0.1f, h/2 + 0.05f + 0.8f, 0.0f);

        glScalef(0.25f, 1.0f, 0.3f);

        glColor3f(0.0, 0.0, 0.0);

        Ball = gluNewQuadric();

        glutSolidCube(0.20f);

    glPopMatrix();

    // (21) Criando apoio 2 do Sauron:
    glPushMatrix();
        
        glTranslatef(0.01f - 0.1f, h/2 + 0.05f + 0.8f, 0.0f);

        glScalef(0.25f, 1.0f, 0.3f);

        glColor3f(0.0, 0.0, 0.0);

        Ball = gluNewQuadric();

        glutSolidCube(0.20f);

    glPopMatrix();


    // (20) Criando Sauron na torre central:
    glPushMatrix();
        
        glTranslatef(0.01f, h/2 + 0.05f + 0.8f + 0.04f, 0.0f);

        glScalef(2.0f, 1.0f, 0.4f);

        glColor3f(0.92, 0.39, 0.04);

        Ball = gluNewQuadric();

        gluSphere(Ball, 0.05f, 26, 13);

    glPopMatrix();

    // (21) Criando cubo da torre central:
    glPushMatrix();
        
        glTranslatef(0.01f, h/2 + 0.2f*(0.8f/0.2f)/2, 0.0f);

        glScalef(1.0f, 0.8f/0.2f, 1.0f);

        glColor3f(0.01f, 0.01f, 0.01f);

        glutSolidCube(0.2f);

    glPopMatrix();

    // (22) Desenhado blocos de cima dos muros:
    glColor3f(0.62,0.63,0.62);

    GLfloat size = 0.1f;
    GLfloat height = 0.05f;
    GLfloat wallSize = 0.2f;
    GLfloat wallDepth = 0.1f*0.2f;
    GLfloat upOnWall = h/2 + height/2 +  wallSize;

    createLittleWall(0.0f, upOnWall, l/2 - 0.04f, 0.0f, size, height, wallDepth);
    createLittleWall(l/2 - 0.04f - r - size/2, upOnWall, l/2 - 0.04f, 0.0f, size, height, wallDepth);
    createLittleWall(-(l/2 - 0.04f - r - size/2), upOnWall, l/2 - 0.04f, 0.0f, size, height, wallDepth);

    createLittleWall(0.0f, upOnWall, -(l/2 - 0.04f), 0.0f, size, height, wallDepth);
    createLittleWall(l/2 - 0.04f - r - size/2, upOnWall, -(l/2 - 0.04f), 0.0f, size, height, wallDepth);
    createLittleWall(-(l/2 - 0.04f - r - size/2), upOnWall, -(l/2 - 0.04f), 0.0f, size, height, wallDepth);

    createLittleWall(l/2 - 0.04f, upOnWall, 0.0f, 90.0f, size, height, wallDepth);
    createLittleWall(l/2 - 0.04f, upOnWall, l/2 - 0.04f - r - size/2, 90.0f, size, height, wallDepth);
    createLittleWall(l/2 - 0.04f, upOnWall, -(l/2 - 0.04f - r - size/2), 90.0f, size, height, wallDepth);
    
    createLittleWall(-(l/2 - 0.04f), upOnWall, 0.0f, 90.0f, size, height, wallDepth);
    createLittleWall(-(l/2 - 0.04f), upOnWall, l/2 - 0.04f - r - size/2, 90.0f, size, height, wallDepth);
    createLittleWall(-(l/2 - 0.04f), upOnWall, -(l/2 - 0.04f - r - size/2), 90.0f, size, height, wallDepth);
    
    glPopMatrix();

    glutSwapBuffers();
}

void createLittleWall(GLfloat x, GLfloat y, GLfloat z, GLfloat theta, GLfloat l, GLfloat height, 
    GLfloat depth){
    
    glPushMatrix();

    glTranslatef(x, y, z);

    glRotatef(theta, 0.0f, 1.0f, 0.0f);

    glScalef(1.0f, height/l, depth/l);

    glutSolidCube(l);

    glPopMatrix();

    return;
}

int main(int argc, char *argv[])
{
    // (1) Essa função inicial serve para que o OpenGL exercute os argumentos passados (argv) na hora da...
    // ... execução:
    glutInit(&argc, argv);

    // (2) Essa função define qual o modelo de janela a ser criado pelo OpenGL (note que são os bits do...
    // resultado da expressão que irão dar todas as definições para a janela):
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);

    // (3) Essa função define as dimensões da janela a ser gerada pelo OpenGL:
    glutInitWindowSize(800, 600);

    // (4) Essa função cria a janela com o nome passado como argumento:
    glutCreateWindow("Castelo Elisandro");

    // (5) Essa função recebe como paramêtro o endereço de uma função ("ChangeSize" nesse caso) que lida...
    // ... com o reajuste do tamanho da janela, assim sempre que a janela for reajustada tal função passada...
    // ... como argumento irá ser executada:
    glutReshapeFunc(ChangeSize);

    // (6) Essa função recebe como paramêtro o endereço de uma função ("Spec ialKeys" nesse caso) que lida...
    // ... com certas teclas assim sempre que tais teclas forem pressionadas tal função passada como argumento...
    // ... irá ser executada:
    glutSpecialFunc(SpecialKeys);

    // (7) Essa função se encarrega de colocar os objetos no espaço (desenhá-los) e fazer as operações de...
    // ... de translação, rotação e etc (manipulando a matriz de modelo):
    glutDisplayFunc(RenderScene);

    // (8) Esta função define os parâmetros de iluminação e a cor do fundo do espaço:
    SetupRC();

    glutMainLoop();
    return 0;
}