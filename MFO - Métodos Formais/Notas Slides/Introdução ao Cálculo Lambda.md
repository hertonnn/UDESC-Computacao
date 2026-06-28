# Introdução ao Cálculo Lambda

## Definição
Cálculo lambda (λ-cálculo) é um modelo matemático capaz de ilustrar de forma simples alguns importantes conceitos presentes em linguagens de programação, como por exemplo ligação, escopo, ordem de avaliação, computabilidade, sistemas de tipos, etc.

O Cálculo lambda consiste em definições de funções e regras de reescrita (substituição de variáveis) e foi definido na década de 30 por Alonzo Church com a finalidade de formalizar o conceito de computabilidade. Uma expressão lambda (em sua forma pura) é definida pela seguinte sintaxe:

```text
<expressão> → x                                   (variável)
            | <expressão> <expressão>             (aplicação)
            | λx.<expressão>                      (abstração lambda ou função)
```

Onde `x` pode ser uma variável (normalmente representada por ..., x, y, z, ...) ou uma constante. Exemplos de expressões lambda:

* `λx.x` — função identidade.
* `λf.λg.λx.f(gx)` — composição de funções.
* `(λx.x)5` — aplicação da função identidade.

É comum, para que as expressões fiquem mais concisas, deixar de usar o ponto para separar abstrações lambda quando estas encontram-se aninhadas. Existem algumas convenções sintáticas para eliminar a necessidade de uso de parêntese na maioria dos casos. As mais importantes são que as aplicações ocorrem da esquerda para a direita e que o escopo de uma λ-abstração se estende o mais à direita possível, por exemplo, `λx.xy` deve ser lido como `λx.(xy)`, não como `(λx.x)y`. Em uma expressão `λx.M`, `M` é chamado do escopo de `x`.

A ocorrência de uma variável, em uma λ-expressão, pode ser livre ou ligada. Uma variável é livre se na expressão não está associada a nenhuma λ-abstração, por exemplo, a variável `x` na expressão `x + 1` e a variável `y` na expressão `λx.x + y`. Uma variável que não é livre é dita ligada. Expressões que diferem apenas pelos nomes das variáveis ligadas são chamadas de expressões α-equivalentes e representam exatamente a mesma expressão (sinônimos), por exemplo:
`λx.x` define a mesma função (identidade) que `λy.y`.

O conjunto de variáveis livres em uma expressão `M` é representado por `FV(M)` (free variables), que é definido como:

* `FV(x) = x`
* `FV(MN) = FV(M) ∪ FV(N)`
* `FV(λx.M) = FV(M) - {x}`

Uma expressão `M` é dita fechada (um termo fechado também é chamado de combinador) se `FV(M) = ∅`.

## Substituição e Equivalência
A substituição de todas as ocorrências de uma variável `x` por uma expressão `M` é representada por `[M/x]`. Por exemplo, podemos obter uma expressão α-equivalente a `λx.M` substituindo todas as ocorrências de `x` por `y`, desde que `y` não ocorra em `M`. Essa substituição é representada por: `λy.[y/x]M`. O axioma central de λ-cálculo envolve substituições e é chamado de β-equivalência. A β-equivalência representa a aplicação de uma λ-abstração (função):

`(λx.M)N = [N/x]M`

Por exemplo: `(λf.fx)(λy.y)` é equivalente a `(λy.y)x` e equivalente a `x`.

### Reduções
Escrevemos `M → N`, `M` é reduzida a `N`, quando uma expressão `M` pode ser reduzida a uma expressão `N`, β-equivalente, aplicando uma substituição em `M`. Geralmente esse processo pode ser repetido várias vezes; uma expressão na qual nenhuma β-redução pode ser aplicada está na forma normal.

Em alguns casos, a avaliação de uma expressão pode fornecer mais de um caminho possível de reduções. Uma importante propriedade de λ-cálculo, chamada de confluência, é que independente da sequência de reduções aplicada, o resultado (forma normal da expressão) é sempre o mesmo. É importante observar que podem ocorrer casos onde um determinado caminho pode ocasionar uma sequência infinita de reduções, nunca atingindo a forma normal.

### Ordem de Avaliação
As regras de avaliação não especificam a ordem exata em que uma expressão deve ser reduzida. Uma possível ordem de avaliação é reduzir completamente o argumento antes de substituí-lo no corpo da função; essa avaliação é chamada avaliação por valor (eager evaluation ou applicative-order). Uma outra alternativa de avaliação é substituir o argumento sem avaliá-lo, nesse caso o argumento será reduzido apenas se necessário; essa ordem de avaliação é chamada de avaliação preguiçosa ou ordem normal (normal-order evaluation ou lazy evaluation). 

