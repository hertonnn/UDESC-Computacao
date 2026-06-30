// gcc snowman_sdl.c -lGL -lGLU -lSDL -lm -o snowman_sdl && ./snowman_sdl
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include <SDL/SDL.h>

/* screen width, height, and bit depth */
#define SCREEN_WIDTH  800
#define SCREEN_HEIGHT 600
#define SCREEN_BPP     16

/* This is our SDL surface */
SDL_Surface *surface;

/* Snowman's Rotation */
static GLfloat yRot = 0.0f;

/* function to release/destroy our resources and restoring the old desktop */
void Quit( int returnCode )
{
    SDL_Quit( );
    exit( returnCode );
}

/* function to reset our viewport after a window resize */
void resizeWindow( int w, int h )
{
    GLfloat fAspect;  
  
    // Prevent a divide by zero  
    if(h == 0)  
        h = 1;  
  
    // Set Viewport to window dimensions  
    glViewport(0, 0, w, h);  
  
    fAspect = (GLfloat)w/(GLfloat)h;  
  
    // Reset coordinate system  
    glMatrixMode(GL_PROJECTION);  
    glLoadIdentity();  
  
    // Produce the perspective projection  
    gluPerspective(35.0f, fAspect, 1.0, 40.0);  
  
    glMatrixMode(GL_MODELVIEW);  
    glLoadIdentity();  
}

/* function to handle key press events */
int handleKeyPress()
{
    SDL_Event event;
    SDL_PollEvent(&event);
    if((event.type == SDL_QUIT) || (event.key.keysym.sym == SDLK_ESCAPE))
        return 0;

    if( event.type == SDL_VIDEORESIZE) {
        resizeWindow( event.resize.w, event.resize.h );
    }
  
    Uint8 *keyState = SDL_GetKeyState(NULL);
    if(keyState[SDLK_LEFT]) {
        yRot = (GLfloat)((const int)(yRot-5.0f) % 360);
    } else if(keyState[SDLK_RIGHT]) {
        yRot = (GLfloat)((const int)(yRot+5.0f) % 360);
    }
    return 1;
}

/* general OpenGL initialization function */
void initGL( GLvoid )
{
    // Light values and coordinates  
    GLfloat  whiteLight[] = { 0.05f, 0.05f, 0.05f, 1.0f };  
    GLfloat  sourceLight[] = { 0.25f, 0.25f, 0.25f, 1.0f };  
    GLfloat  lightPos[] = { -10.f, 5.0f, 5.0f, 1.0f };  
  
    glEnable(GL_DEPTH_TEST);    // Hidden surface removal  
    glFrontFace(GL_CCW);        // Counter clock-wise polygons face out  
    glEnable(GL_CULL_FACE);     // Do not calculate inside  
  
    // Enable lighting  
    glEnable(GL_LIGHTING);  
  
    // Setup and enable light 0  
    glLightModelfv(GL_LIGHT_MODEL_AMBIENT,whiteLight);  
    glLightfv(GL_LIGHT0,GL_AMBIENT,sourceLight);  
    glLightfv(GL_LIGHT0,GL_DIFFUSE,sourceLight);  
    glLightfv(GL_LIGHT0,GL_POSITION,lightPos);  
    glEnable(GL_LIGHT0);  
  
    // Enable color tracking  
    glEnable(GL_COLOR_MATERIAL);  
      
    // Set Material properties to follow glColor values  
    glColorMaterial(GL_FRONT, GL_AMBIENT_AND_DIFFUSE);  
  
    // Black blue background  
    glClearColor(0.25f, 0.25f, 0.50f, 1.0f);  
}

/* Here goes our drawing code */
void drawGLScene( GLvoid )
{
    GLUquadricObj *pObj;    // Quadric Object  
      
    // Clear the window with current clearing color  
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);  
  
    // Save the matrix state and do the rotations  
    glPushMatrix();

    // Move object back and do in place rotation  
    glTranslatef(0.0f, -1.0f, -5.0f);  
    glRotatef(yRot, 0.0f, 1.0f, 0.0f);  

    // Draw something  
    pObj = gluNewQuadric();  
    gluQuadricNormals(pObj, GLU_SMOOTH);  

    // white
    glColor3f(1.0f, 1.0f, 1.0f);  

    // Main Body  
//    gluSphere();  // Bottom

    // Mid section
//    glPushMatrix();
//        glTranslatef(); 
//        gluSphere();
//    glPopMatrix();

    // Head
    glPushMatrix(); // save transform matrix state
        glTranslatef(0.0f, 1.0f, 0.0f);
        gluSphere(pObj, 0.24f, 26, 13);
    glPopMatrix(); // restore transform matrix state

    // Nose (orange)
    glColor3f(1.0f, 0.4f, 0.51f);  
    glPushMatrix();
        glTranslatef(0.0f, 1.0f, 0.2f);
        gluCylinder(pObj, 0.04f, 0.0f, 0.3f, 26, 13);  
    glPopMatrix();  

    // Eyes (black)
// glColor, glPushMatrix,...

    // Hat

    // Hat brim
          
    // Restore the matrix state  
    glPopMatrix();  
}

int main( int argc, char **argv )
{
    int done = 0;
    SDL_Event event;
    SDL_Init(SDL_INIT_VIDEO);
    SDL_SetVideoMode(SCREEN_WIDTH, SCREEN_HEIGHT, 0, SDL_OPENGL | SDL_HWSURFACE );
    glViewport(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

    /* resize the initial window */
    resizeWindow( SCREEN_WIDTH, SCREEN_HEIGHT );

    /* initialize OpenGL */
    initGL( );

    /* wait for events */
    while ( handleKeyPress() ) {
        /* draw the scene */
        drawGLScene( );
        SDL_GL_SwapBuffers();
    }

    Quit(0);
    return 0;
}

