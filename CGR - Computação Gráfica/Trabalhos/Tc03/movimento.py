import sys
import random
import math
from OpenGL.GL import *
from OpenGL.GLUT import *
from OpenGL.GLU import *
from PIL import Image

window_width = 800
window_height = 600
num_fish = 40
max_speed = 2.5
max_force = 0.05

class Vector2D:
    def __init__(self, x=0, y=0):
        self.x = x
        self.y = y
    
    def __add__(self, other):
        return Vector2D(self.x + other.x, self.y + other.y)
    
    def __sub__(self, other):
        return Vector2D(self.x - other.x, self.y - other.y)
    
    def __mul__(self, scalar):
        return Vector2D(self.x * scalar, self.y * scalar)
    
    def __truediv__(self, scalar):
        return Vector2D(self.x / scalar, self.y / scalar)
    
    def length(self):
        return math.sqrt(self.x**2 + self.y**2)
    
    def normalize(self):
        l = self.length()
        if l > 0:
            return self / l
        return Vector2D()
    
    def limit(self, max_val):
        l = self.length()
        if l > max_val:
            return self.normalize() * max_val
        return self
    
    def distance(self, other):
        return (self - other).length()
    
    def copy(self):
        return Vector2D(self.x, self.y)
    
    def tuple(self):
        return (self.x, self.y)
    
    def angle(self):
        return math.atan2(self.y, self.x)

class Fish:
    def __init__(self):
        self.position = Vector2D(random.uniform(0, window_width), random.uniform(0, window_height))
        angle = random.uniform(0, 2*math.pi)
        self.velocity = Vector2D(math.cos(angle), math.sin(angle)) * max_speed
        self.acceleration = Vector2D()
    
    def apply_force(self, force):
        self.acceleration += force
    
    def update(self):
        self.velocity += self.acceleration
        self.velocity = self.velocity.limit(max_speed)
        self.position += self.velocity
        self.acceleration = Vector2D()
        # Wrap screen edges
        if self.position.x > window_width: self.position.x = 0
        if self.position.x < 0: self.position.x = window_width
        if self.position.y > window_height: self.position.y = 0
        if self.position.y < 0: self.position.y = window_height
    
    def seek(self, target):
        desired = (target - self.position).normalize() * max_speed
        steer = (desired - self.velocity).limit(max_force)
        return steer
    
    def separate(self, fishes):
        desired_separation = 25
        steer = Vector2D()
        count = 0
        for other in fishes:
            d = self.position.distance(other.position)
            if 0 < d < desired_separation:
                diff = (self.position - other.position).normalize()
                diff /= d
                steer += diff
                count += 1
        if count > 0:
            steer /= count
        if steer.length() > 0:
            steer = steer.normalize() * max_speed - self.velocity
            steer = steer.limit(max_force)
        return steer
    
    def align(self, fishes):
        neighbor_dist = 50
        sum_vel = Vector2D()
        count = 0
        for other in fishes:
            d = self.position.distance(other.position)
            if 0 < d < neighbor_dist:
                sum_vel += other.velocity
                count += 1
        if count > 0:
            avg = sum_vel / count
            avg = avg.normalize() * max_speed
            steer = avg - self.velocity
            return steer.limit(max_force)
        return Vector2D()
    
    def cohesion(self, fishes):
        neighbor_dist = 50
        center_mass = Vector2D()
        count = 0
        for other in fishes:
            d = self.position.distance(other.position)
            if 0 < d < neighbor_dist:
                center_mass += other.position
                count += 1
        if count > 0:
            center_mass /= count
            return self.seek(center_mass)
        return Vector2D()
    
    def avoid_obstacles(self, obstacles):
        avoid_radius = 90
        steer = Vector2D()
        for obs in obstacles:
            d = self.position.distance(obs)
            if d < avoid_radius:
                diff = (self.position - obs).normalize()
                diff = diff * (avoid_radius - d) * 0.6
                steer += diff
        return steer.limit(max_force * 3)

    def run(self, fishes, obstacles):
        sep = self.separate(fishes) * 1.7
        ali = self.align(fishes) * 1.0
        coh = self.cohesion(fishes) * 1.0
        avoid = self.avoid_obstacles(obstacles) * 2.0
        self.apply_force(sep)
        self.apply_force(ali)
        self.apply_force(coh)
        self.apply_force(avoid)
        self.update()

def draw_fish(fish):
    pos = fish.position
    vel = fish.velocity
    angle = vel.angle()

    size = 10
    glPushMatrix()
    glTranslatef(pos.x, pos.y, 0)
    glRotatef(math.degrees(angle), 0, 0, 1)

    # Corpo laranja (base)
    glBegin(GL_TRIANGLES)
    glColor3f(1.0, 0.5, 0.0)  # Laranja
    glVertex2f(size, 0)
    glVertex2f(-size * 0.5, size * 0.4)
    glVertex2f(-size * 0.5, -size * 0.4)
    glEnd()

    # Faixa branca (triângulo menor central)
    glBegin(GL_TRIANGLES)
    glColor3f(1.0, 1.0, 1.0)  # Branco
    glVertex2f(-size * 0.1, size * 0.25)
    glVertex2f(-size * 0.3, 0)
    glVertex2f(-size * 0.1, -size * 0.25)
    glEnd()

    # Faixa preta fina (uma linha ou triângulo muito estreito perto da branca)
    glBegin(GL_TRIANGLES)
    glColor3f(0.0, 0.0, 0.0)  # Preto
    glVertex2f(-size * 0.15, size * 0.20)
    glVertex2f(-size * 0.25, 0)
    glVertex2f(-size * 0.15, -size * 0.20)
    glEnd()

    glPopMatrix()


