// gcc robot_glut.c -lglut -lGL -lGLU -o robot_glut
#include <GL/glut.h>
#include <stdlib.h>

int shoulder = 0, elbow = 0;

void init(void) 
{
   glClearColor(0.0, 0.0, 0.0, 1.0);
   glOrtho (0, 640, 0, 480, -1 ,1);
}

void display(void)
{
   glClear (GL_COLOR_BUFFER_BIT);
   glColor3f (1.0, 1.0, 1.0);
   glPushMatrix();
     glTranslatef (-1.0, 0.0, 0.0);
     glRotatef ((GLfloat) shoulder, 0.0, 0.0, 1.0);
     glTranslatef (1.0, 0.0, 0.0);
     glBegin(GL_QUADS);
       glVertex2f(1.0, 0.1);
       glVertex2f(1.0, -0.1);
       glVertex2f(-1.0, -0.1);
       glVertex2f(-1.0, 0.1);
     glEnd();

     glPushMatrix();
       glTranslatef (1.0, 0.0, 0.0);
       glRotatef ((GLfloat) elbow, 0.0, 0.0, 1.0);
       glTranslatef (1.0, 0.0, 0.0);
       glBegin(GL_QUADS);
         glVertex2f(1.0, 0.1);
         glVertex2f(1.0, -0.1);
         glVertex2f(-1.0, -0.1);
         glVertex2f(-1.0, 0.1);
       glEnd();
     glPopMatrix();
   glPopMatrix();
   glutSwapBuffers();
}

void reshape (int w, int h)
{
   glViewport (0, 0, (GLsizei) w, (GLsizei) h); 
   glMatrixMode (GL_PROJECTION);
   glLoadIdentity ();
   gluPerspective(65.0, (GLfloat) w/(GLfloat) h, 1.0, 20.0);
   glMatrixMode(GL_MODELVIEW);
   glLoadIdentity();
   glTranslatef (0.0, 0.0, -5.0);
}

void keyboard (unsigned char key, int x, int y)
{
   switch (key) {
      case 's':
      case 'S':
         shoulder = (shoulder - 5) % 360;
         glutPostRedisplay();
         break;
      case 'e':
      case 'E':
         elbow = (elbow - 5) % 360;
         glutPostRedisplay();
         break;
      case 'q':
      case 'Q':
      case 27:
         exit(0);
         break;
      default:
         break;
   }
}

int main(int argc, char** argv)
{
   glutInit(&argc, argv);
   glutInitDisplayMode (GLUT_DOUBLE | GLUT_RGB);
   glutInitWindowSize (640, 480); 
   glutInitWindowPosition (100, 100);
   glutCreateWindow (argv[0]);
   init ();
   glutDisplayFunc(display); 
   glutReshapeFunc(reshape);
   glutKeyboardFunc(keyboard);
   glutMainLoop();
   return 0;
}
