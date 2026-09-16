import cv2 
import numpy as np
import matplotlib.pyplot as plt
from collections import deque 

from skimage.feature import canny
from skimage.metrics import structural_similarity as ssim

# Função auxiliar (convulação)
def convolucao(imagem, kernel):
    
    img_altura, img_largura = imagem.shape
    kernel_altura, kernel_largura = kernel.shape

    pad_h = kernel_altura // 2
    pad_w = kernel_largura // 2

    saida = np.zeros(imagem.shape, dtype = np.float64)

    for y in range(pad_h, img_altura - pad_h):
        for x in range(pad_w, img_largura - pad_w):

            vizinhanca = imagem[y - pad_h : y + pad_h + 1,
                                x - pad_w : x + pad_w + 1]
            
            soma = np.sum(vizinhanca * kernel)
            saida[y, x] = soma 

    return saida

# PASSO 1: Filtragem Gaussiana 3x3
def filtragem_gaussiana(imagem):
    
    kernel_gaussiano = (1/16) * np.array([ 
        [1, 2, 1],
        [2, 4, 2],
        [1, 2, 1]
    ])

    imagem_suavizada = convolucao(imagem,kernel_gaussiano)
    return imagem_suavizada

# PASSO 2: Componentes do Gradiente (Sobel/Prewitt)
def componentes_gradiente(imagem_suavizada, tipo_operador):
    
    if tipo_operador == "sobel":
        # Operadores de Sobel
        kernel_x = np.array([[-1, 0, 1], 
                             [-2, 0, 2], 
                             [-1, 0, 1]])
        kernel_y = np.array([[-1, -2, -1], 
                             [ 0,  0,  0], 
                             [ 1,  2,  1]])
    elif tipo_operador == "prewitt":
        # Operadores de Prewitt
        kernel_x = np.array([[-1, 0, 1], 
                             [-1, 0, 1], 
                             [-1, 0, 1]])
        kernel_y = np.array([[-1, -1, -1], 
                             [ 0,  0,  0], 
                             [ 1,  1,  1]])
    else:
        raise ValueError("Operador não suportado. Utilize (sobel) ou (prewitt)")
    
    Gx = convolucao(imagem_suavizada, kernel_x)
    Gy = convolucao(imagem_suavizada, kernel_y)

    return Gx, Gy 

# PASSO 3: Magnitude do Gradiente
def magnitude(Gx, Gy):

    M = np.sqrt(Gx**2 + Gy**2)

    # Normaliza a magnitude para 0-255 para melhorar a vizualização
    M_normalizado = (M / M.max()) * 255
    # Converte números float para números uint8 (inteiros de 0-255)
    return M_normalizado.astype(np.uint8)

# PASSO 4: Direção do gradiente
def direcao_gradiente(Gx, Gy):

    epsilon = 1e-8
    D = np.arctan2(Gy, Gx + epsilon)

    return D

# PASSO 5: Supressão dos Gradientes não máximos
# Suprime (apaga) qualquer pixel que não seja o máximo local na direção do gradiente
def supressao_nao_maximos(M, D):

    img_altura, img_largura = M.shape
    Mg = np.zeros_like(M)
    D_graus = np.degrees(D) % 180 # Converte radianos para graus

    for y in range(1, img_altura - 1):
        for x in range(1, img_largura - 1):

            mag = M[y, x] # Magnitude do pixel central
            ang = D_graus[y, x] # Ângulo do pixel central

            vizinho1 = 0
            vizinho2 = 0

            # Eixo 0° (Horizontal)
            if (0 <= ang < 22.5) or (157.5 <= ang <= 180):
                vizinho1 = M[y, x + 1]
                vizinho2 = M[y, x - 1]
            # Eixo 45° (Diagonal)
            elif (22.5 <= ang < 67.5):
                vizinho1 = M[y - 1, x + 1] 
                vizinho2 = M[y + 1, x - 1] 
            # Eixo 90° (Vertical)
            elif (67.5 <= ang < 112.5):
                vizinho1 = M[y - 1, x]
                vizinho2 = M[y + 1, x]
            # Eixo 135° (Outra Diagonal)
            elif (112.5 <= ang < 157.5):
                vizinho1 = M[y - 1, x - 1] 
                vizinho2 = M[y + 1, x + 1] 
                
            # Mantém o pixel apenas se for maior que os vizinhos na direção
            if mag >= vizinho1 and mag >= vizinho2:
                Mg[y, x] = mag
            else:
                Mg[y, x] = 0 # Suprime o pixel

    return Mg

