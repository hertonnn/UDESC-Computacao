# Interface em Java — Exercícios

---

## Exemplo

A partir do Diagrama de Classes UML que será apresentado a seguir, implemente duas classes que realizam as operações de soma e subtração de números inteiros e números complexos.

*(Diagrama UML disponível nos slides originais)*

### Descrição

- Não é necessário implementar um sistema em três camadas, apenas crie uma classe contendo um método `main()` que gere números aleatórios e apresente a soma deles;
- A classe `Complexo` possui dois construtores:
  - O primeiro não pede nenhum parâmetro — ele gera dois inteiros aleatórios para representar as partes real e imaginária de um número complexo;
  - O segundo pede como parâmetro a parte real e imaginária, e as seta nos atributos da classe;
- Exemplo: `(2 + 3i)`
  - O `2` representa a parte real;
  - O `3` representa a parte imaginária;
- A interface `IOperacoesBasicas` utiliza um tipo genérico `T`, definido dentro das classes que a realizam.

---

## Resolução

### Interface `IOperacoesBasicas`

A interface será de um tipo genérico `T` e possuirá dois métodos:

- `T soma(T operador1, T operador2);`
- `T subtracao(T operador1, T operador2);`

```java
package dados;

public interface IOperacoesBasicas<T> {
    public T soma(T operador1, T operador2);
    public T subtracao(T operador1, T operador2);
}
```

### Classe `CalculadoraInteiros`

Agora iremos implementar a primeira realização da interface — a classe que realiza a soma e subtração de números inteiros. Utilizaremos o Wrapper `Integer` para substituir nosso tipo genérico `T`. Para realizar uma interface utilizamos a palavra reservada `implements` antes do nome da classe.

```java
package dados;

public class CalculadoraInteiros implements IOperacoesBasicas<Integer> {

    @Override
    public Integer soma(Integer operador1, Integer operador2) {
        return operador1 + operador2;
    }

    @Override
    public Integer subtracao(Integer operador1, Integer operador2) {
        return operador1 - operador2;
    }
}
```

### Classe `Complexo`

Antes de implementarmos a próxima realização da interface, precisamos criar a classe `Complexo`, para representar os números complexos. Todo número complexo possui uma parte real e uma parte imaginária que serão definidos como atributos da classe.

```java
package dados;

import java.util.Random;

public class Complexo {
    private int real;
    private int imaginaria;

    public Complexo(int real, int imaginaria) {
        this.real = real;
        this.imaginaria = imaginaria;
    }

    public Complexo() {
        Random r = new Random();
        real = r.nextInt(100);
        imaginaria = r.nextInt(100);
    }

    public int getReal() {
        return this.real;
    }

    public int getImaginaria() {
        return this.imaginaria;
    }

    public String toString() {
        return "(" + real + " + " + imaginaria + "i" + ")";
    }
}
```

### Classe `CalculadoraComplexos`

Seguindo a mesma lógica da calculadora de inteiros, iremos apenas substituir o tipo genérico `T` para a classe `Complexo` e alterar o retorno dos métodos.

As operações de soma e subtração de números complexos:

- Z1 = a + bi
- Z2 = c + di
- **Z1 + Z2** = (a + c) + (b + d)i
- **Z1 − Z2** = (a − c) + (b − d)i

Construiremos o número que será retornado diretamente na declaração do retorno do método, já realizando a operação ao mesmo tempo no construtor, utilizando os getters dos objetos recebidos.

```java
package dados;

public class CalculadoraComplexos implements IOperacoesBasicas<Complexo> {

    @Override
    public Complexo soma(Complexo operador1, Complexo operador2) {
        return new Complexo(operador1.getReal() + operador2.getReal(),
                operador1.getImaginaria() + operador2.getImaginaria());
    }

    @Override
    public Complexo subtracao(Complexo operador1, Complexo operador2) {
        return new Complexo(operador1.getReal() - operador2.getReal(),
                operador1.getImaginaria() - operador2.getImaginaria());
    }
}
```

> Os códigos-fonte do exemplo estão disponíveis no link fornecido nos slides, com um método `main()` para a utilização das classes.

---

## Exercício

Continuando o exercício da **Aula Prática 6: Classes Abstratas**, implemente o Diagrama de Classes UML a seguir.

> Não é necessário implementar uma classe para realizar a interface via console com o usuário e nem uma classe que administre as funcionalidades do diagrama.

*(Diagrama UML disponível nos slides originais)*

### Descrição

Agora a classe abstrata `Gerador` deve realizar a interface `ISequencia`. Portanto, ela precisa implementar todos os métodos definidos na interface.

### Métodos a Implementar

- **`sortear()`** — retorna um termo da sequência selecionado aleatoriamente.
- **`somatorio()`** — retorna o somatório dos termos presentes na sequência.
- **`mediaAritmetica()`** — retorna a média aritmética dos termos presentes na sequência, sendo calculada somando todos os termos da sequência, divididos pela quantidade de termos.
- **`mediaGeometrica()`** — retorna a média geométrica dos termos. Ela é calculada pela raiz *n* (quantidade de termos) do produtório dos mesmos.
- **`variancia()`** — retorna o valor de s², calculado pela fórmula:
  - *Xi* representa o i-ésimo termo da sequência
  - *X̄* representa a média aritmética
  - *n* a quantidade de termos
  - s² = Σ(Xi − X̄)² / n
- **`desvioPadrao()`** — retorna o valor calculado pela √s² (s² é o cálculo da variância).
- **`amplitude()`** — retorna a diferença entre o maior e o menor número da sequência.

### Tarefa Final

Instancie as **7 especializações** da classe `Gerador` e para cada objeto, gere sequências contendo **10 números**. Utilize os métodos implementados da interface `ISequencia` e determine, para as sequências de 10 números, qual delas possui maior:

1. Somatório
2. Média Aritmética
3. Média Geométrica
4. Variância
5. Desvio Padrão
6. Amplitude
