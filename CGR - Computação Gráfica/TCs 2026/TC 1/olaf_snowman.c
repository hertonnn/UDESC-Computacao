// Comando para compllar e executar: 
// gcc olaf_snowman.c src/glad.c -Iinclude -Llib -lfreeglut -lopengl32 -lglu32 -lwinmm -lgdi32 -o olaf.exe && ./olaf
#include "GL/glut.h"

// Variáveis para rotação:
static GLfloat xRot = 0.0f;
static GLfloat yRot = 0.0f;
static GLfloat zRot = 0.0f;

// desenhar dentes
void drawTooth(float width, float height) {
    glColor3f(1.0f, 1.0f, 1.0f);
    glPushMatrix();
    glScalef(width, height, 0.02f);
    glutSolidCube(1.0f);
    glPopMatrix();
}

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

    // (1) Este vetor define a intensidade RGBA da luz do ambiente (uma luz mais fria/ártica):
    GLfloat whiteLight[] = {0.15f, 0.15f, 0.20f, 1.0f};
    // (2) Este vetor define a intensidade RGBA da luz de difusão:
    GLfloat sourceLight[] = {0.70f, 0.70f, 0.70f, 1.0f};
    // (3) Este vetor define as coordenadas na fonte de luz em coordenadas homogêneas (por isto com 4 coordenadas):
    GLfloat lightPos[] = {-10.f, 10.0f, 10.0f, 1.0f};

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
    // Nesse caso o 1º parâmetro indica que o 2º contém quatro valores de ponto flutuante que especificam a...
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

    // (15) Define a cor do fundo do espaço (um céu azul ártico):
    glClearColor(0.50f, 0.70f, 0.90f, 1.0f);
  
}