# PASSO 6: Limiarização e histerese
def limiarizacao_histerese(Mg, perc_baixo, perc_altor):
    
    # 1. Limiarização 
    mediana = np.median(Mg[Mg > 0]) # Pega a mediana só dos pixels de borda (ignora o fundo preto)

    T_H = mediana * perc_altor
    T_L = mediana * perc_baixo

    print(f"  Limiar Alto (T_H) calculado: {T_H:.2f}")
    print(f"  Limiar Baixo (T_L) calculado: {T_L:.2f}")

    img_altura, img_largura = Mg.shape
    imagem_final = np.zeros_like(Mg)

    forte_y, forte_x = np.where(Mg >= T_H) # Classifca os pixels
    imagem_final[forte_y, forte_x] = 255

    pilha = deque(zip(forte_y, forte_x))

    # 2. Histerese: Conecta as bordas fracas às fortes
    while pilha:
        y, x = pilha.popleft()
        # Verifica os 8 vizinhos
        for dy in range(-1, 2):
            for dx in range(-1, 2):
                if dy == 0 and dx == 0:
                    continue # Pula o próprio pixel

                ny, nx = y + dy, x + dx
                
                if (0 <= ny < img_altura) and (0 <= nx < img_largura):
                    # Verifica se o vizinho é um pixel fraco e ainda não foi processado
                    if ((Mg[ny, nx] >= T_L) and (Mg[ny, nx] < T_H) and 
                        (imagem_final[ny, nx] == 0)):
                        
                        imagem_final[ny, nx] = 255 # Promove o pixel 
                        pilha.append((ny, nx)) # 

    return imagem_final, T_L, T_H

def detector_bordas(imagem_cinza, tipo_operador, limiar_baixo, limiar_alto):

    print(f"\n--- Detector de bordas com operador: {tipo_operador.upper()} ---")

    # PASSO 1
    print("Passo 1: Filtro Gaussiano...")
    img_suavizada = filtragem_gaussiana(imagem_cinza)

    # PASSO 2
    print("Passo 2: Componentes Gx e Gy...")
    Gx, Gy = componentes_gradiente(img_suavizada, tipo_operador)

    # PASSO 3
    print("Passo 3: Magnitude (M)...")
    M = magnitude(Gx, Gy)

    # PASSO 4
    print("Passo 4: Direção (D)...")
    D = direcao_gradiente(Gx, Gy)

    # PASSO 5
    print("Passo 5: Supressão de Não-Máximos...")
    Mg = supressao_nao_maximos(M, D)

    # Passo 6: Histerese
    print("Passo 6: Limiarização e Histerese...")
    img_final, T_L, T_H = limiarizacao_histerese(Mg, limiar_baixo, limiar_alto)

    return img_final, T_L, T_H

# Comparação da implementação manual com com skimage (Canny e SSIM) 
def comparar_com_skimage(imagem_cinza, minha_img_final, T_L_calc, T_H_calc):

    print("\n--- Comparação com skimage ---")
    
    if imagem_cinza.max() > 1:
        img_norm_sk = imagem_cinza / 255.0
    
    T_L_sk = T_L_calc / 255.0
    T_H_sk = T_H_calc / 255.0
    
    canny_skimage = canny(img_norm_sk, low_threshold=T_L_sk, high_threshold=T_H_sk, sigma=1) # Sigma=1 é próximo do Gaussiano 3x3
    
    # Converte a saída da skimage (True/False) para uint8 (0/255)
    canny_skimage_uint8 = canny_skimage.astype(np.uint8) * 255
    
    # Calcula o SSIM 
    score_ssim = ssim(minha_img_final, canny_skimage_uint8, data_range=255)
    
    print(f"Score SSIM (Similaridade): {score_ssim:.4f}")
    
    return canny_skimage_uint8

# Função auxiliar (exibição das imagens)
def exibir_resultados(img_original, img_sobel, img_prewitt, img_skimage):
    plt.figure(figsize=(15, 10))
    
    plt.subplot(2, 2, 1)
    plt.imshow(img_original, cmap='gray')
    plt.title('Imagem Original')
    plt.axis('off')
    
    plt.subplot(2, 2, 2)
    plt.imshow(img_sobel, cmap='gray')
    plt.title('Resultado Manual (Sobel)')
    plt.axis('off')
    
    plt.subplot(2, 2, 3)
    plt.imshow(img_prewitt, cmap='gray')
    plt.title('Resultado Manual (Prewitt)')
    plt.axis('off')
    
    plt.subplot(2, 2, 4)
    plt.imshow(img_skimage, cmap='gray')
    plt.title(f'skimage.filters.canny')
    plt.axis('off')
    
    plt.tight_layout()
    plt.show()

# Código Principal
if __name__ == "__main__":
    
    nome_arquivo = 'moedas.png' # 'Lua1_gray.jpg', 'chessboard_inv.png', 'img02.jpg', 'moedas.png'
    imagem = cv2.imread(nome_arquivo)
    
    if imagem is None:
        print(f"Erro: Não foi possível carregar a imagem '{nome_arquivo}'.")
    else:
        # Converte para tons de cinza 
        if len(imagem.shape) == 3:
            imagem_cinza = cv2.cvtColor(imagem, cv2.COLOR_BGR2GRAY)
        else:
            imagem_cinza = imagem
            
        limiar_baixo = 0.5
        limiar_alto = 1.0

        # Implementação com Sobel
        resultado_sobel, T_L_sobel, T_H_sobel = detector_bordas(imagem_cinza, 'sobel', limiar_baixo, limiar_alto)
        
        # Implementação com Prewitt
        resultado_prewitt, _, _ = detector_bordas(imagem_cinza, 'prewitt', limiar_baixo, limiar_alto)

        # Comparação
        resultado_skimage = comparar_com_skimage(imagem_cinza, resultado_sobel, T_L_sobel, T_H_sobel)
        
        # Exibir 
        exibir_resultados(imagem_cinza, resultado_sobel, resultado_prewitt, resultado_skimage)

