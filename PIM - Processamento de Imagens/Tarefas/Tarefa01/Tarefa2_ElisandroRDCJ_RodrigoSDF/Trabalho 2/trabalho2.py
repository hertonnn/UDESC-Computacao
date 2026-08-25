import numpy as np
import cv2
import os
from skimage.metrics import structural_similarity as ssim

class EdgeDetector:
    def __init__(self, image):
        if len(image.shape) == 3:
            image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        self.imagem = image.astype(np.uint8)
        self.altura, self.largura = self.imagem.shape
        self.gx = np.zeros_like(self.imagem, dtype=np.float64)
        self.gy = np.zeros_like(self.imagem, dtype=np.float64)

    def median(self, vet):
        vet = sorted(vet)
        n = len(vet)
        if n % 2 == 0:
            return (int(vet[n//2]) + int(vet[(n//2)-1])) // 2
        return vet[n//2]

    def valido(self, px, py):
        return 0 <= px < self.altura and 0 <= py < self.largura

    def filtro_passa_baixa(self):
        aux_img = self.imagem.copy()
        for l in range(self.altura):
            for c in range(self.largura):
                vet = []
                for i in range(-1, 2):
                    for j in range(-1, 2):
                        if self.valido(l + i, c + j):
                            vet.append(self.imagem[l + i, c + j])
                aux_img[l, c] = self.median(vet)
        self.imagem = aux_img

    def filtro_derivativo(self, operador_x, operador_y):
        img_aux = np.zeros((self.altura + 2, self.largura + 2), np.uint8)
        img_aux[1:self.altura+1, 1:self.largura+1] = self.imagem

        for i in range(self.altura):
            for j in range(self.largura):
                janela = img_aux[i:i+3, j:j+3]
                self.gx[i, j] = abs(np.sum(operador_x * janela))
                self.gy[i, j] = abs(np.sum(janela * operador_y))

    def calcula_magnitude_direcao(self):
        M = np.sqrt(self.gx**2 + self.gy**2)
        D = np.arctan2(self.gy, self.gx)
        return M, D

def non_maximum_suppression(M, D):
    height, width = M.shape
    output = np.zeros((height, width), dtype=np.uint8)
    angle = D * (180.0 / np.pi)
    angle[angle < 0] += 180

    for i in range(1, height - 1):
        for j in range(1, width - 1):
            q = 255
            r = 255

            if (0 <= angle[i, j] < 22.5) or (157.5 <= angle[i, j] <= 180):
                q = M[i, j + 1]
                r = M[i, j - 1]
            elif 22.5 <= angle[i, j] < 67.5:
                q = M[i + 1, j - 1]
                r = M[i - 1, j + 1]
            elif 67.5 <= angle[i, j] < 112.5:
                q = M[i + 1, j]
                r = M[i - 1, j]
            elif 112.5 <= angle[i, j] < 157.5:
                q = M[i - 1, j - 1]
                r = M[i + 1, j + 1]

            if (M[i, j] >= q) and (M[i, j] >= r):
                output[i, j] = 255
            else:
                output[i, j] = 0

    return output

def normalize_to_uint8(image):
    image = np.where(np.isfinite(image), image, 0)
    min_val, max_val = np.min(image), np.max(image)
    if min_val == max_val:
        return (image * 0).astype(np.uint8)
    normalized_image = 255 * (image - min_val) / (max_val - min_val)
    return normalized_image.astype(np.uint8)

def calculate_ssim(image1, image2):
    return ssim(image1, image2, data_range=image2.max() - image2.min())

def save_image(image, filename):
    cv2.imwrite(filename, image)

def process_image(imgfile, output_dir):
    image = cv2.imread(imgfile)
    base = os.path.splitext(os.path.basename(imgfile))[0]
    if image is None:
        print(f"Erro ao carregar {imgfile}")
        return

    detector = EdgeDetector(image)

    # 1) Pré-filtragem com filtro mediana (passa-baixa)
    detector.filtro_passa_baixa()

    # Sobel OpenCV para comparação (apenas 1x)
    Gx_cv = cv2.Sobel(detector.imagem, cv2.CV_64F, 1, 0, ksize=3)
    Gy_cv = cv2.Sobel(detector.imagem, cv2.CV_64F, 0, 1, ksize=3)
    M_cv = np.sqrt(Gx_cv**2 + Gy_cv**2)
    M_cv_uint8 = normalize_to_uint8(M_cv)

    # Operadores
    sobel_x = np.array([[-1, 0, 1], [-2, 0, 2], [-1, 0, 1]])
    sobel_y = np.array([[-1, -2, -1], [0, 0, 0], [1, 2, 1]])

    prewitt_x = np.array([[-1, 0, 1], [-1, 0, 1], [-1, 0, 1]])
    prewitt_y = np.array([[-1, -1, -1], [0, 0, 0], [1, 1, 1]])

    for name, (opx, opy) in [('sobel', (sobel_x, sobel_y)), ('prewitt', (prewitt_x, prewitt_y))]:
        detector.filtro_derivativo(opx, opy)
        M, D = detector.calcula_magnitude_direcao()
        M_uint8 = normalize_to_uint8(M)
        D_uint8 = normalize_to_uint8((D + np.pi) * (255 / (2 * np.pi)))
        edges = non_maximum_suppression(M, D)

        save_image(M_uint8, os.path.join(output_dir, f"{base}_{name}_magnitude.png"))
        save_image(D_uint8, os.path.join(output_dir, f"{base}_{name}_direction.png"))
        save_image(edges, os.path.join(output_dir, f"{base}_{name}_edges.png"))

        if name == 'sobel':
            print(f"[{base.upper()}] SSIM entre SOBEL e OpenCV Sobel:")
            for K in [0.2, 0.4, 0.6, 0.8, 1.0]:
                M_adjusted = np.where(M > K * M.max(), M, 0)
                M_adj_uint8 = normalize_to_uint8(M_adjusted)
                ssim_score = calculate_ssim(M_adj_uint8, M_cv_uint8)
                print(f"  K = {K:.1f} → SSIM = {ssim_score:.4f}")
            print()

def main():
    output_dir = 'output_images'
    os.makedirs(output_dir, exist_ok=True)

    image_list = ['moedas.png', 'Lua1_gray.jpg', 'chessboard_inv.png', 'img02.jpg']

    for imgfile in image_list:
        process_image(imgfile, output_dir)

if __name__ == "__main__":
    main()
