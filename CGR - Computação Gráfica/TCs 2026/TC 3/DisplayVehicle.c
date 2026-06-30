#include <GL/glut.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Incluímos diretamente o código do veículo que criamos anteriormente.
// NOTA: Para compilar este exemplo, compile apenas este arquivo "DisplayVehicle.c".
// Exemplo de compilação no Windows: gcc DisplayVehicle.c -o DisplayVehicle.exe -lfreeglut -lglu32 -lopengl32
#include "VehicleClass.c"

// Tamanho da janela
int windowWidth = 800;
int windowHeight = 600;

// Variáveis Globais
Vehicle* myVehicle;
Vector2D mouseTarget;

// Inicialização
void init() {
    glClearColor(0.9f, 0.9f, 0.9f, 1.0f); // Define a cor de fundo (cinza claro)
    
    // Inicializa o veículo no centro da tela
    myVehicle = createVehicle(windowWidth / 2.0f, windowHeight / 2.0f);
    
    // Inicializa o alvo do mouse no centro
    mouseTarget = createVector(windowWidth / 2.0f, windowHeight / 2.0f);
}

// Função para desenhar o veículo usando chamadas reais do OpenGL
void drawVehicleGL(Vehicle* v) {
    float angle = vecHeading(v->velocity);
    
    glPushMatrix(); 
    
    // 1. Translada (move) para a posição atual do veículo
    glTranslatef(v->position.x, v->position.y, 0.0f);
    
    // 2. Rotaciona para a direção da velocidade 
    // (o OpenGL usa graus, então multiplicamos radianos por 180/PI)
    glRotatef(angle * (180.0f / M_PI), 0.0f, 0.0f, 1.0f);
    
    // Equivalente ao p5.js: fill(127);
    glColor3f(0.5f, 0.5f, 0.5f); // Cinza (RGB: 127/255 ~ 0.5)
    
    // Desenha o preenchimento do triângulo
    glBegin(GL_TRIANGLES);
    glVertex2f(v->r * 2, 0);
    glVertex2f(-v->r * 2, -v->r);
    glVertex2f(-v->r * 2, v->r);
    glEnd();

    // Equivalente ao p5.js: stroke(0);
    glColor3f(0.0f, 0.0f, 0.0f); // Preto
    glLineWidth(2.0f);
    
    // Desenha o contorno do triângulo
    glBegin(GL_LINE_LOOP);
    glVertex2f(v->r * 2, 0);
    glVertex2f(-v->r * 2, -v->r);
    glVertex2f(-v->r * 2, v->r);
    glEnd();
    
    glPopMatrix();
}

// Função Callback de Renderização (Display)
void display() {
    // Limpa o buffer de cor
    glClear(GL_COLOR_BUFFER_BIT);
    
    // Desenha o alvo (posição do mouse) como um pequeno ponto vermelho
    glColor3f(1.0f, 0.0f, 0.0f);
    glPointSize(8.0f);
    glBegin(GL_POINTS);
    glVertex2f(mouseTarget.x, mouseTarget.y);
    glEnd();
    
    // Desenha o veículo
    drawVehicleGL(myVehicle);
    
    // Troca os buffers para exibir na tela (Double Buffering)
    glutSwapBuffers();
}

// Função Callback de Atualização da Física (~60 FPS)
void update(int value) {
    // Comportamento de Arrive (substitui o Seek completamente)
    vehicleArrive(myVehicle, mouseTarget);
    
    // Atualiza a posição baseada na velocidade e aceleração
    vehicleUpdate(myVehicle);
    
    // Solicita que a tela seja redesenhada
    glutPostRedisplay();
    
    // Agenda a próxima execução desta mesma função (1000ms / 60 = ~16ms)
    glutTimerFunc(16, update, 0);
}

// Configura a projeção 2D da câmera quando a janela muda de tamanho
void reshape(int w, int h) {
    windowWidth = w;
    windowHeight = h;
    glViewport(0, 0, w, h);
    
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    
    // Projeção Ortográfica 2D. 
    // Para imitar o p5.js, colocamos a origem (0,0) no canto superior esquerdo:
    // left: 0, right: w, bottom: h, top: 0
    gluOrtho2D(0.0, (GLdouble)w, (GLdouble)h, 0.0);
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

// Função chamada quando o mouse se move (sem nenhum botão clicado)
void passiveMouseMotion(int x, int y) {
    mouseTarget.x = (float)x;
    mouseTarget.y = (float)y;
}

// Função chamada quando o mouse se move (sendo arrastado com o botão clicado)
void activeMouseMotion(int x, int y) {
    mouseTarget.x = (float)x;
    mouseTarget.y = (float)y;
}

int main(int argc, char** argv) {
    glutInit(&argc, argv);
    
    // Modo Double Buffer e Cores RGB
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
    
    glutInitWindowSize(windowWidth, windowHeight);
    glutInitWindowPosition(100, 100);
    glutCreateWindow("Steering Behaviors: Seek (OpenGL/GLUT)");
    
    init();
    
    // Registra as funções Callbacks
    glutDisplayFunc(display);
    glutReshapeFunc(reshape);
    glutPassiveMotionFunc(passiveMouseMotion);
    glutMotionFunc(activeMouseMotion);
    
    // Inicia o loop de física de forma contínua
    glutTimerFunc(16, update, 0);
    
    // Inicia o loop principal do GLUT
    glutMainLoop();
    
    return 0;
}
