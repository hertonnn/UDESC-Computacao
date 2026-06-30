// gcc fireworks_glut.c src/glad.c -Iinclude -Llib -lfreeglut -lopengl32 -lglu32 -lwinmm -lgdi32 -o o.exe && ./o
#include <GL/gl.h>	  // Header File For The OpenGL32 Library
#include <GL/glu.h>	  // Header File For The GLu32 Library
#include "GL/glut.h" // Header File For The GLUT Library 
#include <math.h>
#include <unistd.h>

#define ESCAPE 27
#define NUM_PARTICLES 50000
#define GRAVITY 0.0003

struct s_pf {
  float x, y, veloc_x, veloc_y;
  unsigned lifetime;
} particles[NUM_PARTICLES];

int window; 
int min_angle = 80;
int angle_range = 20;
float intensity_x = 0;
float intensity_y = 0;
float min_velocity = 0.005;

// Reset a single particle
void ResetParticle(int i)
{
  float velocity = min_velocity + (float)(rand() % 100)/5000.0;
  
  // O ângulo de 360 faz emitir para todos os lados.
  // Para jorrar como um chafariz (para cima), use algo como: int angle = 45 + rand() % 90;
  int angle = min_angle + rand() % angle_range; 

  particles[i].veloc_x = cos( (M_PI * angle/180.0) ) * velocity;
  particles[i].veloc_y = sin( (M_PI * angle/180.0) ) * velocity;
  particles[i].x = 0;
  particles[i].y = 0;
  particles[i].lifetime = (rand() % 100000) + 1000;
}

// Initialize the firework
void InitParticle(int pause)
{
  int i;

  if(pause) usleep(200000 + rand() % 2000000);

  for(i=0;i<NUM_PARTICLES;i++) {
    particles[i].lifetime = 0;
  }
}

/* A general OpenGL initialization function.  Sets all of the initial parameters. */
void InitGL(int Width, int Height)
{
  glClearColor(255.0f, 255.0f, 255.0f, 255.0f);		// This Will Clear The Background Color To Black
  glClearDepth(1.0);				// Enables Clearing Of The Depth Buffer
  glDepthFunc(GL_LESS);				// The Type Of Depth Test To Do
  glEnable(GL_DEPTH_TEST);			// Enables Depth Testing
  glShadeModel(GL_SMOOTH);			// Enables Smooth Color Shading

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();				// Reset The Projection Matrix

  gluPerspective(45.0f,(GLfloat)Width/(GLfloat)Height,0.1f,100.0f);	// Calculate The Aspect Ratio Of The Window

  glMatrixMode(GL_MODELVIEW);

  InitParticle(0); // first firework
}

/* The function called when our window is resized (which shouldn't happen, because we're fullscreen) */
void ReSizeGLScene(int Width, int Height)
{
  if (Height==0)				// Prevent A Divide By Zero If The Window Is Too Small
    Height=1;

  glViewport(0, 0, Width, Height);		// Reset The Current Viewport And Perspective Transformation

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();

  gluPerspective(10.0f,(GLfloat)Width/(GLfloat)Height,0.1f,100.0f);
  glMatrixMode(GL_MODELVIEW);
}

