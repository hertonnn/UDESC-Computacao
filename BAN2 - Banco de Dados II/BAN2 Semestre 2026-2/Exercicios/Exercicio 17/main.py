import math
import random

found_coord = None
coords = []
with open('bier127.tsp', 'r', encoding='utf-8') as f:
    for linha in f:
        if 'NODE_COORD_SECTION' in linha: 
            found_coord = True
            continue
        if 'EOF' in linha:
            break
        if found_coord:
            itens = linha.split()[1:]
            coords_numbers = [float(x) for x in itens]    
            coords.append(coords_numbers)


mt_distance_euclidian = [[0.0 for _ in range(len(coords))] for _ in range(len(coords))]

for x, coord_x in enumerate(coords):
    for y, coord_y in enumerate(coords):
        if x != y:
            point1 = (coord_x[0], coord_x[1])
            point2 = (coord_y[0], coord_y[1])
            dist = math.dist(point1, point2)
            mt_distance_euclidian[x][y] = dist
        else:
            mt_distance_euclidian[x][y] = 0.0

visited = []
visited_set = set()
len_mt = len(mt_distance_euclidian)
initial_node = 0
actual_node = initial_node 

while len(visited) < len_mt:
    visited.append(actual_node)
    visited_set.add(actual_node)
    
    if len(visited) == len_mt:
        break

    min_dist = float('inf')
    nearest_neighbor = None

    for neighbor in range(len_mt):
        if neighbor not in visited_set:
            dist = mt_distance_euclidian[actual_node][neighbor]
            if dist < min_dist:
                min_dist = dist
                nearest_neighbor = neighbor

    actual_node = nearest_neighbor

# volta nó inicial
visited.append(initial_node)

def calculate_tour_cost(tour, matrix):
    cost = 0.0
    for i in range(len(tour) - 1):
        cost += matrix[tour[i]][tour[i+1]]
    return cost

initial_cost = calculate_tour_cost(visited, mt_distance_euclidian)

print("--- SOLUÇÃO INICIAL (Vizinho Mais Próximo) ---")
print(f"Custo: {initial_cost}")
# print("Caminho:", visited)


# Algoritmo 2-opt
print("\nAplicando 2-opt...")

best_tour = visited.copy()
best_cost = initial_cost
improved = True

while improved:
    improved = False
    
    # Itera sobre todos os pares de arestas possíveis
    # i vai de 1 até o penúltimo nó
    for i in range(1, len(best_tour) - 2):
        # j vai de i+1 até o último nó
        for j in range(i + 1, len(best_tour) - 1):
            
            # 2-opt swap: Inverte os nós entre os índices i e j
            new_tour = best_tour[:i] + best_tour[i:j+1][::-1] + best_tour[j+1:]
            
            new_cost = calculate_tour_cost(new_tour, mt_distance_euclidian)
            
            # Se a nova rota invertida for melhor, atualizamos
            if new_cost < best_cost:
                best_tour = new_tour
                best_cost = new_cost
                improved = True
                # Break para reiniciar a busca do início após uma melhoria (First Improvement)
                break 
        
        if improved:
            break

print("\n--- SOLUÇÃO FINAL (Após 2-opt) ---")
print(f"Custo Final: {best_cost}")
print("Caminho Final:", best_tour)