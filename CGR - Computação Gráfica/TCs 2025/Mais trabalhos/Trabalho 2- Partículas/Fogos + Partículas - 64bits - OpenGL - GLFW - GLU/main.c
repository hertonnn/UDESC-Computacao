// gcc -g -std=c17 -I include -L lib main.c src/glad.c -lglfw3dll -lglu32 -lopengl32 -o teste.exe

#define GLFW_INCLUDE_NONE

#include <stdio.h>         
#include <stdlib.h>        
#include <GLFW/glfw3.h>    
#include <GL/gl.h>         
#include <GL/glu.h>        

#define ALTURA_TELA 1000// Altura
#define LARGURA_TELA 800 // Largura 
#define MAX_PARTICULAS 1000 

static GLfloat y_rotacao = 0.0f;

typedef struct{
    float x, y; // Posição
    float vx, vy; // Velocidade
    float r, g, b;  // Cor 
} Particula;

Particula particulas [MAX_PARTICULAS];

void redimensionamento (GLFWwindow *janela, int a, int l); // Redimensionamento da janela
void configuracoes_Cena (); // Configurações de iluminação e do fundo
void desenho_Boneco(GLFWwindow *janela); // Desenha o Boneco de neve
void teclado(GLFWwindow *janela); // Captura do teclado
void inicializacao_particulas(); // Incializa as particulas
void atualizacao_particulas(); // Atualizar a tela 
void desenhar_particulas(GLFWwindow *janela); // Desenha na tela 

void inicializacao_particulas(){
    for(int i = 0; i < MAX_PARTICULAS; i++){
        particulas[i].y = 0;
        particulas[i].x = ((rand() % 200) - 100) / 100.0f;
        particulas[i].vx = ((rand() % 100) - 50) / 1000.f;
        particulas[i].vy = -(((rand() % 100)- 50) / 1000.f);
        
        particulas[i].r = (rand() % 256) / 255.0f;  
        particulas[i].g = (rand() % 256) / 255.0f;  
        particulas[i].b = (rand() % 256) / 255.0f;  
    }
}

void atualizacao_particulas(){
    for(int i = 0; i < MAX_PARTICULAS; i++){
        particulas[i].x += particulas[i].vx;
        particulas[i].y += particulas[i].vy;

        if(particulas[i].y < 0.0f){
            particulas[i].y = 1;
            particulas[i].x = ((rand() % 200) - 100) / 100.0f;
            particulas[i].vx = ((rand() % 100) - 50) / 100.f;
            particulas[i].vy = -(((rand() % 100)- 50) / 100.f);
        }
    }
}

void desenhar_particulas(GLFWwindow *janela){

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glPointSize(6);
    glBegin(GL_POINTS);
    
    for(int i = 0; i < MAX_PARTICULAS; i++){
        glColor3f(particulas[i].r, particulas[i].g, particulas[i].b);
        glVertex3f(particulas[i].x, particulas[i].y, -5.0f);
    }

    glEnd();
}

int main(){
    glfwInit();

    // Criação da Janela
    GLFWwindow *janela = glfwCreateWindow(ALTURA_TELA, LARGURA_TELA, "Fogos de Artifício", NULL, NULL);

    // Verifica se a janela foi aberta corretamente
    if(janela == NULL){
        printf("Falha ao abrir a janela GLFW\n");
        glfwTerminate();
        return -1;
    }

    glfwMakeContextCurrent(janela); // Contexto da janela
    glfwSetFramebufferSizeCallback(janela, redimensionamento);
    glfwSwapInterval(1);
    inicializacao_particulas(); 
    glfwSetInputMode(janela, GLFW_STICKY_KEYS, GL_TRUE);

    redimensionamento(janela, ALTURA_TELA, LARGURA_TELA); // Chama função de redimensionamento
    configuracoes_Cena(); // Chama a função de configuração de cena

    while(!glfwWindowShouldClose(janela)){
        teclado(janela);
        atualizacao_particulas();  
        desenhar_particulas(janela);
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
    
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
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

// gcc -g -std=c17 -I include -L lib main.c src/glad.c -lglfw3dll -lglu32 -lopengl32 -o teste.exe
//rgba(173, 174, 255, 0.87)