// gcc main.c src/glad.c -Iinclude -Llib -lfreeglut -lopengl32 -lglu32 -lwinmm -lgdi32 -o teste.exe
#include <GL/glut.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <windows.h>
#include <string.h> 

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h" 

// Constante para correcao de compatibilidade de textura
#define GL_CLAMP_TO_EDGE 0x812F

// Tamanho do grid
#define COLUMNS 40
#define ROWS 40
#define MAX 200
#define MAX_OBSTACLE_PARTS 10 
#define MAX_OBSTACLES 8

// Direções possíveis para o movimento da cobra
#define UP 1
#define DOWN -1
#define RIGHT 2
#define LEFT -2

// Estrutura dos obstaculos
typedef struct {
    int parts_count;
    int x[MAX_OBSTACLE_PARTS];
    int y[MAX_OBSTACLE_PARTS];
} Obstacle;

// variáveis globais 
GLuint skybox_textures[6];

Obstacle obstacles[MAX_OBSTACLES]; // vetor com todos os obstáculos
int obstacles_count = 0;

// Posição da câmera
float camX = 20, camY = 20, camZ = 35;
float camSpeed = 0.1f;

short sDireection = RIGHT;

int gameOver = 0;
int score = 0;

int gridX, gridY;

int posX[MAX] = {20, 20, 20, 20, 20};
int posY[MAX] = {20, 19, 18, 17, 16};
int snake_length = 5;

int food = 0;
int foodX, foodY;

int delay = 130;

// Declaração das funções
void display_callback();
void init();
void reshape_callback(int, int);
void initGrid(int x, int y);
void initObstacles();
void drawGrid();
void drawUnit(int x, int y);
void drawObstacles();
void timer_callback(int);
void keyboard_callback(int, int, int);
void drawSnake();
void drawFood();
void randomPos(int *x, int *y);
int isPositionInObstacles(int x, int y);
void loadSkyboxTextures();
void drawSkybox(float size);

// Função principal
int main(int argc, char **argv){
    srand(time(NULL));

    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_DEPTH);

    int screenWidth  = glutGet(GLUT_SCREEN_WIDTH);
    int screenHeight = glutGet(GLUT_SCREEN_HEIGHT);

    int windowWidth = 800;
    int windowHeight = 600;

    int posX = (screenWidth - windowWidth) / 2;
    int posY = (screenHeight - windowHeight) / 2;

    glutInitWindowPosition(posX, posY);
    glutInitWindowSize(windowWidth, windowHeight);
    glutCreateWindow("Snake Game 3D - Obstáculos Variados");

    glutDisplayFunc(display_callback); // Desenho
    glutReshapeFunc(reshape_callback); // redimensionamento
    glutTimerFunc(delay, timer_callback, 0); // Atualização 
    glutSpecialFunc(keyboard_callback); // teclado

    initGrid(COLUMNS, ROWS); // Grid
    initObstacles(); // Obstaculos
    init(); // Iniciailiza algumas configurações iniciais como luz

    glutMainLoop();
    return 0;
}

// Callback principal de desenho 
void display_callback(){
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glLoadIdentity();

    float targetX = posX[0];
    float targetY = posY[0];

    camX += (targetX - camX) * camSpeed;
    camY += (targetY - camY) * camSpeed;

    gluLookAt(
        camX, camY - 8, camZ - 15,
        camX, camY, 0.0,
        0.0, 0.0, 1.0
    );

    drawSkybox(80.0f); // Desenha o skybox

    glDisable(GL_TEXTURE_2D);

    drawGrid(); // Desenha chao
    drawObstacles(); // desenha obstaculos
    drawSnake(); // Desenha cobra
    drawFood(); // Desenha comida

    glutSwapBuffers();

    if(gameOver){
        char _score[10];
        itoa(score, _score, 10);
        char text[50] = "Your score: ";
        strcat(text, _score);
        MessageBox(NULL, text, "Game Over", 0);
        exit(0);
    }
}

