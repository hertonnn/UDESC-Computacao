
# 📘 Diário de Bordo – Teoria da Computação  

![img_tec2](https://github.com/hertonnn/UDESC_Ciencia_da_Computacao/blob/master/utils/img/img_tec2.jpg)


**Disciplina:** Teoria da Computação  
**Objetivo:** Registro das dúvidas e reflexões durante o estudo dos capítulos do livro *Introduction to the Theory of Computation* – Michael Sipser.  

# 📝 Anotações de aulas

# Linguagem AMT e Indecidibilidade

## Definição

A linguagem **AMT** é definida como:

```
AMT = {<M, w> | M é uma máquina de Turing determinística e w pertence à linguagem L(M)}
```

Nosso objetivo é determinar se existe um **algoritmo** que, dado como entrada a codificação de uma máquina de Turing `M` e uma palavra `w`, decide se `M` aceita `w`.

## Reconhecibilidade

Sabemos que **AMT é reconhecível**, pois, se `w ∈ L(M)`, a máquina `M` eventualmente **aceita** `w`, ou seja, **há parada com confirmação**. No entanto, o problema ocorre quando `w ∉ L(M)`, já que a máquina pode entrar em **loop infinito**.

---

## Prova da Indecidibilidade de AMT

### 1. Suposição Inicial

Suponha, por absurdo, que existe um **decisor** `D` para a linguagem `AMT`.  
Esse decisor seria capaz de determinar corretamente, para qualquer entrada `<M, w>`, se `M` aceita `w`.

### 2. Construção da Máquina `K`

A partir dessa suposição, construímos uma nova máquina `K`, que recebe como entrada a codificação de uma máquina `M'` (onde `M'` é uma MTD).

### 3. Execução de `D`

A máquina `K` executa `D` com a entrada `<M', <M'>>`, ou seja, passa o código de `M'` como entrada para a própria máquina `M'`.

- Se `D` aceita (ou seja, `M'` aceita `<M'>`), então `K` rejeita.
- Se `D` rejeita (ou seja, `M'` não aceita `<M'>`), então `K` aceita.

### 4. Contradição

Por fim, executamos `K` sobre a **sua própria codificação**: `K(<K>)`.

Neste ponto, temos uma contradição:

- Se `K(<K>)` aceita, então segundo sua definição, ela deveria rejeitar;
- Se `K(<K>)` rejeita, então segundo sua definição, ela deveria aceitar.

Essa contradição implica que a **suposição da existência do decisor `D` é falsa**.

---

## Auto-referência

Esse tipo de construção utiliza **auto-referência**, que ocorre quando um objeto ou definição faz referência a si mesmo.

**Exemplo clássico:**  
> "Esta frase é falsa."

Se for verdadeira, então é falsa; se for falsa, então é verdadeira — ou seja, temos uma **contradição lógica**.

---

## Teorema da Incompletude de Gödel

Esse raciocínio está relacionado ao **Teorema da Incompletude de Gödel**, que afirma:

> Existem proposições verdadeiras em um sistema formal que **não podem ser provadas** dentro do próprio sistema.

- Em outras palavras, há **verdades matemáticas que não são demonstráveis**, o que implica que nenhum sistema formal suficientemente poderoso pode ser **completo e consistente ao mesmo tempo**.


# Teorema: Linguagens Decidíveis, Reconhecíveis e Correconhecíveis

## Definição

Uma linguagem é **correconhecível** se, e somente se, o **complemento dela é reconhecível**.

---

## Teorema

> Uma linguagem é **decidível** se, e somente se, ela for **reconhecível** e **correconhecível**.

---

## Demonstração

### Direção 1 (→): Se `L` é decidível, então `L` é reconhecível e correconhecível

Suponha que `L` seja uma linguagem **decidível**. Isso significa que existe uma **máquina decisora** `D` tal que:

```
L(D) = L
```

Como o decisor `D` aceita todas as cadeias pertencentes à linguagem, `L` é reconhecível.

Agora, para reconhecer o **complemento de L** (isto é, `~L`), podemos construir a seguinte máquina `C`:

1. Execute `D` com a entrada `w`;
2. Se `D` aceita, então **rejeite**;
3. Caso contrário, **aceite**.

Assim, `~L` é reconhecível, e portanto, `L` é também **correconhecível**.

---

### Direção 2 (←): Se `L` é reconhecível e correconhecível, então `L` é decidível

Suponha agora que `L` seja **reconhecível** e também **correconhecível**.

Então existem duas máquinas de Turing:

- `M1`: reconhece `L`
- `M2`: reconhece `~L`

Podemos construir uma nova máquina `D` que executa `M1` e `M2` em paralelo (por exemplo, de forma intercalada), com a seguinte lógica:

- Se `M1` aceita a entrada `w`, então `D` **aceita**;
- Se `M2` aceita a entrada `w`, então `D` **rejeita**.

Como qualquer entrada `w` pertence a exatamente uma das duas linguagens (`L` ou `~L`), uma das máquinas sempre aceitará, fazendo com que `D` sempre pare.

Logo, `D` é uma **máquina decisora** para `L`, o que implica que `L` é **decidível**.

---

## Conclusão

- Se uma linguagem é decidível, então ela é reconhecível e correconhecível;
- Se uma linguagem é reconhecível e correconhecível, então ela é decidível.


# Redução de AMT e Provas de Indecidibilidade

## AMT

Definição:
```
AMT = { <M, w> | w ∈ L(M) }
```

Ou seja, o conjunto das codificações de máquinas de Turing `M` e entradas `w` tais que `M` aceita `w`.

Sabemos que **AMT é indecidível**.

---

## Redução para Provar que uma Linguagem `L` é Indecidível

Para provar que uma linguagem `L` é indecidível, podemos assumir que `L` é decidível, construir uma máquina de Turing que decide `AMT` a partir de `L`, e chegar a uma contradição.

---

## Problema da Parada

Definição:
```
ParaMT = { <M, w> | M é uma MTD e M para com entrada w }
```

### Pergunta

É possível dizer se `M` sempre para?

**Resposta:** Não. (Problema da Parada é indecidível).

### Prova

Assumindo que existe um decisor `U` tal que:
```
L(U) = ParaMT
```

Construímos uma máquina `X` que utiliza `U` como sub-rotina:

- `X` recebe como entrada `<M', w'>`.
- Usa `U` para decidir se `M'` para com entrada `w'`:
  - Se `U` aceitar, execute `M'` com `w'` e aceite ou rejeite conforme `M'`.
  - Se `U` rejeitar (ou entrar em loop), `X` também rejeita.

Dessa forma, `X` decide `AMT`, o que é **uma contradição**, pois sabemos que `AMT` é indecidível.

---

## Exemplo: Linguagem VMT

Definição:
```
VMT = { <M> | L(M) = ∅ }
```

Ou seja, o conjunto das máquinas de Turing que **não aceitam nenhuma palavra**.

### Prova de Indecidibilidade

Assumindo que existe um decisor `P` para `VMT`, construímos a máquina `Y` que decide `AMT`:

- `Y` recebe `<M, x>` como entrada.
- Construa uma máquina `J` que, com entrada `z`:
  1. Rode `M` com entrada `x`.
  2. Se `M` aceitar `x`, `J` aceita todas as palavras (`L(J) = Σ*`); caso contrário, `J` rejeita todas as palavras (`L(J) = ∅`).

Agora, use `P` para decidir se `L(J) = ∅`:
- Se `P` aceitar (ou seja, `L(J) = ∅`), então `M` **não aceita** `x` → `Y` rejeita.
- Se `P` rejeitar (ou seja, `L(J) ≠ ∅`), então `M` **aceita** `x` → `Y` aceita.

Portanto, `Y` decide `AMT`. Isso é uma contradição, pois `AMT` é indecidível.

# Algumas Linguagens Decidíveis

SAT = ⟨⟨φ⟩⟩ | φ é satisfazível

1. VAFD₀ = ⟨⟨B⟩⟩ | B é um AFD tal que L(B) = ∅
2. VAFD = ⟨⟨B⟩⟩ | B é um AFD tal que L(B) ≠ ∅
3. TODOS = ⟨⟨B⟩⟩ | B é um AFD tal que L(B) = Σ\*

---

### Explicações abaixo:

1. Todos os autômatos que **não** aceitam nenhuma palavra
2. Todos que aceitam ao menos **uma** palavra
3. Todos que aceitam **todas as palavras**

---
## 🧾 Prova 1 

### ✅ Estudei:

- Alguns exercícios de MT dos slides e do moodle (resoluções na pasta de exercícios)
- Problemas 3.9 ao 3.13 do cáp.3 do Sipser (resoluções na pasta Cáp.3)

**Ajudou?:** Quase não caiu questão aos moldes dos problemas do livro ); 

