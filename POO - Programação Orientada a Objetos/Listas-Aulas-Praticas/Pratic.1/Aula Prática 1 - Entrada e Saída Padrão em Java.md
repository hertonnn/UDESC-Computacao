# Entrada e Saída Padrão em Java — Exercícios

---

## Exercícios

1. Escreva um programa em Java, que leia **5 valores** do console e apresente a **média** desses 5 valores. É obrigatório o uso de array.

2. Escreva um programa em Java, que leia o **nome** e a **idade** de 5 pessoas e exiba-os em **ordem decrescente** no console. É obrigatório o uso de array.

---

## Resolução — Exercício 1

> Escreva um programa em Java, que leia 5 valores do console e logo em seguida apresente a média desses 5 valores.

- Utilizaremos a classe `Scanner` para fazer a entrada de dados, logo precisamos importá-la:

```java
import java.util.Scanner;
```

- Precisaremos então criar um método `main`:

```java
public static void main(String[] args) {
```

- Iremos então instanciar um objeto da classe `Scanner`, chamado `leitor`:

```java
Scanner leitor = new Scanner(System.in);
```

- Precisaremos de um vetor de inteiros para armazenar os cinco valores e uma outra variável do tipo `float` para calcular a média:

```java
int[] valores = new int[5];
float media = 0;
```

- Precisaremos de um laço de repetição para percorrer o vetor e ler os valores:

```java
for (int i = 0; i < 5; i++) {
    valores[i] = leitor.nextInt();
    media += valores[i];
}
```

> Note que a cada iteração do laço `for`, o valor da média foi incrementado.

- Agora basta exibir na tela o valor da variável média dividido pelo número de iterações do laço:

```java
System.out.println("Media = " + media / 5);
```

---

## Resolução — Exercício 2

> Escreva um programa em Java, que leia o nome e a idade de 3 pessoas e exiba-os no console. É obrigatório o uso de array.
