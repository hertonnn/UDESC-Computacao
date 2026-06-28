# Trabalho Complementar - Animação (CGR)

Este documento contém a transcrição das diretrizes para a execução do Trabalho Complementar associado aos tópicos de Animação e Comportamento de Sistemas. O aluno deve escolher uma das duas opções propostas abaixo para desenvolver.

---

### Opção 1: Simulação de Multidões (Boids)
O objetivo desta opção é criar um ambiente simulado com múltiplos agentes navegando autonomamente.

- **Requisito Técnico:** Utilizar o conceito de *steering behaviors* (Boids).
- **Cenário Esperado:** Simular um bando de pássaros, um cardume de peixes ou entidades similares movendo-se pelo ambiente.
- **Comportamentos Obrigatórios:**
  - *Obstacle Avoidance* (Evitar obstáculos no cenário).
  - *Seek/Flee* (Aproximar-se de um alvo ou fugir de uma ameaça).
  - *Pursue/Evade* (Perseguir um alvo dinâmico ou ser evadido por ele).
  - Entre outros comportamentos emergentes que tragam realismo.
- **Representação Gráfica:** A modelagem visual dos agentes não precisa ser complexa; a população pode ser perfeitamente representada por primitivas geométricas simples (como círculos, triângulos direcionais ou esferas). O foco da avaliação é a lógica de movimentação, e não o detalhamento do modelo.

### Opção 2: Animação Hierárquica de Personagem
O objetivo desta opção é demonstrar a fluidez e controle sobre uma árvore de dependências (modelo hierárquico) aplicada a um corpo articulado.

- **Requisito Técnico:** Criar um personagem composto por um modelo hierárquico (por exemplo, um robô humanoide construído com caixas e cilindros estruturados em uma árvore pai/filho como Tronco $\rightarrow$ Ombro $\rightarrow$ Braço).
- **Comportamentos Obrigatórios:** O personagem deve ser capaz de realizar:
  1. Pelo menos **um movimento cíclico**, caracterizado pela repetição em loop natural (ex: caminhada, corrida, rastejar).
  2. Pelo menos **um movimento não-cíclico**, caracterizado por uma ação focal e com fim determinado (ex: acenar com o braço para a câmera ou menear a cabeça em sinal de negação).