// Função de inicialização -> Luz, material
void init(){
    glClearColor(174.0f/255.0f, 202.0f/255.0f, 227.0f/255.0f, 0.87f);

    glEnable(GL_DEPTH_TEST);

    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);

    GLfloat light_position[] = {0.0f, 0.0f, 10.0f, 1.0f};
    GLfloat light_ambient[]  = {0.2f, 0.2f, 0.2f, 1.0f};
    GLfloat light_diffuse[]  = {0.8f, 0.8f, 0.8f, 1.0f};
    GLfloat light_specular[] = {1.0f, 1.0f, 1.0f, 1.0f};

    glLightfv(GL_LIGHT0, GL_POSITION, light_position);
    glLightfv(GL_LIGHT0, GL_AMBIENT,  light_ambient);
    glLightfv(GL_LIGHT0, GL_DIFFUSE,  light_diffuse);
    glLightfv(GL_LIGHT0, GL_SPECULAR, light_specular);

    glShadeModel(GL_SMOOTH);

    GLfloat mat_specular[] = {1.0, 1.0, 1.0, 1.0};
    GLfloat mat_shininess[] = {50.0};
    glMaterialfv(GL_FRONT, GL_SPECULAR, mat_specular);
    glMaterialfv(GL_FRONT, GL_SHININESS, mat_shininess);

    glEnable(GL_TEXTURE_2D);
    loadSkyboxTextures(); // Carrega as texturas no ceu
}

// Callback de reshape (ajusta viewport e projeção)
void reshape_callback(int w, int h){
    glViewport(0, 0, w, h);

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(60.0, (double)w / (double)h, 1.0, 100.0);
    glMatrixMode(GL_MODELVIEW);
}

// Inicializa grade do jogo 
void initGrid(int x, int y){
    gridX = x;
    gridY = y;
}

// Inicializa obstáculos com formatos variados e dispersos 
void initObstacles(){
    obstacles[0].parts_count = 4;
    obstacles[0].x[0] = 5;  obstacles[0].y[0] = 5;
    obstacles[0].x[1] = 6;  obstacles[0].y[1] = 5;
    obstacles[0].x[2] = 5;  obstacles[0].y[2] = 6;
    obstacles[0].x[3] = 6;  obstacles[0].y[3] = 6;

    obstacles[1].parts_count = 5;
    obstacles[1].x[0] = 15; obstacles[1].y[0] = 15;
    obstacles[1].x[1] = 16; obstacles[1].y[1] = 15;
    obstacles[1].x[2] = 17; obstacles[1].y[2] = 15;
    obstacles[1].x[3] = 17; obstacles[1].y[3] = 16;
    obstacles[1].x[4] = 17; obstacles[1].y[4] = 17;

    obstacles[2].parts_count = 5;
    obstacles[2].x[0] = 25; obstacles[2].y[0] = 25;
    obstacles[2].x[1] = 26; obstacles[2].y[1] = 25;
    obstacles[2].x[2] = 27; obstacles[2].y[2] = 25;
    obstacles[2].x[3] = 28; obstacles[2].y[3] = 25;
    obstacles[2].x[4] = 29; obstacles[2].y[4] = 25;

    obstacles[3].parts_count = 5;
    obstacles[3].x[0] = 30; obstacles[3].y[0] = 10;
    obstacles[3].x[1] = 31; obstacles[3].y[1] = 10;
    obstacles[3].x[2] = 32; obstacles[3].y[2] = 10;
    obstacles[3].x[3] = 31; obstacles[3].y[3] = 11;
    obstacles[3].x[4] = 31; obstacles[3].y[4] = 9;

    obstacles[4].parts_count = 7;
    obstacles[4].x[0] = 10; obstacles[4].y[0] = 30;
    obstacles[4].x[1] = 11; obstacles[4].y[1] = 30;
    obstacles[4].x[2] = 12; obstacles[4].y[2] = 30; 
    obstacles[4].x[3] = 11; obstacles[4].y[3] = 31;
    obstacles[4].x[4] = 12; obstacles[4].y[4] = 31;
    obstacles[4].x[5] = 13; obstacles[4].y[5] = 31;
    obstacles[4].x[6] = 14; obstacles[4].y[6] = 31;

    obstacles[5].parts_count = 5;
    obstacles[5].x[0] = 8;  obstacles[5].y[0] = 20;
    obstacles[5].x[1] = 9;  obstacles[5].y[1] = 20;
    obstacles[5].x[2] = 9;  obstacles[5].y[2] = 21;
    obstacles[5].x[3] = 10; obstacles[5].y[3] = 21;
    obstacles[5].x[4] = 10; obstacles[5].y[4] = 22;

    obstacles[6].parts_count = 4;
    obstacles[6].x[0] = 20; obstacles[6].y[0] = 8;
    obstacles[6].x[1] = 20; obstacles[6].y[1] = 9;
    obstacles[6].x[2] = 20; obstacles[6].y[2] = 10;
    obstacles[6].x[3] = 20; obstacles[6].y[3] = 11;

    obstacles[7].parts_count = 4;
    obstacles[7].x[0] = gridX - 5; obstacles[7].y[0] = gridY - 5;
    obstacles[7].x[1] = gridX - 4; obstacles[7].y[1] = gridY - 5;
    obstacles[7].x[2] = gridX - 4; obstacles[7].y[2] = gridY - 6;
    obstacles[7].x[3] = gridX - 4; obstacles[7].y[3] = gridY - 8;

    obstacles_count = 8;
}