# Função para desenhar o tubarão estilizado
def draw_shark(pos):
    size = 40  # tamanho do tubarão
    
    glPushMatrix()
    glTranslatef(pos.x, pos.y, 0)

    # Corpo - elipse alongada
    glColor3f(0.2, 0.2, 0.7)  # azul escuro
    glBegin(GL_POLYGON)
    for i in range(50):
        angle = 2 * math.pi * i / 50
        x = math.cos(angle) * size * 1.5
        y = math.sin(angle) * size * 0.7
        glVertex2f(x, y)
    glEnd()

    # Nadadeira dorsal (triângulo)
    glColor3f(0.1, 0.1, 0.5)
    glBegin(GL_TRIANGLES)
    glVertex2f(-size * 0.3, size * 0.7)
    glVertex2f(0, size * 1.3)
    glVertex2f(size * 0.3, size * 0.7)
    glEnd()

    # Cauda (triângulo)
    glColor3f(0.1, 0.1, 0.5)
    glBegin(GL_TRIANGLES)
    glVertex2f(size * 1.5, 0)
    glVertex2f(size * 2.0, size * 0.5)
    glVertex2f(size * 2.0, -size * 0.5)
    glEnd()

    # Olho (círculo branco + preto)
    glColor3f(1, 1, 1)
    eye_x = -size * 0.8
    eye_y = size * 0.2
    radius_eye = size * 0.2
    glBegin(GL_TRIANGLE_FAN)
    glVertex2f(eye_x, eye_y)
    for i in range(20):
        angle = 2 * math.pi * i / 20
        glVertex2f(eye_x + math.cos(angle)*radius_eye, eye_y + math.sin(angle)*radius_eye)
    glEnd()

    glColor3f(0, 0, 0)
    radius_pupil = radius_eye * 0.5
    glBegin(GL_TRIANGLE_FAN)
    glVertex2f(eye_x, eye_y)
    for i in range(20):
        angle = 2 * math.pi * i / 20
        glVertex2f(eye_x + math.cos(angle)*radius_pupil, eye_y + math.sin(angle)*radius_pupil)
    glEnd()

    glPopMatrix()

def load_texture(path):
    img = Image.open(path).transpose(Image.FLIP_TOP_BOTTOM)
    img_data = img.convert("RGBA").tobytes()
    width, height = img.size

    tex_id = glGenTextures(1)
    glBindTexture(GL_TEXTURE_2D, tex_id)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, img_data)
    glBindTexture(GL_TEXTURE_2D, 0)
    return tex_id

def draw_background():
    glEnable(GL_TEXTURE_2D)
    glBindTexture(GL_TEXTURE_2D, background_texture)
    glColor3f(1, 1, 1)
    glBegin(GL_QUADS)
    glTexCoord2f(0, 0)
    glVertex2f(0, 0)
    glTexCoord2f(1, 0)
    glVertex2f(window_width, 0)
    glTexCoord2f(1, 1)
    glVertex2f(window_width, window_height)
    glTexCoord2f(0, 1)
    glVertex2f(0, window_height)
    glEnd()
    glBindTexture(GL_TEXTURE_2D, 0)
    glDisable(GL_TEXTURE_2D)

fishes = []
obstacles = []

def display():
    glClear(GL_COLOR_BUFFER_BIT)
    draw_background()

    for fish in fishes:
        fish.run(fishes, obstacles)
        draw_fish(fish)

    for obs in obstacles:
        draw_shark(obs)

    glutSwapBuffers()

def reshape(w, h):
    global window_width, window_height
    window_width = w
    window_height = h
    glViewport(0, 0, w, h)
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    gluOrtho2D(0, w, 0, h)
    glMatrixMode(GL_MODELVIEW)
    glLoadIdentity()

def timer(v):
    glutPostRedisplay()
    glutTimerFunc(16, timer, 1)

def main():
    global fishes, obstacles, background_texture

    glutInit(sys.argv)
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA)
    glutInitWindowSize(window_width, window_height)
    glutCreateWindow("Peixes com Boids".encode('utf-8'))


    glClearColor(0, 0, 0, 1)

    # Load background texture (água)
    background_texture = load_texture("agua.jpg")

    fishes = [Fish() for _ in range(num_fish)]

    # Obstáculos (tubarões) em posições fixas
    obstacles = [
        Vector2D(window_width * 0.3, window_height * 0.5),
        Vector2D(window_width * 0.7, window_height * 0.3)
    ]

    glutDisplayFunc(display)
    glutReshapeFunc(reshape)
    glutTimerFunc(16, timer, 1)

    glEnable(GL_BLEND)
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)

    glutMainLoop()

if __name__ == "__main__":
    main()
