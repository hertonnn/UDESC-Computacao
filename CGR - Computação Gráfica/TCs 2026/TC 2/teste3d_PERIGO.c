// gcc teste3d.c src/glad.c -Iinclude -Llib -lfreeglut -lopengl32 -lglu32 -lwinmm -lgdi32 -o o3d.exe && ./o3d
#include <GL/gl.h>
#include <GL/glu.h>
#include "GL/glut.h"
#include <math.h>
#include <stdlib.h>
#include <unistd.h>

#define ESCAPE 27
#define NUM_PARTICLES 50000
#define GRAVITY 0.0003

struct s_pf {
  float x, y, z, veloc_x, veloc_y, veloc_z;
  unsigned lifetime;
} particles[NUM_PARTICLES];

int window; 
int min_angle = 80;
int angle_range = 20;
float min_velocity = 0.005;
float camera_angle = 0.0f; // Para rotacionar a câmera e ver o 3D

// Reset a single particle
void ResetParticle(int i)
{
  float velocity = min_velocity + (float)(rand() % 100)/5000.0;
  
  // Ângulo de emissão original (elevação)
  int angle = min_angle + rand() % angle_range; 
  
  // Ângulo de giro em torno do eixo Y para espalhar em 3D
  int angle_y = rand() % 360;

  // Lógica simples 3D
  // velocity é convertida usando a elevação (angle) e a rotação(angle_y)
  float horizontal_veloc = cos( (M_PI * angle/180.0) ) * velocity;
  
  particles[i].veloc_x = cos( (M_PI * angle_y/180.0) ) * horizontal_veloc;
  particles[i].veloc_z = sin( (M_PI * angle_y/180.0) ) * horizontal_veloc;
  particles[i].veloc_y = sin( (M_PI * angle/180.0) ) * velocity;
  
  particles[i].x = 0;
  particles[i].y = 0;
  particles[i].z = 0;
  
  // Usando o seu valor grande de tempo de vida 
  particles[i].lifetime = (rand() % 1000) + 100000;
}

// Initialize the firework
void InitParticle(int pause)
{
  int i;

  if(pause) usleep(200000 + rand() % 2000000);

  for(i=0;i<NUM_PARTICLES;i++) {
    particles[i].lifetime = 0; // Inativas
  }
}

/* A general OpenGL initialization function.  Sets all of the initial parameters. */
void InitGL(int Width, int Height)
{
  glClearColor(255.0f, 255.0f, 255.0f, 255.0f);		// Background branco
  glClearDepth(1.0);				// Enables Clearing Of The Depth Buffer
  glDepthFunc(GL_LESS);				// The Type Of Depth Test To Do
  glEnable(GL_DEPTH_TEST);			// Enables Depth Testing
  glShadeModel(GL_SMOOTH);			// Enables Smooth Color Shading

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();				// Reset The Projection Matrix

  gluPerspective(45.0f,(GLfloat)Width/(GLfloat)Height,0.1f,100.0f);	// Aspect Ratio

  glMatrixMode(GL_MODELVIEW);

  InitParticle(0); 
}

/* The function called when our window is resized */
void ReSizeGLScene(int Width, int Height)
{
  if (Height==0)				// Prevent A Divide By Zero
    Height=1;

  glViewport(0, 0, Width, Height);		// Reset Viewport

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();

  gluPerspective(45.0f,(GLfloat)Width/(GLfloat)Height,0.1f,100.0f);
  glMatrixMode(GL_MODELVIEW);
}

/* The main drawing function. */
void DrawGLScene()
{
  int i;
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);		
  glLoadIdentity();				

  // Posiciona a câmera e rotaciona para visualizar o ambiente 3D
  glTranslatef(0.0f, -0.5f, -4.0f);		
  glRotatef(15.0f, 1.0f, 0.0f, 0.0f);        // Dá uma leve inclinação para baixo
  glRotatef(camera_angle, 0.0f, 1.0f, 0.0f); // Rotaciona a cena no eixo Y continuamente

  camera_angle += 0.5f; // Gira a cena automaticamente

  // Gerar novas partículas continuamente (ring buffer)
  static int current_particle = 0;
  int emit_per_frame = 300; 
  for(int j = 0; j < emit_per_frame; j++) {
      ResetParticle(current_particle);
      current_particle = (current_particle + 1) % NUM_PARTICLES;
  }
	
  glPointSize(2.0f); 
  glBegin(GL_POINTS);
  for(i=0;i<NUM_PARTICLES;i++) {
    if(particles[i].lifetime > 0) {
      // Aplica gravidade no eixo Y
      particles[i].veloc_y -= GRAVITY;
      
      // Atualiza posição 3D
      particles[i].x += particles[i].veloc_x;
      particles[i].y += particles[i].veloc_y;
      particles[i].z += particles[i].veloc_z;
      
      particles[i].lifetime--;

      // Equação da esfera em 3D: x² + y² + z² = r²
      float dist_sq = (particles[i].x * particles[i].x) + 
                      (particles[i].y * particles[i].y) + 
                      (particles[i].z * particles[i].z);
      float raio = 1.0f; // Aumentei o espaço para refletir a nova perspectiva
      
      // Colisão esférica (refletindo e reduzindo levemente a energia)
      if (dist_sq >= raio * raio) {
        
        // Verifica se a partícula está se afastando e inverte o sentido (rebate na parede da esfera)
        if (particles[i].x * particles[i].veloc_x > 0) {
            particles[i].veloc_x *= -0.70f;
        }
        if (particles[i].y * particles[i].veloc_y > 0) {
            particles[i].veloc_y *= -0.70f;
        }
        if (particles[i].z * particles[i].veloc_z > 0) {
            particles[i].veloc_z *= -0.70f;
        }
      }
      
      // Desenha o pixel
      glColor3ub(0, 0, 255);
      glVertex3f(particles[i].x, particles[i].y, particles[i].z); // Passa o 3º eixo Z
    }
  }
  glEnd();

  glutSwapBuffers();
  usleep(20000);
}

/* The function called whenever a key is pressed. */
void keyPressed(unsigned char key, int x, int y) 
{
  if (key == ESCAPE) 
  { 
	glutDestroyWindow(window); 
	exit(0);                   
  }
  if (key == 'w' || key == 'W') {
    angle_range += 1;
    if (min_velocity > 0){
      min_velocity -= 0.001;
    }
  }
  else if (key == 's' || key == 'S') {
    if (angle_range != 1) {
      angle_range -= 1;
      min_velocity += 0.001;
    }
  }
}

/* Captura teclas especiais como as Setinhas do teclado */
void specialKeys(int key, int x, int y) 
{
  if (key == GLUT_KEY_LEFT) {
    min_angle += 5; 
  }
  else if (key == GLUT_KEY_RIGHT) {
    min_angle -= 5; 
  }
}

int main(int argc, char **argv) 
{  
  glutInit(&argc, argv);  
  glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_ALPHA | GLUT_DEPTH);  
  glutInitWindowSize(640, 480);  
  glutInitWindowPosition(0, 0);  
  window = glutCreateWindow("Sistema de Particulas 3D");  
  glutDisplayFunc(&DrawGLScene);  
  glutFullScreen();
  glutIdleFunc(&DrawGLScene);
  glutReshapeFunc(&ReSizeGLScene);
  glutKeyboardFunc(&keyPressed);
  glutSpecialFunc(&specialKeys); 
  InitGL(640, 480);
  glutMainLoop();  

  return 0;
}
