// gcc -g -std=c17 -I include -L lib main.c src/glad.c -lglfw3dll -lglu32 -lopengl32 -o teste.exe

#define GLFW_INCLUDE_NONE

#include <stdio.h>         
#include <stdlib.h>        
#include <GLFW/glfw3.h>    
#include <GL/gl.h>         
#include <GL/glu.h>        

#define ALTURA_TELA 1000
#define LARGURA_TELA 900

static GLfloat y_rotacao = 0.0f;

void redimensionamento (GLFWwindow *janela, int a, int l); // Redimensionamento da janela
void configuracoes_Cena (); // Configurações de iluminação e do fundo
void desenho_Castelo(GLFWwindow *janela); // Desenha do castelo
void teclado(GLFWwindow *janela); // Captura do teclado

int main(){
    glfwInit();

    GLFWwindow *janela = glfwCreateWindow(ALTURA_TELA, LARGURA_TELA, "Castelo", NULL, NULL);

    if(janela == NULL){
        printf("Falha ao abrir a janela GLFW\n");
        glfwTerminate();
        return -1;
    }

    glfwMakeContextCurrent(janela);
    glfwSetFramebufferSizeCallback(janela, redimensionamento);
    glfwSwapInterval(1);
    glfwSetInputMode(janela, GLFW_STICKY_KEYS, GL_TRUE);

    redimensionamento(janela, ALTURA_TELA, LARGURA_TELA);
    configuracoes_Cena();

    while(!glfwWindowShouldClose(janela)){
        teclado(janela);
        desenho_Castelo(janela);
        glfwSwapBuffers(janela);
        glfwPollEvents();
    }

    glfwTerminate();
    return 0;
}

