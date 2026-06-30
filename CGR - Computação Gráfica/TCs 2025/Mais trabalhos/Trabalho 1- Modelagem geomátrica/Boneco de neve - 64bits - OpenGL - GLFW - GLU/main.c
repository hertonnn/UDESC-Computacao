// gcc -g -std=c17 -I include -L lib main.c src/glad.c -lglfw3dll -lglu32 -lopengl32 -o teste.exe

#define GLFW_INCLUDE_NONE

#include <stdio.h>         
#include <stdlib.h>        
#include <GLFW/glfw3.h>    
#include <GL/gl.h>         
#include <GL/glu.h>        

#define ALTURA_TELA 800 // Altura
#define LARGURA_TELA 600 // Largura 

static GLfloat y_rotacao = 0.0f;

void redimensionamento (GLFWwindow *janela, int a, int l); // Redimensionamento da janela
void configuracoes_Cena (); // Configurações de iluminação e do fundo
void desenho_Boneco(GLFWwindow *janela); // Desenha o Boneco de neve
void teclado(GLFWwindow *janela); // Captura do teclado

int main(){
    glfwInit();

    // Criação da Janela
    GLFWwindow *janela = glfwCreateWindow(ALTURA_TELA, LARGURA_TELA, "Boneco de Neve", NULL, NULL);

    // Verifica se a janela foi aberta corretamente
    if(janela == NULL){
        printf("Falha ao abrir a janela GLFW\n");
        glfwTerminate();
        return -1;
    }

    glfwMakeContextCurrent(janela); // Contexto da janela
    glfwSetFramebufferSizeCallback(janela, redimensionamento);
    glfwSwapInterval(1);
    glfwSetInputMode(janela, GLFW_STICKY_KEYS, GL_TRUE);

    redimensionamento(janela, ALTURA_TELA, LARGURA_TELA); // Chama função de redimensionamento
    configuracoes_Cena(); // Chama a função de configuração de cena

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
    GLfloat  whiteLight[] = { 0.3f, 0.3f, 0.3f, 1.0f }; // Deixei a cena mais clara
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

void desenho_Boneco(GLFWwindow *janela){
    GLUquadric *boneco;

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glPushMatrix(); 

        glTranslated(0.0f, -1.0f, -5.0f);
        glRotatef(y_rotacao, 0.0f, 1.0f, 0.0f);
       
        boneco = gluNewQuadric();
        gluQuadricNormals(boneco, GLU_SMOOTH);

        glColor3f(1.0f, 1.0f, 1.0f);
        // Cabeça
        glPushMatrix();
            glTranslatef(0.0f, 1.0f, 0.0f);
            gluSphere(boneco, 0.24f, 26, 13);
        glPopMatrix();

        // Nariz
        glPushMatrix();
            glColor4f(0.9333f, 0.5843f, 0.3529f, 1.0f);
            glTranslatef(0.0f, 1.0f, 0.2f);
            gluCylinder(boneco, 0.05f, 0.0f, 0.3f, 26, 13);
        glPopMatrix();

        // Barriga
        glPushMatrix();
            glColor3f(1.0f, 1.0f, 1.0f);
            glTranslatef(0.0f, 0.76f - 0.20f, 0.0f);
            gluSphere(boneco, 0.28, 26, 13);
        glPopMatrix();

        // Barriga de baixo
        glPushMatrix();
            glColor3f(1.0f, 1.0f, 1.0f);
            glTranslatef(0.0f, 0.26f - 0.22f, 0.0f);
            gluSphere(boneco, 0.35, 26, 13);
        glPopMatrix();

        glColor3f(0.0f, 0.0f, 0.0f);
        // Bolinhas da barriga
        glPushMatrix();
            glTranslatef(0.0f,  (0.76f - 0.15f) + 0.08 , 0.26f);
            gluSphere(boneco, 0.025, 26, 13);
        glPopMatrix();

        glPushMatrix();
            glTranslatef(0.0f,  0.76f - 0.15f, 0.28f);
            gluSphere(boneco, 0.025, 26, 13);
        glPopMatrix();

        glPushMatrix();
            glTranslatef(0.0f,  (0.76f - 0.15f) - 0.08 , 0.28f);
            gluSphere(boneco, 0.025, 26, 13);
        glPopMatrix();

        // Olhos 
        glPushMatrix();
            glTranslatef(0.09f, 1.1f, 0.21f);
            gluSphere(boneco, 0.023, 26, 13);
        glPopMatrix();

        glPushMatrix();
            glTranslatef(-0.09f, 1.1f, 0.21f);
            gluSphere(boneco, 0.023, 26, 13);
        glPopMatrix();

        // Chapéu - Aba
        glPushMatrix();
            glTranslatef(0.0f, 1.18f, 0.0f);
            glRotatef(-90, 1.0f, 0.0f, 0.0f);
            gluCylinder(boneco, 0.25f, 0.25f, 0.06, 26, 13);
        glPopMatrix();

        // Chapéu - Corpo
        glPushMatrix();
            glTranslatef(0.0f, 1.18f, 0.0f);
            glRotatef(-90, 1.0f, 0.0f, 0.0f);
            gluCylinder(boneco, 0.16f, 0.16f, 0.37, 26, 13);
        glPopMatrix();

        // Gorro
        glColor4f(0.73f, 0.49f, 0.81f, 1.0f);
        glPushMatrix();
            glTranslatef(0.0f, 0.76, 0.0f);
            glRotatef(-90, 1.0f, 0.0f, 0.0f);
            gluCylinder(boneco, 0.2f, 0.2f, 0.06, 26, 13);
        glPopMatrix();

        // Aba do gorro
        glPushMatrix();
            glTranslatef(0.15f, 0.78, 0.1f);
            glRotatef(45, 1.0f, 0.0f, 0.0f);
            gluCylinder(boneco, 0.025f, 0.009f, 0.25f, 26, 13);
        glPopMatrix();

        // Aba do gorro
        glPushMatrix();
            glTranslatef(0.15f, 0.78, 0.1f);
            glRotatef(90, 0.0f, 1.0f, 0.0f);
            glRotatef(45, 1.0f, 0.0f, 0.0f);
            gluCylinder(boneco, 0.025f, 0.009f, 0.25f, 26, 13);
        glPopMatrix();

        // Braco esquerdo
        glPushMatrix();
            glColor4f(0.49f, 0.37f, 0.29f, 1.0f);
            glTranslatef(-0.20f, 0.70, 0.0f);
            glRotatef(-90, 0.0f, 1.0f, 0.0f);
            glRotatef(45, 1.0f, 0.0f, 0.0f);
            gluCylinder(boneco, 0.025f, 0.005f, 0.50f, 26, 13);
        glPopMatrix();

        // Braco direito
        glPushMatrix();
            glColor4f(0.49f, 0.37f, 0.29f, 1.0f);
            glTranslatef(0.20f, 0.70, 0.0f);
            glRotatef(90, 0.0f, 1.0f, 0.0f);
            glRotatef(45, 1.0f, 0.0f, 0.0f);
            gluCylinder(boneco, 0.025f, 0.005f, 0.50f, 26, 13);
        glPopMatrix();

    glPopMatrix(); 
}

// gcc -g -std=c17 -I include -L lib main.c src/glad.c -lglfw3dll -lglu32 -lopengl32 -o teste.exe
//rgba(173, 174, 255, 0.87)