
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

----
# Indecibilidade com AMT

Anteriormente, foi provado que a linguagem AMT = {<M, w> | w pertence a L(M)} é indecidível. Com esse fato, podemos mostrar que alguma linguagem L é indecidível mostrando que essa linguagem é igual a AMT. Começamos supondo um decisor para essa linguagem e chegando a um absurdo.


## Problema da Parada

ParaMT = {<M, w> | M é uma MTD e w uma entrada para M}

É possível dizer que M sempre para? R: Não.

**Prova**

Supondo que exista um decisor U tal que L(U) = ParaMT

Construimos uma máquina X que rode U como subrotina e que tenha aceitação sempre que U aceite w' e rejeite sempre que haja rejeição ou um loop infinito.

Se U aceitar, rode M' com entrada w' e responda o que M' responder.

Com isso, é possível afirmar que X é um decisor para a linguagem AMT.

Aí temos uma contradição, pois foi provado anteriormente que AMT é indecidível.


**Exemplo 1:**

VMT = {<M> | L(M) = ∅}

Ou seja, máquinas de Turing que não aceitam nenhuma palavra.

Supondo que exista um decisor P para L(P) = VMT. Construímos a máquina de Turing a seguir:
Y tem como entrada <M, x> onde M é uma MTD e x é uma palavra.

Construa a máquina J com entrada z.

1. Rode M com entrada x e responda o que M responder.

L(J) = Qualquer palavra se M aceitar x, ou conjunto vazio se x não pertencer a L(M)

2. Rode P com a entrada J. Se P aceitar, rejeite. Se P rejeitar, aceite.

Então L(Y) = AMT e Y é um decisor. Pela prova que AMT é indecidível, temos um absurdo.


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

# Demonstração da Indecidibilidade de RegularMT

Definimos:

- **RegularMT** = {⟨M⟩ | L(M) é uma linguagem regular}

---

## Suposição Inicial

Suponha que **RegularMT** seja decidível.

Então, existe uma máquina de Turing decisora chamada **UNNOME** tal que:

- L(UNNOME) = RegularMT

---

## Construção da Máquina H

Defina a máquina de Turing **H** que recebe como entrada o par ⟨M’, w⟩ e opera da seguinte forma:

1. Construa a máquina **X** definida por:

   **X**, com entrada x:

   - Se x for da forma \(0^n 1^n\), aceite.
   - Se x não for da forma \(0^n 1^n\), execute M’ com entrada w e responda o que M’ responder.

2. Execute **UNNOME** com entrada ⟨X⟩.

3. Responda o que **UNNOME** responder.

---

# EQMT = { <M1, M2> | L(M1) = L(M2) }



Supondo que EQMT é decidível, ou seja, existe decisor ÉEQ tal que L(ÉEQ) = EQMT.

Seja a máquina D a seguir:



D, com entrada <M’>:

	1.	Construa a máquina de Turing V a seguir:



(diagrama da máquina V):



→ (qR)  (qA)



	2.	Execute ÉEQ com entrada <M’, V> e responda o que ÉEQ responder.



Logo, D é uma decisora e L(D) = VMT.



Como VMT é indecidível, a decidibilidade de EQMT é falsa.

Portanto, EQMT é indecidível.

---
# AMTFL: ⟨A, w⟩ | A é uma MTFL e w ∈ L(A)



# VMTFL3: ⟨A⟩ | A é uma MTFL e L(A) = ∅



⸻



Histórias de Computação:



Sequência de configurações C₁, C₂, …, Ck de uma MT M com entrada w tal que:

	•	C₁ = q₀w (config. inicial)

	•	Para todo i, 1 ≤ i ≤ k, tem-se que Ci é obtido por Ci-1

	•	Ck é uma config. de parada



⸻



Nº de configurações diferentes em uma MTFL com entrada w onde |w| = n:



(k ^ n ) * n * m



onde:

	•	k = |Γ| (tamanho alfabeto da fita)

	•	m = |Q| (nº de estados)

	•	n = estado atual
---
## Conclusão

- A máquina **H** é um decisor para a linguagem **AMT** (o problema da aceitação de máquinas de Turing).
- Sabemos que **AMT** é indecidível.
- Logo, a existência de **H** contradiz a indecidibilidade de **AMT**.
- Portanto, a suposição de que **RegularMT** é decidível é **falsa**.

---
# Problema da Correspondência de Post



Primeira peça (tipo 1):



