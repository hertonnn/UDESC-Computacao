#include <GL/glut.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Inclui a biblioteca 3D do veículo
#include "VehicleClass3D.c"

int windowWidth = 800;
int windowHeight = 600;

Vehicle* myVehicle;
Vector3D mouseTarget;

void init() {
    glClearColor(0.1f, 0.15f, 0.2f, 1.0f); // Fundo azul escuro espacial
    
    // Configurações críticas para 3D (Profundidade e Iluminação)
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
    glEnable(GL_COLOR_MATERIAL); 
    
    // Luz posicional
    GLfloat lightPos[] = { 100.0f, 300.0f, 200.0f, 1.0f };
    glLightfv(GL_LIGHT0, GL_POSITION, lightPos);

    myVehicle = createVehicle(0.0f, 0.0f, 0.0f);
    mouseTarget = createVector3D(0.0f, 0.0f, 0.0f);
}

// Função de desenho tridimensional calculando Pitch e Yaw usando matrizes
void drawVehicleGL3D(Vehicle* v) {
    glPushMatrix();
    
    // 1. Move para a posição 3D
    glTranslatef(v->position.x, v->position.y, v->position.z);
    
    // 2. Calcula a rotação para alinhar o objeto com o vetor de velocidade
    Vector3D vel = v->velocity;
    float speed = vecMag(vel);
    
    if (speed > 0.001f) {
        vecNormalize(&vel);
        
        // O glutSolidCone por padrão aponta no eixo Z (0, 0, 1)
        Vector3D defaultDirection = {0.0f, 0.0f, 1.0f}; 
        
        // Produto escalar (dot product) acha o cosseno do ângulo entre Z e a Velocidade
        float dot = defaultDirection.x * vel.x + defaultDirection.y * vel.y + defaultDirection.z * vel.z;
        
        // Produto vetorial (cross product) acha o eixo ortogonal para rotacionar
        Vector3D axis = vecCross(defaultDirection, vel);
        
        // Calcula o ângulo em graus
        float angle = acosf(dot) * (180.0f / M_PI);
        
        // Caso especial: se a velocidade for exatamente -Z
        if (dot < -0.999f) {
            glRotatef(180.0f, 1.0f, 0.0f, 0.0f);
        } else {
            glRotatef(angle, axis.x, axis.y, axis.z);
        }
    }
    
    // 3. Centraliza a malha do cone
    glTranslatef(0.0f, 0.0f, -v->r);
    
    // 4. Desenha o Cone 3D
    glColor3f(0.2f, 0.8f, 0.4f); // Verde neon
    glutSolidCone(v->r, v->r * 4.0f, 16, 16);
    
    glPopMatrix();
}

void display() {
    // IMPORTANTE: Limpar buffer de Cor e Profundidade
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glLoadIdentity();
    
    // Posiciona a câmera de forma frontal normal (na origem).
    // A distorção visual da Perspectiva Cavaleira é feita pela matriz de projeção!
    gluLookAt(0.0, 0.0, 600.0,
              0.0, 0.0, 0.0,
              0.0, 1.0, 0.0);
              
    // Desenha um "chão" quadriculado em Y = -150
    // Na perspectiva Cavaleira, um plano XZ será distorcido na diagonal, criando o efeito 3D clássico!
    glDisable(GL_LIGHTING);
    glColor3f(0.3f, 0.3f, 0.3f);
    glBegin(GL_LINES);
    for (int i = -600; i <= 600; i += 40) {
        glVertex3f(i, -150, -600); glVertex3f(i, -150, 600);
        glVertex3f(-600, -150, i); glVertex3f(600, -150, i);
    }
    glEnd();
    glEnable(GL_LIGHTING);

    // Desenha o alvo (esfera vermelha)
    glPushMatrix();
    glTranslatef(mouseTarget.x, mouseTarget.y, mouseTarget.z);
    glColor3f(1.0f, 0.2f, 0.2f); // Vermelho
    glutSolidSphere(6.0, 16, 16);
    glPopMatrix();
    
    // Desenha o veículo 3D
    drawVehicleGL3D(myVehicle);
    
    glutSwapBuffers();
}

void update(int value) {
    // Na perspectiva Cavaleira (frontal com profundidade em diagonal), a tela volta a representar X e Y.
    // Então o mouse controla X e Y, e a profundidade (Z) oscila no tempo.
    float time = glutGet(GLUT_ELAPSED_TIME);
    mouseTarget.z = sin(time * 0.003f) * 150.0f; // Oscila de -150 a 150 em Z

    vehicleArrive(myVehicle, mouseTarget);
    vehicleUpdate(myVehicle);
    
    glutPostRedisplay();
    glutTimerFunc(16, update, 0);
}

void reshape(int w, int h) {
    windowWidth = w;
    windowHeight = h;
    glViewport(0, 0, w, h);
    
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    
    // ==========================================
    // PERSPECTIVA CAVALEIRA
    // ==========================================
    float aspect = (float)w / (float)h;
    float viewSize = 400.0f; 
    
    // 1. Projeção Ortográfica base
    glOrtho(-viewSize * aspect, viewSize * aspect, -viewSize, viewSize, -2000.0, 2000.0);
    
    // 2. Matriz de Cisalhamento (Shear) no eixo Z
    // A Cavaleira mantém o eixo Z com tamanho 1.0 (L=1) em um ângulo de 45º (PI/4)
    float L = 1.0f;
    float angle = M_PI / 4.0f; 
    float c = L * cosf(angle);
    float s = L * sinf(angle);
    
    GLfloat shear[16] = {
        1.0f, 0.0f, 0.0f, 0.0f,
        0.0f, 1.0f, 0.0f, 0.0f,
        -c,   -s,   1.0f, 0.0f, // Valores negativos invertem a fuga (para a direita e cima)
        0.0f, 0.0f, 0.0f, 1.0f
    };
    glMultMatrixf(shear);
    
    glMatrixMode(GL_MODELVIEW);
}

// Mapeia o mouse da tela para o plano (X,Y) do mundo 3D no plano Z=0
void mapMouseTo3D(int x, int y) {
    float aspect = (float)windowWidth / (float)windowHeight;
    float viewSize = 400.0f; 
    
    // Na projeção Ortográfica + Cisalhamento, o plano Z=0 NÃO sofre distorção.
    // O mapeamento da tela é linear e direto!
    mouseTarget.x = ((float)x / windowWidth - 0.5f) * 2.0f * (viewSize * aspect);
    mouseTarget.y = -((float)y / windowHeight - 0.5f) * 2.0f * viewSize;
}

void passiveMouseMotion(int x, int y) {
    mapMouseTo3D(x, y);
}

void activeMouseMotion(int x, int y) {
    mapMouseTo3D(x, y);
}

int main(int argc, char** argv) {
    glutInit(&argc, argv);
    
    // ATENÇÃO: Adicionado GLUT_DEPTH para o Depth Buffer
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    
    glutInitWindowSize(windowWidth, windowHeight);
    glutInitWindowPosition(100, 100);
    glutCreateWindow("Steering Behaviors: 3D Arrive");
    
    init();
    
    glutDisplayFunc(display);
    glutReshapeFunc(reshape);
    glutPassiveMotionFunc(passiveMouseMotion);
    glutMotionFunc(activeMouseMotion);
    glutTimerFunc(16, update, 0);
    
    glutMainLoop();
    return 0;
}
