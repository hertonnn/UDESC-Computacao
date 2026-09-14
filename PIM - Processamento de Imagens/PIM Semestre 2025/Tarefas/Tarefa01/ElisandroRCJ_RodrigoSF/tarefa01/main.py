import numpy as np
import pickle
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D 

# Vizinhanca 3D tipo C6 (6 vizinhos pelas faces)
def get_neighbors_C6(pos, shape):
    z, y, x = pos
    neighbors = []
    for dz, dy, dx in [(-1,0,0),(1,0,0),(0,-1,0),(0,1,0),(0,0,-1),(0,0,1)]:
        nz, ny, nx = z+dz, y+dy, x+dx
        if 0 <= nz < shape[0] and 0 <= ny < shape[1] and 0 <= nx < shape[2]:
            neighbors.append((nz, ny, nx))
    return neighbors

# Vizinhanca 3D tipo C18 (faces + arestas, sem vértices diagonais)
def get_neighbors_C18(pos, shape):
    z, y, x = pos
    neighbors = []
    for dz in [-1, 0, 1]:
        for dy in [-1, 0, 1]:
            for dx in [-1, 0, 1]:
                if dz == 0 and dy == 0 and dx == 0:
                    continue
                num_nonzero = sum([abs(dz) > 0, abs(dy) > 0, abs(dx) > 0])
                if num_nonzero <= 2:  # face (1) ou aresta (2)
                    nz, ny, nx = z + dz, y + dy, x + dx
                    if 0 <= nz < shape[0] and 0 <= ny < shape[1] and 0 <= nx < shape[2]:
                        neighbors.append((nz, ny, nx))
    return neighbors

# Vizinhanca 3D tipo C26 (faces + arestas + vértices)
def get_neighbors_C26(pos, shape):
    z, y, x = pos
    neighbors = []
    for dz in [-1,0,1]:
        for dy in [-1,0,1]:
            for dx in [-1,0,1]:
                if dz == 0 and dy == 0 and dx == 0:
                    continue
                nz, ny, nx = z+dz, y+dy, x+dx
                if 0 <= nz < shape[0] and 0 <= ny < shape[1] and 0 <= nx < shape[2]:
                    neighbors.append((nz, ny, nx))
    return neighbors

def rotular(volume, alvo, vizinhanca='C6'):
    rotulo = np.zeros_like(volume, dtype=np.int32)
    current_label = 1
    agrupamentos = {}

    if vizinhanca == 'C6':
        get_neighbors = get_neighbors_C6
    elif vizinhanca == 'C18':
        get_neighbors = get_neighbors_C18
    else:
        get_neighbors = get_neighbors_C26

    for z in range(volume.shape[0]):
        for y in range(volume.shape[1]):
            for x in range(volume.shape[2]):
                if volume[z, y, x] == alvo and rotulo[z, y, x] == 0:
                    fila = [(z, y, x)]
                    rotulo[z, y, x] = current_label
                    tamanho = 1

                    while fila:
                        pos = fila.pop(0)
                        for viz in get_neighbors(pos, volume.shape):
                            vz, vy, vx = viz
                            if volume[vz, vy, vx] == alvo and rotulo[vz, vy, vx] == 0:
                                rotulo[vz, vy, vx] = current_label
                                fila.append((vz, vy, vx))
                                tamanho += 1
                    agrupamentos[current_label] = tamanho
                    current_label += 1

    return rotulo, agrupamentos

def extrair_maior_agrupar(rotulo, volume, alvo):
    unicos, contagens = np.unique(rotulo, return_counts=True)
    if len(unicos) <= 1:  
        return np.zeros_like(volume)
    maior = unicos[1:][np.argmax(contagens[1:])]
    resultado = np.zeros_like(volume)
    resultado[(rotulo == maior)] = alvo
    return resultado

def processar_volume(volume, vizinhanca='C6'):
    CELL_TYPES = {255: 'proliferativa', 200: 'quiescente', 140: 'necrotica'}
    totais = {}
    distribuicoes = {}
    maiores_volumes = {}

    for valor, tipo in CELL_TYPES.items():
        rotulos, grupos = rotular(volume, valor, vizinhanca)
        totais[tipo] = sum(grupos.values())
        distribuicoes[tipo] = grupos
        maiores_volumes[tipo] = extrair_maior_agrupar(rotulos, volume, valor)

    return totais, distribuicoes, maiores_volumes

def salvar_volumes(maiores_volumes):
    for tipo, vol in maiores_volumes.items():
        np.save(f"{tipo}_maior_volume.npy", vol)

def visualizar_clusters_3d(maiores_volumes):
    fig = plt.figure(figsize=(10,8))
    ax = fig.add_subplot(111, projection='3d')

    cores = {
        'proliferativa': (1, 0, 0),  # vermelho
        'quiescente': (0, 1, 0),    # verde
        'necrotica': (0, 0, 1),     # azul
    }

    for tipo, volume in maiores_volumes.items():
        zs, ys, xs = np.where(volume > 0)
        ax.scatter(xs, ys, zs, c=[cores[tipo]], label=tipo, s=5)

    ax.set_xlabel('X')
    ax.set_ylabel('Y')
    ax.set_zlabel('Z')
    ax.set_title('Maiores agrupamentos 3D por tipo de célula')
    ax.legend()
    plt.show()

def imprimir_distribuicao_categorizada(grupos, tipo_nome):
    grandes = []
    medios = []
    pequenos = []

    for label, tamanho in grupos.items():
        if tamanho > 100:
            grandes.append((label, tamanho))
        elif tamanho >= 10:
            medios.append((label, tamanho))
        elif tamanho >= 1:
            pequenos.append((label, tamanho))

    print(f"{tipo_nome.upper()}:")
    print(f"  Total de voxels: {sum([t for _, t in grupos.items()])}")

    def imprimir_lista(lista, nome):
        if not lista:
            return
        print(f"  {nome}:")
        for label, tamanho in lista:
            print(f"    Agrupamento {label}: {tamanho} voxels")

    imprimir_lista(grandes, "Grandes (>100 voxels)")
    imprimir_lista(medios, "Médios (10-100 voxels)")

    if pequenos:
        valores_pequenos = [tamanho for _, tamanho in pequenos]
        print(f"  Pequenos (1-9 voxels): {len(pequenos)} agrupamentos.")
        print(f"    Valores: {valores_pequenos}")
    print()

if __name__ == "__main__":
    volume = None
    with open("volume_TAC", "rb") as f:
        volume = pickle.load(f)

    vizinhanca = 'C26' #pode ser C6, C18 e C26

    totais, distribuicoes, maiores = processar_volume(volume, vizinhanca)

    totais_filtrados = totais
    distribuicoes_filtradas = distribuicoes

    print("Totais de células por tipo:")
    for tipo, total in totais_filtrados.items():
        print(f"{tipo}: {total} voxels")

    print("\nDistribuição categorizada dos agrupamentos:\n")
    for tipo, grupos in distribuicoes_filtradas.items():
        imprimir_distribuicao_categorizada(grupos, tipo)

    salvar_volumes(maiores)
    print("\nMaiores agrupamentos salvos como arquivos .npy.")

    visualizar_clusters_3d(maiores)
