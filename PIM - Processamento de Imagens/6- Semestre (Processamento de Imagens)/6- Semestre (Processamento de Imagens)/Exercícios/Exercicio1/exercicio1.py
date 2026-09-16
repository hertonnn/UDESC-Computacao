import cv2 
import numpy as np

image = cv2.imread('figuraEscura.jpg') # lê a imagem e retorna uma matriz
# Cada pixel da imagem é representado como um array com 3 valores (BGR)
cv2.imshow('Image', image)
# Abre uma janela chamada 'Image' monstrando a imagem
print(np.mean(image))
# np.mean(image) -> Calcula a média de todos os valores de pixel da imagem

cv2.waitKey(0) # Evita que a tela feche imediatamente

