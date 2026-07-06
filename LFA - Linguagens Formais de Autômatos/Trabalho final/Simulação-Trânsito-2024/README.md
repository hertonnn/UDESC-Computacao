
# 🚦 Simulação de Trânsito com Autômatos Finitos e com Pilha

Projeto desenvolvido para a disciplina de **Linguagens Formais e Autômatos (LFA)** com o objetivo de modelar e simular o comportamento de veículos em uma região urbana, utilizando **Autômatos Finitos Determinísticos (AFDs)** e **Autômatos com Pilha (APs)**.

## 👨‍💻 Autor

- **Herton da Silveira e Silva**  
  📅 2 de Dezembro de 2024

---

## 🧠 Objetivo

Modelar e simular o fluxo de veículos em um cenário urbano simplificado, considerando:

- Pontos de entrada e saída.
- Cruzamentos com ou sem semáforo.
- Estacionamentos.
- Retornos.
- Direções de movimento.
- Controle de fluxo via semáforos com pilha.

---

## 🗺️ Descrição do Cenário

![img-cenario](https://github.com/hertonnn/UDESC-Computacao/blob/095e0211a4ed2580e11c10cb003f7820a87afc47/LFA%20-%20Linguagens%20Formais%20de%20Aut%C3%B4matos/Trabalho%20final/Simula%C3%A7%C3%A3o-Tr%C3%A2nsito-2024/img/cenario-original.png)

O cenário conta com:

- **Quarteirões** interligados por cruzamentos.
- **4 pontos de partida**: A, B, C e D.
- **Estacionamentos**: p1, p3, p3.1, p5 e p7.
- **Cruzamentos**: C1, C2, C3, C4 (podem ter semáforos).
- **Retornos**: R1 a R4.

Cada autômato representa as possibilidades de percurso a partir de um ponto de origem.

---

## 🔀 AFD - Representação de Trajetórias

![tragetoria](https://github.com/hertonnn/UDESC-Computacao/blob/095e0211a4ed2580e11c10cb003f7820a87afc47/LFA%20-%20Linguagens%20Formais%20de%20Aut%C3%B4matos/Trabalho%20final/Simula%C3%A7%C3%A3o-Tr%C3%A2nsito-2024/img/automato-geral.png)

- O **AFD** modela os percursos de veículos.
- Alfabeto: `["cima", "baixo", "esquerda", "direita", "estacionar"]`
- Exemplo de transições:

```python
transicoes_AFD = {
  'A': {'baixo': 'C1', 'estacionar': 'p1'},
  'B': {'baixo': 'C2', 'estacionar': 'p3'},
  'C': {'direita': 'C1'},
  'D': {'esquerda': 'C4'},
  'C1': {'cima': 'A', 'estacionar': 'p1', 'direita': 'C2', 'baixo': 'C3'},
  'C2': {'cima': 'B', 'estacionar': 'p3', 'direita': 'R4', 'baixo': 'C4'},
  'C3': {'cima': 'C1', 'esquerda': 'R1', 'estacionar': 'p7', 'baixo': 'R2'},
  'C4': {'cima': 'C2', 'esquerda': 'C3', 'estacionar': 'p5', 'baixo': 'R3'},
}
```

---

## 🚦 AP - Controle de Semáforos

![semaforo](https://github.com/hertonnn/UDESC-Computacao/blob/095e0211a4ed2580e11c10cb003f7820a87afc47/LFA%20-%20Linguagens%20Formais%20de%20Aut%C3%B4matos/Trabalho%20final/Simula%C3%A7%C3%A3o-Tr%C3%A2nsito-2024/img/semaforo-AP.png)

Modelagem de um semáforo com três estados:

- **vermelho** (estado inicial)
- **verde**
- **amarelo**

### Lógica com pilha:

```python
transicoes_AP = {
  ('vermelho', 'veiculo', 'ε'): [('vermelho', 'veiculo')],
  ('vermelho', 'troca', 'ε'): [('verde', 'ε')],
  ('verde', 'veiculo', 'veiculo'): [('verde', 'ε')],
  ('verde', 'troca', 'ε'): [('amarelo', 'ε')],
  ('amarelo', 'veiculo', 'veiculo'): [('amarelo', 'ε')],
  ('amarelo', 'troca', 'ε'): [('vermelho', 'ε')],
}
```

![fluxo](https://github.com/hertonnn/UDESC-Computacao/blob/095e0211a4ed2580e11c10cb003f7820a87afc47/LFA%20-%20Linguagens%20Formais%20de%20Aut%C3%B4matos/Trabalho%20final/Simula%C3%A7%C3%A3o-Tr%C3%A2nsito-2024/img/fluxo.png)
---

## 🧱 Estrutura de Código

### Classes principais:

- `Sistema`: representa todo o cenário.
- `Cruzamento`: pode ou não conter um semáforo.
- `Semaforo`: representa o AP do semáforo.
- AFDs e APs implementados como classes modulares.

### Exemplo de execução:

```bash
python3.10 main.py
```

### Menu interativo:

```
1. Testar trajetória
2. Testar fluxo
3. Sair
```

---

## ✅ Trajetórias Aceitas

- De **B**: baixo baixo esquerda estacionar
- De **A**: estacionar / baixo direita cima estacionar
- De **C**: direita direita cima estacionar
- De **D**: esquerda esquerda cima estacionar

## ❌ Trajetórias Recusadas

- De **A**: baixo / baixo baixo baixo estacionar
- De **C**: direita direita direita cima estacionar
- De **D**: estacionar (sem movimento)

## ✅ Fluxos Aceitos (Semáforo)

- `veiculo veiculo troca veiculo veiculo`
- `veiculo troca veiculo`

## ❌ Fluxos Recusados

- `veiculo troca`
- `veiculo veiculo troca troca`

---

## 🧪 Análise de Estacionamentos

Ajustes realizados para melhorar eficiência:

- Estacionamentos reposicionados para evitar semáforos.
- Melhor distribuição geográfica no mapa urbano.
- Menor número de transições para destinos equivalentes.

---

## 🛠️ Tecnologias Utilizadas

- Python 3.10
- Programação orientada a objetos
- Representação de transições via dicionários

---

## 🔗 Referências

- [Documentação Python - Classes](https://docs.python.org/pt-br/3/tutorial/classes.html)
- [Computação Paralela - Wikipédia](https://pt.wikipedia.org/wiki/Computa%C3%A7%C3%A3o_paralela)

---

## 📌 Conclusão

Este projeto demonstra como **autômatos formais** podem representar de maneira eficiente o tráfego urbano. Utilizando **AFDs** para rotas e **APs** para o controle de semáforos, é possível validar trajetórias e fluxos com precisão e aplicar o modelo em diversos cenários urbanos reais ou simulados.