// Desenha o grid completo, chamando drawUnit para cada posição
void drawGrid(){
    GLfloat mat_diffuse[] = {81.0f/255.0f, 137.0f/255.0f, 92.0f/255.0f, 1.0f};
    glMaterialfv(GL_FRONT, GL_DIFFUSE, mat_diffuse);

    glBegin(GL_QUADS);
        glVertex3f(0, 0, -0.01f);
        glVertex3f(gridX, 0, -0.01f);
        glVertex3f(gridX, gridY, -0.01f);
        glVertex3f(0, gridY, -0.01f);
    glEnd();

    for(int x = 0; x < gridX; x++){
        for(int y = 0; y < gridY; y++){
            drawUnit(x, y);
        }
    }
}

// Desenha a unidade do grid em posição (x,y)
// Desenha bordas nas extremidades e linhas do grid
void drawUnit(int x, int y){
    float margin = 0.05f;

    if(x == 0 || y == 0 || x == gridX - 1 || y == gridY - 1){
        GLfloat border_diffuse[] = {62.0f/255.0f, 46.0f/255.0f, 41.0f/255.0f, 1.0f};
        glMaterialfv(GL_FRONT, GL_DIFFUSE, border_diffuse);

        glPushMatrix();
            glTranslatef(x + 0.5, y + 0.5, 0.0);
            glutSolidCube(1.0 - 2 * margin);
        glPopMatrix();
    }

    glDisable(GL_LIGHTING);
    glColor4f(41.0f / 255.0f, 75.0f / 255.0f, 48.0f / 255.0f, 1.0f);

    glBegin(GL_LINE_LOOP);
        glVertex3f(x, y, 0);
        glVertex3f(x + 1, y, 0);
        glVertex3f(x + 1, y + 1, 0);
        glVertex3f(x, y + 1, 0);
    glEnd();
    glEnable(GL_LIGHTING);
}

// Desenha os obstáculos no cenário
void drawObstacles(){
    GLfloat mat_diffuse[] = {41.0f/255.0f, 75.0f/255.0f, 48.0f/255.0f, 1.0f}; // verde escuro
    glMaterialfv(GL_FRONT, GL_DIFFUSE, mat_diffuse);

    float margin = 0.05f;

    for(int i = 0; i < obstacles_count; i++){
        for(int part = 0; part < obstacles[i].parts_count; part++){
            glPushMatrix();
                glTranslatef(obstacles[i].x[part] + 0.5f, obstacles[i].y[part] + 0.5f, 0.0f);
                glutSolidCube(1.0f - 2 * margin);
            glPopMatrix();
        }
    }
}

// Atualização
void timer_callback(int){
    glutPostRedisplay();
    glutTimerFunc(delay, timer_callback, 0);
}

