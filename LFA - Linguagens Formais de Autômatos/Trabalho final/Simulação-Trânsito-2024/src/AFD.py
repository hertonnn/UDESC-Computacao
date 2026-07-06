class AFD_class:
    def __init__(self, estados, alfabeto, transicoes, estado_inicial, estados_finais):
        
        self.estados = estados
        self.alfabeto = alfabeto
        self.transicoes = transicoes
        self.estado_inicial = estado_inicial
        self.estados_finais = estados_finais

    def processar(self, cadeia):
        
        estado_atual = self.estado_inicial

        for simbolo in cadeia:
            if simbolo not in self.alfabeto:
                print(f"Erro: símbolo '{simbolo}' não pertence ao alfabeto.")
                return False

            if simbolo in self.transicoes[estado_atual]:
                estado_atual = self.transicoes[estado_atual][simbolo]
            else:
                print(f"Erro: não há transição definida para o estado '{estado_atual}' com a instrução '{simbolo}'.")
                return False

        if estado_atual in self.estados_finais:
            return True
        else:
            return False


# # Configuração do AFD_class
# estados = ['q0', 'q1', 'q2']
# alfabeto = {'a', 'b'}
# transicoes = {
#     'q0': {'a': 'q1', 'b': 'q0'},
#     'q1': {'a': 'q1', 'b': 'q2'},
#     'q2': {'a': 'q2', 'b': 'q2'}
# }
# estado_inicial = 'q0'
# estados_finais = {'q2'}

# # Criando o AFD_class
# afd = AFD_class(estados, alfabeto, transicoes, estado_inicial, estados_finais)

# # Testando o AFD_class com cadeias de entrada
# cadeias = ['aab', 'ab', 'aaab', 'bbaa']
# for cadeia in cadeias:
#     resultado = afd.processar(cadeia)
#     print(f"A cadeia '{cadeia}' é {'aceita' if resultado else 'rejeitada'} pelo AFD_class.")
