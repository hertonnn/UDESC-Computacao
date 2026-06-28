
import pygame, sys
from pygame.locals import *
import random
import time
import re
 
pygame.init()
 
FPS = 60
FramePerSec = pygame.time.Clock()
SecPerFrame = 1/FPS
 
# Cores
BLUE  = (0, 0, 255)
RED   = (255, 0, 0)
GREEN = (0, 255, 0)
BLACK = (0, 0, 0)
WHITE = (255, 255, 255)
 


def loadImage(img):
	img = pygame.image.load(img)
	img.set_colorkey(img.get_at((0,0)))
	return img

def clamp(n, minn, maxn):
    return max(min(maxn, n), minn)

class Element(pygame.sprite.Sprite):
	def __init__(self, img = None):
		super().__init__() 
		self.image = None
		if(img != None):
			self.image = loadImage(img)
			self.rect = self.image.get_rect()
			self.rect.center=(16,16)

	def setPos(self, x, y):
		self.rect.center = (x, y)

	def getRect(self):
		return self.rect

	def draw(self, surface):
		if(self.image != None):
			surface.blit(self.image, self.rect)

	def move(self):
		pass
	def update(self):
		pass


 
class Enemy(Element):
	def __init__(self, img="crab.png"):
		super().__init__(img) 		
		self.direction = "DOWN"
		self.counter = 0
		self.counterMax = 50
		self.setPos(32,32)
		self.destNode = (1,1)
		self.lastNode = (1,1)

		self.speed = random.randint(2,4) #pixels per frame
		
	def getNodePos(self):
		return self.lastNode

	def isSafeNode(self, x, y):
		if x < 0 or x >= len(MAP):
			return False
		if y < 0 or y >= len(MAP[0]):
			return False
		if(MAP[x][y] != 0): 
			return False
		return True
	
	def setNode(self, x, y):
		self.lastNode = (x,y)
		self.destNode = (x,y)
		self.setPos(x*self.rect[2], y*self.rect[3])
		
	# Nova função (Cálculo da distância, por Manhattan)
	def manhattan_distancia(self, pos1, pos2):
		return abs(pos1[0] - pos2[0]) + abs(pos1[1] - pos2[1])
		
	def nextNode(self):
			
		player_node = P1.getNodePos()
		
		movimentos_possiveis = {
			"UP" : (self.lastNode[0], self.lastNode[1] - 1),
			"DOWN" : (self.lastNode[0], self.lastNode[1] + 1),
			"LEFT" : (self.lastNode[0] - 1, self.lastNode[1]),
			"RIGHT" : (self.lastNode[0] + 1, self.lastNode[1]),
		}
		
		movimentos_validos = []

		for next_pos in movimentos_possiveis.values():
			if self.isSafeNode(next_pos[0], next_pos[1]):
				movimentos_validos.append(next_pos)
		
		if not movimentos_validos:
			return None
		
		melhor_movimento = None
		distancia_menor = float('inf')

		for move in movimentos_validos:
			distancia = self.manhattan_distancia(move, player_node)

			if distancia < distancia_menor:
				distancia_menor = distancia
				melhor_movimento = move
		
		return melhor_movimento
 
	def update(self):
			
		mx = 0
		my = 0	

		if(self.destNode != None):
			d = self.destNode[0]*32 - self.rect.center[0]
			mx = d
			d = self.destNode[1]*32 - self.rect.center[1]
			my = d


		if(mx == 0 and my == 0):
			self.destNode = self.nextNode()
			if self.destNode == None:
				return
			else:
				self.lastNode = self.destNode

		mx = clamp(mx, -self.speed, self.speed)
		my = clamp(my, -self.speed, self.speed)


		self.rect.move_ip(mx,my)	
		
		
	
