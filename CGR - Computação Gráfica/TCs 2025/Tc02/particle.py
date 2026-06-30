from OpenGL.GL import *
from OpenGL.GLUT import *
from OpenGL.GLU import *
import random

NUM_PARTICLES = 800
particles = []
WIND_DIRECTION = 0.02  

class Raindrop:
    def __init__(self):
        self.reset()

    def reset(self):
        self.x = random.uniform(-3.5, 2.0)
        self.y = random.uniform(1.0, 2.5)
        self.z = random.uniform(-1.5, 1.5)
        self.vy = random.uniform(0.02, 0.05)
        self.length = random.uniform(0.05, 0.1)

    def update(self):
        self.y -= self.vy
        self.x += WIND_DIRECTION * 0.5  
        if self.y < -1.5:
            self.reset()

def init_particles():
    global particles
    particles = [Raindrop() for _ in range(NUM_PARTICLES)]

def draw_particle(p):
    glColor4f(0.7, 0.8, 1.0, 0.6)  
    glBegin(GL_LINES)
    glVertex3f(p.x, p.y, p.z)
    glVertex3f(p.x + WIND_DIRECTION, p.y + p.length, p.z)
    glEnd()

def display():
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    glLoadIdentity()
    glTranslatef(0.0, 0.0, -4.0)

    for p in particles:
        p.update()
        draw_particle(p)

    glutSwapBuffers()

def timer(value):
    glutPostRedisplay()
    glutTimerFunc(16, timer, 0)

def reshape(w, h):
    glViewport(0, 0, w, h)
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    gluPerspective(45.0, float(w)/float(h), 0.1, 50.0)
    glMatrixMode(GL_MODELVIEW)

def main():
    glutInit()
    glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH)
    glutInitWindowSize(800, 600)
    glutCreateWindow("Efeito de Chuva com Partículas".encode())

    glEnable(GL_BLEND)
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
    glClearColor(0.0, 0.0, 0.0, 1.0)

    init_particles()
    glutDisplayFunc(display)
    glutReshapeFunc(reshape)
    glutTimerFunc(0, timer, 0)
    glutMainLoop()

if __name__ == "__main__":
    main()