// Teclas 
void keyboard_callback(int key, int, int){
    switch(key){
        case GLUT_KEY_UP:    
            if(sDireection != DOWN)  
                sDireection = UP; 
            break;
        case GLUT_KEY_DOWN:  
            if(sDireection != UP)    
                sDireection = DOWN; 
            break;
        case GLUT_KEY_LEFT:  
            if(sDireection != RIGHT) 
                sDireection = LEFT; 
            break;
        case GLUT_KEY_RIGHT: 
            if(sDireection != LEFT)  
                sDireection = RIGHT; 
            break;
    }
}

// Desenha a cobrinha
void drawSnake(){

    // Movimentação do corpo -> herda 
    for(int i = snake_length - 1; i > 0; i--){
        posX[i] = posX[i - 1];
        posY[i] = posY[i - 1];
    }

    // Movimentação da cabeça
    if(sDireection == UP){
        posY[0]++;
    } else if(sDireection == DOWN){ 
        posY[0]--;
    } else if(sDireection == RIGHT){
        posX[0]++;
    }else if(sDireection == LEFT){
        posX[0]--;
    }
    
    // Desenho da cobra
    for(int i = 0; i < snake_length; i++){
        GLfloat mat_diffuse[4];
        if(i == 0){
            // Cabeça 
            mat_diffuse[0] = 45.0f / 255.0f;
            mat_diffuse[1] = 6.0f / 255.0f;
            mat_diffuse[2] = 51.0f / 255.0f;
            mat_diffuse[3] = 1.0f;
        } else {
            // corpo
            mat_diffuse[0] = 115.0f / 255.0f;
            mat_diffuse[1] = 24.0f / 255.0f;
            mat_diffuse[2] = 124.0f / 255.0f;
            mat_diffuse[3] = 1.0f;
        }
        glMaterialfv(GL_FRONT, GL_DIFFUSE, mat_diffuse);

        glPushMatrix();
            glTranslatef(posX[i] + 0.5, posY[i] + 0.5, 0.5);
            glutSolidCube(1.0);
        glPopMatrix();
    }

    // Colisão com parede
    if(posX[0] == 0 || posX[0] == gridX - 1 || posY[0] == 0 || posY[0] == gridY - 1){
        gameOver = 1;
    }

    // Colisão com corpo
    for(int i = 1; i < snake_length; i++){
        if(posX[0] == posX[i] && posY[0] == posY[i]){
            gameOver = 1;
            break;
        }
    }

    // Colisão com obstáculos
    for(int i = 0; i < obstacles_count; i++){
        for(int part = 0; part < obstacles[i].parts_count; part++){
            if(posX[0] == obstacles[i].x[part] && posY[0] == obstacles[i].y[part]){
                gameOver = 1;
                break;
            }
        }
        if(gameOver) break;
    }

    // Comer comida
    if(posX[0] == foodX && posY[0] == foodY){
        score++;
        snake_length++;
        if(snake_length > MAX){
            snake_length = MAX;
        }
        food = 0;

        if(delay > 40){
            delay -= 3;
        }
    }
}

// Desenha a comida 
void drawFood(){
    if(food == 0) {
        randomPos(&foodX, &foodY);
    }
    food = 1;

    GLfloat food_diffuse[] = {191.0f/255.0f, 68.0f/255.0f, 68.0f/255.0f, 1.0f};
    glMaterialfv(GL_FRONT, GL_DIFFUSE, food_diffuse);

    glPushMatrix();
        glTranslatef(foodX + 0.5, foodY + 0.5, 0.5);
        glutSolidCube(1.0);
    glPopMatrix();
}

// Verifica se a posição está dentro de algum obstáculo
int isPositionInObstacles(int x, int y){
    for(int i = 0; i < obstacles_count; i++){
        for(int part = 0; part < obstacles[i].parts_count; part++){
            if(obstacles[i].x[part] == x && obstacles[i].y[part] == y){
                return 1;
            }
        }
    }
    return 0;
}

// Gera posição aleatória válida para a comida
void randomPos(int *x, int *y){
    int maxX = gridX - 2, maxY = gridY - 2, min = 1;
    int valid = 0;

    while(!valid) {
        *x = min + rand() % (maxX - min + 1);
        *y = min + rand() % (maxY - min + 1);

        if(!isPositionInObstacles(*x, *y)){
            valid = 1;
        }
    }
}

