# Resumo de Animação Computacional

Este documento traz um resumo dos conceitos apresentados nos slides sobre Animação Computacional na disciplina de Computação Gráfica.

## 1. Introdução à Animação
Animação computacional consiste em gerar sequências de imagens que, exibidas em velocidade adequada, criam a ilusão de movimento. Existem diversas técnicas, que variam desde o controle manual total pelo animador até comportamentos completamente autônomos dos personagens.

## 2. Técnicas de Motion Control

### Keyframing (Quadros-Chave)
* O animador define os quadros-chave (poses principais) e o computador gera automaticamente os quadros intermediários por interpolação.
* É a técnica mais clássica e amplamente utilizada.

### Animação Procedural
* O movimento é gerado algoritmicamente, por fórmulas matemáticas ou regras procedurais, sem a necessidade de definir quadros-chave manualmente.

### Animação Baseada em Física
* O movimento é simulado com base em leis da física (equações de Euler, dinâmica de corpos rígidos, sistemas híbridos, etc.).
* **Vantagens:** Resultados muito realistas e fácil especificação de tarefas.
* **Desvantagem:** Difícil controle — o sistema pode se tornar instável.

## 3. Animação Baseada em Tarefas
Definida por Zeltzer (1985), pressupõe que exista um motor inteligente capaz de entender comandos de alto nível (ex: "Vá até a posição 10, 10, 10") e que possua conhecimento do ambiente (posição de objetos, etc.). Não especifica tempo diretamente na instrução.

## 4. Animação Baseada em Eventos
* Define regras simples ou complexas para disparar tarefas (ações) automaticamente.
  * Exemplo simples: "Quando for meio-dia, vamos almoçar."
  * Exemplo complexo: "Quando for meio-dia: chamar amigos → se não tenho dinheiro, passo no banco → se não gosto do menu do RU, vou no Shopping."
* Regras podem utilizar informações de estados de objetos e implicar em conhecimento de personalidades.
* **Problema:** Conflito de eventos (eventos diferentes geram reações conflitantes para a mesma entidade). A solução comum é definir prioridades entre eventos.

## 5. Animação Comportamental
Define comportamentos das entidades sem especificação de tarefas de baixo nível. Os agentes possuem personalidades e características que guiam suas ações autonomamente.

### Níveis de Escala
* **Indivíduos:** Ex: "Agente 1 trabalha num restaurante e é introvertido."
* **Grupos:** Ex: "Grupo 5 é uma família de 4 pessoas viajando de trem."
* **Multidões:** Ex: "A multidão vai ver um jogo de futebol. A importância do jogo é grande."

### Modelos Comportamentais
* Percepção/Decisão/Ação
* Beliefs/Desires/Intentions (Brazier)
* Reactivity and Planning Capabilities (Ferber)
* Knowledge/Status/Intention (Musse)

### Marcos Históricos
* **Reynolds (1987):** Propôs a animação comportamental, onde personagens virtuais autônomos determinam suas próprias ações (*self-animated characters*).
* **Tu e Terzopoulos (1994):** Modelo comportamental para cardumes com visão sintética.
* **Bouvier et al. (1997):** Sistema de partículas adaptado para multidões humanas.
* **Helbing et al. (2000):** Modelo de forças físicas e sócio-psicológicas para simulação de multidões em emergências.

## 6. Comportamento de Multidões
Duas classes de comportamentos são identificadas:

### Comportamentos Inerentes (próprios do ser humano)
* Deslocar-se ao destino.
* Deslocar-se evitando colisões.
* Estratégia do mínimo esforço.

### Comportamentos Emergentes (surgem da auto-organização coletiva)
* **Formação de vias de pedestres:** Fluxos opostos se organizam naturalmente em faixas.
* **Redução de velocidade:** Velocidade diminui com o aumento da densidade (proxêmica).
* **Formação de arco:** Pedestres próximos a saídas formam arcos.
* **Efeito gargalo:** Variação de densidade e velocidade em estreitamentos de corredores.
* **Efeito do canto:** Redução de velocidade em curvas de trajetória.
* **Efeito de pressão (pushing):** Em situações de pânico, pedestres se empurram para manter o fluxo de evacuação.
* **Ondas de choque:** Propagação em "onda" decorrente da pressão entre pedestres.

## 7. Sistema de Partículas
Criado por William T. Reeves para o filme *Star Trek II: A Ira de Khan* (1982).
* Usado para modelar objetos "confusos" como fogo, nuvens, fumaça e água.
* O volume não é representado por uma entidade única, mas por uma nuvem de primitivas.
* As partículas não são estáticas — se movem, são criadas e destruídas ao longo da animação.
* Objetos definidos por partículas não são determinísticos (forma não completamente especificada).
* **Atributos principais:** posição inicial, velocidade, tamanho, cor, transparência, forma e tempo de vida.

## 8. Vida Artificial
Simulações de seres vivos usando animação comportamental:
* **Bandos de pássaros** — Craig Reynolds
* **Peixes** — Dimetri Terzopoulos
* **Cobras e vermes** — Gavin Miller
* **Humanos Virtuais** — Daniel Thalmann e Norman Badler
