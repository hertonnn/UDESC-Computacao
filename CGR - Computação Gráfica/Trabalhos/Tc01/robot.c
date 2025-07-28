// Comanda para executar: gcc robot.c -lglut -lGL -lGLU -lm -o robot && ./robot
#include "GL/glut.h"
#include <math.h>
#define _USE_MATH_DEFINES
# define M_PI 3.14159265358979323846

void createLittleWall(GLfloat x, GLfloat y, GLfloat z, GLfloat theta, GLfloat l, GLfloat height, 
    GLfloat depth);
double rad(GLfloat theta);

// Variáveis que iremos utilizar para rotação:
static GLfloat xRot = 0.0f;
static GLfloat yRot = 0.0f;
static GLfloat zRot = 0.0f;

// Altura até o topo tronco superior:
GLfloat h_troncoCompleto = 0.25 + 0.75*0.5 + 0.25;
// largura do topo tronco superior:
GLfloat l_troncoSuperior = 0.5;

// Tamanho dos antebraços:
GLfloat forearm_r = 0.3;
// Angulô do antebraço direito (o ombro é a origem):
GLfloat forearm_right_theta = 45;
// Angulô do antebraço esquerdo (o ombro é a origem):
GLfloat forearm_left_theta = 45;

// Tamanho dos braços:
GLfloat arm_r = 0.2;
// Angulô do braço direito (a ponta do antebraço é a origem):
GLfloat arm_right_theta = 30;
// Angulô do braço esquerdo (a ponta do antebraço é a origem):
GLfloat arm_left_theta = 30;

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

void keyboard(unsigned char key, int x, int y){
 switch (key) {
        case 'A':
        case 'a':
            // forearm_left_theta = forearm_left_theta + 5.0;
            forearm_left_theta = (GLfloat) (((int) forearm_left_theta + 5) % 360);
            glutPostRedisplay();
            break;
        case 's':
        case 'S':
            // arm_left_theta = arm_left_theta + 5.0;
            arm_left_theta = (GLfloat) (((int) arm_left_theta + 5) % 360);
            glutPostRedisplay();
            break;
        case 'd':
        case 'D':
            // forearm_right_theta = forearm_right_theta + 5.0;
            forearm_right_theta = (GLfloat) (((int) forearm_right_theta + 5) % 360);
            glutPostRedisplay();
            break;
        case 'f':
        case 'F':
            // arm_right_theta = arm_right_theta + 5.0;
            arm_right_theta = (GLfloat) (((int) arm_right_theta + 5) % 360);
            glutPostRedisplay();
            break;
        default:
            break;
    }
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

    glColor3f(0.5, 0.5, 0.5);

    glTranslatef(0.0f, 0.0f, -5.0f);

    glRotatef(yRot, 0.0f, 1.0f, 0.0f);
        
    glRotatef(xRot, 1.0f, 0.0f, 0.0f);

    // Tronco inferior:
    glPushMatrix();

        glScalef(0.75, 0.75, 0.25);

        glTranslatef(0, 0.25, 0);

        glutSolidCube(0.5);

    glPopMatrix();

    // Tronco superior:
    glPushMatrix();
        
        glScalef(1.0, 1.0, 0.5);

        glTranslatef(0, 0.25 + 0.75*0.5, 0);

        glutSolidCube(0.5);

    glPopMatrix();

    // Perna direita (na orientação do robô):
    glPushMatrix();
        
        glScalef(1.0, 5.0, 0.5*0.25/0.1);

        glTranslatef(0.5 * 0.75/2, -0.05, 0);

        glutSolidCube(0.1);

    glPopMatrix();

    // Perna esquerda (na orientação do robô):
    glPushMatrix();
        
        glScalef(1.0, 5.0, 0.5*0.25/0.1);

        glTranslatef(-(0.5 * 0.75/2), -0.05, 0);

        glutSolidCube(0.1);

    glPopMatrix();

    // Cabeça:
    glPushMatrix();
        glTranslatef(0, h_troncoCompleto + 0.2*1.25/2, 0);
        
        glScalef(0.5, 1.25, 0.5);
        
        GLfloat raioCabeça = 0.25f;  // Defina o raio da cabeça
        int divisões = 20;  // Número de divisões para a esfera (quanto maior, mais suave)

        glutSolidSphere(raioCabeça, divisões, divisões); // Criando a esfera com o raio e divisões definidas
    glPopMatrix();


    // Antebraço direito (na orientação do robô):
    glPushMatrix();
        
        glTranslatef(-(l_troncoSuperior/2 + 0.05), h_troncoCompleto - 0.05, 0);

        glRotatef(forearm_right_theta, 1, 0, 0);

        glScalef(1.0, 1.0, forearm_r/0.1);

        glTranslatef(0, 0, 0.05);

        glutSolidCube(0.1);

    glPopMatrix();

    // Braço direito (na orientação do robô):
    glPushMatrix();
        
        glTranslatef(-(l_troncoSuperior/2 + 0.05), 
                    h_troncoCompleto - 0.05 - forearm_r*(GLfloat)sin(rad(forearm_right_theta)), 
                    forearm_r*(GLfloat)cos(rad(forearm_right_theta)));

        glRotatef(forearm_right_theta-arm_right_theta, 1, 0, 0);

        glScalef(1.0, 1.0, 4.0);

        glTranslatef(0, 0, 0.05);

        glColor3f(2, 2, 1);

        glutSolidCube(0.1);

    glPopMatrix();

    glColor3f(0.5, 0.5, 0.5);

    // Antebraço esquerdo (na orientação do robô):
    glPushMatrix();
        
        glTranslatef(l_troncoSuperior/2 + 0.05, h_troncoCompleto - 0.05, 0);

        glRotatef(forearm_left_theta, 1, 0, 0);

        glScalef(1.0, 1.0, forearm_r/0.1);

        glTranslatef(0, 0, 0.05);

        glutSolidCube(0.1);

    glPopMatrix();

    // Braço esquerdo (na orientação do robô):
    glPushMatrix();
        
        glTranslatef(l_troncoSuperior/2 + 0.05, 
                    h_troncoCompleto - 0.05 - forearm_r*(GLfloat)sin(rad(forearm_left_theta)), 
                    forearm_r*(GLfloat)cos(rad(forearm_left_theta)));
                    
        glRotatef(forearm_left_theta-arm_left_theta, 1, 0, 0);

        glScalef(1.0, 1.0, 4.0);

        glTranslatef(0, 0, 0.05);

        glColor3f(2, 2, 1);

        glutSolidCube(0.1);

    glPopMatrix();
    
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

double rad(GLfloat theta){
    return ((double) theta)*M_PI/180;
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
    glutCreateWindow("Robo Elisandro");

    // (5) Essa função recebe como paramêtro o endereço de uma função ("ChangeSize" nesse caso) que lida...
    // ... com o reajuste do tamanho da janela, assim sempre que a janela for reajustada tal função passada...
    // ... como argumento irá ser executada:
    glutReshapeFunc(ChangeSize);

    // (6) Essa função recebe como parâmetro um função que recebe cada entrada do teclado com um char e lida...
    // ... com esta entrada:
    glutKeyboardFunc(keyboard);

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