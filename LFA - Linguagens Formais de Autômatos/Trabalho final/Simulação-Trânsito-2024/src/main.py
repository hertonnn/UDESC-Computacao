import AFD 
import AP

class Sistema:
    def __init__(self, entradas, retornos, estacionamentos, cruzamentos, alfabeto, transicoes):
        
        self.entradas = entradas 
        self.retornos = retornos  
        self.estacionamentos = estacionamentos 
        self.cruzamentos = cruzamentos  
        self.transicoes = transicoes
        self.alfabeto = alfabeto
        
    def valida_trajeto(self, estado_inicial, trajeto):
        
        estados = self.entradas | self.retornos | estacionamentos | cruzamentos
        afd = AFD.AFD_class(estados, self.alfabeto, self.transicoes, estado_inicial, estacionamentos)
        
        if afd.processar(trajeto):
            print("\nO trajeto é possível dado o início.\n")
        else:
            print("\nTrajeto não é possível.\n")

        
class Cruzamento:
    def __init__(self, nome, semaforo = None):

        self.nome = nome
        self.semaforo = semaforo
        
class Semaforo:
    def __init__(self, estado_inicial, estados, alfabeto, alfabeto_pilha, estados_aceitacao, transicoes):
        self.estado_atual = estado_inicial
        self.estados = estados
        self.alfabeto = alfabeto
        self.alfabeto_pilha = alfabeto_pilha
        self.estados_aceitacao = estados_aceitacao
        self.transicoes = transicoes
    
    def valida_fluxo(self, fluxo):
        ap = AP.AP_class(self.estados, self.alfabeto, self.alfabeto_pilha, self.transicoes, self.estado_atual, self.estados_aceitacao)
        
        if ap.processar(fluxo):
            print("\nO fluxo é possível dado o semáforo.\n")
        else:
            print("\nFluxo não é possível.\n")
        

# Etapa 1: Representação do Movimento dos Veículos
# - modelando para um cenário específico de trânsito!

possiveis_estados_iniciais = {'A', 'B', 'C', 'D'}
retornos = {'R1', 'R2', 'R3', 'R4'}
estacionamentos = {'p1', 'p3', 'p3.1', 'p5', 'p7'}

# cruzamentos
C1 = Cruzamento('C1')
C2 = Cruzamento('C2')
C3 = Cruzamento('C3')
C4 = Cruzamento('C4')

cruzamentos = {C1, C2, C3, C4}

# Visão de cima, como um mapa:
alfabeto = {'cima', 'baixo', 'direita', 'esquerda', 'retorne', 'estacionar'}

transicoes = {
    # Possiveis estados iniciais
    'A': {'baixo': 'C1', 'estacionar': 'p1'},
    'B': {'baixo': 'C2', 'estacionar': 'p3'},
    'C': {'direita': 'C1'},
    'D': {'esquerda': 'C4'},
    
    # Retornos
    'R1': {'': ''},
    'R2': {'cima': 'C3'},
    'R3': {'cima': 'C4'},
    'R4': {'': ''},
    
    # Cruzamentos
    'C1': {'cima': 'A', 'estacionar': 'p1', 'direita': 'C2', 'baixo': 'C3'},
    'C2': {'cima': 'B', 'estacionar': 'p3', 'estacionar': 'p3.1', 'direita': 'R4', 'baixo': 'C4'},
    'C3': {'cima': 'C1', 'esquerda': 'R1', 'estacionar': 'p7', 'baixo': 'R2'},
    'C4': {'cima': 'C2', 'estacionar': 'p5', 'baixo': 'R3', 'esquerda': 'C3'}
}


# Etapa 2: Representação os Semáforos
# - modelando para um cenário específico de trânsito!

estado_inicial_AP = 'vermelho'
estados_AP = {'vermelho', 'verde', 'amarelo', 'fim'}
alfabeto_AP = {'veiculo', 'troca','fim'}
alfabeto_AP_Pilha = {'veiculo'}
estado_aceitacao_AP = {'fim'}

transicoes_AP = {
    
    # Transições dos estados do semáforo
    ('vermelho', 'veiculo', 'ε'): [('vermelho', 'veiculo')],
    ('vermelho', 'troca', 'ε'): [('verde', 'ε')],
    ('verde', 'veiculo', 'veiculo'): [('verde', 'ε')],
    ('verde', 'troca', 'ε'): [('amarelo', 'ε')],
    ('amarelo', 'veiculo', 'veiculo'): [('amarelo', 'ε')],
    ('amarelo', 'troca', 'ε'): [('vermelho', 'ε')],
    
    # Transições para o estado final 
    ('amarelo', 'ε', '?'): [('vermelho', '?')],
    ('vermelho', 'ε', '?'): [('vermelho', '?')],
    ('verde', 'ε', '?'): [('vermelho', '?')],
}


semaforo = Semaforo(estado_inicial_AP, estados_AP, alfabeto_AP, alfabeto_AP_Pilha, estado_aceitacao_AP, transicoes_AP)

sistema = Sistema(possiveis_estados_iniciais, retornos, estacionamentos, cruzamentos, alfabeto, transicoes)

def menu_principal():
    while True:
        print("\n=== SIMULAÇÃO DE TRÂNSITO ===")
        print("1. Testar trajetória")
        print("2. Testar fluxo")
        print("3 Sair")
        
        try:
            opcao = int(input("Escolha uma opção: "))
        except ValueError:
            print("Por favor, insira um número válido.")
            continue

        if opcao == 1:
            print("\nExemplo de trajetória seria início no B: baixo baixo esquerda estacionar\n")
            estado_inicial = input("Digite o estado inicial: ")
            entrada = input("Digite a trajetória: ")
            
            trajetoria = [item.strip() for item in entrada.split()] 
            sistema.valida_trajeto(estado_inicial, trajetoria) 
            
        elif opcao == 2:
            print("\nExemplo de fluxo seria: veiculo troca veiculo\n")
            entrada = input("Digite o fluxo: ")
            
            fluxo = [item.strip() for item in entrada.split()]
            fluxo.append('fim')
            semaforo.valida_fluxo(fluxo)
        elif opcao == 3:
            print("Saindo do sistema. Até logo!")
            break
        else:
            print("Opção inválida. Tente novamente.")
menu_principal()



