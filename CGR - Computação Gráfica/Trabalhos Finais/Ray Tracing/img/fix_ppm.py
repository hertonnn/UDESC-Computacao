import os

def consertar_ppm_p3(caminho_entrada, caminho_saida):
    print("Lendo o arquivo P3 (isso pode demorar alguns segundos devido ao tamanho do texto)...")
    tokens = []
    
    with open(caminho_entrada, 'r', encoding='utf-8', errors='ignore') as f:
        for linha in f:
            # Removemos comentários se houver (tudo depois do #)
            linha = linha.split('#')[0]
            tokens.extend(linha.split())

    if len(tokens) < 4 or tokens[0] != 'P3':
        print("Erro: Não foi possível identificar o cabeçalho P3 válido.")
        return

    largura = int(tokens[1])
    altura_original = int(tokens[2])
    maxval = int(tokens[3])

    # O restante dos tokens são os valores de cor (R, G e B)
    dados_pixels = tokens[4:]
    
    # Cada pixel tem 3 valores, então sabemos quantos números formam uma linha horizontal completa
    valores_por_linha = largura * 3
    
    # Calculamos quantas linhas completas realmente temos
    nova_altura = len(dados_pixels) // valores_por_linha
    
    # Pegamos apenas os valores que formam linhas completas e descartamos a linha final quebrada
    dados_validos = dados_pixels[:nova_altura * valores_por_linha]

    print(f"Escrevendo a imagem corrigida com altura de {nova_altura} pixels...")
    with open(caminho_saida, 'w', encoding='utf-8') as f_out:
        f_out.write(f"P3\n{largura} {nova_altura}\n{maxval}\n")
        
        # Escreve os pixels de volta no arquivo
        for i in range(0, len(dados_validos), valores_por_linha):
            linha_pixel = " ".join(dados_validos[i : i + valores_por_linha])
            f_out.write(linha_pixel + "\n")

    print("\nSucesso!")
    print(f"Altura original planejada: {altura_original}")
    print(f"Nova altura recuperada: {nova_altura}")
    print(f"Arquivo salvo como: {caminho_saida}")

# Coloque o nome do seu arquivo quebrado aqui
arquivo_quebrado = "image_final_render.ppm"
arquivo_consertado = "image_final_render_resolved.ppm"

if os.path.exists(arquivo_quebrado):
    consertar_ppm_p3(arquivo_quebrado, arquivo_consertado)
else:
    print(f"Arquivo '{arquivo_quebrado}' não encontrado.")