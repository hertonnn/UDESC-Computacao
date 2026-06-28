# Contagem: Princípios Aditivo e Multiplicativo

## Princípio Multiplicativo

### Problemas Motivacionais
1. Quantas linhas tem uma tabela verdade com $n$ proposições?
2. Quantos subconjuntos existem a partir de um conjunto finito com $m$ elementos?
3. Uma criança pode escolher **uma** entre $2$ tipos de balas (rosa ou preta) **e um** entre $3$ chicletes (amarelo, verde ou branco). Quantas configurações diferentes de guloseimas podem ser feitas?

No Problema 3, a escolha da bala seguida pela do chiclete produz as combinações:
- Rosa $\to$ Amarelo / Verde / Branco
- Preta $\to$ Amarelo / Verde / Branco

Se a ordem for invertida (escolha do chiclete primeiro), as opções se mantêm. **A sequência da escolha não altera o número de configurações.** Ao final, teremos $2 \times 3 = 6$ configurações possíveis.

### Definição

**Definição (Princípio Multiplicativo):**
Se existem $n_1$ resultados possíveis para um primeiro evento e $n_2$ resultados possíveis para o evento seguinte, então existem $n_1 \cdot n_2$ resultados possíveis para esta sequência de eventos.

**Exemplos Adicionais:**
- Quantidade de sequências de 4 dígitos existentes ($10 \cdot 10 \cdot 10 \cdot 10$).
- Quantidade de sequências de 4 dígitos **sem repetição** existentes ($10 \cdot 9 \cdot 8 \cdot 7$).
- Número de elementos do produto cartesiano de dois conjuntos finitos ($|A \times B| = |A| \cdot |B|$).

---

## Princípio Aditivo

### Problema Motivacional
Escolha de **uma** sobremesa entre $3$ tipos de bolo e $4$ tipos de torta.
Nesse caso, **não é uma sequência** de dois eventos, mas sim uma **escolha entre um deles**. A criança não levará ambos, e sim um total de $3 + 4 = 7$ opções.

### Definição

**Definição (Princípio Aditivo):**
Se $A$ e $B$ são eventos disjuntos com $n_1$ e $n_2$ resultados possíveis, respectivamente, então o número total de possibilidades para o evento "$A$ ou $B$" é $n_1 + n_2$.

**Exemplos Adicionais:**
- Comprar um veículo podendo escolher entre $23$ automóveis e $14$ caminhões ($23 + 14$).
- Se $A$ e $B$ são dois conjuntos finitos **disjuntos**, o número de elementos de $A \cup B$ é a soma das cardinalidades dos conjuntos:
  $$|A \cup B| = |A| + |B|$$

---

## Cardinalidade de Conjuntos Finitos

A contagem e a teoria de conjuntos estão estritamente ligadas. Sejam $A$ e $B$ dois conjuntos finitos. Temos as seguintes regras úteis de cardinalidade:

$$|A - B| = |A| - |A \cap B|$$

E se $B \subseteq A$, a fórmula é simplificada para:
$$|A - B| = |A| - |B|$$

### Demonstração: $|A - B| = |A| - |A \cap B|$
Temos que:
$$(A - B) \cup (A \cap B) = (A \cap \overline{B}) \cup (A \cap B)$$
$$= A \cap (\overline{B} \cup B) = A \cap U = A$$

Como os conjuntos $A - B$ e $A \cap B$ são completamente disjuntos (a interseção deles é vazia), pelo Princípio Aditivo, a cardinalidade da união é a soma das cardinalidades:
$$|(A - B) \cup (A \cap B)| = |A - B| + |A \cap B| = |A|$$
Isolando o termo $|A - B|$:
$$|A - B| = |A| - |A \cap B| \quad \blacksquare$$

### Demonstração: $|A - B| = |A| - |B|$ se $B \subseteq A$
Se $B \subseteq A$, então todos os elementos de $B$ estão em $A$. Por consequência, a interseção deles é exatamente o menor conjunto:
$$A \cap B = B$$

Pelo resultado anterior:
$$|A - B| = |A| - |A \cap B|$$
$$|A - B| = |A| - |B| \quad \blacksquare$$

---

## Combinando os Princípios

Em problemas do mundo real, os dois princípios normalmente aparecem de forma combinada.

**Exemplo:**
Se uma mulher tem $7$ blusas, $5$ saias e $9$ vestidos, de quantas maneiras diferentes ela pode se vestir? (Supondo que tudo combina).

A pessoa poderá se vestir com **um vestido** OU com **uma combinação de blusa e saia**.
- **Princípio Aditivo:** Número de opções = Nro de vestidos + Nro de combinações [blusa e saia].
- **Princípio Multiplicativo:** Para a combinação [blusa e saia], há uma sequência de escolhas — escolha da blusa E escolha da saia. Portanto, Nro de combinações = Nro de blusas $\cdot$ Nro de saias.

Cálculo final:
$$\text{Opções} = 9 + (7 \cdot 5) = 9 + 35 = 44$$

Portanto, ela possui $44$ maneiras diferentes de se vestir.
