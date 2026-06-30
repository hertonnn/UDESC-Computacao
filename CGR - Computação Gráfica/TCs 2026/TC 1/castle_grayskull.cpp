// Comando para compilar e executar (ajuste os caminhos conforme seu ambiente):
// g++ castle_grayskull.cpp src/glad.c -Iinclude -Llib -lfreeglut -lopengl32 -lglu32 -lwinmm -lgdi32 -o grayskull.exe && ./grayskull

#include <GL/glut.h>

// Variáveis de rotação global - Iniciando em 3/4 para ver as novas torres
static GLfloat xRot = 15.0f;
static GLfloat yRot = -35.0f;

void ChangeSize(int w, int h) {
    GLfloat fAspect;
    if (h == 0) h = 1;

    glViewport(0, 0, w, h);
    fAspect = (GLfloat)w / (GLfloat)h;

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    // Aumentei um pouco a distância de corte distante (zFar) para 50.0
    gluPerspective(45.0f, fAspect, 1.0, 50.0);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

void SpecialKeys(int key, int x, int y) {
    if (key == GLUT_KEY_LEFT) yRot -= 5.0f;
    if (key == GLUT_KEY_RIGHT) yRot += 5.0f;
    if (key == GLUT_KEY_UP) xRot += 5.0f;
    if (key == GLUT_KEY_DOWN) xRot -= 5.0f;
    
    yRot = (GLfloat)((const int)yRot % 360);
    xRot = (GLfloat)((const int)xRot % 360);

    glutPostRedisplay();
}

void SetupRC() {
    // Iluminação ligeiramente mais escura/esverdeada
    GLfloat ambientLight[] = {0.1f, 0.15f, 0.1f, 1.0f};
    GLfloat diffuseLight[] = {0.5f, 0.6f, 0.5f, 1.0f};
    // Posição da luz vindo da frente/cima/esquerda
    GLfloat lightPos[] = {-10.0f, 20.0f, 15.0f, 1.0f};

    glEnable(GL_DEPTH_TEST);
    glFrontFace(GL_CCW);
    glEnable(GL_CULL_FACE);
    glEnable(GL_LIGHTING);

    glLightModelfv(GL_LIGHT_MODEL_AMBIENT, ambientLight);
    glLightfv(GL_LIGHT0, GL_AMBIENT, ambientLight);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, diffuseLight);
    glLightfv(GL_LIGHT0, GL_POSITION, lightPos);
    glEnable(GL_LIGHT0);

    glEnable(GL_COLOR_MATERIAL);
    glColorMaterial(GL_FRONT, GL_AMBIENT_AND_DIFFUSE);

    // Fundo noturno sombrio
    glClearColor(0.02f, 0.02f, 0.05f, 1.0f);
}

