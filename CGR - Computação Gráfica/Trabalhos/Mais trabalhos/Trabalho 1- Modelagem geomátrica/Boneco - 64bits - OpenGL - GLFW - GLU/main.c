// gcc -g -std=c17 -I include -L lib main.c src/glad.c -lglfw3dll -lglu32 -lopengl32 -o teste.exe

#define GLFW_INCLUDE_NONE

#include <stdio.h>         
#include <stdlib.h>        
#include <GLFW/glfw3.h>    
#include <GL/gl.h>         
#include <GL/glu.h>        

#define ALTURA_TELA 800
#define LARGURA_TELA 600

static GLfloat y_rotacao = 0.0f;

void redimensionamento (GLFWwindow *janela, int a, int l); // Redimensionamento da janela
void configuracoes_Cena (); // Configurações de iluminação e do fundo
void desenho_Boneco(GLFWwindow *janela); // Desenha o Robo humanoide
void teclado(GLFWwindow *janela); // Captura do teclado

int main(){
    glfwInit();

    GLFWwindow *janela = glfwCreateWindow(ALTURA_TELA, LARGURA_TELA, "Robo humanoide", NULL, NULL);

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
        desenho_Boneco(janela);
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
    glEnable(GL_CULL_FACE);    
    
    glEnable(GL_LIGHTING);     
    glLightModelfv(GL_LIGHT_MODEL_AMBIENT, whiteLight);  
    glLightfv(GL_LIGHT0, GL_AMBIENT, sourceLight);       
    glLightfv(GL_LIGHT0, GL_DIFFUSE, sourceLight);       
    glLightfv(GL_LIGHT0, GL_POSITION, lightPos);         
    glEnable(GL_LIGHT0);                               
    
    glEnable(GL_COLOR_MATERIAL);    
    glColorMaterial(GL_FRONT, GL_AMBIENT_AND_DIFFUSE);  
    
    glClearColor(0.6156f, 0.6156f, 0.8039f, 1.0f);
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

void desenho_Boneco(GLFWwindow *janela){
    GLUquadric *boneco;

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glPushMatrix(); 

        glTranslated(0.0f, 0.0f, -5.0f);
        glRotatef(y_rotacao, 0.0f, 1.0f, 0.0f);
       
        boneco = gluNewQuadric();
        gluQuadricNormals(boneco, GLU_SMOOTH);

        glColor3f(0.6745f, 0.6745f, 0.7490f);

        // Cabeça 
        glPushMatrix();
            glTranslatef(0.0f, 0.95f, 0.0f);
            gluSphere(boneco, 0.24f, 26, 13);
        glPopMatrix();

        glColor3f(0.0f, 0.0f, 0.0f);
        // Boca
        glPushMatrix();
            glTranslatef(0.0f, 0.85f, 0.15f);
            glRotatef(90, 1.0f, 0.0f, 0.0f);
            gluCylinder(boneco, 0.08f, 0.08f, 0.01, 26, 13);;
        glPopMatrix();

        // Olho esquerdo 
        glPushMatrix();
            glTranslatef(0.1f, 0.95f, 0.17f);
            gluSphere(boneco, 0.05f, 26, 13);
        glPopMatrix();

        // Olho direito
        glPushMatrix();
            glTranslatef(-0.1f, 0.95f, 0.17f);
            gluSphere(boneco, 0.05f, 26, 13);
        glPopMatrix();

        glColor3f(0.1922f, 0.1529f, 0.2980f);
        //Pescoço
        glPushMatrix();
            glTranslatef(0.0f, 0.80f, 0.0f);
            glRotatef(90, 1.0f, 0.0f, 0.0f);
            gluCylinder(boneco, 0.12f, 0.12f, 0.65, 26, 13);
        glPopMatrix();

        glColor3f(0.6745f, 0.6745f, 0.7490f);
        // Tronco
        glPushMatrix();
            glTranslatef(0.0f, 0.65f, 0.0f);
            glRotatef(90, 1.0f, 0.0f, 0.0f);
            gluCylinder(boneco, 0.25f, 0.25f, 0.65, 26, 13);
        glPopMatrix();

        // ----- Construção do braço esquerdo -----

        glColor3f(0.1922f, 0.1529f, 0.2980f);
        // Ombro (esquerdo)
        glPushMatrix();
            glTranslatef(-0.27f, 0.59f, 0.f);
            gluSphere(boneco, 0.1f, 26, 13);
        glPopMatrix();

        glColor3f(0.6745f, 0.6745f, 0.7490f);
        // Braco 1 (esquerdo)
        glPushMatrix();
            glTranslatef(-0.27f, 0.585f, 0.0f);
            glRotatef(70, 1.0f, 0.0f, 0.0f);
            gluCylinder(boneco, 0.1f, 0.1f, 0.3, 26, 13);
        glPopMatrix();

        glColor3f(0.1922f, 0.1529f, 0.2980f);
        // Cotovelo (esquerdo)
        glPushMatrix();
            glTranslatef(-0.27f, 0.29f, 0.11f);
            gluSphere(boneco, 0.11f, 26, 13);
        glPopMatrix();

        glColor3f(0.6745f, 0.6745f, 0.7490f);
        // Braco 1 - resto (esquerdo)
        glPushMatrix();
            glTranslatef(-0.27f, 0.28f, 0.1f);
            glRotatef(50, 1.0f, 0.0f, 0.0f);
            gluCylinder(boneco, 0.1f, 0.1f, 0.3, 26, 13);
        glPopMatrix();

        glColor3f(0.6745f, 0.6745f, 0.7490f);
        // Mao (esquerdo)
        glPushMatrix();
            glTranslatef(-0.27f, 0.07f, 0.276f);
            gluSphere(boneco, 0.1f, 26, 13);
        glPopMatrix();

        // ----- Construção do braço direito -----
        
        glColor3f(0.1922f, 0.1529f, 0.2980f);
        // Ombro (direito)
        glPushMatrix();
            glTranslatef(0.27f, 0.59f, 0.f);
            gluSphere(boneco, 0.1f, 26, 13);
        glPopMatrix();

        glColor3f(0.6745f, 0.6745f, 0.7490f);
        // Braco 1 (direita)
        glPushMatrix();
            glTranslatef(0.27f, 0.59f, 0.0f);
            glRotatef(90, 1.0f, 0.0f, 0.0f);
            gluCylinder(boneco, 0.1f, 0.1f, 0.3, 26, 13);
        glPopMatrix();

        glColor3f(0.1922f, 0.1529f, 0.2980f);
        // Cotovelo (direito)
        glPushMatrix();
            glTranslatef(0.27f, 0.29f, 0.f);
            gluSphere(boneco, 0.11f, 26, 13);
        glPopMatrix();

        glColor3f(0.6745f, 0.6745f, 0.7490f);
        // Braco 1 - resto (direita)
        glPushMatrix();
            glTranslatef(0.27f, 0.25f, 0.0f);
            glRotatef(90, 1.0f, 0.0f, 0.0f);
            gluCylinder(boneco, 0.1f, 0.1f, 0.2, 26, 13);
        glPopMatrix();

        glColor3f(0.6745f, 0.6745f, 0.7490f);
        // Mao (direito)
        glPushMatrix();
            glTranslatef(0.27f, 0.05f, 0.f);
            gluSphere(boneco, 0.1f, 26, 13);
        glPopMatrix();

        // ----- Pernas -----

        glColor3f(0.6745f, 0.6745f, 0.7490f);
        // Perna (direita)
        glPushMatrix();
            glTranslatef(0.15f, 0.0f, 0.0f);
            glRotatef(90, 1.0f, 0.0f, 0.0f);
            gluCylinder(boneco, 0.1f, 0.1f, 0.5, 26, 13);
        glPopMatrix();

        // Perna (esquerda)
        glPushMatrix();
            glTranslatef(-0.15f, 0.0f, 0.0f);
            glRotatef(90, 1.0f, 0.0f, 0.0f);
            gluCylinder(boneco, 0.1f, 0.1f, 0.5, 26, 13);
        glPopMatrix();

        glColor3f(0.1922f, 0.1529f, 0.2980f);
        // Joelho (esquerdo)
        glPushMatrix();
            glTranslatef(-0.15f, -0.5f, 0.f);
            gluSphere(boneco, 0.11f, 26, 13);
        glPopMatrix();

        // Joelho (direito)
        glPushMatrix();
            glTranslatef(0.15f, -0.5f, 0.f);
            gluSphere(boneco, 0.11f, 26, 13);
        glPopMatrix();

        // Pé (direito)
        glPushMatrix();
            glTranslatef(0.15f, -1.0f, 0.f);
            gluSphere(boneco, 0.1f, 26, 13);
        glPopMatrix();

        // Pé (esquerdo)
        glPushMatrix();
            glTranslatef(-0.15f, -1.0f, 0.f);
            gluSphere(boneco, 0.1f, 26, 13);
        glPopMatrix();
        
        glColor3f(0.6745f, 0.6745f, 0.7490f);
        // Resto Perna (direita)
        glPushMatrix();
            glTranslatef(0.15f, -0.5f, 0.0f);
            glRotatef(90, 1.0f, 0.0f, 0.0f);
            gluCylinder(boneco, 0.1f, 0.1f, 0.5, 26, 13);
        glPopMatrix();

        // Resto Perna (esquerda)
        glPushMatrix();
            glTranslatef(-0.15f, -0.5f, 0.0f);
            glRotatef(90, 1.0f, 0.0f, 0.0f);
            gluCylinder(boneco, 0.1f, 0.1f, 0.5, 26, 13);
        glPopMatrix();

    glPopMatrix(); 
}

// gcc -g -std=c17 -I include -L lib main.c src/glad.c -lglfw3dll -lglu32 -lopengl32 -o teste.exe
//rgb(49, 39, 76)