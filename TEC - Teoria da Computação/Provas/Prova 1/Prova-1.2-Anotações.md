**Questão 1**

Com base na definição formal de Máquina de Turing do livro-texto adotado na disciplina (Sipser), responda às perguntas abaixo e justifique seu raciocínio:

a) É possível que o alfabeto da fita $\Gamma$ seja idêntico ao alfabeto de entrada $\Sigma$?
b) Pode existir uma máquina de Turing composta por apenas um único estado?

---

**Questão 2**

Zezinho percebeu que, para uma mesma linguagem, o tempo de execução de uma máquina de Turing não determinística foi significativamente menor do que o de uma máquina de Turing determinística. Diante disso, Zezinho concluiu:

"O poder computacional de uma Máquina de Turing não determinística é superior ao de uma Máquina de Turing determinística."

A declaração de Zezinho está correta? Explique o porquê.

---

**Questão 3**

Apresente argumentos para justificar ou refutar as seguintes afirmações:

a) A classe das linguagens Turing-reconhecíveis possui fechamento sob a operação de complemento.
b) A linguagem gerada por um enumerador será finita se, e apenas se, o enumerador eventualmente parar.

---

**Questão 4**

Especifique formalmente uma Máquina de Turing, detalhando integralmente sua função de transição (função programa), que receba como entrada uma cadeia $w \in \{0, 1\}^*$ e processe a sua forma reversa $w^R$ (isto é, a cadeia $w$ lida no sentido da direita para a esquerda). Ao finalizar o processamento, a fita da máquina deve conter unicamente a palavra $w^R$ e a máquina deve encerrar sua execução em um estado de aceitação.

---

**Questão 5**

De acordo com a obra "Teoria da Computação - Máquinas Universais e Computabilidade" (autores Divério, Tiaraju e Menezes, Paulo B. - Porto Alegre: Sagra-Luzatto, 1999), a definição de uma máquina de Turing é estruturada como uma 8-upla:

$$
M = (\Sigma, Q, \Pi, q_0, F, V, \beta, \odot)
$$

onde:
