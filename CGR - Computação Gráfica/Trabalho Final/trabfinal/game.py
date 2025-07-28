import pygame
from pygame.locals import *
from OpenGL.GL import *
from OpenGL.GLU import *
from OpenGL.GLUT import *
import random
import time
import os

# Inicialização
pygame.init()
glutInit()

display = (800, 600)
pygame.display.set_mode(display, DOUBLEBUF | OPENGL)
pygame.display.set_caption("Nave com PyOpenGL")

# Nave
nave_pos = [0.0, -1]
nave_vel = 0.02

# Tiros
shots = []

# Inimigos
inimigos = []
spawn_interval = 60
frame_count = 0
last_shot_frame = -100
shot_cooldown = 15

# Pontuação e Vidas
pontuacao = 0
vidas = 3

# Setup OpenGL
glMatrixMode(GL_PROJECTION)
glLoadIdentity()
gluOrtho2D(-1, 1, -1, 1)
glMatrixMode(GL_MODELVIEW)

def tela_instrucoes():
    textura_instrucoes, largura_instr, altura_instr = carregar_textura("./png/instrucoes.png")

    esperando = True
    while esperando:
        glClear(GL_COLOR_BUFFER_BIT)
        
        # Desenha a textura de instruções ocupando toda a tela
        glLoadIdentity()
        glEnable(GL_TEXTURE_2D)
        glBindTexture(GL_TEXTURE_2D, textura_instrucoes)
        glColor3f(1, 1, 1)
        glBegin(GL_QUADS)
        glTexCoord2f(0, 0)
        glVertex2f(-1, -1)
        glTexCoord2f(1, 0)
        glVertex2f(1, -1)
        glTexCoord2f(1, 1)
        glVertex2f(1, 1)
        glTexCoord2f(0, 1)
        glVertex2f(-1, 1)
        glEnd()
        glBindTexture(GL_TEXTURE_2D, 0)
        glDisable(GL_TEXTURE_2D)
        
        pygame.display.flip()
        
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                return False  # Fecha o jogo
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_RETURN:  # Aperta Enter para começar
                    esperando = False
                    return True

        pygame.time.wait(10)
        
# Carregar textura a partir de imagem pygame
def carregar_textura(path):
    if not os.path.isfile(path):
        raise FileNotFoundError(f"Arquivo de textura não encontrado: {path}")
    textura_surface = pygame.image.load(path)
    textura_data = pygame.image.tostring(textura_surface, "RGBA", True)
    largura, altura = textura_surface.get_rect().size
    textura_id = glGenTextures(1)
    glBindTexture(GL_TEXTURE_2D, textura_id)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, largura, altura, 0, GL_RGBA, GL_UNSIGNED_BYTE, textura_data)
    glBindTexture(GL_TEXTURE_2D, 0)
    return textura_id, largura, altura

def carregar_textura_fundo(path):
    if not os.path.isfile(path):
        raise FileNotFoundError(f"Arquivo de textura não encontrado: {path}")
    surface = pygame.image.load(path)
    data = pygame.image.tostring(surface, "RGBA", True)
    width, height = surface.get_rect().size
    texture_id = glGenTextures(1)
    glBindTexture(GL_TEXTURE_2D, texture_id)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data)
    glBindTexture(GL_TEXTURE_2D, 0)
    return texture_id, width, height

def desenhar_fundo(texture_id, img_w, img_h):
    glEnable(GL_TEXTURE_2D)
    glBindTexture(GL_TEXTURE_2D, texture_id)
    glColor3f(1, 1, 1)

    tela_ratio = 800 / 600  # 1.333
    img_ratio = img_w / img_h

    if img_ratio > tela_ratio:
        scale_w = 2.0
        scale_h = 2.0 * (tela_ratio / img_ratio)
    else:
        scale_h = 2.0
        scale_w = 2.0 * (img_ratio / tela_ratio)

    glBegin(GL_QUADS)
    glTexCoord2f(0, 0)
    glVertex2f(-scale_w / 2, -scale_h / 2)
    glTexCoord2f(1, 0)
    glVertex2f(scale_w / 2, -scale_h / 2)
    glTexCoord2f(1, 1)
    glVertex2f(scale_w / 2, scale_h / 2)
    glTexCoord2f(0, 1)
    glVertex2f(-scale_w / 2, scale_h / 2)
    glEnd()

    glBindTexture(GL_TEXTURE_2D, 0)
    glDisable(GL_TEXTURE_2D)

# Carregando texturas 
textura_nave, largura_nave, altura_nave = carregar_textura("./png/nave.png")
textura_ovini, largura_ovini, altura_ovini = carregar_textura("./png/ovini.png")
textura_fundo, largura_fundo, altura_fundo = carregar_textura_fundo("./png/espaco-sideral.png") 
textura_gameover, largura_gameover, altura_gameover = carregar_textura_fundo("./png/GAMEOVER.png")
textura_shot, largura_shot, altura_shot = carregar_textura("./png/tiro.png")
textura_instrucoes, largura_instrucoes, altura_instrucoes = carregar_textura("./png/instrucoes.png")

# Funções auxiliares para texto
def draw_text(x, y, text, scale=0.0012):
    glPushMatrix()
    glTranslatef(x, y, 0)
    glScalef(scale, scale, 1)
    glColor3f(1, 1, 1)
    for ch in text:
        glutStrokeCharacter(GLUT_STROKE_ROMAN, ord(ch))
    glPopMatrix()

def get_text_width(text):
    width = 0
    for ch in text:
        width += glutStrokeWidth(GLUT_STROKE_ROMAN, ord(ch))
    return width

