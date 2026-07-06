# 🎯 AMAR-É-LINDO — Exergame de Amarelinha

## Descrição
MVP (Minimum Viable Product) de um exergame baseado na brincadeira tradicional de amarelinha.
O jogador deve memorizar uma sequência de casas iluminadas e reproduzi-la na ordem correta.

## Estrutura do Projeto
```
AmarELindo/
├── main.py                ← Código principal do jogo
├── README.md              ← Este arquivo
└── assets/
    ├── images/            ← Coloque imagens aqui (logo, backgrounds, sprites)
    ├── sounds/            ← Coloque sons aqui (ver lista abaixo)
    └── fonts/             ← Coloque fontes .ttf personalizadas aqui
```

## Como Executar
```bash
pip install pygame
python main.py
```

## Controles
| Ação               | Controle        |
|---------------------|-----------------|
| Iniciar jogo       | Clique do mouse |
| Clicar nas casas   | Clique do mouse |
| Reiniciar          | Tecla `R`       |
| Sair               | Tecla `ESC`     |

## Sons (opcionais)
Coloque arquivos `.wav` na pasta `assets/sounds/`:
- `acerto.wav` — Toca ao acertar uma casa
- `erro.wav` — Toca ao errar
- `dica.wav` — Toca quando a dica é ativada
- `bonus.wav` — Toca ao completar a sequência
- `inicio.wav` — Toca ao iniciar uma rodada

## Regras
- **Acerto:** +10 pontos por casa correta
- **Sequência completa:** +20 pontos de bônus
- **Dica (3s sem clicar):** -10 pontos
- **Erro:** Pontuação da rodada zerada, perde 1 vida
- **3 vidas** por partida

## Fases
| Fase | Casas na sequência | Tempo de memorização |
|------|--------------------|----------------------|
| A    | 3                  | 5.0s                 |
| B    | 4                  | 4.0s                 |
| C    | 5                  | 3.5s                 |
| D    | 6                  | 3.0s                 |
| E    | 7                  | 2.5s                 |
| F    | 8                  | 2.0s                 |
| G    | 9                  | 1.5s                 |

## Integração Futura com Câmera
Os pontos de integração estão marcados no código com comentários.
O método principal é `processar_entrada_jogador(pos)` — basta substituir
as coordenadas do mouse pelas coordenadas detectadas pela visão computacional.
