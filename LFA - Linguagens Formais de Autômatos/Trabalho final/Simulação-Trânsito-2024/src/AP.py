class AP_class:
    def __init__(self, estados, alfabeto, alfabeto_pilha, transicoes, estado_inicial, estados_finais):
        self.estados = estados
        self.alfabeto = alfabeto
        self.alfabeto_pilha = alfabeto_pilha
        self.transicoes = transicoes
        self.estado_inicial = estado_inicial
        self.estados_finais = estados_finais

    def processar(self, cadeia):
        return self.processar(cadeia)

    def processar(self, cadeia):
        estado_atual = self.estado_inicial
        proximo = ''
        pilha = ['#']
        
        for instrucao in cadeia:
            if instrucao == 'fim' and pilha[-1] == '#':
                return True
            if instrucao not in self.alfabeto:
                print("Instrução inválida")
                return False
            for (estado, simbolo_entrada, topo), transicoes in self.transicoes.items():
                if estado == estado_atual and simbolo_entrada == instrucao and (topo == pilha[-1] or topo == 'ε'):
                    for (proximo_estado, empilha) in transicoes:
                        proximo = proximo_estado
                        
                        if topo != 'ε' and pilha[-1] != '#':
                            pilha.pop()
                        if empilha != 'ε':
                            pilha.append(empilha)
            estado_atual = proximo
        print("Fluxo recusado")
        return False    


# estado_inicial_AP = 'vermelho'
# estados_AP = {'vermelho', 'verde', 'amarelo', 'fim'}
# alfabeto_AP = {'veiculo', 'troca', 'fim'}
# alfabeto_AP_Pilha = {'veiculo'}
# estado_aceitacao_AP = {'fim'}

# transicoes_AP = {
#     ('vermelho', 'veiculo', 'ε'): [('vermelho', 'veiculo')],
#     ('vermelho', 'troca', 'ε'): [('verde', 'ε')],
#     ('verde', 'veiculo', 'veiculo'): [('verde', 'ε')],
#     ('verde', 'troca', 'ε'): [('amarelo', 'ε')],
#     ('amarelo', 'veiculo', 'veiculo'): [('amarelo', 'ε')],
#     ('amarelo', 'troca', 'ε'): [('vermelho', 'ε')],
# }

# ap = AP_class(estados_AP, alfabeto_AP, alfabeto_AP_Pilha, transicoes_AP, estado_inicial_AP, estado_aceitacao_AP)
# fluxo = ['veiculo','veiculo','troca','veiculo','fim']
# print(ap.processar(fluxo))