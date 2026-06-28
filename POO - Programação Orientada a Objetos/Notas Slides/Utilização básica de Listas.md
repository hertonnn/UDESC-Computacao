# Utilização Básica de Listas em Java

## O que são?
• Listas são estruturas de dados prontas para utilização;
• Possuem uma interface que facilita a utilização para as operações de:
• Adição;
• Remoção;
• Busca;
• Dentre outras...

## Utilizando
• Iremos utilizar uma LinkedList de Strings nesse exemplo;
• Para utiliza-la iremos importar a biblioteca de List e LinkedList;
```java
import java.util.LinkedList;
import java.util.List;
```

## Declaração
• Iremos então declarar um objeto chamado lista do tipo LinkedList:
• A declaração de um objeto do tipo LinkedList se dá da seguinte maneira:
• `List<Tipo> nome = new LinkedList<Tipo>();`
• Note que o tipo do objeto é colocado entre o simbolo de menor igual `<>`;
• Em nosso exemplo, o tipo String:
```java
List<String> lista = new LinkedList<String>();
```

## Adicionando itens
• Para adicionar um item a lista, utilizaremos o método add();
• Esse método possui duas variações:
• `add(index,objeto)`: no qual adiciona um objeto na posição x da lista.
• `add(objeto)`: no qual adiciona um objeto ao final da lista.

### Adicionando itens - Exemplo
• Adicionando o objeto "Casa":
```java
lista.add("Casa");
```
• Adicionando o objeto "Mesa":
```java
lista.add("Mesa");
```
• Adicionando o objeto "Carro" na posição 0:
```java
lista.add(0, "Carro");
```
• Adicionando o objeto "Avião":
```java
lista.add("Avião");
```
• Adicionando o objeto "Barco":
```java
lista.add("Barco");
```

## Percorrendo a List
• Para percorrer a lista, utilizaremos um for each, que como o nome já diz, percorre a lista;
• Note que a variável s é um auxiliar que a cada iteração recebe um objeto da lista;
```java
System.out.println();
for (String s : lista) {
    System.out.println(s);
}
```

### Percorrendo a List - Saída
• O trecho de código gera a seguinte saída:
```text
Carro
Casa
Mesa
Avião
Barco
```

### Percorrendo a List - Através do índice
• É possivel percorrer a lista do jeito tradicional;
• Utilizando uma variável i que acessa cada posição da lista;
• Utilizaremos o método size() da List que nos retorna o número de objetos;
• Para determinar a condição de parada do for;
```java
for (int i = 0; i < lista.size(); i++) {
    System.out.println(lista.get(i));
}
```
• As duas maneiras geram a mesma saída:
```text
Carro
Casa
Mesa
Avião
Barco
```

## Removendo itens
• Assim como o método de adição, o método de remoção possui duas variações:
• `remove(index)`: remove o objeto na posição informada como parâmetro;
• `remove(objeto)`: remove o objeto que foi passado;

### Removendo itens - Pelo index
• Observe o exemplo da remoção de um objeto na primeira posição;
• No caso o objeto "Casa":
```java
lista.remove(1);
```
• Resultado da lista após a remoção: (Casa removida)

### Removendo itens - Pelo objeto
• Agora vamos remover o objeto "Barco":
```java
lista.remove("Barco");
```
• Resultado da lista após a remoção: (Barco removido)