/* The main drawing function. */
void DrawGLScene()
{
  int i;
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);		// Clear The Screen And The Depth Buffer
  glLoadIdentity();				// Reset The View

  glTranslatef(0.0f,0.0f,-6.0f);		// Move particles 6.0 units into the screen

  // --- MANGUEIRA ---
  glPushMatrix();
  
  // Iluminação temporária para dar volume à mangueira
  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
  glEnable(GL_COLOR_MATERIAL);
  glColorMaterial(GL_FRONT, GL_AMBIENT_AND_DIFFUSE);
  GLfloat light_pos[] = { 5.0f, 5.0f, 5.0f, 0.0f }; // Luz direcional 
  glLightfv(GL_LIGHT0, GL_POSITION, light_pos);

  // A mangueira vem de baixo, trazida para a origem onde as partículas jorram
  glRotatef(-60.0f, 1.0f, 0.0f, 0.0f); // Levanta o bico (inclina o Z local para cima/frente)
  glRotatef(20.0f, 0.0f, 1.0f, 0.0f);  // Dá uma quebrada de lado

  // Transladar para trás no Z local para que a ponta termine exatamente na origem
  glTranslatef(0.0f, 0.0f, -4.0f);

  GLUquadricObj *quadratic = gluNewQuadric();
  gluQuadricNormals(quadratic, GLU_SMOOTH);

  // Corpo da mangueira
  glColor3f(0.1f, 0.6f, 0.1f); // Verde
  gluCylinder(quadratic, 0.02f, 0.01f, 3.8f, 32, 32); 

  // Bico dourado/metálico da mangueira na ponta
  glTranslatef(0.0f, 0.0f, 3.8f); 
  glColor3f(0.8f, 0.6f, 0.1f); // Dourado
  gluCylinder(quadratic, 0.011f, 0.008f, 0.2f, 32, 32);

  gluDeleteQuadric(quadratic);
  
  // Limpar os estados
  glDisable(GL_LIGHTING);
  glDisable(GL_LIGHT0);
  glPopMatrix();
  // -----------------

  // Gerar novas partículas continuamente (ring buffer)
  static int current_particle = 0;
  int emit_per_frame = 300; 
  for(int j = 0; j < emit_per_frame; j++) {
      ResetParticle(current_particle);
      current_particle = (current_particle + 1) % NUM_PARTICLES;
  }
	
  glPointSize(1.0f); 
  glBegin(GL_POINTS);
  for(i=0;i<NUM_PARTICLES;i++) {
      if (particles[i].veloc_y != 0){
        particles[i].veloc_y -= GRAVITY;
      }
      else{
        particles[i].veloc_y -= GRAVITY;
      }
      particles[i].x += particles[i].veloc_x;
      particles[i].y += particles[i].veloc_y;
      particles[i].lifetime--;

      // equação da circunferência: x² + y² = raio²
      float dist_sq = (particles[i].x * particles[i].x) + (particles[i].y * particles[i].y);
      float raio = 0.4f; 
      
      // parede imaginária 
      /*
      if (particles[i].x > 0.5){

        particles[i].veloc_x = -0.70 * particles[i].veloc_x;
      }
    */ 
    
      if (dist_sq >= raio * raio) {
          
        // inverte o X se bater na borda
        if (particles[i].y < 0 && particles[i].veloc_y < 0) {
          particles[i].veloc_y = -0.70 * particles[i].veloc_y;
          if (fabs(particles[i].veloc_y) < 0.001) particles[i].veloc_y = 0;
        }
        else if (particles[i].y > 0 && particles[i].veloc_y > 0) {
            particles[i].veloc_y = -0.70 * particles[i].veloc_y;
            if (fabs(particles[i].veloc_y) < 0.001) particles[i].veloc_y = 0;
        }
        else if (particles[i].x < 0 && particles[i].veloc_x < 0) {
            particles[i].veloc_x = -0.70 * particles[i].veloc_x;
            if (fabs(particles[i].veloc_x) < 0.001) particles[i].veloc_x = 0;
        }
        else if (particles[i].x > 0 && particles[i].veloc_x > 0) {
            particles[i].veloc_x = -0.70 * particles[i].veloc_x;
            if (fabs(particles[i].veloc_x) < 0.001) particles[i].veloc_x = 0;
        }
      }
      
      
      glColor3ub(0, 0, 255);
      glVertex3f(particles[i].x, particles[i].y, 0.0f); // draw pixel
  }
  glEnd();

  // swap buffers to display, since we're double buffered.
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
    min_angle += 5; // Aumentar o ângulo move o jato para a esquerda
  }
  else if (key == GLUT_KEY_RIGHT) {
    min_angle -= 5; // Diminuir o ângulo move o jato para a direita
  }
}

int main(int argc, char **argv) 
{  
  glutInit(&argc, argv);  
  glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_ALPHA | GLUT_DEPTH);  
  glutInitWindowSize(640, 480);  
  glutInitWindowPosition(0, 0);  
  window = glutCreateWindow("Fogos de artificio");  
  glutDisplayFunc(&DrawGLScene);  
  glutFullScreen();
  glutIdleFunc(&DrawGLScene);
  glutReshapeFunc(&ReSizeGLScene);
  glutKeyboardFunc(&keyPressed);
  glutSpecialFunc(&specialKeys); // Registrando teclas especiais
  InitGL(640, 480);
  glutMainLoop();  

  return 0;
}

