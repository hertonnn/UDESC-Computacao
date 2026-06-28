# Aula Prática 5 - Utilização de Coleções em Java

## Exemplo

Crie uma função que armazene em um `Map` a tabuada do número 1 ao número 10 e exiba no console a tabuada do número `n` armazenada em um `List`.

---

## Resolução

### Imports

Vamos utilizar um `List` (instanciado como `ArrayList`) para armazenar os valores de 1 a 10 da tabuada de um número `n`:

```java
import java.util.List;
import java.util.ArrayList;
```

Um `Map` é um mapa que associa um objeto a uma chave única de acesso/busca. Os Maps são compostos de pares ordenados `<K, V>`, onde `K` corresponde à chave (key) e `V` corresponde ao valor (value). Aqui, será instanciado como `HashMap`:

```java
import java.util.Map;
import java.util.HashMap;
```

### Método tabuada()

Método estático que recebe um número inteiro `n` e retorna um `List<Integer>` com os valores da tabuada de 1 a 10. Coleções utilizam apenas objetos — como inteiros são tipos primitivos, utilizamos seu Wrapper `Integer`:

```java
public static List<Integer> tabuada(int n) {
    List<Integer> tabuada = new ArrayList<Integer>();
    for (int i = 1; i <= 10; i++) {
        tabuada.add(i * n);
    }
    return tabuada;
}
```

### Método main()

Dentro do `main()`, instanciamos o `HashMap`. A chave será um `Integer` e o valor será uma lista de inteiros (`List<Integer>`) contendo a tabuada da respectiva chave:

```java
public static void main(String[] args) {
    Map<Integer, List<Integer>> todasAsTabuadas = new HashMap<Integer, List<Integer>>();

    // Adiciona as tabuadas de 1 a 10 usando put(chave, valor)
    for (int i = 1; i <= 10; i++) {
        todasAsTabuadas.put(i, tabuada(i));
    }
}
```

### Exibindo com forEach()

O `Map` possui um método `forEach()` que recebe um par ordenado `(K, V)` e um trecho de código a ser executado para cada par:

```java
todasAsTabuadas.forEach(
    (chave, tabuada) -> {
        System.out.print("Tabuada de " + chave + ": ");
        for (int x : tabuada) {
            System.out.print(x + " ");
        }
        System.out.println();
    }
);
```

**Saída:**

```
Tabuada de 1: 1 2 3 4 5 6 7 8 9 10
Tabuada de 2: 2 4 6 8 10 12 14 16 18 20
Tabuada de 3: 3 6 9 12 15 18 21 24 27 30
Tabuada de 4: 4 8 12 16 20 24 28 32 36 40
Tabuada de 5: 5 10 15 20 25 30 35 40 45 50
Tabuada de 6: 6 12 18 24 30 36 42 48 54 60
Tabuada de 7: 7 14 21 28 35 42 49 56 63 70
Tabuada de 8: 8 16 24 32 40 48 56 64 72 80
Tabuada de 9: 9 18 27 36 45 54 63 72 81 90
Tabuada de 10: 10 20 30 40 50 60 70 80 90 100
```

---

## Métodos Úteis - List

| Método | Descrição |
|--------|-----------|
| `int size()` | Retorna o número de objetos na lista |
| `boolean add(T objeto)` | Adiciona um objeto ao final da lista |
| `boolean add(int posicao, T objeto)` | Adiciona um objeto em uma posição específica da lista |
| `boolean remove(T objeto)` | Remove um objeto da lista. A classe deve implementar `equals()` |
| `boolean remove(int posicao)` | Remove um objeto em uma posição específica da lista |
| `T get(int posicao)` | Retorna o objeto da posição x da lista |
| `boolean contains(T objeto)` | Retorna `true` caso o objeto esteja na lista. A classe deve implementar `equals()` |

## Métodos Úteis - Map

| Método | Descrição |
|--------|-----------|
| `int size()` | Retorna o número de objetos no map |
| `boolean containsKey(K chave)` | Retorna `true` caso a chave exista no map. A classe deve implementar `equals()` |
| `boolean remove(T objeto)` | Remove um objeto (K ou V) do map. A classe deve implementar `equals()` |
| `V get(K chave)` | Retorna o valor associado à chave K |
| `boolean put(K chave, V valor)` | Adiciona um par ordenado (K, V) no Map |

---

## Exercício

Utilizando o framework de coleções, implemente o diagrama de classes a seguir:

> *(Diagrama de Classes UML presente nos slides 21 e 22 do PDF)*

### Regras

- A classe `ListaTelefonica` deve manter uma lista de contatos telefônicos.
- O método `exibirContatos()` da classe `Main` deve exibir todos os contatos, **ordenados de acordo com a primeira letra do nome**.
- Por exemplo:

```
A:
- André: 983748574
- Ana: 97364985
B:
- Bianca: 947346543
C:
D:
- Daniel: 973648374
E:
F:
G:
H:
...
Y:
Z:
```

- Os contatos **não necessariamente** precisam ser exibidos em ordem alfabética, apenas devem estar **agrupados de acordo com a inicial** do seu primeiro nome.
- Utilize `HashMap` para indexar os contatos pela inicial.
- O método `removerContato()` da classe `Main` deve requisitar ao usuário a inicial do contato que ele deseja remover. Após o usuário entrar com ela, deve ser exibida uma lista contendo todos os contatos que possuem essa inicial. O usuário deverá então escolher um.