### ✅ O que caiu?

- Qual a relação entre decidíveis e reconhecíveis?
- Complemento de uma linguagem decidível, é uma decidível tb?
- Intersecção de uma linguagem decidível e uma turing reconhecível

# Questões
### 🔹 Problema 3.12 – Capítulo 3 (Sipser)
"...quando a máquina está no estado lendo um 'a', a cabeça da máquina salta para a extremidade esquerda da fita..." Não tinha sacado de cara aqui que o ato de reiniciar é, obviamente, voltar até o início da fita.

#### Passo a passo:

Fita inicial:
```txt
... A B C D ...
      ↑  (Cabeçote sobre B)
```
Marca aonde está o cabeçote:
```txt
... A *B C D ...
       ↑
```
Copia tudo uma célua a direita(exceto a marca), reseta e anda até a marca:
```txt
... □ *A B C D ...
       ↑     (Cabeçote sobre A)
```

---

## ❓ Dúvidas em Aberto

### 🔹 Problema 3.9(a) – Capítulo 3 (Sipser)  
**Situação:** Não respondida  
**Dúvida:**  
Na resolução do problema, o livro apenas afirma (seguindo o Teorema 2.20) que nenhum autômato de pilha com uma única pilha (1-AP) reconhece a linguagem:  
```
B = { aⁿ bⁿ cⁿ | n ≥ 0 }
```
Em seguida, ele demonstra como um autômato com duas pilhas (2-AP) pode reconhecê-la.

