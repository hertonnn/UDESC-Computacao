// gcc fireworks_glfw.c -lglfw -lGL -lGLU -lm -o fireworks_glfw && ./fireworks_glfw
#define GLFW_INCLUDE_NONE
#include <stdio.h>
#include <stdlib.h>
#include <GLFW/glfw3.h>  // Header File For The GLFW Library
#include <GL/gl.h>       // Header File For The OpenGL32 Library
#include <GL/glu.h>      // Header File For The GLu32 Library
#include <math.h>
#include <unistd.h>

void processInput(GLFWwindow *window);

// settings
#define SCREEN_WIDTH  640
#define SCREEN_HEIGHT 480

/* for the particles */
#define NUM_PARTICLES 3000
#define GRAVITY 0.0003

struct s_pf {
  float x, y, veloc_x, veloc_y;
  unsigned lifetime;
} particles[NUM_PARTICLES];

// Initialize the firework
void InitParticle(int pause)
{
  int i;

  if(pause) usleep(200000 + rand() % 2000000);

  for(i=0;i<NUM_PARTICLES;i++) {
    float velocity = (float)(rand() % 100)/5000.0;
    int angle = rand() % 360;
    particles[i].veloc_x = cos( (M_PI * angle/180.0) ) * velocity;
    particles[i].veloc_y = sin( (M_PI * angle/180.0) ) * velocity;
    particles[i].x = 0.0;
    particles[i].y = 0.0;
    particles[i].lifetime = rand() % 100;
  }
}

/* function to reset our viewport after a window resize */
void resizeWindow(GLFWwindow* window, int width, int height )
{
    GLfloat ratio;
    if ( height == 0 ) height = 1;
    ratio = ( GLfloat )width / ( GLfloat )height;
    glViewport( 0, 0, ( GLsizei )width, ( GLsizei )height );
    glMatrixMode( GL_PROJECTION );
    glLoadIdentity( );
    gluPerspective( 45.0f, ratio, 0.1f, 100.0f );
    glMatrixMode( GL_MODELVIEW );
    glLoadIdentity( );
    glTranslatef(0.0f,0.0f,-6.0f);        // Move particles 6.0 units into the screen
}

/* function to handle key press events */
void handleKeyPress(GLFWwindow *window)
{
    if(glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
        glfwTerminate();
        exit(EXIT_SUCCESS);
    }
}

/* Here goes our drawing code */
void drawGLScene(GLFWwindow* window)
{
    int i, ative_particles=0;

    /* Clear The Screen And The Depth Buffer */
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );

    /* Draw points of the firework */
    glBegin(GL_POINTS);
    for(i=0;i<NUM_PARTICLES;i++) {
        if(particles[i].lifetime) {
            ative_particles++;
            particles[i].veloc_y -= GRAVITY;
            particles[i].x += particles[i].veloc_x;
            particles[i].y += particles[i].veloc_y;
            particles[i].lifetime--;

            glVertex3f( particles[i].x, particles[i].y, 0.0f); // draw pixel
        }
    }
    glEnd();

    if(!ative_particles) {
        glfwSwapBuffers(window);
        InitParticle(1); // reset particles
    }

    usleep(100);
}

int main()
{
    // glfw: initialize and configure
    // ------------------------------
    glfwInit();

    // glfw window creation
    // --------------------
    GLFWwindow* window = glfwCreateWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Fireworks", NULL, NULL);
    if (window == NULL)
    {
        fprintf(stderr, "Failed to open GLFW window\n");
        glfwTerminate();
        return -1;
    }

    glfwMakeContextCurrent(window);
    glfwSetFramebufferSizeCallback(window, resizeWindow);
    glfwSwapInterval(1);
    
    InitParticle(0); // first firework

    // Ensure we can capture the escape key being pressed below
    glfwSetInputMode(window, GLFW_STICKY_KEYS, GL_TRUE);

    resizeWindow(window, SCREEN_WIDTH, SCREEN_HEIGHT);


    // render loop
    while (!glfwWindowShouldClose(window))
    {
        // input
        handleKeyPress(window);

        // render
        drawGLScene(window);

        // glfw: swap buffers and poll IO events (keys pressed/released, mouse moved etc.)
        // -------------------------------------------------------------------------------
        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    // glfw: terminate, clearing all previously allocated GLFW resources.
    glfwTerminate();
    return 0;
}