def draw_text_centered(y, text, scale=0.002):
    width = get_text_width(text) * scale
    x = -width / 2
    draw_text(x, y, text, scale)

# Desenha um quadrado texturizado centrado em (x,y)
def draw_textured_quad(x, y, width, height, textura_id):
    glEnable(GL_TEXTURE_2D)
    glBindTexture(GL_TEXTURE_2D, textura_id)
    glColor3f(1,1,1)
    glBegin(GL_QUADS)
    glTexCoord2f(0, 0)
    glVertex2f(x - width/2, y)
    glTexCoord2f(1, 0)
    glVertex2f(x + width/2, y)
    glTexCoord2f(1, 1)
    glVertex2f(x + width/2, y + height)
    glTexCoord2f(0, 1)
    glVertex2f(x - width/2, y + height)
    glEnd()
    glBindTexture(GL_TEXTURE_2D, 0)
    glDisable(GL_TEXTURE_2D)

# Função desenhar nave usando textura
def draw_nave(x, y):
    # Ajuste de escala para caber na tela - você pode ajustar esse valor
    scale = 0.1
    w = largura_nave / 800 * 2 * scale  # normaliza para espaço OpenGL [-1,1]
    h = altura_nave / 600 * 2 * scale
    draw_textured_quad(x, y, w, h, textura_nave)

# Função desenhar inimigo (ovni) usando textura
def draw_inimigo(x, y):
    scale = 0.1
    w = largura_ovini / 800 * 2 * scale
    h = altura_ovini / 600 * 2 * scale
    draw_textured_quad(x, y, w, h, textura_ovini)

# Função desenhar tiro (continua quad vermelho)
def draw_shot(x, y):
    scale = 0.03  # você pode ajustar o tamanho do tiro aqui
    w = largura_shot / 800 * 2 * scale
    h = altura_shot / 600 * 2 * scale
    draw_textured_quad(x, y, w, h, textura_shot)

# Função de colisão simples
def colisao(shot, inimigo):
    sx, sy = shot
    ix, iy = inimigo
    return abs(sx - ix) < 0.08 and abs(sy - iy) < 0.07


# Tela de Game Over com opções
def tela_game_over():
    while True:
        glClear(GL_COLOR_BUFFER_BIT)
        glColor3f(1, 0, 0)
        desenhar_fundo(textura_gameover, largura_gameover, altura_gameover)

        pygame.display.flip()

        for event in pygame.event.get():
            if event.type == QUIT:
                return False  # fechar o jogo
            if event.type == KEYDOWN:
                if event.key == K_r:
                    return True  # reiniciar o jogo
                elif event.key == K_q:
                    return False  # fechar o jogo

        pygame.time.wait(100)

# Loop principal
clock = pygame.time.Clock()
running = True

while running:
    if not tela_instrucoes():
        running = False  # Saiu da tela de instruções sem começar o jogo
    else:
        pontuacao = 0
        vidas = 3
        nave_pos = [0.0, -0.9]
        shots = []
        inimigos = []
        frame_count = 0
        last_shot_frame = -100

        while vidas > 0:
            clock.tick(60)
            glClear(GL_COLOR_BUFFER_BIT)
            desenhar_fundo(textura_fundo, largura_fundo, altura_fundo)
            frame_count += 1

            for event in pygame.event.get():
                if event.type == QUIT:
                    running = False
                    vidas = 0

            keys = pygame.key.get_pressed()
            if keys[K_LEFT] and nave_pos[0] - nave_vel - 0.05 > -1:
                nave_pos[0] -= nave_vel
            if keys[K_RIGHT] and nave_pos[0] + nave_vel + 0.05 < 1:
                nave_pos[0] += nave_vel
            if keys[K_SPACE] and (frame_count - last_shot_frame > shot_cooldown):
                shots.append([nave_pos[0], nave_pos[1] + 0.12])
                last_shot_frame = frame_count

            # Atualizar tiros
            novos_tiros = []
            for shot in shots:
                shot[1] += 0.05
                if shot[1] < 1:
                    novos_tiros.append(shot)
            shots = novos_tiros

            # Gerar inimigos
            if frame_count % spawn_interval == 0:
                inimigos.append([random.uniform(-0.9, 0.9), 1.0])

            # Atualizar inimigos
            novos_inimigos = []
            for inimigo in inimigos:
                inimigo[1] -= 0.01
                if inimigo[1] > -1:
                    novos_inimigos.append(inimigo)
                else:
                    vidas -= 1  # perdeu vida
            inimigos = novos_inimigos

            # Verificar colisões (cada tiro atinge só 1 inimigo)
            inimigos_restantes = []
            novos_tiros = shots.copy()  # copia para modificar

            for inimigo in inimigos:
                atingido = False
                for shot in novos_tiros:
                    if colisao(shot, inimigo):
                        atingido = True
                        pontuacao += 10
                        novos_tiros.remove(shot)  # remove o tiro que acertou
                        break
                if not atingido:
                    inimigos_restantes.append(inimigo)

            inimigos = inimigos_restantes
            shots = novos_tiros

            # Desenhar tiros restantes
            for shot in shots:
                draw_shot(shot[0], shot[1])

            # Desenhar inimigos com textura
            for inimigo in inimigos:
                draw_inimigo(inimigo[0], inimigo[1])

            # Desenhar nave com textura
            draw_nave(nave_pos[0], nave_pos[1])

            # HUD
            draw_text(-0.98, 0.88, f"Vidas: {vidas}", scale=0.0008)
            draw_text(0.4, 0.88, f"Pontos: {pontuacao}", scale=0.0008)

            pygame.display.flip()

        # Tela game over
        if not tela_game_over():
            running = False  # usuário escolheu sair, finaliza loop

pygame.quit()