void RenderScene(void) {
    GLUquadricObj *quadric = gluNewQuadric();
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glPushMatrix();

        glTranslatef(0.0f, -1.5f, -10.0f); 
        glRotatef(yRot, 0.0f, 1.0f, 0.0f);
        glRotatef(xRot, 1.0f, 0.0f, 0.0f);

        // Definição de cores
        GLfloat stoneColor[] = {0.3f, 0.42f, 0.3f};
        GLfloat darkStoneColor[] = {0.15f, 0.2f, 0.15f}; // Para a base rochosa
        GLfloat roofColor[] = {0.15f, 0.15f, 0.15f};

        // BASE ROCHOSA 
        glPushMatrix();
            glColor3fv(darkStoneColor);
            // Posicionada no "chão" da cena
            glTranslatef(0.0f, -0.1f, 0.0f); 
            glScalef(6.0f, 0.3f, 5.0f); // Muito larga e profunda, mas achatada
            glutSolidCube(1.0f);
        glPopMatrix();

        //CORPO CENTRAL DO CASTELO
        glPushMatrix();
            glColor3fv(stoneColor);
            glTranslatef(0.0f, 0.6f, 0.0f); // Elevado para ficar sobre a base
            glScalef(2.5f, 2.2f, 1.8f); // Ligeiramente mais profundo
            glutSolidCube(1.0f);
        glPopMatrix();

        // TORRE FRONTAL ESQUERDA
        glPushMatrix();
            glColor3fv(stoneColor);
            glTranslatef(-1.5f, 0.0f, 0.6f);
            glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);
            gluCylinder(quadric, 0.5f, 0.5f, 2.2f, 20, 10);
            // Telhado
            glTranslatef(0.0f, 0.0f, 2.2f);
            glColor3fv(roofColor);
            glutSolidCone(0.6f, 1.0f, 20, 10);
        glPopMatrix();

        //  TORRE FRONTAL DIREITA 
        glPushMatrix();
            glColor3fv(stoneColor);
            glTranslatef(1.5f, 0.0f, 0.6f);
            glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);
            gluCylinder(quadric, 0.5f, 0.5f, 2.0f, 20, 10);
            // Telhado
            glTranslatef(0.0f, 0.0f, 2.0f);
            glColor3fv(roofColor);
            glutSolidCone(0.6f, 0.9f, 20, 10);
        glPopMatrix();

        //
        glPushMatrix();
            glColor3fv(stoneColor);
            // Posicionada atrás da estrutura central (Z negativo)
            glTranslatef(-1.0f, 0.0f, -0.7f); 
            glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);
            // Mais alta que as frontais para ser visível
            gluCylinder(quadric, 0.45f, 0.45f, 2.8f, 20, 10); 
            // Telhado
            glTranslatef(0.0f, 0.0f, 2.8f);
            glColor3fv(roofColor);
            glutSolidCone(0.55f, 0.8f, 20, 10);
        glPopMatrix();

        // --- NOVO: TORRE TRASEIRA DIREITA ---
        glPushMatrix();
            glColor3fv(stoneColor);
            glTranslatef(1.0f, 0.0f, -0.7f);
            glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);
            gluCylinder(quadric, 0.45f, 0.45f, 2.8f, 20, 10);
            // Telhado
            glTranslatef(0.0f, 0.0f, 2.8f);
            glColor3fv(roofColor);
            glutSolidCone(0.55f, 0.8f, 20, 10);
        glPopMatrix();

        // --- FACE DA CAVEIRA (SKULL) ---
        glPushMatrix();
            glColor3fv(stoneColor);
            // Ajustado Z para 1.0f para projetar à frente do corpo central profundo
            glTranslatef(0.0f, 1.0f, 1.0f); 
            glScalef(1.2f, 1.5f, 0.6f);
            gluSphere(quadric, 0.8f, 30, 15);
        glPopMatrix();

        // --- OLHOS DA CAVEIRA (ÓRBITAS VAZIAS) ---
        glPushMatrix();
            glColor3f(0.0f, 0.0f, 0.0f);
            // Olho Esquerdo
            glPushMatrix();
                glTranslatef(-0.4f, 1.4f, 1.35f);
                glScalef(1.0f, 0.8f, 0.5f);
                gluSphere(quadric, 0.25f, 20, 10);
            glPopMatrix();
            // Olho Direito
            glPushMatrix();
                glTranslatef(0.4f, 1.4f, 1.35f);
                glScalef(1.0f, 0.8f, 0.5f);
                gluSphere(quadric, 0.25f, 20, 10);
            glPopMatrix();
        glPopMatrix();

        // --- CAVIDADE DO NARIZ ---
        glPushMatrix();
            glColor3f(0.0f, 0.0f, 0.0f);
            glTranslatef(0.0f, 0.9f, 1.45f);
            glScalef(0.6f, 0.8f, 0.3f);
            glutSolidCone(0.2f, 0.5f, 10, 5);
        glPopMatrix();

        // --- PORTA / PONTE LEVADIÇA (JAWBRIDGE) ---
        glPushMatrix();
            // Cavidade da boca
            glColor3f(0.0f, 0.0f, 0.0f);
            glTranslatef(0.0f, 0.3f, 1.1f);
            glScalef(1.0f, 0.9f, 0.5f);
            gluSphere(quadric, 0.6f, 20, 10);

            // Ponte de madeira abaixada inclinada
            glColor3f(0.35f, 0.2f, 0.1f);
            glTranslatef(0.0f, -0.65f, 0.6f);
            glRotatef(20.0f, 1.0f, 0.0f, 0.0f); 
            glScalef(0.8f, 0.08f, 1.7f); // Mais longa para tocar a base rochosa
            glutSolidCube(1.0f);
        glPopMatrix();

    glPopMatrix(); // Fim da matriz global

    gluDeleteQuadric(quadric);
    glutSwapBuffers();
}

int main(int argc, char *argv[]) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(1024, 768); // Janela um pouco maior
    glutCreateWindow("Castelo de Grayskull");

    glutReshapeFunc(ChangeSize);
    glutSpecialFunc(SpecialKeys);
    glutDisplayFunc(RenderScene);

    SetupRC();

    glutMainLoop();
    return 0;
}