void redimensionamento (GLFWwindow *janela, int a, int l){
    GLfloat proporcao;

    if (a == 0){
        a  = 1;
    }

    glViewport(0, 0, a, l);

    proporcao = (GLfloat)a/(GLfloat)l;

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(35.0f, proporcao, 1.0, 40.0);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

void configuracoes_Cena (){
    GLfloat  whiteLight[] = { 0.3f, 0.3f, 0.3f, 1.0f };
    GLfloat  sourceLight[] = { 0.25f, 0.25f, 0.25f, 1.0f };
    GLfloat  lightPos[] = { -10.f, 5.0f, 5.0f, 1.0f };

    glEnable(GL_DEPTH_TEST);   
    glFrontFace(GL_CCW);       
    //glEnable(GL_CULL_FACE);    
    
    glEnable(GL_LIGHTING);     
    glLightModelfv(GL_LIGHT_MODEL_AMBIENT, whiteLight);  
    glLightfv(GL_LIGHT0, GL_AMBIENT, sourceLight);       
    glLightfv(GL_LIGHT0, GL_DIFFUSE, sourceLight);       
    glLightfv(GL_LIGHT0, GL_POSITION, lightPos);         
    glEnable(GL_LIGHT0);                               
    
    glEnable(GL_COLOR_MATERIAL);    
    glColorMaterial(GL_FRONT, GL_AMBIENT_AND_DIFFUSE);  
    
    glClearColor(0.7882f, 0.9137f, 0.9804f, 1.0f);
}

void teclado(GLFWwindow *janela){
    if(glfwGetKey(janela, GLFW_KEY_ESCAPE) == GLFW_PRESS){
        glfwTerminate();
        exit(EXIT_SUCCESS);
    }

    if(glfwGetKey(janela, GLFW_KEY_LEFT) == GLFW_PRESS){
        y_rotacao -= 5.0f;
    }

    if(glfwGetKey(janela, GLFW_KEY_RIGHT) == GLFW_PRESS){
        y_rotacao += 5.0f;
    }

    y_rotacao = (GLfloat)((const int)y_rotacao % 360);

}

void desenho_Castelo(GLFWwindow *janela){
    GLUquadric *castelo;

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glPushMatrix();

        glTranslated(0.0f, 0.0f, -5.0f);
        glRotated(y_rotacao, 0.0f, 1.0f, 0.0f);

        castelo = gluNewQuadric();
        gluQuadricNormals(castelo, GLU_SMOOTH);

        glColor3b(0.60f, 0.60f, 0.60f);
        // Porta principal
        glPushMatrix();
            glBegin(GL_QUADS);
            glVertex3f(-0.15f, -0.7f, 0.01f); // inferior esquerdo
            glVertex3f(0.15f, -0.7f, 0.01f); // inferior direito
            glVertex3f(0.15f, -0.3f, 0.01f); // superior direito
            glVertex3f(-0.15f, -0.3f, 0.01f); // superior esquerdo
            glEnd();
        glPopMatrix();

        glColor3f(0.6196f, 0.5803f, 0.5803f);
        // Muro frente 
        glPushMatrix();
            glBegin(GL_QUADS);
            glVertex3f(-0.5f, -0.7f, 0.0f); // inferior esquerdo
            glVertex3f(0.5f, -0.7f, 0.0f); // inferior direito
            glVertex3f(0.5f, -0.05f, 0.0f); // superior direito
            glVertex3f(-0.5f, -0.05f, 0.0f); // superior esquerdo
            glEnd();
        glPopMatrix();

        //Muro fundo
        glPushMatrix();
            glBegin(GL_QUADS);
            glVertex3f(-0.5f, -0.7f, -1.0f); // inferior esquerdo
            glVertex3f(0.5f, -0.7f, -1.0f); // inferior direito
            glVertex3f(0.5f, -0.05f, -1.0f); // superior direito
            glVertex3f(-0.5f, -0.05f, -1.0f); // superior esquerdo
            glEnd();
        glPopMatrix();

        //Muro esquerdo
        glPushMatrix();
            glBegin(GL_QUADS);
            glVertex3f(-0.5f, -0.7f, 0.0f); // inferior esquerdo
            glVertex3f(-0.5f, -0.7f, -1.0); // inferior direito
            glVertex3f(-0.5f, -0.05f, -1.0f); // superior direito
            glVertex3f(-0.5f, -0.05f, 0.0f); // superior esquerdo
            glEnd();
        glPopMatrix();

        //Muro direito
        glPushMatrix();
            glBegin(GL_QUADS);
            glVertex3f(0.5f, -0.7f, 0.0f); // inferior esquerdo
            glVertex3f(0.5f, -0.7f, -1.0); // inferior direito
            glVertex3f(0.5f, -0.05f, -1.0f); // superior direito
            glVertex3f(0.5f, -0.05f, 0.0f); // superior esquerdo
            glEnd();
        glPopMatrix();

        // Primeira torre (esquerda - frente)
        glPushMatrix();
            glTranslated(-0.6f, -0.7f, 0.0f);
            glRotatef(-90, 1.0f, 0.0f, 0.0f);
            gluCylinder(castelo, 0.2f, 0.2f, 0.7, 26, 13);
        glPopMatrix();

        // Terceira torre (esquerda - fundo)
        glPushMatrix();
            glTranslated(-0.6f, -0.7f, -1.0f);
            glRotatef(-90, 1.0f, 0.0f, 0.0f);
            gluCylinder(castelo, 0.2f, 0.2f, 0.7, 26, 13);
        glPopMatrix();

        // Segunda torre (direita - frente)
        glPushMatrix();
            glTranslated(0.6f, -0.7f, 0.0f);
            glRotatef(-90, 1.0f, 0.0f, 0.0f);
            gluCylinder(castelo, 0.2f, 0.2f, 0.7, 26, 13);
        glPopMatrix();

        // Quarta torre (direita - fundo)
        glPushMatrix();
            glTranslated(0.6f, -0.7f, -1.0f);
            glRotatef(-90, 1.0f, 0.0f, 0.0f);
            gluCylinder(castelo, 0.2f, 0.2f, 0.7, 26, 13);
        glPopMatrix();

        glColor3b(0.60f, 0.60f, 0.60f);
        // Cone da torre (esquerdo - frente)
        glPushMatrix();
            glTranslated(-0.6, 0.0, 0.0f);
            glRotatef(-90, 1.0f, 0.0f, 0.0f);
            gluCylinder(castelo, 0.3f, 0.0f, 0.5, 26, 13);
        glPopMatrix();

        // Cone da torre (esquerdo - fundo)
        glPushMatrix();
            glTranslated(-0.6, 0.0, -1.0f);
            glRotatef(-90, 1.0f, 0.0f, 0.0f);
            gluCylinder(castelo, 0.3f, 0.0f, 0.5, 26, 13);
        glPopMatrix();

        //Cone da torre (direita - frente)
        glPushMatrix();
            glTranslated(0.6, 0.0, 0.0f);
            glRotatef(-90, 1.0f, 0.0f, 0.0f);
            gluCylinder(castelo, 0.3f, 0.0f, 0.5, 26, 13);
        glPopMatrix();

        //Cone da torre (direita - fundo)
        glPushMatrix();
            glTranslated(0.6, 0.0, -1.0f);
            glRotatef(-90, 1.0f, 0.0f, 0.0f);
            gluCylinder(castelo, 0.3f, 0.0f, 0.5, 26, 13);
        glPopMatrix();

        // janela esquerda
        glPushMatrix();
            glTranslated(-0.6f, -0.3f, 0.11f);
            glRotatef(-90, 1.0f, 0.0f, 0.0f);
            gluCylinder(castelo, 0.1f, 0.1f, 0.2, 26, 13);
        glPopMatrix();

        // janela direita
        glPushMatrix();
            glTranslated(0.6f, -0.3f, 0.11f);
            glRotatef(-90, 1.0f, 0.0f, 0.0f);
            gluCylinder(castelo, 0.1f, 0.1f, 0.2, 26, 13);
        glPopMatrix();
        
    glPopMatrix();
}

// gcc -g -std=c17 -I include -L lib main.c src/glad.c -lglfw3dll -lglu32 -lopengl32 -o teste.exe
//rgba(82, 63, 63, 0.89)