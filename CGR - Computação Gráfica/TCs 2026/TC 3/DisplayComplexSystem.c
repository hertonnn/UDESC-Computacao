#include <GL/glut.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Incluímos diretamente o código da classe Vehicle em 2D
#include "VehicleClass.c"

#define NUM_AGENTS 100 // Definido em 30 agentes para um bom efeito visual de multidão

int windowWidth = 800;
int windowHeight = 600;

Vehicle* flock[NUM_AGENTS];
Vector2D mouseTarget;

void init() {
    glClearColor(0.9f, 0.9f, 0.9f, 1.0f);
    
    // Inicializa a "multidão" de agentes (flock)
    for(int i = 0; i < NUM_AGENTS; i++) {
        // Posição inicial aleatória espalhada pela tela
        float rx = (float)(rand() % windowWidth);
        float ry = (float)(rand() % windowHeight);
        flock[i] = createVehicle(rx, ry);
        
        // Dica do Shiffman: Pequena variação na velocidade e força para que o grupo pareça orgânico (não robótico)
        flock[i]->maxspeed = 4.0f + (rand() % 30) / 10.0f; // Varia de 4.0 a 7.0
        flock[i]->maxforce = 0.2f + (rand() % 20) / 100.0f; // Varia de 0.2 a 0.4
        flock[i]->r = 4.0f; // Um pouco menor para caberem vários na tela
    }
    
    mouseTarget = createVector(windowWidth / 2.0f, windowHeight / 2.0f);
}

void drawVehicleGL(Vehicle* v) {
    float angle = vecHeading(v->velocity);
    
    glPushMatrix(); 
    glTranslatef(v->position.x, v->position.y, 0.0f);
    glRotatef(angle * (180.0f / M_PI), 0.0f, 0.0f, 1.0f);
    
    glColor3f(0.6f, 0.6f, 0.6f);
    glBegin(GL_TRIANGLES);
    glVertex2f(v->r * 2, 0);
    glVertex2f(-v->r * 2, -v->r);
    glVertex2f(-v->r * 2, v->r);
    glEnd();

    glColor3f(0.0f, 0.0f, 0.0f);
    glLineWidth(1.5f);
    glBegin(GL_LINE_LOOP);
    glVertex2f(v->r * 2, 0);
    glVertex2f(-v->r * 2, -v->r);
    glVertex2f(-v->r * 2, v->r);
    glEnd();
    
    glPopMatrix();
}

void display() {
    glClear(GL_COLOR_BUFFER_BIT);
    
    // Alvo (mouse)
    glColor3f(1.0f, 0.0f, 0.0f);
    glPointSize(8.0f);
    glBegin(GL_POINTS);
    glVertex2f(mouseTarget.x, mouseTarget.y);
    glEnd();
    
    // Desenha todos os agentes
    for(int i = 0; i < NUM_AGENTS; i++) {
        drawVehicleGL(flock[i]);
    }
    
    glutSwapBuffers();
}

void update(int value) {
    for(int i = 0; i < NUM_AGENTS; i++) {
        // A Mágica de Sistemas Complexos: 
        // Aplicamos múltiplos comportamentos combinados em vez de um só!
        // O veículo tenta ir até o mouse (Seek/Arrive) mas ao mesmo tempo desvia dos outros (Separate)
        vehicleApplyBehaviors(flock[i], flock, NUM_AGENTS, mouseTarget);
        
        vehicleUpdate(flock[i]);
    }
    
    glutPostRedisplay();
    glutTimerFunc(16, update, 0);
}

void reshape(int w, int h) {
    windowWidth = w;
    windowHeight = h;
    glViewport(0, 0, w, h);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluOrtho2D(0.0, (GLdouble)w, (GLdouble)h, 0.0);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

void passiveMouseMotion(int x, int y) {
    mouseTarget.x = (float)x;
    mouseTarget.y = (float)y;
}

void activeMouseMotion(int x, int y) {
    mouseTarget.x = (float)x;
    mouseTarget.y = (float)y;
}

int main(int argc, char** argv) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
    glutInitWindowSize(windowWidth, windowHeight);
    glutInitWindowPosition(100, 100);
    glutCreateWindow("Sistemas Complexos Buscar e Separar");
    
    init();
    
    glutDisplayFunc(display);
    glutReshapeFunc(reshape);
    glutPassiveMotionFunc(passiveMouseMotion);
    glutMotionFunc(activeMouseMotion);
    glutTimerFunc(16, update, 0);
    
    glutMainLoop();
    return 0;
}