// Função que carrega as texturas do skybox 
void loadSkyboxTextures() {
    const char* files[6] = {
        "textures/sky_right.png",
        "textures/sky_left.png",
        "textures/sky_top.png",
        "textures/sky_bottom.png",
        "textures/sky_front.png",
        "textures/sky_back.png"
    };

    glGenTextures(6, skybox_textures);

    for (int i = 0; i < 6; i++) {
        int width, height, channels;
        unsigned char* image = stbi_load(files[i], &width, &height, &channels, 4);
        
        if (!image) {
            printf("Erro ao carregar textura: %s\n", files[i]);
            exit(1);
        }

        glBindTexture(GL_TEXTURE_2D, skybox_textures[i]);

        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, image);

        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

        stbi_image_free(image);
    }
}

// Desenha skybox 3D ao redor da cena 
void drawSkybox(float size) {
    glPushAttrib(GL_ENABLE_BIT | GL_CURRENT_BIT | GL_TEXTURE_BIT);

    glDisable(GL_LIGHTING);
    glEnable(GL_TEXTURE_2D);
    glColor3f(1.0f, 1.0f, 1.0f);

    glPushMatrix();
    glLoadIdentity();

    float half = size / 2.0f;

    // RIGHT
    glBindTexture(GL_TEXTURE_2D, skybox_textures[0]);
    glBegin(GL_QUADS);
        glTexCoord2f(0, 0); glVertex3f(half, -half, -half);
        glTexCoord2f(1, 0); glVertex3f(half, -half, half);
        glTexCoord2f(1, 1); glVertex3f(half, half, half);
        glTexCoord2f(0, 1); glVertex3f(half, half, -half);
    glEnd();

    // LEFT
    glBindTexture(GL_TEXTURE_2D, skybox_textures[1]);
    glBegin(GL_QUADS);
        glTexCoord2f(0, 0); glVertex3f(-half, -half, half);
        glTexCoord2f(1, 0); glVertex3f(-half, -half, -half);
        glTexCoord2f(1, 1); glVertex3f(-half, half, -half);
        glTexCoord2f(0, 1); glVertex3f(-half, half, half);
    glEnd();

    // TOP
    glBindTexture(GL_TEXTURE_2D, skybox_textures[2]);
    glBegin(GL_QUADS);
        glTexCoord2f(0, 0); glVertex3f(-half, half, -half);
        glTexCoord2f(1, 0); glVertex3f(half, half, -half);
        glTexCoord2f(1, 1); glVertex3f(half, half, half);
        glTexCoord2f(0, 1); glVertex3f(-half, half, half);
    glEnd();

    // BOTTOM
    glBindTexture(GL_TEXTURE_2D, skybox_textures[3]);
    glBegin(GL_QUADS);
        glTexCoord2f(0, 0); glVertex3f(-half, -half, half);
        glTexCoord2f(1, 0); glVertex3f(half, -half, half);
        glTexCoord2f(1, 1); glVertex3f(half, -half, -half);
        glTexCoord2f(0, 1); glVertex3f(-half, -half, -half);
    glEnd();

    // FRONT
    glBindTexture(GL_TEXTURE_2D, skybox_textures[4]);
    glBegin(GL_QUADS);
        glTexCoord2f(0, 0); glVertex3f(-half, -half, -half);
        glTexCoord2f(1, 0); glVertex3f(half, -half, -half);
        glTexCoord2f(1, 1); glVertex3f(half, half, -half);
        glTexCoord2f(0, 1); glVertex3f(-half, half, -half);
    glEnd();

    // BACK
    glBindTexture(GL_TEXTURE_2D, skybox_textures[5]);
    glBegin(GL_QUADS);
        glTexCoord2f(0, 0); glVertex3f(half, -half, half);
        glTexCoord2f(1, 0); glVertex3f(-half, -half, half);
        glTexCoord2f(1, 1); glVertex3f(-half, half, half);
        glTexCoord2f(0, 1); glVertex3f(half, half, half);
    glEnd();

    glPopMatrix();
    glPopAttrib(); 
}

