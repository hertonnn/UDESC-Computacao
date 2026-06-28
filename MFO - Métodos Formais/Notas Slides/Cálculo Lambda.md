# Cálculo Lambda




## Contexto Histórico e Problemas de Hilbert


![Imagem Embutida 2](imagens/C%C3%A1lculo%20Lambda/slide_2_img_2.jpeg)


Os Problemas de Hilbert são uma lista de 23 problemas matemáticos propostos como desafio para o século XX por David Hilbert, no Congresso Internacional de Matemáticos de 1900 em Paris. Na ocasião, foram listados 10 problemas, e a lista foi completada posteriormente.

**10º Problema de Hilbert:** Consiste em encontrar um procedimento (um algoritmo) para verificar se uma equação diofantina (uma equação polinomial com múltiplas variáveis e coeficientes inteiros) possui solução inteira. Por exemplo, dada $P(x_1, x_2, ..., x_n) = 0$ (e.g., $6x^3 + 3xy^2 + z^3 - 10 = 0$), o algoritmo deveria retornar "Sim" ou "Não".

## O Surgimento do Cálculo Lambda


![Imagem Embutida 2](imagens/C%C3%A1lculo%20Lambda/slide_4_img_2.jpeg)
![Imagem Embutida 3](imagens/C%C3%A1lculo%20Lambda/slide_4_img_3.png)
![Imagem Embutida 2](imagens/C%C3%A1lculo%20Lambda/slide_5_img_2.jpeg)
![Imagem Embutida 3](imagens/C%C3%A1lculo%20Lambda/slide_5_img_3.jpeg)


O Cálculo Lambda surgiu como um dos principais formalismos para descrever a computação. Historicamente, ele está posicionado ao lado de outros modelos fundamentais da computabilidade:
- **Alan Turing:** Máquinas de Turing
- **Kurt Gödel:** Funções μ-recursivas

**Tese de Church-Turing:**
Uma função sobre números naturais pode ser calculada por um procedimento se e somente se ela pode ser computada por uma Máquina de Turing. Ou seja, todas as funções computáveis são computáveis por uma Máquina de Turing.

## Por que estudar Cálculo Lambda?




1. Expressa qualquer computação possível.
2. É a fundamentação teórica sobre a qual as linguagens funcionais são projetadas.
3. Atualmente, está disponível em boa parte das linguagens de programação contemporâneas.

## Sintaxe do Cálculo Lambda




A sintaxe é dada por:

```text
<Expressão> → x                          (uma variável a, b, c, ...)
            | (<Expressão> <Expressão>)  (aplicação de função)
            | (λx . <Expressão>)         (abstração λ)
```

**Exemplos de Expressões λ:**
- `(λx . x)`
- `(λf . (λx . (f x)))`

**Eliminando alguns parênteses:**
Pode-se simplificar a notação omitindo alguns parênteses, já que a aplicação é associativa à esquerda. Por exemplo, a expressão `f g h x` é equivalente a `(((f g) h) x)`.

## Escopo




O escopo de uma variável é o contexto no qual ela pode ser usada. Em uma expressão `λx.M`, a expressão `M` é o escopo da variável `x`.

**Exemplos com parênteses e escopo:**
- `(λa. λb. λc. a (a b c)) (λa. λb. a b)`
- Uma expressão como `λaλb. b(λxλy. x)(λsλz. z)` é avaliada, com a adição explícita dos parênteses, da seguinte forma: 
  `((λaλb. b) (λxλy. x)) (λsλz. z)`

## Equivalência α




Dizemos que duas expressões lambda são α-equivalentes caso difiram apenas nos nomes das variáveis que ocorrem ligadas às abstrações λ. Funções α-equivalentes representam a mesma computação. 

Por exemplo:
- `λxλy. x ≡α λaλb. a`
- `λfλx. f x ≡α λaλb. a b`

## Variáveis Livres e Ligadas




Uma variável livre é uma variável que não está ligada a uma abstração λ. O conjunto de variáveis livres de uma expressão `M` é representado por `FV(M)` (do inglês *Free Variables*), definido como:

- `FV(x) = {x}`
- `FV(M N) = FV(M) ∪ FV(N)`
- `FV(λx. M) = FV(M) - {x}`

Se `FV(M) = ∅`, dizemos que `M` é uma expressão fechada (também chamada de **combinador**).

**Exemplos de avaliação:**
- `FV(λx. f x) = FV(f x) - {x} = (FV(f) ∪ FV(x)) - {x} = ({f} ∪ {x}) - {x} = {f}`
- `FV(λxλf. g (f x y)) = {g, y}`