**Questão:**  
Se essa fosse uma questão de prova, eu deveria apenas partir do ponto em que sabemos que um 1-AP não reconhece tal linguagem (citando o Teorema 2.20), ou seria necessário justificar esse fato?

**Possível justificativa para resposta discursiva:**  
> "Um autômato com apenas uma pilha não consegue verificar três quantidades iguais simultaneamente. Isso é provado na Teoria da Computação: a linguagem `{ aⁿ bⁿ cⁿ | n ≥ 0 }` **não é livre de contexto**, e os autômatos de pilha reconhecem exatamente as **linguagens livres de contexto**."

---

### 🔹 Problema 3.9(b) – Capítulo 3 (Sipser)  
**Situação:** Não respondida  
**Dúvida:**  
Ainda tenho incerteza sobre como se dá a **configuração das duas pilhas** na simulação de uma Máquina de Turing (MT) por um autômato de pilha com duas pilhas (2-AP).  

**Questão específica:**  
Se a entrada da MT tiver **comprimento par ou ímpar**, isso altera a lógica da simulação? Afinal, a fita da MT será "dividida" entre as duas pilhas, e o ponto central pode variar dependendo da paridade do comprimento da entrada.

---

### 🔹 Problema 3.10 – Capítulo 3 (Sipser)  
**Situação:** Não respondida  
**Dúvida:**  
Minha dificuldade está relacionada à **marcação da posição do cabeçote** original da MT.  

**Questão específica:**  
Durante a simulação da MT, essa posição precisa ser indicada na fita. No entanto, isso parece exigir **três informações por célula**:
- O símbolo armazenado;
- Uma marca de controle (por exemplo, um estado codificado);
- A posição do cabeçote.

**Observação:**  
A não ser que a posição do cabeçote seja representada de forma implícita (por exemplo, utilizando um símbolo "branco" para marcar a célula sob o cabeçote), não fica claro como isso é tratado de forma prática com apenas uma célula por posição na fita.