Por exemplo:

**Avaliação por Valor:**
```text
(λw.λy.λx.y(wyx))((λa.λb.λc.b(abc))(λs.λz.z))
→ (λw.λy.λx.y(wyx))(λb.λc.b((λs.λz.z)bc)))
→ (λw.λy.λx.y(wyx))(λb.λc.b((λz.z)c))
→ (λw.λy.λx.y(wyx))(λb.λc.b(c))
→ λy.λx.y((λb.λc.b(c))yx)
→ λy.λx.y(λc.y(c)x)
→ λy.λx.y(y(x))
```

**Avaliação Preguiçosa:**
```text
(λw.λy.λx.y(wyx))((λa.λb.λc.b(abc))(λs.λz.z))
→ λy.λx.y(((λa.λb.λc.b(abc))(λs.λz.z))yx)
→ λy.λx.y((λb.λc.b((λs.λz.z)bc))yx)
→ λy.λx.y((λb.λc.b((λz.z)c))yx)
→ λy.λx.y((λb.λc.b(c))yx)
→ λy.λx.y((λc.y(c))x)
→ λy.λx.y(y(x))
```

A avaliação de uma expressão pode resultar em uma expressão na forma normal ou a computação pode não terminar; vamos representar a segunda situação através do símbolo `⊥`. Note que `⊥` não é propriamente um valor e não pode ser manipulado.

Uma função `f` é dita estrita se `f ⊥ = ⊥` e não estrita se `f ⊥`, em alguma situação, fornecer outro valor. (Uma função é estrita se necessita que o valor de todos os seus argumentos sejam completamente calculados). Por exemplo, a função identidade é claramente estrita, mas `λx.λy.x` não é, pois `(λx.λy.y) ⊥ (λx.x)` é avaliado como: `λx.x`. A existência de funções não estritas torna significante a escolha da ordem de avaliação. Outro exemplo, a expressão `(λx.λy.y)((λz.zz)(λz.zz))(λw.w)` termina se adotarmos a ordem de avaliação preguiçosa e não termina se adotarmos a ordem de avaliação por valor.

**Teorema de Church e Rosser:** Se `v` é o resultado da avaliação de uma expressão `M` aplicando a ordem de avaliação preguiçosa, então qualquer que seja a ordem de avaliação aplicada, ou o resultado da avaliação é `v` ou a avaliação falha (não termina). Se a avaliação de `M` não termina usando a ordem de avaliação preguiçosa a avaliação não termina usando qualquer ordem de avaliação.

## Currificação
Podemos representar uma função que recebe dois argumentos como `λx.(λy.M)`, onde `M` é uma expressão lambda, possivelmente envolvendo `x` e `y`. Aplicando um único argumento à função temos como retorno uma função que aceita o segundo argumento `y`. Por exemplo, a função matemática `f(g, x) = g(x)` tem dois argumentos, mas poderia ser representada em λ-cálculo como:

`fc = λg.λx.gx`

A diferença entre `f` e `fc` é que a função `f` deve receber um par de argumentos `(g, x)` enquanto `fc` pode receber um único argumento `g`, retornando nesse caso `λx.gx`. Depois de passados todos os argumentos para a função `fc` o resultado é exatamente o mesmo da função `f`. Funções como `fc` passaram a ser conhecidas como funções Currificadas depois que o matemático Haskell Curry estudou suas propriedades.

## Numerais de Church
Os números naturais podem ser expressos através do zero e seus sucessores; dessa forma o número 1 é representado por `suc(zero)`, o número 2 é representado por `suc(suc(zero))` e assim sucessivamente. Em λ-cálculo podemos representar o zero como a λ-abstração `λs.λz.z` e seus sucessores como:

```text
1 ≡ λs.λz.s(z)
2 ≡ λs.λz.s(s(z))
3 ≡ λs.λz.s(s(s(z)))
...
```

Considerando essa representação para os números naturais, a função para calcular o sucessor de um número qualquer é definida como:

`SUC = λw.λy.λx.y(wyx)`

Por exemplo, o sucessor de zero pode ser obtido aplicando a função `SUC` na representação de zero:

```text
(λw.λy.λx.y(wyx))(λs.λz.z)
→ λy.λx.y((λs.λz.z)yx)
→ λy.λx.y((λz.z)x)
→ λy.λx.y(x)
```

o resultado é α-equivalente à representação de 1. A função de adição entre dois números naturais é definida como:

`ADD = λx.λy.λw.λu.xw(ywu)`

Como exemplo podemos aplicar a função de adição para os números naturais 2 e 3:

```text
(λx.λy.λw.λu.xw(ywu))(λs.λz.s(s(z)))(λs.λz.s(s(s(z))))
→ (λy.λw.λu.(λs.λz.s(s(z)))w(ywu))(λs.λz.s(s(s(z))))
→ (λy.λw.λu.(λz.w(w(z)))(ywu))(λs.λz.s(s(s(z))))
→ (λy.λw.λu.w(w(ywu)))(λs.λz.s(s(s(z))))
→ λw.λu.w(w((λs.λz.s(s(s(z))))wu))
→ λw.λu.w(w((λz.w(w(w(z))))u))
→ λw.λu.w(w(w(w(w(u)))))
```

## Booleanos
Os valores booleanos verdade e falsidade são representados pelas λ-abstrações:

* `V ≡ λx.λy.x`
* `F ≡ λx.λy.y`

Dessa forma as operações lógicas são definidas como:

* `E = λx.λy.xy(λu.λv.v)`
* `OU = λx.λy.(x(λu.λv.u))y`
* `NAO = λx.(x(λu.λv.v))(λa.λb.a)`

## λ-Cálculo Enriquecido
Qualquer linguagem de programação deve fornecer meios de condicionar a avaliação de uma expressão ao resultado da avaliação de outra expressão. Na grande maioria das linguagens de programação encontramos alguma variação da construção sintática:

`if <expressão1> then <expressão2> else <expressão3>`

Onde a `expressão2` é avaliada caso a `expressão1` resulte em um valor verdade; caso contrário, a `expressão3` é avaliada. Note que a definição do valor verdade é justamente uma função que recebe dois argumentos e tem como resultado o primeiro, e falsidade uma função que recebe dois argumentos e tem como resultado o segundo, portanto construções como a expressão de seleção poderiam ser definidas em λ-cálculo puro. Embora qualquer computação possa se expressar através de λ-cálculo puro, o λ-cálculo enriquecido (com a expressão condicional, algarismos arábicos, operadores aritméticos, operadores relacionais, operadores lógicos, etc.) é comumente usado, uma vez que a manipulação de expressões em λ-cálculo enriquecido é consideravelmente mais simples do que em sua versão pura:

* `λx.x + 1` — função incremento.
* `λx.λy.if x > y then x else y` — função que retorna o maior entre dois elementos.

## Operador de Ponto Fixo
A maioria das linguagens de programação modernas permite a definição de funções recursivas. Uma função recursiva possui uma ou mais referências a si mesma na sua declaração. Por exemplo, a função que calcula o fatorial de um inteiro positivo:

`f = λn.if n = 0 then 1 else n * f (n-1)`

Considere agora a função `G` obtida através de uma pequena alteração na definição acima, tornando a função `f` um argumento:

`G = λf.λn.if n = 0 then 1 else n * f (n-1)`

O ponto fixo da função `G` é tal que `G(f) = f`. O ponto fixo de uma função pode ser definido em λ-cálculo através do operador `FIX` que apresenta a seguinte identidade:

`FIX F = F (FIX F)`

Usando o operador de ponto fixo definimos a função fatorial da seguinte maneira:

`fat = FIX λf.λn.if n = 0 then 1 else n * f (n-1)`

Cada vez que o operador de ponto fixo é reduzido `FIX F` deve ser substituído por `F (FIX F)`. Como no exemplo abaixo, é calculado o fatorial de 1:

```text
(FIX λf.λn.if n = 0 then 1 else n * f (n-1)) 1
→ ((λf.λn.if n = 0 then 1 else n * f (n-1)) (FIX λf.λn.if n = 0 then 1 else n * f (n-1))) 1
→ (λn.if n = 0 then 1 else n * (FIX λf.λn.if n = 0 then 1 else n * f (n-1)) (n-1)) 1
→ if 1 = 0 then 1 else 1 * (FIX λf.λn.if n = 0 then 1 else n * f (n-1)) (1-1)
→ 1
```

A expressão lambda que define o operador de ponto fixo é:

`FIX = λf.(λx.f(xx))(λx.f(xx))`
