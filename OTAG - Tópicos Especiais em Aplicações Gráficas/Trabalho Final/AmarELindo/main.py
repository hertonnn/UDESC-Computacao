"""
===============================================================================
EXERGAME: AMAR-É-LINDO (MVP)
===============================================================================
Descrição:
    MVP do exergame baseado na brincadeira de amarelinha.
    O jogador deve memorizar uma sequência de casas iluminadas e reproduzi-la
    clicando com o mouse na ordem correta.

Objetivo do MVP:
    Validar a lógica de programação, mecânica de jogo e feedbacks visuais.
    A interação atual é via mouse; futuramente será integrada com visão
    computacional (câmera + detecção de pose/movimento).

Estrutura de Pastas:
    AmarELindo/
    ├── main.py              (este arquivo)
    └── assets/
        ├── images/          (coloque imagens aqui: logo, backgrounds, etc.)
        ├── sounds/          (coloque sons aqui: acerto.wav, erro.wav, etc.)
        └── fonts/           (coloque fontes .ttf aqui, se desejar)

Fluxo do Jogo:
    1. TELA INICIAL   → Título animado com botão "Jogar"
    2. CATEGORIAS     → Seleção: Iniciante / Intermediário / Avançado
    3. CONTAGEM       → 3... 2... 1... Vai!
    4. MEMORIZAR      → Sequência de casas é iluminada
    5. REPRODUZIR     → Jogador clica nas casas na ordem correta
    6. Repete rodadas com dificuldade crescente dentro da categoria

Sequências:
    As sequências geradas seguem caminhos válidos na amarelinha,
    respeitando a adjacência das casas no layout clássico.

Autor: Desenvolvido como trabalho acadêmico - UDESC
Data: Julho/2026
===============================================================================
"""

import pygame
import random
import sys
import os
import time
import math

# =============================================================================
# COMPATIBILIDADE WINDOWS (encoding do console)
# =============================================================================
try:
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
except Exception:
    pass  # Fallback caso o terminal nao suporte reconfigure

# =============================================================================
# INICIALIZAÇÃO DO PYGAME
# =============================================================================
pygame.init()
pygame.mixer.init()

# =============================================================================
# CONSTANTES DE CONFIGURAÇÃO
# =============================================================================

# --- Dimensões da Tela ---
LARGURA_TELA = 600
ALTURA_TELA = 700
FPS = 60

# --- Paleta de Cores (RGB) ---
BRANCO         = (255, 255, 255)
PRETO          = (0,   0,   0)
CINZA_CLARO    = (200, 200, 200)
CINZA_ESCURO   = (80,  80,  80)
CINZA_MEDIO    = (140, 140, 140)

# Cores do grid da amarelinha
COR_CASA_NORMAL    = (70,  100, 160)   # Azul escuro (casa padrão)
COR_CASA_BORDA     = (40,  60,  110)   # Borda das casas
COR_CASA_HOVER     = (100, 140, 200)   # Hover do mouse sobre a casa

# Cores de feedback
COR_ILUMINADA      = (255, 220, 50)    # Amarelo (sequência sendo mostrada)
COR_ACERTO         = (50,  200, 80)    # Verde (acerto)
COR_ERRO           = (220, 50,  50)    # Vermelho (erro)
COR_DICA           = (180, 120, 255)   # Roxo (dica/ajuda)
COR_CORRETA_FLASH  = (50,  255, 130)   # Verde claro (mostra casa correta no erro)

# Cores de UI
COR_FUNDO          = (25,  25,  40)    # Fundo da tela
COR_PAINEL         = (35,  35,  55)    # Painel de informações
COR_TEXTO_TITULO   = (255, 220, 50)    # Título
COR_TEXTO_INFO     = (200, 200, 220)   # Informações
COR_TEXTO_PONTOS   = (100, 255, 150)   # Pontuação
COR_TEXTO_FASE     = (255, 180, 80)    # Fase

# Cores para categorias
COR_INICIANTE      = (80,  200, 120)   # Verde suave
COR_INTERMEDIARIO  = (255, 180, 50)    # Laranja/Amarelo
COR_AVANCADO       = (220, 60,  80)    # Vermelho

# Cores de botões
COR_BOTAO          = (60,  80,  140)   # Azul médio
COR_BOTAO_HOVER    = (80,  110, 180)   # Azul claro
COR_BOTAO_BORDA    = (100, 130, 200)   # Borda do botão

# --- Dimensões do Grid da Amarelinha ---
# O layout da amarelinha clássica:
#   Casa 9 (topo, sozinha - "Céu")
#   Casas 7 e 8 (lado a lado)
#   Casa 6 (sozinha)
#   Casas 4 e 5 (lado a lado)
#   Casa 3 (sozinha)
#   Casas 1 e 2 (lado a lado)
# (De baixo para cima, como na amarelinha real)

CASA_LARGURA  = 120   # Largura de cada casa
CASA_ALTURA   = 80    # Altura de cada casa
CASA_ESPACO   = 6     # Espaço entre as casas
GRID_OFFSET_X = LARGURA_TELA // 2   # Centro horizontal do grid
GRID_OFFSET_Y = 140                 # Margem superior do grid

# --- Categorias e Fases ---
# Cada categoria tem suas próprias fases de progressão
CATEGORIAS = {
    "INICIANTE": {
        "nome": "Iniciante",
        "cor": COR_INICIANTE,
        "descricao": "Sequências curtas e tempo generoso",
        "icone": "★",
        "fases": {
            "A": {"SEQ": 3, "TMP": 6.0, "nome": "Fase 1 - Aquecimento"},
            "B": {"SEQ": 3, "TMP": 5.0, "nome": "Fase 2 - Caminhada"},
            "C": {"SEQ": 4, "TMP": 5.0, "nome": "Fase 3 - Trote"},
            "D": {"SEQ": 4, "TMP": 4.0, "nome": "Fase 4 - Corrida Leve"},
        },
        "ordem_fases": ["A", "B", "C", "D"],
    },
    "INTERMEDIARIO": {
        "nome": "Intermediário",
        "cor": COR_INTERMEDIARIO,
        "descricao": "Sequências médias e tempo moderado",
        "icone": "★★",
        "fases": {
            "A": {"SEQ": 4, "TMP": 4.5, "nome": "Fase 1 - Desafio"},
            "B": {"SEQ": 5, "TMP": 4.0, "nome": "Fase 2 - Ritmo"},
            "C": {"SEQ": 5, "TMP": 3.5, "nome": "Fase 3 - Velocidade"},
            "D": {"SEQ": 6, "TMP": 3.0, "nome": "Fase 4 - Precisão"},
            "E": {"SEQ": 6, "TMP": 2.5, "nome": "Fase 5 - Mestre"},
        },
        "ordem_fases": ["A", "B", "C", "D", "E"],
    },
    "AVANCADO": {
        "nome": "Avançado",
        "cor": COR_AVANCADO,
        "descricao": "Sequências longas e pouco tempo",
        "icone": "★★★",
        "fases": {
            "A": {"SEQ": 5, "TMP": 3.0, "nome": "Fase 1 - Sprint"},
            "B": {"SEQ": 6, "TMP": 2.5, "nome": "Fase 2 - Turbinado"},
            "C": {"SEQ": 7, "TMP": 2.0, "nome": "Fase 3 - Relâmpago"},
            "D": {"SEQ": 8, "TMP": 1.5, "nome": "Fase 4 - Expert"},
            "E": {"SEQ": 9, "TMP": 1.2, "nome": "Fase 5 - Lenda"},
            "F": {"SEQ": 9, "TMP": 1.0, "nome": "Fase 6 - Imortal"},
        },
        "ordem_fases": ["A", "B", "C", "D", "E", "F"],
    },
}

# --- Adjacência das casas na amarelinha ---
# Define quais casas são vizinhas/acessíveis a partir de cada casa.
# Isso garante que as sequências geradas representem caminhos reais
# que um ser humano poderia percorrer pulando na amarelinha.
#
# Layout (de baixo para cima):
#   Fileira 1 (base):  casas 1 e 2 (lado a lado)  → um pé em cada
#   Fileira 2:         casa 3 (sozinha)            → um pé só
#   Fileira 3:         casas 4 e 5 (lado a lado)   → um pé em cada
#   Fileira 4:         casa 6 (sozinha)             → um pé só
#   Fileira 5:         casas 7 e 8 (lado a lado)    → um pé em cada
#   Fileira 6 (topo):  casa 9 (sozinha - "Céu")    → um pé só
#
# Adjacência: uma casa é vizinha se está na mesma fileira (lado a lado)
# ou na fileira imediatamente acima ou abaixo.
ADJACENCIA = {
    1: [2, 3],         # 1 → vizinho de 2 (mesma fileira), 3 (fileira acima)
    2: [1, 3],         # 2 → vizinho de 1 (mesma fileira), 3 (fileira acima)
    3: [1, 2, 4, 5],   # 3 → vizinho de 1,2 (fileira abaixo), 4,5 (fileira acima)
    4: [3, 5, 6],      # 4 → vizinho de 3 (abaixo), 5 (mesma fileira), 6 (acima)
    5: [3, 4, 6],      # 5 → vizinho de 3 (abaixo), 4 (mesma fileira), 6 (acima)
    6: [4, 5, 7, 8],   # 6 → vizinho de 4,5 (abaixo), 7,8 (acima)
    7: [6, 8, 9],      # 7 → vizinho de 6 (abaixo), 8 (mesma fileira), 9 (acima)
    8: [6, 7, 9],      # 8 → vizinho de 6 (abaixo), 7 (mesma fileira), 9 (acima)
    9: [7, 8],         # 9 → vizinho de 7,8 (fileira abaixo)
}

# --- Timing ---
TEMPO_FLASH_CASA    = 0.5     # Tempo que cada casa fica iluminada na sequência (s)
TEMPO_INTERVALO     = 0.2     # Intervalo entre cada flash da sequência (s)
TEMPO_FEEDBACK      = 0.6     # Tempo que o feedback (verde/vermelho) fica visível (s)
TEMPO_DICA          = 3.0     # Segundos de inatividade antes de mostrar a dica
TEMPO_DICA_FLASH    = 0.3     # Tempo que cada casa pisca na dica (s)
TEMPO_MOSTRA_CORRETA = 1.0   # Tempo para mostrar a casa correta após erro (s)
TEMPO_CONTAGEM      = 1.0    # Tempo de cada número na contagem regressiva (s)

# --- Pontuação ---
PONTOS_ACERTO     = 10    # Pontos por casa correta
PONTOS_BONUS      = 20    # Bônus por sequência completa
PONTOS_DESCONTO   = -10   # Desconto ao usar dica
# Em caso de erro, a pontuação da rodada é zerada


# =============================================================================
# LAYOUT DA AMARELINHA (Posições das casas)
# =============================================================================
def calcular_posicoes_amarelinha():
    """
    Calcula as posições (Rect) de cada casa da amarelinha no formato clássico.
    Retorna um dicionário {numero_casa: pygame.Rect}.

    Layout (de baixo para cima):
        Fileira 1 (base):  casas 1 e 2 (lado a lado)
        Fileira 2:         casa 3 (centralizada)
        Fileira 3:         casas 4 e 5 (lado a lado)
        Fileira 4:         casa 6 (centralizada)
        Fileira 5:         casas 7 e 8 (lado a lado)
        Fileira 6 (topo):  casa 9 (centralizada - "Céu")

    NOTA PARA INTEGRAÇÃO FUTURA COM CÂMERA:
        Estas coordenadas de tela poderão ser mapeadas para regiões do mundo real
        detectadas pela visão computacional. Basta substituir a verificação de
        "clique do mouse dentro do Rect" por "posição do jogador na região".
    """
    posicoes = {}
    cx = GRID_OFFSET_X  # Centro horizontal

    # Calculamos de cima para baixo (topo → base)
    # Fileira 6 (topo) - Casa 9 ("Céu")
    y = GRID_OFFSET_Y
    posicoes[9] = pygame.Rect(
        cx - CASA_LARGURA // 2, y,
        CASA_LARGURA, CASA_ALTURA
    )

    # Fileira 5 - Casas 7 e 8 (lado a lado)
    y += CASA_ALTURA + CASA_ESPACO
    posicoes[7] = pygame.Rect(
        cx - CASA_LARGURA - CASA_ESPACO // 2, y,
        CASA_LARGURA, CASA_ALTURA
    )
    posicoes[8] = pygame.Rect(
        cx + CASA_ESPACO // 2, y,
        CASA_LARGURA, CASA_ALTURA
    )

    # Fileira 4 - Casa 6 (centralizada)
    y += CASA_ALTURA + CASA_ESPACO
    posicoes[6] = pygame.Rect(
        cx - CASA_LARGURA // 2, y,
        CASA_LARGURA, CASA_ALTURA
    )

    # Fileira 3 - Casas 4 e 5 (lado a lado)
    y += CASA_ALTURA + CASA_ESPACO
    posicoes[4] = pygame.Rect(
        cx - CASA_LARGURA - CASA_ESPACO // 2, y,
        CASA_LARGURA, CASA_ALTURA
    )
    posicoes[5] = pygame.Rect(
        cx + CASA_ESPACO // 2, y,
        CASA_LARGURA, CASA_ALTURA
    )

    # Fileira 2 - Casa 3 (centralizada)
    y += CASA_ALTURA + CASA_ESPACO
    posicoes[3] = pygame.Rect(
        cx - CASA_LARGURA // 2, y,
        CASA_LARGURA, CASA_ALTURA
    )

    # Fileira 1 (base) - Casas 1 e 2 (lado a lado)
    y += CASA_ALTURA + CASA_ESPACO
    posicoes[1] = pygame.Rect(
        cx - CASA_LARGURA - CASA_ESPACO // 2, y,
        CASA_LARGURA, CASA_ALTURA
    )
    posicoes[2] = pygame.Rect(
        cx + CASA_ESPACO // 2, y,
        CASA_LARGURA, CASA_ALTURA
    )

    return posicoes


