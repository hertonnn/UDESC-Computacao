import pygame
from pygame.locals import *
from OpenGL.GL import *
from OpenGL.GLU import *

def load_texture(image_path):
    texture_surface = pygame.image.load(image_path)
    texture_data = pygame.image.tostring(texture_surface, "RGB", True)
    width, height = texture_surface.get_rect().size

    texture_id = glGenTextures(1)
    glBindTexture(GL_TEXTURE_2D, texture_id)
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
    
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, texture_data)
    
    return texture_id

def load_obj(filename):
    vertices = []
    texcoords = []
    faces = []

    with open(filename, "r") as f:
        for line in f:
            if line.startswith("v "):
                parts = line.strip().split()[1:]
                vertices.append(list(map(float, parts)))
            elif line.startswith("vt "):
                parts = line.strip().split()[1:]
                texcoords.append(list(map(float, parts)))
            elif line.startswith("f "):
                face = []
                parts = line.strip().split()[1:]
                for part in parts:
                    v, t = part.split("/")[:2]
                    face.append((int(v) - 1, int(t) - 1))
                faces.append(face)
    
    return vertices, texcoords, faces

def draw_obj(vertices, texcoords, faces):
    glBegin(GL_TRIANGLES)
    for face in faces:
        for vertex_index, tex_index in face:
            glTexCoord2fv(texcoords[tex_index])
            glVertex3fv(vertices[vertex_index])
    glEnd()

def main():
    pygame.init()
    screen = pygame.display.set_mode((800, 600), DOUBLEBUF | OPENGL)
    pygame.display.set_caption("Camisa OpenGL")

    glEnable(GL_DEPTH_TEST)
    glEnable(GL_TEXTURE_2D)

    texture_id = load_texture("color.jpg")
    vertices, texcoords, faces = load_obj("shirt.obj")

    glMatrixMode(GL_PROJECTION)
    gluPerspective(40, (800/600), 0.1, 100.0)
    glMatrixMode(GL_MODELVIEW)

    clock = pygame.time.Clock()

    cam_z = 2.0  # distância da câmera

    # ângulos de rotação do objeto
    rot_x = 0
    rot_y = 0

    # velocidade de rotação, para manter girando se quiser (opcional)
    rot_speed_x = 0
    rot_speed_y = 0

    running = True
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            
            # Controle dos ângulos pelo teclado
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_LEFT:
                    rot_speed_y = -30
                elif event.key == pygame.K_RIGHT:
                    rot_speed_y = 30
                elif event.key == pygame.K_UP:
                    rot_speed_x = -30
                elif event.key == pygame.K_DOWN:
                    rot_speed_x = 30
            
            if event.type == pygame.KEYUP:
                if event.key in (pygame.K_LEFT, pygame.K_RIGHT):
                    rot_speed_y = 0
                if event.key in (pygame.K_UP, pygame.K_DOWN):
                    rot_speed_x = 0

        # Atualiza os ângulos acumulando a velocidade
        rot_x = (rot_x + rot_speed_x) % 360
        rot_y = (rot_y + rot_speed_y) % 360

        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
        glLoadIdentity()

        glTranslatef(0.0, -0.2, -cam_z)

        # Aplica as rotações no objeto, no eixo X e depois no Y
        glRotatef(rot_x, 1, 0, 0)
        glRotatef(rot_y, 0, 1, 0)

        glBindTexture(GL_TEXTURE_2D, texture_id)
        draw_obj(vertices, texcoords, faces)

        pygame.display.flip()
        clock.tick(60)

    pygame.quit()

if __name__ == "__main__":
    main()