class Player(Enemy):
	def __init__(self):
		super().__init__("player.png") 
		self.direction = "UP"
		self.newDir = None
		self.speed = 3

	def nextNode(self):
		if(self.newDir != None):
			if(self.newDir == "UP"):
				if(self.isSafeNode(self.lastNode[0], self.lastNode[1]-1)):
					self.direction = self.newDir
					self.newDir = None
					return (self.lastNode[0], self.lastNode[1]-1)
			if(self.newDir == "DOWN"):
				if(self.isSafeNode(self.lastNode[0], self.lastNode[1]+1)):
					self.direction = self.newDir
					self.newDir = None
					return (self.lastNode[0], self.lastNode[1]+1)
			if(self.newDir == "LEFT"):
				if(self.isSafeNode(self.lastNode[0]-1, self.lastNode[1])):
					self.direction = self.newDir
					self.newDir = None
					return (self.lastNode[0]-1, self.lastNode[1])
			if(self.newDir == "RIGHT"):
				if(self.isSafeNode(self.lastNode[0]+1, self.lastNode[1])):
					self.direction = self.newDir
					self.newDir = None
					return (self.lastNode[0]+1, self.lastNode[1])	
			
		if(self.direction == "UP"):
			if(self.isSafeNode(self.lastNode[0], self.lastNode[1]-1)):
				return (self.lastNode[0], self.lastNode[1]-1)
		if(self.direction == "DOWN"):
			if(self.isSafeNode(self.lastNode[0], self.lastNode[1]+1)):
				return (self.lastNode[0], self.lastNode[1]+1)
		if(self.direction == "LEFT"):
			if(self.isSafeNode(self.lastNode[0]-1, self.lastNode[1])):
				return (self.lastNode[0]-1, self.lastNode[1])
		if(self.direction == "RIGHT"):
			if(self.isSafeNode(self.lastNode[0]+1, self.lastNode[1])):
				return (self.lastNode[0]+1, self.lastNode[1])	
			
		return None

	def update(self):
		pressed_keys = pygame.key.get_pressed()
		if pressed_keys[K_UP]:
			self.newDir = "UP"
		elif pressed_keys[K_DOWN]:
			self.newDir="DOWN"		 
		if pressed_keys[K_LEFT]:
			self.newDir = "LEFT"
		if pressed_keys[K_RIGHT]:
			self.newDir = "RIGHT"

		super().update()
 

class Obstacle(Element):
	def __init__(self, img):
		super().__init__(img) 
		self.setPos(400,300)


	

enemies = []
N_ENEMIES = 10
for i in range(N_ENEMIES):
	enemies.append(Enemy())

mapFromAscii = False #para mapas feitos em https://textik.com/

MAP = []
f = open("map_0.txt")
lines = f.readlines()
if('+' in lines[0]):
	mapFromAscii = True

for line in lines:
	if mapFromAscii:	
		line = re.sub(r"[^\s]", '1', line) #troca por '1' tudo que nao for espaco		                                   
		line = line.replace(' ', '0') #troca ' ' por 0
	row = []
	l = list(line)
	for c in l:
		if(c == '0'):
			row.append(0)
		if(c == '1'):
			row.append(1)
	if(len(row) > 3):
		MAP.append(list(row))

#transposta, para acessar no modelo MAP[x][y]
MAP = [[row[i] for row in MAP] for i in range(len(MAP[0]))]
    

px = len(MAP) -2
py = len(MAP[0])-2
P1 = Player()
P1.setNode(px, py)
MAP[px][py] = 0

# Screen information
SCREEN_WIDTH = len(MAP) * 32 - 32
SCREEN_HEIGHT = len(MAP[0]) * 32 - 32
 
DISPLAYSURF = pygame.display.set_mode((SCREEN_WIDTH,SCREEN_HEIGHT))
DISPLAYSURF.fill(WHITE)
pygame.display.set_caption("Crab")

background = pygame.Surface((SCREEN_WIDTH, SCREEN_HEIGHT))
backImg = pygame.image.load("sand.png")
backRect = backImg.get_rect()
print(backRect)
w = 0
h = 0
while w < SCREEN_WIDTH:
	while h < SCREEN_HEIGHT:
		background.blit(backImg, (w,h))
		h = h + backRect[3]
	w = w + backRect[2]
	h = 0



obstacles = []
nodes = []
i = 0
j = 0
while i < len(MAP):
	while j < len(MAP[0]):
		if(MAP[i][j] == 1):
			e = Element('block.png')
			e.setPos(i*32,j*32)
			obstacles.append(e)
		j = j + 1
	i = i + 1
	j=0



elements = [P1] + enemies + obstacles

pygame.mixer.music.load("sound.mp3")
pygame.mixer.music.play(-1)

while True:	 
	for event in pygame.event.get():			  
		if event.type == QUIT:
			pygame.quit()
			sys.exit()
 
	for e in elements:
		e.update()
	 
	DISPLAYSURF.blit(background, (0,0))

	for e in elements:
		e.draw(DISPLAYSURF)

		
	l = P1.getRect().collidelistall(enemies)
	if(len(l) > 0):
		time.sleep(2)
		P1.setNode(px,py)
		for i in range(N_ENEMIES):
			enemies[i].setNode(1,1)
	
		 
	pygame.display.update()
	FramePerSec.tick(FPS)


