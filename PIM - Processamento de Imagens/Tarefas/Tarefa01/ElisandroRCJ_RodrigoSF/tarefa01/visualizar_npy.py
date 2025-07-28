import numpy as np
import matplotlib.pyplot as plt

def plot_3d_cluster(volume, cor, titulo):
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    coords = np.argwhere(volume > 0)
    if coords.size > 0:
        # coords[:, 2] = eixo X, coords[:, 1] = eixo Y, coords[:, 0] = eixo Z
        ax.scatter(coords[:, 2], coords[:, 1], coords[:, 0], c=cor, s=10)
    ax.set_xlabel('X')
    ax.set_ylabel('Y')
    ax.set_zlabel('Z')
    ax.set_title(titulo)
    plt.show()

if __name__ == "__main__":
    proliferativa = np.load("proliferativa_maior_volume.npy")
    quiescente = np.load("quiescente_maior_volume.npy")
    necrotica = np.load("necrotica_maior_volume.npy")

    plot_3d_cluster(proliferativa, 'red', 'Cluster Proliferativa (X,Y,Z)')
    plot_3d_cluster(quiescente, 'green', 'Cluster Quiescente (X,Y,Z)')
    plot_3d_cluster(necrotica, 'blue', 'Cluster Necrótica (X,Y,Z)')