## Substituição e Redução β




A substituição de todas as ocorrências livres de uma variável `x` por uma expressão `M` é representada por `[M / x] N`. O axioma central do cálculo-λ envolve a substituição e é chamado de **redução β**. A redução β representa a aplicação de uma abstração λ (função) em um argumento:

`(λx. N) M ⊳ [M / x] N`

Por exemplo:
`(λf. f x) (λy. y) ⊳ (λy. y) x ⊳ x`

Dizemos que essas expressões são β-equivalentes.

**Passo a passo de redução:**
```text
  (λx. x x) (λa. a) (λb. λc. c)
⊳ (λa. a) (λa. a) (λb. λc. c)
⊳ (λa. a) (λb. λc. c)
⊳ (λb. λc. c)
```

**Forma Normal:** Uma expressão na qual não é possível aplicar nenhuma redução β está na sua forma normal.

## Numerais de Church




Os números naturais podem ser expressos por meio de `0` e seus sucessores. Dessa forma, o número `1` pode ser expresso como o sucessor de zero, o `2` como o sucessor do sucessor de zero, e assim sucessivamente.

- `0 ≡ λsλz. z`
- `1 ≡ λsλz. s(z)`
- `2 ≡ λsλz. s(s(z))`
- `3 ≡ λsλz. s(s(s(z)))`
- `4 ≡ λsλz. s(s(s(s(z))))`

Operações fundamentais em numerais de Church:
- Sucessor: `SUC = λwλyλx. y(w y x)`
- Adição: `ADD = λxλyλwλu. x w (y w u)`

**Exemplo de avaliação da função SUC (Sucessor de 2):**
```text
  (λwλyλx. y(w y x)) (λsλz. s(s(z)))
⊳ λyλx. y ((λsλz. s(s(z))) y x)
⊳ λyλx. y ((λz. y(y(z))) x)
⊳ λyλx. y (y(y(x))) ≡α λsλz. s(s(s(z)))
= 3
```

## Booleanos




Valores booleanos (verdadeiro e falso) podem ser representados pelas abstrações λ:
- `V ≡ λaλb. a`
- `F ≡ λaλb. b`

E os operadores lógicos são definidos como:
- `E = λxλy. x y (λuλv. v)`
- `OU = λxλy. x λuλv. u y`
- `NÃO = λx. x (λuλv. v) (λwλz. w)`

**Exemplo de avaliação de condição:** `Se NÃO VERDADE então 1 senão 2`
```text
  (λx. x (λuλv. v) (λwλz. w)) (λaλb. a) (λsλz. s(z)) (λsλz. s(s(z)))
⊳ ((λaλb. a) (λuλv. v) (λwλz. w)) (λsλz. s(z)) (λsλz. s(s(z)))
⊳ ((λb. λuλv. v) (λwλz. w)) (λsλz. s(z)) (λsλz. s(s(z)))
⊳ (λuλv. v) (λsλz. s(z)) (λsλz. s(s(z)))
⊳ (λv. v) (λsλz. s(s(z)))
⊳ λsλz. s(s(z))
```
*O resultado da avaliação converge para o equivalente ao número `2`.*

## Cálculo Lambda Enriquecido e Currificação


![Imagem Embutida 2](imagens/C%C3%A1lculo%20Lambda/slide_42_img_2.jpeg)


**Cálculo-λ Enriquecido:**
Embora qualquer computação possa ser expressa por meio do cálculo-λ puro, o cálculo-λ enriquecido (com expressão condicional, algarismos arábicos, operadores aritméticos, lógicos, relacionais, construtores de dados, etc.) é comumente usado, uma vez que as expressões ficam muito mais concisas e consideravelmente mais simples.

Exemplos:
- `λx. x + 1`
- `λxλy. if x < y then x else y`

**Currificação (Currying):**
Funções com múltiplos parâmetros, em cálculo-λ, são geralmente tratadas de forma linearizada (currificada) como múltiplas aplicações de funções com um único parâmetro. Por exemplo, uma função com dois parâmetros, `λxλy.M`, é avaliada como uma função que recebe um parâmetro formal `x` e retorna uma função que recebe um parâmetro formal `y`.

Exemplo:
```text
  (λxλy. x + y) 5 2
⊳ (λy. 5 + y) 2
⊳ 5 + 2
```

A aplicação parcial de argumentos é conhecida como **currificação** em homenagem ao matemático Haskell Curry, que investigou essa propriedade do cálculo-λ, inspirado no trabalho de Moses Schönfinkel.
