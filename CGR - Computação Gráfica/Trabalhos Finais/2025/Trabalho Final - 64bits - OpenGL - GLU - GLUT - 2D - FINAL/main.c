// gcc main.c src/glad.c -Iinclude -Llib -lfreeglut -lopengl32 -lglu32 -lwinmm -lgdi32 -o teste.exe
#include <GL/glut.h>
#include <stdio.h>
#include <GL/gl.h>
#include <time.h>
#include <stdlib.h>


#define COLUMNS 40
#define ROWS 40


#define FPS 10


#define UP 1
#define DOWN -1
#define RIGHT 2
#define LEFT -2


#define MAX 200


short sDireection = RIGHT;
int gameOver = 0;
int score = 0;


int gridX, gridY;
int posX[200] = {20, 20, 20, 20, 20}, posY[200] = {20, 19, 18, 17, 16};
int snake_length = 5;


int food = 0;
int foodX, foodY;


void display_callback();
void init();
void reshape_callback(int, int);
void initGrid(int x, int y);
void grawGrid();
void unitGrawGrid(int x, int y);
void timer_callbck(int);
void keyboard_callback(int, int, int);
void drawSnake();
void drawFood();
void random(int *x, int *y);


int main(int argc, char **argv){
   
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE);


    int screen_width = GetSystemMetrics(SM_CXSCREEN);
    int screen_height = GetSystemMetrics(SM_CYSCREEN);
    int WinposX = (screen_width - 500) / 2;
    int WinposY = (screen_height - 500) / 2;
    glutInitWindowPosition(WinposX, WinposY);


    glutInitWindowSize(500, 500);
    glutCreateWindow("Snake Game");
    glutDisplayFunc(display_callback);
    glutReshapeFunc(reshape_callback);
    glutTimerFunc(0, timer_callbck, 0);
    glutSpecialFunc(keyboard_callback);
    init();
    glutMainLoop();


    return 0;
}


void display_callback(){


    glClear(GL_COLOR_BUFFER_BIT);
    grawGrid();
    drawSnake();
    drawFood();
    glutSwapBuffers();


    if(gameOver == 1){
        char _score[10];
        itoa(score, _score, 10);
        char text[50] = "Your score: ";
        strcat(text, _score);
        MessageBox(NULL, text, "Game Over", 0);
        exit(0);
    }


}


void init(){
   
    glClearColor(81.0f / 255.0f, 137.0f / 255.0f, 92.0f / 255.0f, 0.87f);
    initGrid(COLUMNS, ROWS);
}


void reshape_callback(int w, int h){
   
    glViewport(0, 0, (GLsizei)w, (GLsizei)h);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrtho(0.0, COLUMNS, 0.0, ROWS, -1.0, 1.0);
    glMatrixMode(GL_MODELVIEW);
}


void initGrid(int x, int y){
   
    gridX = x;
    gridY = y;
}


void grawGrid(){


    for(int x = 0; x < gridX; x++){
        for(int y = 0; y < gridY; y++){
            unitGrawGrid(x,y);
        }
    }
}


void unitGrawGrid(int x, int y){
   
    if(x == 0 || y == 0 || x == gridX - 1 || y == gridY - 1){


        float margin = 0.1f;
       
        glColor4f(62.0f / 255.0f, 46.0f / 255.0f, 41.0f / 255.0f, 0.87f);
        glBegin(GL_QUADS);
            glVertex2f(x + margin, y + margin);
            glVertex2f(x + 1 - margin, y + margin);
            glVertex2f(x + 1 - margin, y + 1 - margin);
            glVertex2f(x + margin, y + 1 - margin);
        glEnd();
    } else{


        glLineWidth(1.0);
        glColor4f(41.0f / 255.0f, 75.0f / 255.0f, 48.0f / 255.0f, 0.87f);
    }


    glBegin(GL_LINE_LOOP);
        glVertex2f(x, y);
        glVertex2f(x + 1, y);
        glVertex2f(x + 1, y + 1);
        glVertex2f(x, y + 1);
    glEnd();
}


void timer_callbck(int){
   
    glutPostRedisplay();
    glutTimerFunc(1000 / FPS, timer_callbck, 0);
}


void keyboard_callback(int key, int, int){
   
    switch(key){
        case GLUT_KEY_UP:
            if(sDireection != DOWN){
                sDireection = UP;  
            }
            break;
        case GLUT_KEY_DOWN:
            if(sDireection != UP){
                sDireection = DOWN;
            }
            break;
        case GLUT_KEY_RIGHT:
            if(sDireection != LEFT){
                sDireection = RIGHT;
            }
            break;
        case GLUT_KEY_LEFT:
            if(sDireection != RIGHT){
                sDireection = LEFT;
            }
            break;
    }


}


void drawSnake(){
   
    for(int i = snake_length - 1; i > 0; i--){
        posX[i] = posX[i - 1];
        posY[i] = posY[i - 1];
    }


    if(sDireection == UP){
        posY[0]++;
    } else if(sDireection == DOWN){
        posY[0]--;
    } else if(sDireection == RIGHT){
        posX[0]++;
    } else if(sDireection == LEFT){
        posX[0]--;
    }


    for(int i = 0; i < snake_length; i++){
        if(i == 0){
           glColor4f(45.0f / 255.0f, 6.0f / 255.0f, 51.0f / 255.0f, 0.87f);
           glRectd(posX[i], posY[i], posX[i] + 1, posY[i] + 1);
        } else{
            glColor4f(115.0f / 255.0f, 24.0f / 255.0f, 124.0f / 255.0f, 0.87f);
            glRectd(posX[i], posY[i], posX[i] + 1, posY[i] + 1);
        }
    }


    if(posX[0] == 0 || posX[0] == gridX - 1 || posY[0] == 0 || posY[0] == gridY - 1){
        gameOver = 1;
    }


    for(int i = 1; i < snake_length; i++){
        if(posX[0] == posX[i] && posY[0] == posY[i]){
            gameOver = 1;
            break;
        }
    }


    if(posX[0] == foodX && posY[0] == foodY){
        score++;
        snake_length ++;
        if(snake_length > MAX){
            snake_length = MAX;
        }
        food = 0;
    }
}


void drawFood(){
   
    if(food == 0){
        random(&foodX, &foodY);
    }


    food = 1;


    glColor4f(191.0f / 255.0f, 68.0f / 255.0f, 68.0f / 255.0f, 0.87f);
    glRectf(foodX, foodY, foodX + 1, foodY + 1);
}


void random(int *x, int *y){


    int maxX = gridX - 2;
    int maxY = gridY - 2;
    int min = 1;
    srand(time(NULL));
    *x = min + rand () % (maxX - min);
    *y = min + rand () % (maxY - min);
}
// gcc main.c src/glad.c -Iinclude -Llib -lfreeglut -lopengl32 -lglu32 -lwinmm -lgdi32 -o teste.exe


