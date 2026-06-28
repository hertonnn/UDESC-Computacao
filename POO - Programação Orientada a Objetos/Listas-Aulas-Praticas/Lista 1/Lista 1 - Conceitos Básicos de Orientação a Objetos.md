# Lista 1 - Conceitos Básicos de POO

## Exercício 1

Escolha um dos temas listados abaixo e implemente em Java cinco classes referentes a ele, cada uma contendo ao menos três atributos que as represente adequadamente, além de seus métodos `getters` e `setters`, `equals()`, `toString()`, e, ao menos, dois construtores.

- Tema 1: Sistema de aluguel de veículos
- Tema 2: Sistema de gerenciamento de bibliotecas
- Tema 3: Sistema de vendas de cursos online
- Tema 4: Sistema de supermercados
- Tema 5: Sistema de plataforma de filmes e séries
- Tema 6: Sistema de hotelaria

## Exercício 2

Para cada uma das 5 classes implementadas no exercício anterior, instancie pelo menos dois objetos utilizando diferentes construtores e seus `setters` e `getters` para modificar os valores de seus atributos e apresentá-los no console.

## Exercício 3

Implemente em Java uma classe para representar imóveis a serem vendidos e uma segunda classe para representar uma imobiliária. Cada imóvel possui uma largura, comprimento e um preço, além de um método para calcular a área total do imóvel em m² e um método `toString()`.

Já a imobiliária possui um nome e um array de imóveis a serem vendidos, além de um método para adicionar imóveis a esse array. A classe `Imobiliaria` deve possuir um método `toString()` que listará todos os imóveis existentes e um método para filtrar os imóveis que possuam área maior ou igual a um valor `x` passado como parâmetro. Tal método deve retornar os imóveis ordenados por preço conforme a assinatura:

```
Área = comprimento * largura        (1)
Imovel[] filtrarPorArea(float x);   (2)
```

## Exercício 4

Crie uma classe `Pessoa` contendo um nome e quaisquer outros atributos que desejar. Implemente uma classe `Sorteador` que contém um número `n` de pessoas (esse `n` pode ser fixo). A classe `Sorteador` deve conter um método `sortearProximo()` responsável por retornar uma `Pessoa` aleatória, removendo-a da classe `Sorteador` e retornando a pessoa sorteada conforme a assinatura:

```java
Pessoa sortearProximo();
```

## Exercício 5

Utilizando Python, implemente os itens a seguir:

**a)** Defina outras duas classes do seu tema do Exercício 1 contendo três atributos que as represente adequadamente, crie o método `__str__()` para a classe em questão.

**b)** Instancie pelo menos dois objetos dessa classe, atribua valores a seus campos e exiba o objeto no console.
