// Comando para compilar e executar:
// g++ robo_articulado.cpp src/glad.c -Iinclude -Llib -lfreeglut -lopengl32 -lglu32 -lwinmm -lgdi32 -o robo.exe && ./robo

#include <GL/glut.h>

// Rotação global da câmera
static GLfloat xRot = 15.0f;
static GLfloat yRot = 30.0f;

// Variáveis de articulação (Ângulos em graus)
static GLfloat ombroEsqX = 0.0f;
static GLfloat cotoveloEsqX = 0.0f;
static GLfloat quadrilEsqX = 0.0f;
static GLfloat joelhoEsqX = 0.0f;

void ChangeSize(int w, int h) {
    GLfloat fAspect;
    if (h == 0) h = 1;

    glViewport(0, 0, w, h);
    fAspect = (GLfloat)w / (GLfloat)h;

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(45.0f, fAspect, 1.0, 40.0);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

void SpecialKeys(int key, int x, int y) {
    // Controle da câmera (rotação global)
    if (key == GLUT_KEY_LEFT) yRot -= 5.0f;
    if (key == GLUT_KEY_RIGHT) yRot += 5.0f;
    if (key == GLUT_KEY_UP) xRot -= 5.0f;
    if (key == GLUT_KEY_DOWN) xRot += 5.0f;

    yRot = (GLfloat)((const int)yRot % 360);
    xRot = (GLfloat)((const int)xRot % 360);

    glutPostRedisplay();
}

void KeyboardKeys(unsigned char key, int x, int y) {
    // Controles de articulação para testar a hierarquia
    switch (key) {
        case 'q': ombroEsqX += 5.0f; break;
        case 'a': ombroEsqX -= 5.0f; break;
        case 'w': cotoveloEsqX += 5.0f; break;
        case 's': cotoveloEsqX -= 5.0f; break;
        case 'e': quadrilEsqX += 5.0f; break;
        case 'd': quadrilEsqX -= 5.0f; break;
        case 'r': joelhoEsqX += 5.0f; break;
        case 'f': joelhoEsqX -= 5.0f; break;
        // Limites para as articulações (opcional, para não dobrar ao contrário)
    }
    glutPostRedisplay();
}

void SetupRC() {
    GLfloat ambientLight[] = {0.2f, 0.2f, 0.2f, 1.0f};
    GLfloat diffuseLight[] = {0.8f, 0.8f, 0.8f, 1.0f};
    GLfloat lightPos[] = {-10.0f, 15.0f, 10.0f, 1.0f};

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

    glClearColor(0.2f, 0.3f, 0.4f, 1.0f); // Fundo azul acinzentado
}

void RenderScene(void) {
    GLUquadricObj *quadric = gluNewQuadric();
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glPushMatrix();
        // Posicionamento inicial da câmera
        glTranslatef(0.0f, 0.0f, -8.0f);
        glRotatef(xRot, 1.0f, 0.0f, 0.0f);
        glRotatef(yRot, 0.0f, 1.0f, 0.0f);

        GLfloat metalColor[] = {0.6f, 0.65f, 0.7f};
        GLfloat jointColor[] = {0.2f, 0.2f, 0.2f};

        // ================= TRONCO (Raiz da Hierarquia) =================
        glPushMatrix(); 
            glColor3fv(metalColor);
            // Desenha o tronco centrado (cilindro orientado para cima)
            glPushMatrix();
                glTranslatef(0.0f, -0.8f, 0.0f);
                glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);
                gluCylinder(quadric, 0.5f, 0.6f, 1.6f, 30, 10);
            glPopMatrix();

            // --- CABEÇA ---
            glPushMatrix();
                glTranslatef(0.0f, 1.2f, 0.0f); // Relativo ao topo do tronco
                glColor3fv(metalColor);
                gluSphere(quadric, 0.4f, 30, 30);
                
                // Olho (visor)
                glColor3f(0.0f, 1.0f, 1.0f); // Ciano brilhante
                glTranslatef(0.0f, 0.1f, 0.35f);
                glScalef(1.5f, 0.4f, 0.2f);
                glutSolidCube(0.3f);
            glPopMatrix();

            // --- BRAÇO ESQUERDO (Articulado via teclado) ---
            glPushMatrix();
                glTranslatef(-0.7f, 0.6f, 0.0f); // Posição do Ombro

                glColor3fv(jointColor);
                gluSphere(quadric, 0.2f, 20, 20); // Junta do ombro

                glRotatef(ombroEsqX, 1.0f, 0.0f, 0.0f); // ARTICULAÇÃO: Ombro

                // Braço superior
                glPushMatrix();
                    glColor3fv(metalColor);
                    glRotatef(90.0f, 1.0f, 0.0f, 0.0f); // Aponta cilindro para baixo
                    gluCylinder(quadric, 0.15f, 0.15f, 0.7f, 20, 10);
                glPopMatrix();

                // Antebraço (Filho do Braço)
                glTranslatef(0.0f, -0.7f, 0.0f); // Move para o cotovelo

                glColor3fv(jointColor);
                gluSphere(quadric, 0.15f, 20, 20); // Junta do cotovelo

                glRotatef(cotoveloEsqX, 1.0f, 0.0f, 0.0f); // ARTICULAÇÃO: Cotovelo

                glPushMatrix();
                    glColor3fv(metalColor);
                    glRotatef(90.0f, 1.0f, 0.0f, 0.0f);
                    gluCylinder(quadric, 0.12f, 0.1f, 0.7f, 20, 10);
                glPopMatrix();
            glPopMatrix();

            // --- BRAÇO DIREITO (Estático por enquanto) ---
            glPushMatrix();
                glTranslatef(0.7f, 0.6f, 0.0f); // Posição do Ombro
                glColor3fv(jointColor);
                gluSphere(quadric, 0.2f, 20, 20); 

                glPushMatrix();
                    glColor3fv(metalColor);
                    glRotatef(90.0f, 1.0f, 0.0f, 0.0f); 
                    gluCylinder(quadric, 0.15f, 0.15f, 0.7f, 20, 10);
                glPopMatrix();

                glTranslatef(0.0f, -0.7f, 0.0f); // Cotovelo
                glColor3fv(jointColor);
                gluSphere(quadric, 0.15f, 20, 20); 

                glPushMatrix();
                    glColor3fv(metalColor);
                    glRotatef(90.0f, 1.0f, 0.0f, 0.0f);
                    gluCylinder(quadric, 0.12f, 0.1f, 0.7f, 20, 10);
                glPopMatrix();
            glPopMatrix();

            // --- PERNA ESQUERDA (Articulada via teclado) ---
            glPushMatrix();
                glTranslatef(-0.35f, -0.8f, 0.0f); // Posição do Quadril

                glColor3fv(jointColor);
                gluSphere(quadric, 0.22f, 20, 20); // Junta do quadril

                glRotatef(quadrilEsqX, 1.0f, 0.0f, 0.0f); // ARTICULAÇÃO: Quadril

                // Coxa
                glPushMatrix();
                    glColor3fv(metalColor);
                    glRotatef(90.0f, 1.0f, 0.0f, 0.0f); 
                    gluCylinder(quadric, 0.2f, 0.18f, 0.8f, 20, 10);
                glPopMatrix();

                // Panturrilha (Filha da Coxa)
                glTranslatef(0.0f, -0.8f, 0.0f); // Move para o joelho

                glColor3fv(jointColor);
                gluSphere(quadric, 0.18f, 20, 20); // Junta do joelho

                glRotatef(joelhoEsqX, 1.0f, 0.0f, 0.0f); // ARTICULAÇÃO: Joelho

                glPushMatrix();
                    glColor3fv(metalColor);
                    glRotatef(90.0f, 1.0f, 0.0f, 0.0f);
                    gluCylinder(quadric, 0.18f, 0.15f, 0.8f, 20, 10);
                glPopMatrix();
            glPopMatrix();

            // --- PERNA DIREITA (Estática por enquanto) ---
            glPushMatrix();
                glTranslatef(0.35f, -0.8f, 0.0f); // Posição do Quadril
                glColor3fv(jointColor);
                gluSphere(quadric, 0.22f, 20, 20); 

                glPushMatrix();
                    glColor3fv(metalColor);
                    glRotatef(90.0f, 1.0f, 0.0f, 0.0f); 
                    gluCylinder(quadric, 0.2f, 0.18f, 0.8f, 20, 10);
                glPopMatrix();

                glTranslatef(0.0f, -0.8f, 0.0f); // Joelho
                glColor3fv(jointColor);
                gluSphere(quadric, 0.18f, 20, 20); 

                glPushMatrix();
                    glColor3fv(metalColor);
                    glRotatef(90.0f, 1.0f, 0.0f, 0.0f);
                    gluCylinder(quadric, 0.18f, 0.15f, 0.8f, 20, 10);
                glPopMatrix();
            glPopMatrix();

        glPopMatrix(); // Fim do Tronco

    glPopMatrix(); // Fim da matriz global

    gluDeleteQuadric(quadric);
    glutSwapBuffers();
}

int main(int argc, char *argv[]) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(800, 800);
    glutCreateWindow("Robô Articulado (Hierarquia OpenGL)");

    glutReshapeFunc(ChangeSize);
    glutSpecialFunc(SpecialKeys); // Setas para girar a câmera
    glutKeyboardFunc(KeyboardKeys); // Letras para mover as articulações
    glutDisplayFunc(RenderScene);

    SetupRC();

    glutMainLoop();
    return 0;
}