[#]

[#q0w#]



Tipo 2 - É um movimento à direita para cada δ(q,a) que resulta (r,b,D). Acrescente a peça:



[q a]

[b r]



Tipo 3 - Final de configuração



 É um movimento à esquerda para cada δ(q,a) que resulta (r,b,E). Acrescente a peça para cada γ ∈ Γ e a peça:



[q a γ]

[γ b r]



Tipo 4 - Para cada símbolo do alfabeto da fita, acrescente a peça:



[γ]

[γ]



Tipo 5 - Final de configuração. Acrescente as peças:



[#]

[#]



e



[#]

[branco #]



Tipo 6 - Aceitação. 

Para cada γ ∈ Γ, acrescente as peças:



[γqA]

[qA]



ou



[qAγ]

[qA]



Tipo 7 - Última peça. 

Acrescente:



[qA # #]

[#]
---
# Prova 1 - Correção
1 - Responda às perguntas a seguir a partir da máquina de Turing

    M = ({q0, q1, …, q7, qA, qR}, {#, 0, 1}, {#, 0, 1, x, _}, δ, q0, qA, qR)
onde δ é representado no diagrama abaixo.

![img_q1](https://raw.githubusercontent.com/hertonnn/UDESC-Computacao/refs/heads/master/utils/img/img_tec_p1.jpeg)

a) Qual a linguagem da máquina M?

     LM = {w#w | w ∈  {0,1}*}

b) A palavra #xxx pertence à L(M)? Por quê?

     #xxx não pertence, pois não respeita o formato w#w p/ w ∈ {0,1}*

c) M é uma decisora?
    
Se sim: seria possível obter uma máquina de Turing equivalente não 
decisora? Por quê?

Se não: indique uma entrada que entre em loop infinito.

R: Sim, pois pra toda entrada w, há parada com aceitacão ou rejeição. Podemos criar uma máquina equivalente não decisora alterando os estados em que há rejeição por indefinição. Por exemplo, podemos fazer com que haja transições para um loop infinito ao invés da máquina parar por indecisão. 

2 - 

a) Por que, ao simular uma Máquina de Turing não determinista em uma Máquina de Turing determinista, não se deve fazer uma busca por profundidade na árvore das possíveis computações da máquina não determinista?

R: Porque, ao realizar uma busca em profundidade (DFS) na árvore de possibilidades, corremos o risco de não alcançar um ramo aceitante mesmo que exista, especialmente se outro ramo entrar em um loop infinito. Já na busca em largura (BFS), todas as ramificações são percorridas por nível, garantindo que, se houver uma aceitação, ela será encontrada.

b) Sejam A e B linguagens quaisquer sobre o mesmo alfabeto. Se A é decidível e B é Turing-reconhecível, o que se pode afirmar a respeito de A ∩ B? Justifique sua resposta. 

R: A ∩ B é reconhecível. Para verificar uma entrada w, basta rodar primeiro o decisor de A. Se w não estiver em A, rejeitamos imediatamente, pois w não poderá estar em A ∩ B. Se w estiver em A, simulamos a máquina que reconhece B com a entrada w. Caso essa segunda máquina aceite, concluímos que w pertence a A ∩ B e aceitamos. Se a segunda máquina não parar, ficamos em loop, o que garante que A ∩ B não seja decidível, mas sim apenas reconhecível.

c) Uma configuração de uma máquina de Turing é uma sequência finita e tamanho n>=2, composta por 1 estado e n-1 símbolos do alfabeto da fita, que indica o conteúdo da fita, o estado corrente e a posição da fita. Explique porque sempre é possível obter uma configuração em qualquer momento da computação de uma máquina, mesmo sabendo que o tamanho da fita é infinito.

R: 

R: A fita de uma Máquina de Turing pode ser infinita, mas, a cada momento da computação, apenas uma porção finita dela foi acessada e contém informação relevante. Por isso, podemos representar todas as informações do instante atual (estado e conteúdo não vazio da fita) por uma sequência finita, inserindo o estado atual no local em que o cabeçote se encontra.

3- Seja A uma linguagem decidível. Então o complemento  de A é reconhecível.

R: Fato, Pelo teorema A é decicível <=> A é reconhecível e correconhecível. Se temos que A decicível, A também é reconhecível. Para encontrar o reconhecedor do complemento de A, podemos criar uma máquina M' que rode uma máquina M decisora de A com entrada w e inverta o que M responder. Com isso, temos que M' é reconhecedora e decisora da linguagem que é complemento de A.


b) Se M for uma máquina de Turing que entra em loop infinito para algumas entradas, então L(M) é uma linguagem indecidível.

R: Não obrigatoriamente. O fato de uma máquina entrar em loop para algumas entradas não determina que sua linguagem não seja indecidível. É possível transformar uma máquina não-decidedora em uma decididora para a mesma linguagem, de maneira que a linguagem continue a mesma, mas apenas a máquina seja alterada.

4.

R:

Máquina de Sipser que simula a de Zezinho

Em todos os estados finais de aceitação, a MS faz com que as indefinições da função programa existentes nesses estados virem transições para o estado qAceita.

O funcionamento da rejeição é parecida na MZ, apenas não utiliza um estado qRejeita. Logo, toda vez que a entrada for rejeitada, isso deve ocorrer por indefinição da função programa.

Máquina de Zezinho que simula a de Sipser

Todas as transições que vão para aceitação em qAceita da MS são feitas por indefinição em MZ. O estado de aceitação também não pode ter transições (pois o processamento poderia continuar a partir dele, o que não ocorre na máquina de Sipser)



# Prova 2 - Correção 
...


# Decidibilidade por outro material... 

A partir de desse ponto da disciplina usei o material da [UFMG](https://homepages.dcc.ufmg.br/~msalvim/courses/ftc/) de Teoria da computação para compreender algumas demonstrações que não havia entendido no material da professora. Portanto, aqui vou reproduzir as mesmas demonstrações que estão no diário de bordo, mas um pouco mais detalhadas iguais as da UFMG para revisar e estudar mesmo.

Como visto anteriormente no material, podemos concluir:

"Portanto, há linguagens para as quais não há MT correspondente. Estas
linguagens não podem ser, portanto, Turing-reconhecíveis."

## AMT: O Problema da Aceitacão para MTs concerne a seguinte linguagem:
- AMT = {<M,w> | M é uma MT e M aceita w}.

Antes de mais nada, sabemos que a AMT é Turing-reconhecível, já que é visto no material que a MT U (Máquina de Turing Universal) não decide a linguagem AMT, mas apenas a reconhece.

### Demonstração

A demonstração se dá por contradição. Assumimos que AMT seja decidível e derivamos um absurdo.

Suponha que existe um decisor H para AMT, que se comporte da seguinte forma:

    H(<M, w>) = 
        aceite,   se M aceita w
        rejeite,  se M não aceita w

Se o decisor H existe, é possível construir uma nova MT D que utiliza H como uma subrotina.

A MT D recebe uma MT M como entrada e pergunta ao decisor H se M, ao receber como entrada a cadeia <M> que representa sua própria descrição, aceita ou rejeita. O que o decisor responder, a MT D inverte seu comportamento.

D = "Sobre a entrada <M>, onde M é uma MT:

    1. Rode H sobre a entrada <M,<M>>.
    2. Dê como saída o oposto do que H dá como saída: se H aceita, *rejeite*; se H rejeita, *aceite.*

Note que D vai ter esse comportamento:

    D(<M>) = 
        aceite, se M não aceita <M>.
        rejeite, se M aceita <M>.
Agora que chegamos ao cerne da demonstração: verificamos o que acontece quando rodados a MT D com sua própria descrição <D> como entrada será:

    D(<D>) = 
        aceita, se D não aceita <D>.
        rejeita se D aceita <D>.

Mass note que isso é um absurdo:

**D aceita a cadeia <D>** se, e somente se, **D não aceita a cadeia <D>!**

Portanto, concluimos que a hipótese de que pode existir um decisor H para AMT é falsa, ou seja, AMT é indecidível.

## Teorema: Uma linguagem é decidível se, e somente se, ela é Turing-reconhecível e co-Turing-reconhecível.

- Antes de mais nada, uma linguagem é co-Turing-raconhecível (no material da Karina acho que é correconhecível apenas) se ela for o complemento de uma linguagem Turing-reconhecível.

### Demonstração

-> ida

Bom, se uma linguagem A for decidível, então tanto A quanto seu complemento Ā  são Turing-reconhecíveis.

Isso pois qualquer linguagem decidível é Turing-reconhecível, e o complemento de uma decidível é também decidível.

<- volta

Se tanto A quanto Ā são Turing-reconhecíveis, então existe um reconhecedor M1 para A e um reconhecedor M2 para Ā.

Podemos então combinar M1 e M2 no seguinte decisor M para A.

M = "Sobre a entrada w:

    1. Rode ambas M1 e M2 sobre a entrada w em paralelo
    2. Se M1 aceita, *aceite*; se M2 aceita, *rejeite.*
 
Obs: Rodar as duas máquinas em paralelo significa que M tem duas fitas, uma para simular M1 e outra para simular M2, e M alternadamente simula um passo de cada na máquina até que uma delas aceite.

Para ver que M decide A, note que toda cadeia w ou está em A ou está em Ā, logo ou M1 ou M2 deve necessariamente aceitar w. Como M pára sempre que ou M1 ou M2 aceita, M sempre pára. Além disso, M aceita todas as cadeias em A e rejeita todas as cadeias demais. Isto mostra que A é decidível.

## Demonstração de que ĀMT (complemento de AMT) não é Turing-reconhecível

Primeiro, note que já sabemos que AMT é Turing-reconhecével.

Por contradição, assuma que AMT também seja Turing-reconhecível. Neste
caso AMT seria co-Turing-reconhecível.

Mas se AMT é Turing-reconhecível e co-Turing-reconhecível, AMT deve ser
decicível.

Mas isto é uma contradicão: já que demonstramos que AMT não é decidível.
Logo AMT não pode ser Turing-reconhecível.

## Redutibilidade 

Como nem sempre é conveniente mostrar que um problema é indecidível de maneira direta, usamos a redutibilidade para demonstrar que problemas são indecidíveis (ou decidíveis).

Para entender melhor sobre esse conceito indico ir nos slides da [UFMG sobre](https://homepages.dcc.ufmg.br/~msalvim/courses/ftc/Aula5_Redutibilidade%5bstill%5d.pdf). Aqui vou pular direto para as demonstrações usando redutibilidade que são o que me interessa para a prova.


## PARAMT é indecidível
- PARAMT = {<M, w> | M é uma MT e M para sobre a entrada w}.

Algumas vezes nos referimos a AMT como "Problema da parada", porém, estritamente falando, o **Problema da Parada** é a linguagem PARAMT.

### Demonstração 

Por contradição.

Suponha que PARAMT seja decidível.

Então existe uma MT R que decide PARAMT (acredito que esse decisor diz se dado uma máquina e uma cadeia w essa maquina pára ou não), e poderíamos usar R para construir uma MT S que decide a linguagem AMT da seguinte forma. 

S = "Sobre uma entrada <M, w>, uma codificação de uma MT M e de uma cadeia w:
    
    1. Rode a MT R sobre a entrada <M, w>. 
    2. Se R rejeita, *rejeite*. (Ou seja, se R rejeita significa que a M não para quando recebe w, acredito...).
    3. Se R aceita, simule M sobre w até que ela pare.
    4. Se M aceitou, *aceite*; se M rejeitou, *rejeite.*

Mas note que se R é capaz de decidir PARAMT (ou sejam R nunca entra em loop e sempre dá a resposta correta), então claramente S é um decisor para AMT (pois S também nunca entra em loop e sempre dá a resposta correta.).

Mas isto é uma contradição, pois já determinamos que AMT é indecidível.

Logo concluimos que PARAMT é indecidível.

## VMT é indecidível
- VMT = {<M> | M é uma MT e L(M) =  ∅}

Este é o problema de se decidir se a linguagem reconhecida por uma MT é vazia.

### Demonstração

VMT = {<M> | L(M) = ∅}

Ou seja, máquinas de Turing que não aceitam nenhuma palavra.

Supondo que exista um decisor P para VMT. Construímos a máquina de Turing a seguir:

S = "Tem como entrada <M, x> onde M é uma MTD e x é uma palavra:

    1. Construa a máquina J: 
            L(J) = Qualquer palavra,  se M aceitar x
                   {∅}, se M rejeitar x
    2. Rode P com a entrada J. Se P aceitar, rejeite. Se P rejeitar, aceite.

Então L(S) = AMT e S é um decisor. Pela prova que AMT é indecidível, temos um absurdo.

## REGULARMT é indecidível
- REGULARMT = {<M> | M é uma MT e L(M) é uma linguagem regular}.

Este é o problema de se decidir se dada uma MT, existe um AF equivalente a ela.

Vamos supor que RegularMT é decidível.

Logo, existe decisor R tal que L(R) = RegularMT.

Seja H a seguinte máquina de Turing com entrada ⟨M’, w⟩:

	1.	Construa a máquina X a seguir com entrada x:

        I) Se x for da forma 0ⁿ1ⁿ, aceite.

        II) Se x ≠ 0ⁿ1ⁿ, execute M’ com entrada w e responda o que M’ responder.

	2.	Execute R com entrada ⟨X⟩. Responda o que R responder.

Logo, H é um decisor para AMT.

Como não é possível existir decisor para AMT, a suposição da decidibilidade de RegularMT é falsa.

## EQMT é indecidível

EQMT = { <M1, M2> | L(M1) = L(M2) }

Este é o problema de se decidir se duas MTs reconhecem a mesma linguagem.

Supondo que EQMT é decidível, ou seja, existe decisor R que decida EQMT.

Seja a máquina D a seguir com entrada <M'>:

	1.	Execute R com entrada <M’, Mv>, Mv é uma MT que rejeita todas as entradas.
    2. Se R aceita, aceite; Se não, rejeite;


Note que L(Mv) = ∅.

Logo, ao decidir se uma MT M' de entrada é equivalente a Mv, D está decidindo VMT. 

Como VMT é indecidível, a decidibilidade de EQMT é falsa.

Portanto, EQMT é indecidível.


## TUDOMT é indecidível

TUDOMT = {<M> | M é uma MT e L(M) = Σ∗}

Esse é o problema de se decidir se uma MT aceita qualquer palavra.

Supondo que TUDOMT é decidível, ou seja, existe um decisor R que decide TUDOMT. Podemos usar R para construir uma MT S que seja um decisor de AMT da seguinte forma:

S = "Sobre uma entrada <M, w> onde M é uma MT e w uma palavra:

    1. Construa uma MT da seguinte forma:
        Y: com entrada y (essa entrada y não utilizaremos. Pois essa MT serve apenas para rodar M sobre w)
            (I) Roda M com entrada w e responda o que M responder.
    2. Rode R com entrada <Y> e responda o que R responder. "

Note que a L(Y) é Σ∗ quando M aceita w, e ∅ quando M não aceita w (independente se M rejeita w ou entra em loop infinito). Logo H é um decisor de AMT, o que é um absurdo. Portanto R não existe, ou seja, TUDOMT não é decidível.

## 2wMT = {<M, w>} | M é uma MT e ww ∈ L(M)}

Esse é o problema de se decidir se ww pertence a uma linguagem

Seja uma MTD S a seguir: 

S = "Sobre uma entrada <M, w> onde M é uma MT e w uma palavra:

    1. Construa uma MT da seguinte forma:
        Y: com entrada y
            (I) se y != 1010, rejeite.
            (II) se y = 1010, Rode M com entrada w e responda o que M responder.
    2. Retorne <Y, 10> "  

Tem-se que S é uma MT que computa uma função de mapeamento de AMT para 2wMT, uma vez que, se a entrada <M, w> de S pertence à AMT (ou seja, se w ∈ L(M)) então o par <Y, 10> pertence à 2wMT já que Y aceita 1010. Porém, se w ∉ L(M), então Y não aceita 1010, portanto <Y, 10> ∉ 2wMT. Como AMT ≤m 2wMT e AMT é indecidível, temos que 2wMT é indecidível.


## SPVMT = {<M> | M é uma MT e ε ∉ L(M)}

*parecida com 2wMT e um pouco REGULARMT*

Esse é o problema de se decidir se dada uma MT o ε não pertence a L(M)

Seja uma MTD S a seguir:

S = "Sobre uma entrada <M, w> onde M é uma MT e w uma palavra:

    1. Construa a seguinte MT:
        Y: Com entrada y
            (I) Se y != ε, aceite.
            (II) Se y = ε, Rode M com entrada w e responda o que M responder.
    2. Retorne <Y>

Tem-se que L(Y) = Σ∗ quando e w ∈ L(M) e L(Y) = Σ* - {ε} quando w ∉ L(M). Ou seja, caso <M, w> ∈ ĀMT, temos que <X> ∈ SPMT; e se <M, w> ∉ ĀMT, então <X> ∉ SPVMT. Logo F é uma MT que computa uma função de redução de ĀMT para SPVMT. Como ĀMT é indecidível e ĀMT ≤m SPVMT, temos que SPVMT é indecidível.
 
## Q = {<M> | M é uma MT e |L(M)| = 4}

Note que Q pode ser vista como a linguagem de códigos das MTs que aceitam exatamente quatro palavras.

Seja uma MTD S a seguir:

S = "Sobre uma entrada <M> onde M é uma MT:
    1. Construa uma MT Y da seguinte forma:
        l(Y) =