# =============================================================================
# CLASSE PRINCIPAL DO JOGO
# =============================================================================
class JogoAmarelinha:
    """
    Classe principal que gerencia todo o fluxo do exergame.

    Fluxo de Estados:
        TELA_INICIAL → SELECAO_CATEGORIA → CONTAGEM → MEMORIZAR
        → REPRODUZIR → FEEDBACK → FIM_RODADA → (repete)
        → GAME_OVER → TELA_INICIAL

    NOTA PARA INTEGRAÇÃO FUTURA COM CÂMERA:
        O método 'processar_entrada_jogador()' é o ponto central de entrada
        de interação. Atualmente verifica cliques do mouse. Para integrar
        com visão computacional, basta substituir/complementar este método
        para receber as coordenadas do jogador detectadas pela câmera.
    """

    # --- Estados do Jogo ---
    ESTADO_TELA_INICIAL     = "TELA_INICIAL"
    ESTADO_SELECAO          = "SELECAO_CATEGORIA"
    ESTADO_CONTAGEM         = "CONTAGEM"
    ESTADO_MEMORIZAR        = "MEMORIZAR"
    ESTADO_REPRODUZIR       = "REPRODUZIR"
    ESTADO_FEEDBACK         = "FEEDBACK"
    ESTADO_DICA             = "DICA"
    ESTADO_FIM_RODADA       = "FIM_RODADA"
    ESTADO_GAME_OVER        = "GAME_OVER"

    def __init__(self):
        """Inicializa o jogo, configurando tela, fontes, sons e estado inicial."""

        # --- Configuração da Tela ---
        self.tela = pygame.display.set_mode((LARGURA_TELA, ALTURA_TELA))
        pygame.display.set_caption("AMAR-É-LINDO — Exergame de Amarelinha")
        self.clock = pygame.time.Clock()

        # --- Fontes ---
        self.fonte_titulo    = pygame.font.SysFont("Arial", 52, bold=True)
        self.fonte_subtitulo = pygame.font.SysFont("Arial", 28)
        self.fonte_casa      = pygame.font.SysFont("Arial", 36, bold=True)
        self.fonte_info      = pygame.font.SysFont("Arial", 22)
        self.fonte_pontos    = pygame.font.SysFont("Arial", 32, bold=True)
        self.fonte_feedback  = pygame.font.SysFont("Arial", 32, bold=True)
        self.fonte_instrucao = pygame.font.SysFont("Arial", 20)
        self.fonte_botao     = pygame.font.SysFont("Arial", 26, bold=True)
        self.fonte_contagem  = pygame.font.SysFont("Arial", 120, bold=True)
        self.fonte_categoria_titulo = pygame.font.SysFont("Arial", 30, bold=True)
        self.fonte_categoria_desc   = pygame.font.SysFont("Arial", 18)
        self.fonte_categoria_icone  = pygame.font.SysFont("Arial", 24)

        # --- Posições das Casas ---
        self.casas = calcular_posicoes_amarelinha()

        # --- Estado do Jogo ---
        self.estado = self.ESTADO_TELA_INICIAL
        self.categoria_selecionada = None     # "INICIANTE", "INTERMEDIARIO", "AVANCADO"
        self.fase_atual = "A"
        self.sequencia = []              # Sequência gerada para memorização
        self.indice_sequencia = 0        # Índice da próxima casa na sequência
        self.indice_jogador = 0          # Índice da casa que o jogador deve acertar
        self.pontuacao_total = 0         # Pontuação acumulada
        self.pontuacao_rodada = 0        # Pontuação da rodada atual
        self.rodada = 0                  # Número da rodada
        self.vidas = 3                   # Vidas do jogador

        # --- Controle de Animações/Tempo ---
        self.tempo_inicio_estado = 0     # Quando o estado atual começou
        self.casa_iluminada = None       # Qual casa está iluminada agora
        self.casa_feedback = None        # Casa com feedback (acerto/erro)
        self.cor_feedback = None         # Cor do feedback atual
        self.casa_correta_flash = None   # Casa correta sendo mostrada após erro
        self.ultimo_clique_tempo = 0     # Tempo do último clique (para dica)
        self.dica_usada = False          # Se a dica foi usada na rodada
        self.dica_indice = 0             # Índice da dica sendo mostrada
        self.mensagem_feedback = ""      # Mensagem de feedback para o jogador

        # --- Controle do Flash da Sequência ---
        self.flash_inicio = 0           # Tempo de início do flash atual
        self.flash_casa_idx = 0         # Índice da casa sendo mostrada na sequência
        self.mostrando_flash = False    # Se está no momento de mostrar uma casa

        # --- Controle da Contagem Regressiva ---
        self.contagem_numero = 3        # Número atual da contagem (3, 2, 1)
        self.contagem_inicio = 0        # Tempo de início da contagem

        # --- Animações da Tela Inicial ---
        self.tempo_inicio_jogo = time.time()  # Para animações baseadas em tempo

        # --- Botões da Tela Inicial ---
        self.botao_jogar = pygame.Rect(
            LARGURA_TELA // 2 - 120, 480, 240, 60
        )

        # --- Botões de Categoria ---
        self.botoes_categoria = {}
        self._criar_botoes_categoria()

        # --- Botão Voltar ---
        self.botao_voltar = pygame.Rect(20, ALTURA_TELA - 60, 120, 40)

        # --- Carregamento de Sons (Opcional) ---
        self.sons = self._carregar_sons()

        # --- Log Inicial ---
        print("=" * 60)
        print("  AMAR-E-LINDO - Exergame de Amarelinha (MVP)")
        print("=" * 60)
        print(f"  Casas do grid: {list(self.casas.keys())}")
        print(f"  Categorias: Iniciante, Intermediario, Avancado")
        print("=" * 60)

    def _criar_botoes_categoria(self):
        """Cria os retângulos dos botões de seleção de categoria."""
        largura_cartao = 460
        altura_cartao = 120
        espaco = 25
        inicio_y = 160

        for i, chave in enumerate(["INICIANTE", "INTERMEDIARIO", "AVANCADO"]):
            y = inicio_y + i * (altura_cartao + espaco)
            self.botoes_categoria[chave] = pygame.Rect(
                LARGURA_TELA // 2 - largura_cartao // 2, y,
                largura_cartao, altura_cartao
            )

    def _carregar_sons(self):
        """
        Carrega os arquivos de som, se existirem.
        Retorna um dicionário com os sons carregados.

        Para adicionar sons, coloque arquivos .mp3 na pasta assets/sounds/:
            - acerto.mp3  : som de acerto
            - erro.mp3    : som de erro
            - dica.mp3    : som de dica
            - bonus.mp3   : som de bônus
            - inicio.mp3  : som de início de rodada
        """
        sons = {}
        pasta_sons = os.path.join(os.path.dirname(__file__), "assets", "sounds")

        nomes_sons = ["acerto", "erro", "dica", "bonus", "inicio"]
        for nome in nomes_sons:
            caminho = os.path.join(pasta_sons, f"{nome}.mp3")
            if os.path.exists(caminho):
                try:
                    sons[nome] = pygame.mixer.Sound(caminho)
                    print(f"  [SOM] Carregado: {nome}.mp3")
                except Exception as e:
                    print(f"  [SOM] Erro ao carregar {nome}.mp3: {e}")
            else:
                sons[nome] = None  # Som não disponível
        return sons

    def _tocar_som(self, nome):
        """Toca um som se ele estiver disponível."""
        if nome in self.sons and self.sons[nome] is not None:
            self.sons[nome].play()

    # =========================================================================
    # GERAÇÃO DE SEQUÊNCIA (CAMINHO VÁLIDO NA AMARELINHA)
    # =========================================================================
    def gerar_sequencia(self):
        """
        Gera uma nova sequência de casas que forma um caminho válido
        na amarelinha, respeitando a adjacência entre as casas.

        O caminho começa na base (casas 1 ou 2) e segue subindo pela
        amarelinha de forma que cada próxima casa seja vizinha da anterior.
        Isso garante que a sequência seja humanamente possível de percorrer.

        Exemplos de sequências válidas:
            [1, 3, 4, 6, 7, 9]     → subindo pela esquerda
            [2, 3, 5, 6, 8, 9]     → subindo pela direita
            [1, 2, 3, 4, 5, 6]     → zigue-zague na base
            [1, 3, 5, 4, 6, 8, 9]  → caminho misto
        """
        cat = CATEGORIAS[self.categoria_selecionada]
        tamanho = cat["fases"][self.fase_atual]["SEQ"]

        # Gera o caminho válido
        self.sequencia = self._gerar_caminho_valido(tamanho)

        print(f"\n  [SEQUENCIA] Gerada: {self.sequencia}")
        print(f"  [FASE] {cat['fases'][self.fase_atual]['nome']}")
        print(f"  [TEMPO] Memorizacao: {cat['fases'][self.fase_atual]['TMP']}s")

    def _gerar_caminho_valido(self, tamanho):
        """
        Gera um caminho válido de 'tamanho' casas na amarelinha.

        Regras:
        1. Começa na base (casa 1 ou 2)
        2. Cada próxima casa deve ser vizinha da anterior (ver ADJACENCIA)
        3. Prioriza avançar para cima (casas com número maior)
        4. Evita repetir a casa imediatamente anterior
        5. Tenta cobrir casas diferentes para variar o caminho

        Returns:
            Lista de inteiros representando o caminho (ex: [1, 3, 4, 6, 7, 9])
        """
        max_tentativas = 50
        melhor_caminho = None

        for _ in range(max_tentativas):
            caminho = self._tentar_gerar_caminho(tamanho)
            if caminho and len(caminho) == tamanho:
                # Verificação: caminho tem casas suficientemente variadas?
                casas_unicas = len(set(caminho))
                if melhor_caminho is None or casas_unicas > len(set(melhor_caminho)):
                    melhor_caminho = caminho
                # Se temos boa variedade, aceita
                if casas_unicas >= min(tamanho, 6):
                    return caminho

        # Retorna o melhor caminho encontrado, ou gera um simples como fallback
        if melhor_caminho:
            return melhor_caminho

        # Fallback: caminho simples subindo
        return self._caminho_fallback(tamanho)

    def _tentar_gerar_caminho(self, tamanho):
        """
        Tenta gerar um caminho válido de 'tamanho' passos.

        Usa uma heurística que:
        - Começa da base (casa 1 ou 2, aleatoriamente)
        - Prioriza subir (vizinhos com número maior) com peso maior
        - Permite voltar ou ir para o lado com peso menor
        - Evita repetir a casa imediatamente anterior

        Returns:
            Lista de inteiros ou None se falhou.
        """
        # Escolhe casa inicial na base
        casa_atual = random.choice([1, 2])
        caminho = [casa_atual]
        visitadas_recentes = {casa_atual}

        for _ in range(tamanho - 1):
            vizinhos = ADJACENCIA[casa_atual]

            # Filtra vizinhos para evitar repetir a casa imediatamente anterior
            if len(caminho) >= 2:
                casa_anterior = caminho[-2]
                opcoes = [v for v in vizinhos if v != casa_anterior]
            else:
                opcoes = list(vizinhos)

            if not opcoes:
                opcoes = list(vizinhos)  # Se não tem opção, aceita qualquer vizinho

            # Calcula pesos: prioriza casas maiores (subir) e não visitadas
            pesos = []
            for v in opcoes:
                peso = 1.0
                # Bonus para subir (casas com número maior)
                if v > casa_atual:
                    peso += 3.0
                # Bonus para casas ainda não visitadas recentemente
                if v not in visitadas_recentes:
                    peso += 2.0
                pesos.append(peso)

            # Escolhe com base nos pesos
            total_peso = sum(pesos)
            pesos_norm = [p / total_peso for p in pesos]
            escolha = random.choices(opcoes, weights=pesos_norm, k=1)[0]

            caminho.append(escolha)
            casa_atual = escolha
            visitadas_recentes.add(escolha)

        return caminho

    def _caminho_fallback(self, tamanho):
        """
        Gera um caminho fallback simples subindo pela amarelinha.
        Usado como último recurso se a geração aleatória falhar.
        """
        # Caminhos predefinidos subindo
        caminhos_base = [
            [1, 3, 4, 6, 7, 9, 8, 6, 5, 3],  # Subindo pela esquerda, descendo
            [2, 3, 5, 6, 8, 9, 7, 6, 4, 3],   # Subindo pela direita, descendo
            [1, 2, 3, 4, 5, 6, 7, 8, 9, 7],   # Zigue-zague completo
            [2, 1, 3, 5, 4, 6, 8, 7, 9, 8],   # Alternando lados
        ]
        caminho = random.choice(caminhos_base)
        return caminho[:tamanho]

    # =========================================================================
    # TRANSIÇÕES DE ESTADO
    # =========================================================================
    def selecionar_categoria(self, categoria):
        """Seleciona uma categoria e vai para a contagem regressiva."""
        self.categoria_selecionada = categoria
        self.fase_atual = CATEGORIAS[categoria]["ordem_fases"][0]
        self.pontuacao_total = 0
        self.rodada = 0
        self.vidas = 3

        print(f"\n  [CATEGORIA] Selecionada: {CATEGORIAS[categoria]['nome']}")
        print(f"  [FASE] Inicial: {CATEGORIAS[categoria]['fases'][self.fase_atual]['nome']}")

        self._iniciar_contagem()

    def _iniciar_contagem(self):
        """Inicia a contagem regressiva antes de começar a rodada."""
        self.estado = self.ESTADO_CONTAGEM
        self.contagem_numero = 3
        self.contagem_inicio = time.time()
        print(f"  [CONTAGEM] 3... 2... 1... Vai!")

    def iniciar_rodada(self):
        """Inicia uma nova rodada: gera sequência e entra em modo memorização."""
        self.rodada += 1
        self.gerar_sequencia()
        self.indice_jogador = 0
        self.pontuacao_rodada = 0
        self.dica_usada = False
        self.casa_feedback = None
        self.cor_feedback = None
        self.casa_correta_flash = None
        self.mensagem_feedback = ""

        # Inicia a animação de mostrar a sequência
        self.estado = self.ESTADO_MEMORIZAR
        self.flash_casa_idx = 0
        self.mostrando_flash = True
        self.flash_inicio = time.time()
        self.casa_iluminada = self.sequencia[0]
        self._tocar_som("inicio")

        print(f"\n  --- RODADA {self.rodada} ---")
        print(f"  [ESTADO] MEMORIZAR -> Mostrando sequencia...")

    def iniciar_reproducao(self):
        """Transição para o modo de reprodução (jogador clica)."""
        self.estado = self.ESTADO_REPRODUZIR
        self.indice_jogador = 0
        self.casa_iluminada = None
        self.ultimo_clique_tempo = time.time()
        print(f"  [ESTADO] REPRODUZIR -> Aguardando jogador...")

    def avancar_fase(self):
        """
        Avança para a próxima fase dentro da categoria selecionada.
        Se já estiver na última fase, permanece nela.
        """
        cat = CATEGORIAS[self.categoria_selecionada]
        ordem = cat["ordem_fases"]
        idx = ordem.index(self.fase_atual)
        if idx < len(ordem) - 1:
            self.fase_atual = ordem[idx + 1]
            print(f"\n  * AVANCOU PARA: {cat['fases'][self.fase_atual]['nome']}")
            print(f"    SEQ: {cat['fases'][self.fase_atual]['SEQ']} casas")
            print(f"    TMP: {cat['fases'][self.fase_atual]['TMP']}s")
        else:
            print(f"\n  * Ja esta na fase maxima: {cat['fases'][self.fase_atual]['nome']}")

    # =========================================================================
    # PROCESSAMENTO DE ENTRADA DO JOGADOR
    # =========================================================================
    def processar_entrada_jogador(self, pos_mouse):
        """
        Verifica se o jogador clicou em uma casa e processa a jogada.

        NOTA PARA INTEGRAÇÃO FUTURA COM CÂMERA:
        ========================================
        Este método é o PONTO PRINCIPAL de integração.
        Atualmente recebe 'pos_mouse' (x, y) do clique do mouse.

        Para integrar com visão computacional:
        1. Obtenha a posição do jogador via câmera (ex: MediaPipe Pose)
        2. Mapeie a posição do corpo para coordenadas do grid
        3. Chame este método passando as coordenadas mapeadas
           em vez de pos_mouse.

        Exemplo futuro:
            pos_jogador = camera.detectar_posicao_pe()  # retorna (x, y)
            pos_grid = mapear_para_grid(pos_jogador)
            self.processar_entrada_jogador(pos_grid)
        ========================================

        Args:
            pos_mouse: tupla (x, y) da posição do clique
        """
        if self.estado != self.ESTADO_REPRODUZIR:
            return

        # Verifica em qual casa o jogador clicou
        casa_clicada = None
        for numero, rect in self.casas.items():
            if rect.collidepoint(pos_mouse):
                casa_clicada = numero
                break

        if casa_clicada is None:
            return  # Clicou fora de qualquer casa

        # Reset do temporizador de dica
        self.ultimo_clique_tempo = time.time()

        # Verifica se a casa clicada é a correta
        casa_esperada = self.sequencia[self.indice_jogador]

        if casa_clicada == casa_esperada:
            # ✅ ACERTO
            self._processar_acerto(casa_clicada)
        else:
            # ❌ ERRO
            self._processar_erro(casa_clicada, casa_esperada)

    def _processar_acerto(self, casa):
        """Processa um acerto do jogador."""
        self.pontuacao_rodada += PONTOS_ACERTO
        self.casa_feedback = casa
        self.cor_feedback = COR_ACERTO
        self.mensagem_feedback = f"+{PONTOS_ACERTO} pontos!"
        self.tempo_inicio_estado = time.time()
        self.estado = self.ESTADO_FEEDBACK
        self._tocar_som("acerto")

        print(f"  [OK] ACERTO! Casa {casa} (posicao {self.indice_jogador + 1}/{len(self.sequencia)})")
        print(f"     Pontos rodada: {self.pontuacao_rodada}")

        self.indice_jogador += 1

        # Verifica se completou a sequência
        if self.indice_jogador >= len(self.sequencia):
            # Sequência completa! Bônus!
            self.pontuacao_rodada += PONTOS_BONUS
            self.pontuacao_total += self.pontuacao_rodada
            self.mensagem_feedback = f"Sequencia completa! +{PONTOS_BONUS} bonus!"
            self._tocar_som("bonus")

            print(f"  [!!] SEQUENCIA COMPLETA!")
            print(f"     Bonus: +{PONTOS_BONUS}")
            print(f"     Pontos rodada: {self.pontuacao_rodada}")
            print(f"     Pontos total: {self.pontuacao_total}")

            # Avança de fase
            self.avancar_fase()
            self.estado = self.ESTADO_FIM_RODADA

    def _processar_erro(self, casa_clicada, casa_esperada):
        """Processa um erro do jogador."""
        self.casa_feedback = casa_clicada
        self.cor_feedback = COR_ERRO
        self.casa_correta_flash = casa_esperada
        self.pontuacao_rodada = 0  # Zera pontuação da rodada
        self.vidas -= 1
        self.mensagem_feedback = f"X Errou! Era casa {casa_esperada}"
        self.tempo_inicio_estado = time.time()
        self.estado = self.ESTADO_FEEDBACK
        self._tocar_som("erro")

        print(f"  [X] ERRO! Clicou {casa_clicada}, esperava {casa_esperada}")
        print(f"     Pontos rodada ZERADOS!")
        print(f"     Vidas restantes: {self.vidas}")
        print(f"     Pontos total: {self.pontuacao_total}")

        if self.vidas <= 0:
            self.estado = self.ESTADO_GAME_OVER
            print(f"\n  [!!] GAME OVER! Pontuacao final: {self.pontuacao_total}")

    def verificar_dica(self):
        """
        Verifica se o jogador ficou ocioso por TEMPO_DICA segundos.
        Se sim, ativa o sistema de dica.
        """
        if self.estado != self.ESTADO_REPRODUZIR:
            return

        tempo_ocioso = time.time() - self.ultimo_clique_tempo
        if tempo_ocioso >= TEMPO_DICA:
            self._ativar_dica()

    def _ativar_dica(self):
        """Ativa o sistema de dica, mostrando o caminho correto."""
        self.estado = self.ESTADO_DICA
        self.dica_usada = True
        self.dica_indice = self.indice_jogador  # Começa da posição atual
        self.flash_inicio = time.time()
        self.mostrando_flash = True
        self.casa_iluminada = self.sequencia[self.dica_indice]
        self._tocar_som("dica")

        # Aplica desconto
        self.pontuacao_rodada += PONTOS_DESCONTO
        if self.pontuacao_rodada < 0:
            self.pontuacao_rodada = 0

        print(f"  [?] DICA ATIVADA! Desconto: {PONTOS_DESCONTO} pontos")
        print(f"     Mostrando sequencia restante a partir da posicao {self.indice_jogador + 1}")
        print(f"     Pontos rodada: {self.pontuacao_rodada}")

    # =========================================================================
    # ATUALIZAÇÃO DO JOGO (GAME LOOP)
    # =========================================================================
    def atualizar(self):
        """
        Atualiza o estado do jogo a cada frame.
        Gerencia animações, temporizadores e transições de estado.
        """
        agora = time.time()

        # --- Estado: CONTAGEM (Contagem regressiva) ---
        if self.estado == self.ESTADO_CONTAGEM:
            self._atualizar_contagem(agora)

        # --- Estado: MEMORIZAR (Mostrando sequência) ---
        elif self.estado == self.ESTADO_MEMORIZAR:
            self._atualizar_memorizacao(agora)

        # --- Estado: REPRODUZIR (Aguardando jogador) ---
        elif self.estado == self.ESTADO_REPRODUZIR:
            self.verificar_dica()

        # --- Estado: FEEDBACK (Mostrando resultado do clique) ---
        elif self.estado == self.ESTADO_FEEDBACK:
            if agora - self.tempo_inicio_estado >= TEMPO_FEEDBACK:
                # Se era erro e temos a casa correta para mostrar
                if self.cor_feedback == COR_ERRO and self.casa_correta_flash is not None:
                    # Mostra a casa correta por um momento
                    if agora - self.tempo_inicio_estado >= TEMPO_FEEDBACK + TEMPO_MOSTRA_CORRETA:
                        self.casa_correta_flash = None
                        self.casa_feedback = None
                        self.cor_feedback = None
                        if self.vidas > 0:
                            self.estado = self.ESTADO_FIM_RODADA
                elif self.cor_feedback == COR_ACERTO:
                    # Se foi acerto e ainda há casas na sequência
                    self.casa_feedback = None
                    self.cor_feedback = None
                    if self.indice_jogador < len(self.sequencia):
                        self.estado = self.ESTADO_REPRODUZIR
                        self.ultimo_clique_tempo = time.time()

        # --- Estado: DICA (Mostrando caminho correto) ---
        elif self.estado == self.ESTADO_DICA:
            self._atualizar_dica(agora)

        # --- Estado: FIM_RODADA (Transição entre rodadas) ---
        elif self.estado == self.ESTADO_FIM_RODADA:
            if agora - self.tempo_inicio_estado >= 2.0:
                self._iniciar_contagem()

    def _atualizar_contagem(self, agora):
        """Atualiza a contagem regressiva (3, 2, 1, Vai!)."""
        tempo_decorrido = agora - self.contagem_inicio

        if tempo_decorrido >= TEMPO_CONTAGEM:
            self.contagem_numero -= 1
            self.contagem_inicio = agora

            if self.contagem_numero <= 0:
                # Contagem terminou → iniciar rodada
                self.iniciar_rodada()

    def _atualizar_memorizacao(self, agora):
        """Atualiza a animação de memorização (flash da sequência)."""
        tempo_decorrido = agora - self.flash_inicio

        if self.mostrando_flash:
            # Casa está iluminada
            if tempo_decorrido >= TEMPO_FLASH_CASA:
                # Apaga a casa
                self.mostrando_flash = False
                self.casa_iluminada = None
                self.flash_inicio = agora
        else:
            # Intervalo entre casas
            if tempo_decorrido >= TEMPO_INTERVALO:
                self.flash_casa_idx += 1
                if self.flash_casa_idx < len(self.sequencia):
                    # Próxima casa
                    self.mostrando_flash = True
                    self.casa_iluminada = self.sequencia[self.flash_casa_idx]
                    self.flash_inicio = agora
                else:
                    # Fim da sequência → modo reprodução
                    self.iniciar_reproducao()

    def _atualizar_dica(self, agora):
        """Atualiza a animação de dica."""
        tempo_decorrido = agora - self.flash_inicio

        if self.mostrando_flash:
            if tempo_decorrido >= TEMPO_DICA_FLASH:
                self.mostrando_flash = False
                self.casa_iluminada = None
                self.flash_inicio = agora
        else:
            if tempo_decorrido >= TEMPO_INTERVALO:
                self.dica_indice += 1
                if self.dica_indice < len(self.sequencia):
                    self.mostrando_flash = True
                    self.casa_iluminada = self.sequencia[self.dica_indice]
                    self.flash_inicio = agora
                else:
                    # Fim da dica → volta para reprodução
                    self.casa_iluminada = None
                    self.estado = self.ESTADO_REPRODUZIR
                    self.ultimo_clique_tempo = time.time()
                    print(f"  [DICA] Finalizada. Aguardando jogador novamente...")

    # =========================================================================
    # RENDERIZAÇÃO (DESENHO NA TELA)
    # =========================================================================
    def desenhar(self):
        """Desenha todos os elementos na tela."""
        self.tela.fill(COR_FUNDO)

        if self.estado == self.ESTADO_TELA_INICIAL:
            self._desenhar_tela_inicial()
        elif self.estado == self.ESTADO_SELECAO:
            self._desenhar_selecao_categoria()
        elif self.estado == self.ESTADO_CONTAGEM:
            self._desenhar_contagem()
        elif self.estado == self.ESTADO_GAME_OVER:
            self._desenhar_game_over()
        else:
            self._desenhar_hud()
            self._desenhar_amarelinha()
            self._desenhar_mensagem_estado()

        pygame.display.flip()

    def _desenhar_tela_inicial(self):
        """Desenha a tela inicial com título animado e botão Jogar."""
        agora = time.time()
        t = agora - self.tempo_inicio_jogo

        # --- Fundo com partículas decorativas animadas ---
        self._desenhar_particulas(t)

        # --- Título com efeito de brilho pulsante ---
        # Calcula cor pulsante para o título
        pulso = (math.sin(t * 2) + 1) / 2  # 0 a 1
        cor_titulo = (
            int(255 * (0.8 + 0.2 * pulso)),
            int(220 * (0.7 + 0.3 * pulso)),
            int(50 + 80 * pulso),
        )

        titulo = self.fonte_titulo.render("AMAR-É-LINDO", True, cor_titulo)
        titulo_x = LARGURA_TELA // 2 - titulo.get_width() // 2
        titulo_y = 120 + int(math.sin(t * 1.5) * 5)  # Flutuação suave
        self.tela.blit(titulo, (titulo_x, titulo_y))

        # Linha decorativa sob o título
        linha_y = titulo_y + titulo.get_height() + 10
        largura_linha = int(300 + 50 * math.sin(t * 2))
        pygame.draw.line(
            self.tela, COR_TEXTO_TITULO,
            (LARGURA_TELA // 2 - largura_linha // 2, linha_y),
            (LARGURA_TELA // 2 + largura_linha // 2, linha_y),
            3
        )

        # --- Subtítulo ---
        subtitulo = self.fonte_subtitulo.render("Exergame de Amarelinha", True, COR_TEXTO_INFO)
        self.tela.blit(subtitulo, (LARGURA_TELA // 2 - subtitulo.get_width() // 2, 210))

        # --- Ícone de amarelinha decorativa ---
        self._desenhar_amarelinha_mini(LARGURA_TELA // 2, 340, t)

        # --- Botão JOGAR com efeito hover ---
        pos_mouse = pygame.mouse.get_pos()
        hover = self.botao_jogar.collidepoint(pos_mouse)

        # Animação do botão
        escala_botao = 1.0 + 0.03 * math.sin(t * 3) if not hover else 1.05
        botao_rect = self.botao_jogar.copy()
        if hover:
            botao_rect.inflate_ip(10, 6)

        # Sombra do botão
        sombra = botao_rect.copy()
        sombra.move_ip(3, 3)
        pygame.draw.rect(self.tela, (15, 15, 25), sombra, border_radius=15)

        # Corpo do botão
        cor_botao = COR_BOTAO_HOVER if hover else COR_BOTAO
        pygame.draw.rect(self.tela, cor_botao, botao_rect, border_radius=15)
        pygame.draw.rect(self.tela, COR_BOTAO_BORDA, botao_rect, width=2, border_radius=15)

        # Texto do botão
        txt_jogar = self.fonte_botao.render("JOGAR", True, BRANCO)
        self.tela.blit(
            txt_jogar,
            (botao_rect.centerx - txt_jogar.get_width() // 2,
             botao_rect.centery - txt_jogar.get_height() // 2)
        )

        # --- Instrução sutil ---
        instrucao = self.fonte_instrucao.render(
            "Pressione ESC para sair  |  R para reiniciar", True, CINZA_ESCURO
        )
        self.tela.blit(instrucao, (LARGURA_TELA // 2 - instrucao.get_width() // 2, ALTURA_TELA - 40))

    def _desenhar_particulas(self, t):
        """Desenha partículas decorativas animadas no fundo."""
        random.seed(42)  # Seed fixa para partículas consistentes
        for i in range(20):
            x = random.randint(0, LARGURA_TELA)
            y = random.randint(0, ALTURA_TELA)
            # Movimento suave
            x = (x + int(math.sin(t * 0.5 + i) * 30)) % LARGURA_TELA
            y = (y + int(math.cos(t * 0.3 + i * 0.7) * 20)) % ALTURA_TELA
            raio = int(2 + math.sin(t + i) * 1.5)
            alpha = int(40 + 30 * math.sin(t * 0.8 + i))
            cor = (
                60 + int(30 * math.sin(t + i)),
                80 + int(40 * math.sin(t * 0.7 + i)),
                160 + int(40 * math.sin(t * 0.5 + i))
            )
            pygame.draw.circle(self.tela, cor, (x, y), max(1, raio))
        random.seed()  # Restaura seed aleatória

    def _desenhar_amarelinha_mini(self, cx, cy, t):
        """Desenha uma amarelinha em miniatura decorativa para a tela inicial."""
        mini_w = 30
        mini_h = 22
        mini_esp = 3

        # Layout miniatura (de cima para baixo)
        casas_mini = []
        y = cy - 3 * (mini_h + mini_esp)

        # Casa 9 (topo)
        casas_mini.append((cx - mini_w // 2, y, mini_w, mini_h, 9))
        y += mini_h + mini_esp

        # Casas 7 e 8
        casas_mini.append((cx - mini_w - mini_esp // 2, y, mini_w, mini_h, 7))
        casas_mini.append((cx + mini_esp // 2, y, mini_w, mini_h, 8))
        y += mini_h + mini_esp

        # Casa 6
        casas_mini.append((cx - mini_w // 2, y, mini_w, mini_h, 6))
        y += mini_h + mini_esp

        # Casas 4 e 5
        casas_mini.append((cx - mini_w - mini_esp // 2, y, mini_w, mini_h, 4))
        casas_mini.append((cx + mini_esp // 2, y, mini_w, mini_h, 5))
        y += mini_h + mini_esp

        # Casa 3
        casas_mini.append((cx - mini_w // 2, y, mini_w, mini_h, 3))
        y += mini_h + mini_esp

        # Casas 1 e 2
        casas_mini.append((cx - mini_w - mini_esp // 2, y, mini_w, mini_h, 1))
        casas_mini.append((cx + mini_esp // 2, y, mini_w, mini_h, 2))

        for (mx, my, mw, mh, num) in casas_mini:
            # Animação: ilumina casas em sequência
            idx_anim = int(t * 2) % 9 + 1
            if num == idx_anim:
                cor = COR_ILUMINADA
            else:
                cor = COR_CASA_NORMAL

            rect = pygame.Rect(mx, my, mw, mh)
            pygame.draw.rect(self.tela, cor, rect, border_radius=4)
            pygame.draw.rect(self.tela, COR_CASA_BORDA, rect, width=1, border_radius=4)

            # Número pequeno
            num_font = pygame.font.SysFont("Arial", 12, bold=True)
            num_txt = num_font.render(str(num), True, BRANCO)
            self.tela.blit(
                num_txt,
                (rect.centerx - num_txt.get_width() // 2,
                 rect.centery - num_txt.get_height() // 2)
            )

    def _desenhar_selecao_categoria(self):
        """Desenha a tela de seleção de categoria com cartões."""
        agora = time.time()
        t = agora - self.tempo_inicio_jogo

        # --- Título ---
        titulo = self.fonte_titulo.render("ESCOLHA A CATEGORIA", True, COR_TEXTO_TITULO)
        self.tela.blit(titulo, (LARGURA_TELA // 2 - titulo.get_width() // 2, 50))

        # Linha decorativa
        pygame.draw.line(
            self.tela, COR_TEXTO_TITULO,
            (LARGURA_TELA // 2 - 180, 110),
            (LARGURA_TELA // 2 + 180, 110),
            2
        )

        # --- Cartões de Categoria ---
        pos_mouse = pygame.mouse.get_pos()

        for i, (chave, cat) in enumerate(CATEGORIAS.items()):
            rect = self.botoes_categoria[chave]
            hover = rect.collidepoint(pos_mouse)

            # Animação de entrada (slide da esquerda)
            offset_x = max(0, int(300 * math.exp(-(t - 0.2 * i) * 5))) if t < 2 else 0

            rect_anim = rect.copy()
            rect_anim.x -= offset_x

            # Sombra
            sombra = rect_anim.copy()
            sombra.move_ip(4, 4)
            pygame.draw.rect(self.tela, (15, 15, 25), sombra, border_radius=15)

            # Fundo do cartão
            cor_fundo_cartao = (50, 55, 80) if not hover else (65, 70, 100)
            pygame.draw.rect(self.tela, cor_fundo_cartao, rect_anim, border_radius=15)

            # Borda colorida lateral
            borda_lateral = pygame.Rect(rect_anim.x, rect_anim.y, 8, rect_anim.height)
            pygame.draw.rect(self.tela, cat["cor"], borda_lateral, border_radius=4)

            # Borda do cartão
            borda_cor = cat["cor"] if hover else (80, 85, 110)
            pygame.draw.rect(self.tela, borda_cor, rect_anim, width=2, border_radius=15)

            # Ícone (estrelas)
            icone = self.fonte_categoria_icone.render(cat["icone"], True, cat["cor"])
            self.tela.blit(icone, (rect_anim.x + 25, rect_anim.y + 15))

            # Nome da categoria
            nome = self.fonte_categoria_titulo.render(cat["nome"], True, BRANCO)
            self.tela.blit(nome, (rect_anim.x + 25, rect_anim.y + 42))

            # Descrição
            desc = self.fonte_categoria_desc.render(cat["descricao"], True, CINZA_CLARO)
            self.tela.blit(desc, (rect_anim.x + 25, rect_anim.y + 78))

            # Info de fases
            n_fases = len(cat["fases"])
            seq_min = cat["fases"][cat["ordem_fases"][0]]["SEQ"]
            seq_max = cat["fases"][cat["ordem_fases"][-1]]["SEQ"]
            info = self.fonte_categoria_desc.render(
                f"{n_fases} fases  |  {seq_min}-{seq_max} casas por sequência",
                True, CINZA_MEDIO
            )
            self.tela.blit(info, (rect_anim.x + 25, rect_anim.y + 97))

            # Seta indicativa no hover
            if hover:
                seta = self.fonte_botao.render(">", True, cat["cor"])
                self.tela.blit(
                    seta,
                    (rect_anim.right - 35,
                     rect_anim.centery - seta.get_height() // 2)
                )

        # --- Botão Voltar ---
        hover_voltar = self.botao_voltar.collidepoint(pos_mouse)
        cor_voltar = CINZA_ESCURO if not hover_voltar else CINZA_MEDIO
        pygame.draw.rect(self.tela, cor_voltar, self.botao_voltar, border_radius=8)
        pygame.draw.rect(self.tela, CINZA_MEDIO, self.botao_voltar, width=1, border_radius=8)
        txt_voltar = self.fonte_instrucao.render("< Voltar", True, BRANCO)
        self.tela.blit(
            txt_voltar,
            (self.botao_voltar.centerx - txt_voltar.get_width() // 2,
             self.botao_voltar.centery - txt_voltar.get_height() // 2)
        )

    def _desenhar_contagem(self):
        """Desenha a contagem regressiva (3, 2, 1, Vai!)."""
        agora = time.time()
        t = agora - self.contagem_inicio
        progresso = t / TEMPO_CONTAGEM  # 0 a 1

        # --- Fundo com amarelinha semi-transparente ---
        self._desenhar_amarelinha(decorativo=True)

        # --- Overlay escuro ---
        overlay = pygame.Surface((LARGURA_TELA, ALTURA_TELA), pygame.SRCALPHA)
        overlay.fill((25, 25, 40, 180))
        self.tela.blit(overlay, (0, 0))

        # --- Número grande com animação de escala ---
        if self.contagem_numero > 0:
            texto_num = str(self.contagem_numero)
            # Efeito de zoom: começa grande e encolhe
            escala = 1.0 + (1.0 - progresso) * 0.5
            tamanho_fonte = int(120 * escala)
            fonte_temp = pygame.font.SysFont("Arial", min(tamanho_fonte, 200), bold=True)

            # Cor com transparência (fica mais transparente com o tempo)
            alpha = int(255 * (1.0 - progresso * 0.3))
            cor = COR_TEXTO_TITULO

            txt = fonte_temp.render(texto_num, True, cor)
            self.tela.blit(
                txt,
                (LARGURA_TELA // 2 - txt.get_width() // 2,
                 ALTURA_TELA // 2 - txt.get_height() // 2 - 30)
            )

            # Círculo animado ao redor do número
            raio = int(80 + 20 * math.sin(progresso * math.pi * 2))
            pygame.draw.circle(
                self.tela, COR_TEXTO_TITULO,
                (LARGURA_TELA // 2, ALTURA_TELA // 2 - 20),
                raio, width=3
            )
        else:
            # "VAI!" com efeito de explosão
            txt = self.fonte_titulo.render("VAI!", True, COR_ACERTO)
            self.tela.blit(
                txt,
                (LARGURA_TELA // 2 - txt.get_width() // 2,
                 ALTURA_TELA // 2 - txt.get_height() // 2 - 30)
            )

        # --- Info da categoria ---
        if self.categoria_selecionada:
            cat = CATEGORIAS[self.categoria_selecionada]
            info = self.fonte_info.render(
                f"Categoria: {cat['nome']}  |  {cat['fases'][self.fase_atual]['nome']}",
                True, COR_TEXTO_INFO
            )
            self.tela.blit(info, (LARGURA_TELA // 2 - info.get_width() // 2, ALTURA_TELA // 2 + 80))

        # --- Texto "Prepare-se!" ---
        if self.contagem_numero > 0:
            prepara = self.fonte_subtitulo.render("Prepare-se!", True, CINZA_CLARO)
            self.tela.blit(
                prepara,
                (LARGURA_TELA // 2 - prepara.get_width() // 2, ALTURA_TELA // 2 + 50)
            )

    def _desenhar_game_over(self):
        """Desenha a tela de Game Over."""
        agora = time.time()
        t = agora - self.tempo_inicio_jogo

        # Fundo com partículas vermelhas
        random.seed(99)
        for i in range(15):
            x = random.randint(0, LARGURA_TELA)
            y = random.randint(0, ALTURA_TELA)
            x = (x + int(math.sin(t * 0.3 + i) * 40)) % LARGURA_TELA
            y = (y + int(math.cos(t * 0.2 + i * 0.5) * 30)) % ALTURA_TELA
            raio = int(2 + math.sin(t + i) * 1)
            cor = (120 + int(40 * math.sin(t + i)), 30, 30)
            pygame.draw.circle(self.tela, cor, (x, y), max(1, raio))
        random.seed()

        # Título GAME OVER
        titulo = self.fonte_titulo.render("GAME OVER", True, COR_ERRO)
        self.tela.blit(titulo, (LARGURA_TELA // 2 - titulo.get_width() // 2, 180))

        # Linha decorativa
        pygame.draw.line(
            self.tela, COR_ERRO,
            (LARGURA_TELA // 2 - 120, 245),
            (LARGURA_TELA // 2 + 120, 245), 2
        )

        # Informações
        cat = CATEGORIAS[self.categoria_selecionada] if self.categoria_selecionada else None
        info = [
            (f"Pontuacao Final: {self.pontuacao_total}", COR_TEXTO_PONTOS),
            (f"Rodadas jogadas: {self.rodada}", COR_TEXTO_INFO),
        ]
        if cat:
            info.append((f"Categoria: {cat['nome']}", cat["cor"]))
            info.append((f"Fase alcancada: {cat['fases'][self.fase_atual]['nome']}", COR_TEXTO_FASE))

        y = 300
        for texto, cor in info:
            txt = self.fonte_subtitulo.render(texto, True, cor)
            self.tela.blit(txt, (LARGURA_TELA // 2 - txt.get_width() // 2, y))
            y += 50

        # Botões
        pos_mouse = pygame.mouse.get_pos()

        # Botão "Jogar Novamente"
        self.botao_jogar_novamente = pygame.Rect(LARGURA_TELA // 2 - 140, 530, 280, 50)
        hover_jogar = self.botao_jogar_novamente.collidepoint(pos_mouse)
        cor_btn = COR_BOTAO_HOVER if hover_jogar else COR_BOTAO
        pygame.draw.rect(self.tela, cor_btn, self.botao_jogar_novamente, border_radius=12)
        pygame.draw.rect(self.tela, COR_BOTAO_BORDA, self.botao_jogar_novamente, width=2, border_radius=12)
        txt = self.fonte_botao.render("Jogar Novamente", True, BRANCO)
        self.tela.blit(txt, (self.botao_jogar_novamente.centerx - txt.get_width() // 2,
                             self.botao_jogar_novamente.centery - txt.get_height() // 2))

        # Botão "Menu Inicial"
        self.botao_menu = pygame.Rect(LARGURA_TELA // 2 - 140, 600, 280, 50)
        hover_menu = self.botao_menu.collidepoint(pos_mouse)
        cor_btn2 = CINZA_ESCURO if not hover_menu else CINZA_MEDIO
        pygame.draw.rect(self.tela, cor_btn2, self.botao_menu, border_radius=12)
        pygame.draw.rect(self.tela, CINZA_MEDIO, self.botao_menu, width=2, border_radius=12)
        txt2 = self.fonte_botao.render("Menu Inicial", True, BRANCO)
        self.tela.blit(txt2, (self.botao_menu.centerx - txt2.get_width() // 2,
                              self.botao_menu.centery - txt2.get_height() // 2))

    def _desenhar_hud(self):
        """Desenha o HUD (Heads-Up Display) com informações do jogo."""
        # Painel superior
        pygame.draw.rect(self.tela, COR_PAINEL, (0, 0, LARGURA_TELA, 55))
        pygame.draw.line(self.tela, COR_CASA_BORDA, (0, 55), (LARGURA_TELA, 55), 2)

        # Fase e Categoria
        if self.categoria_selecionada:
            cat = CATEGORIAS[self.categoria_selecionada]
            fase_txt = self.fonte_info.render(
                f"{cat['nome']} | {cat['fases'][self.fase_atual]['nome']}", True, COR_TEXTO_FASE
            )
        else:
            fase_txt = self.fonte_info.render("[FASE]", True, COR_TEXTO_FASE)
        self.tela.blit(fase_txt, (15, 15))

        # Pontuação
        pontos_txt = self.fonte_info.render(
            f"Pontos: {self.pontuacao_total}", True, COR_TEXTO_PONTOS
        )
        self.tela.blit(pontos_txt, (LARGURA_TELA // 2 - pontos_txt.get_width() // 2, 15))

        # Vidas e Rodada
        vidas_txt = self.fonte_info.render(
            f"Vidas: {self.vidas}  |  Rodada: {self.rodada}", True, COR_TEXTO_INFO
        )
        self.tela.blit(vidas_txt, (LARGURA_TELA - vidas_txt.get_width() - 15, 15))

        # Painel inferior com info da rodada
        pygame.draw.rect(self.tela, COR_PAINEL, (0, ALTURA_TELA - 80, LARGURA_TELA, 80))
        pygame.draw.line(
            self.tela, COR_CASA_BORDA,
            (0, ALTURA_TELA - 80), (LARGURA_TELA, ALTURA_TELA - 80), 2
        )

        # Info da rodada no painel inferior
        dica_str = "DICA usada" if self.dica_usada else ""
        rodada_txt = self.fonte_info.render(
            f"Pontos da rodada: {self.pontuacao_rodada}  |  "
            f"Sequencia: {self.indice_jogador}/{len(self.sequencia)}  |  "
            f"{dica_str}",
            True, COR_TEXTO_INFO
        )
        self.tela.blit(rodada_txt, (15, ALTURA_TELA - 55))

        # Barra de progresso da sequência
        if len(self.sequencia) > 0:
            progresso = self.indice_jogador / len(self.sequencia)
            barra_larg = LARGURA_TELA - 30
            pygame.draw.rect(self.tela, CINZA_ESCURO, (15, ALTURA_TELA - 25, barra_larg, 10), border_radius=5)
            pygame.draw.rect(
                self.tela, COR_ACERTO,
                (15, ALTURA_TELA - 25, int(barra_larg * progresso), 10),
                border_radius=5
            )

    def _desenhar_amarelinha(self, decorativo=False):
        """
        Desenha o grid da amarelinha na tela.

        Args:
            decorativo: Se True, desenha em tamanho reduzido (para o menu)
        """
        pos_mouse = pygame.mouse.get_pos()

        for numero, rect in self.casas.items():
            # Determina a cor da casa
            cor = COR_CASA_NORMAL

            # Verifica se está iluminada (memorização ou dica)
            if numero == self.casa_iluminada:
                if self.estado == self.ESTADO_DICA:
                    cor = COR_DICA
                else:
                    cor = COR_ILUMINADA

            # Verifica feedback (acerto/erro)
            if numero == self.casa_feedback and self.cor_feedback:
                cor = self.cor_feedback

            # Verifica flash da casa correta (após erro)
            if numero == self.casa_correta_flash:
                cor = COR_CORRETA_FLASH

            # Hover do mouse (apenas no modo reprodução)
            if (self.estado == self.ESTADO_REPRODUZIR
                    and rect.collidepoint(pos_mouse)
                    and cor == COR_CASA_NORMAL):
                cor = COR_CASA_HOVER

            # Desenha a casa com bordas arredondadas
            pygame.draw.rect(self.tela, cor, rect, border_radius=12)
            pygame.draw.rect(self.tela, COR_CASA_BORDA, rect, width=3, border_radius=12)

            # Número da casa
            num_texto = self.fonte_casa.render(str(numero), True, BRANCO)
            self.tela.blit(
                num_texto,
                (rect.centerx - num_texto.get_width() // 2,
                 rect.centery - num_texto.get_height() // 2)
            )

    def _desenhar_mensagem_estado(self):
        """Desenha mensagens contextuais na tela."""
        msg = ""
        cor = COR_TEXTO_INFO

        if self.estado == self.ESTADO_MEMORIZAR:
            msg = "MEMORIZE A SEQUENCIA!"
            cor = COR_ILUMINADA
        elif self.estado == self.ESTADO_REPRODUZIR:
            msg = "SUA VEZ! Clique nas casas na ordem correta"
            cor = COR_TEXTO_INFO
            # Mostra tempo restante para dica
            tempo_ocioso = time.time() - self.ultimo_clique_tempo
            if tempo_ocioso > 1.5:
                tempo_restante = max(0, TEMPO_DICA - tempo_ocioso)
                msg += f"  (dica em {tempo_restante:.1f}s)"
        elif self.estado == self.ESTADO_FEEDBACK:
            msg = self.mensagem_feedback
            cor = COR_ACERTO if self.cor_feedback == COR_ACERTO else COR_ERRO
        elif self.estado == self.ESTADO_DICA:
            msg = "DICA: Observe a sequencia novamente!"
            cor = COR_DICA
        elif self.estado == self.ESTADO_FIM_RODADA:
            msg = "Preparando proxima rodada..."
            cor = COR_TEXTO_TITULO

        if msg:
            # Painel de mensagem
            msg_y = ALTURA_TELA - 135
            pygame.draw.rect(
                self.tela, (*COR_PAINEL, 200),
                (50, msg_y - 10, LARGURA_TELA - 100, 45),
                border_radius=8
            )
            texto = self.fonte_feedback.render(msg, True, cor)
            self.tela.blit(texto, (LARGURA_TELA // 2 - texto.get_width() // 2, msg_y))

    # =========================================================================
    # LOOP PRINCIPAL DO JOGO
    # =========================================================================
    def executar(self):
        """
        Loop principal do jogo.

        NOTA PARA INTEGRAÇÃO FUTURA COM CÂMERA:
        ========================================
        Para integrar com visão computacional, adicione neste loop:
        1. Captura de frame da câmera
        2. Processamento com MediaPipe / OpenCV
        3. Detecção da posição do jogador
        4. Chamada a self.processar_entrada_jogador(pos_detectada)

        Exemplo:
            cap = cv2.VideoCapture(0)
            while self.rodando:
                ret, frame = cap.read()
                if ret:
                    pos = detectar_posicao(frame)
                    if pos:
                        self.processar_entrada_jogador(pos)
                ...
        ========================================
        """
        rodando = True

        while rodando:
            # --- Processamento de Eventos ---
            for evento in pygame.event.get():
                if evento.type == pygame.QUIT:
                    rodando = False

                elif evento.type == pygame.KEYDOWN:
                    if evento.key == pygame.K_ESCAPE:
                        # ESC volta para a tela anterior, ou sai do jogo
                        if self.estado == self.ESTADO_SELECAO:
                            self.estado = self.ESTADO_TELA_INICIAL
                        elif self.estado in (self.ESTADO_TELA_INICIAL,):
                            rodando = False
                        else:
                            # Durante o jogo, ESC volta ao menu
                            self.estado = self.ESTADO_TELA_INICIAL
                            self.__init__()

                    elif evento.key == pygame.K_r:
                        # Reinicia o jogo
                        self.__init__()
                        self.estado = self.ESTADO_TELA_INICIAL

                elif evento.type == pygame.MOUSEBUTTONDOWN:
                    if evento.button == 1:  # Botão esquerdo
                        if self.estado == self.ESTADO_TELA_INICIAL:
                            # Verifica clique no botão JOGAR
                            if self.botao_jogar.collidepoint(evento.pos):
                                self.estado = self.ESTADO_SELECAO
                                self.tempo_inicio_jogo = time.time()  # Reset para animações

                        elif self.estado == self.ESTADO_SELECAO:
                            # Verifica clique nos botões de categoria
                            for chave, rect in self.botoes_categoria.items():
                                if rect.collidepoint(evento.pos):
                                    self.selecionar_categoria(chave)
                                    break
                            # Verifica clique no botão voltar
                            if self.botao_voltar.collidepoint(evento.pos):
                                self.estado = self.ESTADO_TELA_INICIAL

                        elif self.estado == self.ESTADO_REPRODUZIR:
                            # Clicou durante a reprodução → processa entrada
                            # =============================================
                            # PONTO DE INTEGRAÇÃO COM CÂMERA:
                            # Substitua evento.pos pela posição detectada
                            # pela visão computacional.
                            # =============================================
                            self.processar_entrada_jogador(evento.pos)

                        elif self.estado == self.ESTADO_GAME_OVER:
                            # Verifica clique nos botões
                            if hasattr(self, 'botao_jogar_novamente') and \
                               self.botao_jogar_novamente.collidepoint(evento.pos):
                                # Jogar novamente com a mesma categoria
                                cat = self.categoria_selecionada
                                self.__init__()
                                self.selecionar_categoria(cat)
                            elif hasattr(self, 'botao_menu') and \
                                 self.botao_menu.collidepoint(evento.pos):
                                # Voltar ao menu inicial
                                self.__init__()

            # --- Atualização ---
            self.atualizar()

            # --- Renderização ---
            self.desenhar()

            # --- Controle de FPS ---
            self.clock.tick(FPS)

        # Encerramento
        pygame.quit()
        sys.exit()


# =============================================================================
# PONTO DE ENTRADA
# =============================================================================
if __name__ == "__main__":
    jogo = JogoAmarelinha()
    jogo.executar()