void RenderScene(void)
{
    GLUquadricObj *Ball;
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);


    glPushMatrix();

        // (?) Esta função carrega uma matriz de translação na pilha:
        glTranslatef(0.0f, -0.2f, -5.0f);
        // Obs.: a coordenada da câmera inicia no ponto (0,0,0) virada para o eixo z.
        glRotatef(yRot, 0.0f, 1.0f, 0.0f);
        glRotatef(xRot, 1.0f, 0.0f, 0.0f);
    
        // (?) Esta função retorna um objeto quádrico:
        Ball = gluNewQuadric();
        // Obs.: note que não precisamos dar as coordenadas do objeto pois ele será criado a partir...
        // ... do ponto (0,0,0).

    glPushMatrix();
        // Escala global ligeiramente para baixo para caber melhor na tela
        glScalef(0.9f, 0.9f, 0.9f);

    // glPushMatrix();
    //     // Chão de neve simples
    //     glColor3f(1.0f, 1.0f, s1.0f);
    //     glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);
    //     glTranslatef(0.0f, 0.0f, -0.3f);
    //     Ball = gluNewQuadric();
    //     gluDisk(Ball, 0.0f, 2.5f, 50, 20);
    // glPopMatrix();

    glPushMatrix();
        // Bola de baixo (base):
        glColor3f(1.0f, 1.0f, 1.0f);
        glTranslatef(0.0f, 0.10f, 0.0f);
        // Levemente achatada
        glScalef(1.0f, 0.85f, 1.0f); 
        gluSphere(Ball, 0.35f, 30, 15);
    glPopMatrix();

    glPushMatrix();
        // Pés de neve:
        glColor3f(1.0f, 1.0f, 1.0f);
        glTranslatef(-0.15f, 0.05f, 0.15f);
        glScalef(1.0f, 0.6f, 1.0f);
        gluSphere(Ball, 0.10f, 20, 10);
        
        glLoadIdentity(); // Reset para o pé direito
        glTranslatef(0.0f, -0.2f, -5.0f);
        glRotatef(yRot, 0.0f, 1.0f, 0.0f);
        glRotatef(xRot, 1.0f, 0.0f, 0.0f);
        glScalef(0.9f, 0.9f, 0.9f); // Escala global
        glTranslatef(0.15f, 0.05f, 0.15f);
        glScalef(1.0f, 0.6f, 1.0f);
        gluSphere(Ball, 0.10f, 20, 10);
    glPopMatrix();

    glPushMatrix();
        // Bola do meio (corpo superior):
        glColor3f(1.0f, 1.0f, 1.0f);
        glTranslatef(0.0f, 0.45f, 0.0f);
        // Obrigon (mais alta que larga, levemente plana na frente)
        glScalef(0.85f, 1.2f, 0.75f);
        gluSphere(Ball, 0.25f, 30, 15);
    glPopMatrix();

    glPushMatrix();
        // Botões pretos (como esferas):
        glColor3f(0.0f, 0.0f, 0.0f);
        // Primeiro botão
        glTranslatef(0.0f, 0.55f, 0.16f);
        gluSphere(Ball, 0.025f, 20, 10);
        // Segundo botão
        glTranslatef(0.0f, -0.07f, -0.005f);
        gluSphere(Ball, 0.025f, 20, 10);
        // Terceiro botão
        glTranslatef(0.0f, -0.07f, -0.005f);
        gluSphere(Ball, 0.025f, 20, 10);
    glPopMatrix();

    glPushMatrix();
        // Braço (Esquerdo - galho):
        glColor3f(0.5f, 0.3f, 0.1f);
        glTranslatef(-0.25f, 0.5f, 0.0f);
        glRotatef(-50.0f, 0.0f, 0.0f, 1.0f);
        glRotatef(-90.0f, 0.0f, 1.0f, 0.0f);
        gluCylinder(Ball, 0.015f, 0.015f, 0.35f, 20, 10);
        // Dedos (galhos menores)
        glPushMatrix();
            glTranslatef(0.0f, 0.0f, 0.35f);
            glRotatef(40.0f, 1.0f, 0.0f, 0.0f);
            gluCylinder(Ball, 0.008f, 0.008f, 0.08f, 10, 5);
        glPopMatrix();
        glPushMatrix();
            glTranslatef(0.0f, 0.0f, 0.35f);
            glRotatef(-40.0f, 1.0f, 0.0f, 0.0f);
            gluCylinder(Ball, 0.008f, 0.008f, 0.08f, 10, 5);
        glPopMatrix();
        glPushMatrix();
            glTranslatef(0.0f, 0.0f, 0.35f);
            glRotatef(0.0f, 1.0f, 0.0f, 0.0f);
            gluCylinder(Ball, 0.008f, 0.008f, 0.08f, 10, 5);
        glPopMatrix();
    glPopMatrix();

    glPushMatrix();
        // Braço (Direito - galho):
        glColor3f(0.5f, 0.3f, 0.1f);
        glTranslatef(0.25f, 0.5f, 0.0f);
        glRotatef(50.0f, 0.0f, 0.0f, 1.0f);
        glRotatef(90.0f, 0.0f, 1.0f, 0.0f);
        gluCylinder(Ball, 0.015f, 0.015f, 0.35f, 20, 10);
        // Dedos (galhos menores)
        glPushMatrix();
            glTranslatef(0.0f, 0.0f, 0.35f);
            glRotatef(40.0f, 1.0f, 0.0f, 0.0f);
            gluCylinder(Ball, 0.008f, 0.008f, 0.08f, 10, 5);
        glPopMatrix();
        glPushMatrix();
            glTranslatef(0.0f, 0.0f, 0.35f);
            glRotatef(-40.0f, 1.0f, 0.0f, 0.0f);
            gluCylinder(Ball, 0.008f, 0.008f, 0.08f, 10, 5);
        glPopMatrix();
        glPushMatrix();
            glTranslatef(0.0f, 0.0f, 0.35f);
            glRotatef(0.0f, 1.0f, 0.0f, 0.0f);
            gluCylinder(Ball, 0.008f, 0.008f, 0.08f, 10, 5);
        glPopMatrix();
    glPopMatrix();

    glPushMatrix();
        // Cabeça (oblonga):
        glColor3f(1.0f, 1.0f, 1.0f);
        glTranslatef(0.0f, 0.90f, 0.0f);
        // Oblonga (mais alta que larga, levemente plana na frente)
        glScalef(0.85f, 1.3f, 0.85f);
        gluSphere(Ball, 0.22f, 30, 15);
    glPopMatrix();

    glPushMatrix();
        // Nariz de cenoura (cilindro cônico):
        glColor3f(1.0f, 0.5f, 0.0f);
        glTranslatef(0.0f, 0.90f, 0.12f);
        gluCylinder(Ball, 0.05f, 0.0f, 0.25f, 20, 10);
    glPopMatrix();

    glPushMatrix();
        // Olhos expressivos:
        // Olho esquerdo
        glColor3f(0.0f, 0.0f, 0.0f);
        glTranslatef(-0.07f, 1.02f, 0.15f);
        gluSphere(Ball, 0.035f, 20, 10);
        glColor3f(1.0f, 1.0f, 1.0f);
        glTranslatef(0.01f, 0.015f, 0.025f);
        gluSphere(Ball, 0.01f, 10, 5); // Brilho
        
        // Olho direito
        glColor3f(0.0f, 0.0f, 0.0f);
        glLoadIdentity(); // Reset para o olho direito
        glTranslatef(0.0f, -0.2f, -5.0f);
        glRotatef(yRot, 0.0f, 1.0f, 0.0f);
        glRotatef(xRot, 1.0f, 0.0f, 0.0f);
        glScalef(0.9f, 0.9f, 0.9f); // Escala global
        glTranslatef(0.07f, 1.02f, 0.15f);
        gluSphere(Ball, 0.035f, 20, 10);
        glColor3f(1.0f, 1.0f, 1.0f);
        glTranslatef(-0.01f, 0.015f, 0.025f);
        gluSphere(Ball, 0.01f, 10, 5); // Brilho
    glPopMatrix();

    glPushMatrix();
        // Boca sorridente com dentes:
        // Fenda sorridente preta
        glColor3f(0.0f, 0.0f, 0.0f);
        glTranslatef(0.0f, 0.78f, 0.13f);
        glScalef(1.2f, 0.3f, 0.1f);
        gluSphere(Ball, 0.1f, 20, 10);
        
        // Dentes visíveis
        glLoadIdentity();
        glTranslatef(0.0f, -0.2f, -5.0f);
        glRotatef(yRot, 0.0f, 1.0f, 0.0f);
        glRotatef(xRot, 1.0f, 0.0f, 0.0f);
        glScalef(0.9f, 0.9f, 0.9f); // Escala global
        glTranslatef(0.0f, 0.81f, 0.165f);
        glScalef(1.2f, 0.3f, 0.1f);
        // Desenhar dois dentes brancos
        drawTooth(0.04f, 0.07f);
        glTranslatef(0.0f, -0.02f, 0.0f); // Posição do segundo dente
        drawTooth(0.04f, 0.07f);
    glPopMatrix();

    glPushMatrix();
        // Cabelo de galho (três finos):
        glColor3f(0.5f, 0.3f, 0.1f);
        glTranslatef(0.0f, 1.15f, 0.0f);
        // Primeiro galho
        glPushMatrix();
            glRotatef(10.0f, 0.0f, 0.0f, 1.0f);
            gluCylinder(Ball, 0.005f, 0.005f, 0.15f, 10, 5);
        glPopMatrix();
        // Segundo galho
        glPushMatrix();
            glRotatef(-10.0f, 1.0f, 0.0f, 0.0f);
            gluCylinder(Ball, 0.005f, 0.005f, 0.15f, 10, 5);
        glPopMatrix();
        // Terceiro galho
        glPushMatrix();
            glRotatef(-20.0f, 0.0f, 0.0f, 1.0f);
            glRotatef(20.0f, 1.0f, 0.0f, 0.0f);
            gluCylinder(Ball, 0.005f, 0.005f, 0.15f, 10, 5);
        glPopMatrix();
    glPopMatrix();

    glPopMatrix(); // Escala global

    glPopMatrix(); // Rotação global

    glutSwapBuffers();
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
    glutCreateWindow("Olaf - CGR 2026");

    // (5) Essa função recebe como paramêtro o endereço de uma função ("ChangeSize" nesse caso) que lida...
    // ... com o reajuste do tamanho da janela, assim sempre que a janela for reajustada tal função passada...
    // ... como argumento irá ser executada:
    glutReshapeFunc(ChangeSize);

    // (6) Essa função recebe como paramêtro o endereço de uma função ("SpecialKeys" nesse caso) que lida...
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