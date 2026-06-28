# Introdução a UML

## Diagrama de Classes
* Modela a visão estrutural do projeto de um sistema de forma estática;
* Representa as classes, interfaces e a forma como eles se relacionam;
* Importantes para a documentação e visualização;

## Pacotes
* Modularizam um sistema;
* Separam as partes de um sistema;
* Facilitam a organização;
* Um dos principais princípios da orientação a objeto, pois aumenta a reutilização de código;
* Por convenção, nomes de pacotes começam com letra minúscula;
* Pacotes abrigam classes, interfaces, relacionamentos, e vários outros componentes;

```java
package nomePacote;
```
* Normalmente IDE's como Eclipse e Netbeans declaram os pacotes automaticamente;

## Classes
* Unidade mais importante da orientação a objetos;
* Representada por um retângulo;
* Contém:
  * Nome: Por convenção, as classes iniciam com letra maiúscula;
  * Atributos: representam os atributos das classes:
    * UML: `- nome : String`
    * Java: `private String nome`
  * Métodos: representam as funcionalidades que a classe possui:
    * UML: `+ soma(a:int,b:int):int`
    * Java: `int soma(int a , int b)`

## Classes Abstratas
* Classes que não podem ser instanciadas;
* Tema de aulas futuras;
* No diagrama de classe UML são classes que possuem o nome em itálico;

## Encapsulamento
* Conceito importante em orientação a objeto;
* Java é uma das linguagens que implementa encapsulamento;
* UML possui 4 formas:
  * `-` (private): membros da própria classe
  * `+` (public): qualquer um
  * `#` (protected): membros da própria classe e classes filhas (herança)
  * `~` (package): membros do mesmo pacote

## Generalização
* Representa um relacionamento de herança;
* Em Java é associada a palavra `extends`;
* Na UML é representado por uma seta pintada de branco;
* As setas partem das classes filhas em direção a classe Pai;
* É possível haver vários níveis de herança (mas isso será abordado na aula de Herança);

Veja o código-fonte em Java das classes representadas no diagrama:

```java
public class Produto {
    private String nome;
    private float valor;

    public String getNome() {
        return this.nome;
    }

    public float getValor() {
        return this.valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
}
```

```java
class Comida extends Produto {
    private float peso;

    public void setPeso(float peso) {
        this.peso = peso;
    }

    public float getPeso() {
        return this.peso;
    }
}
```

```java
class Bebida extends Produto {
    private float volume;

    public void setVolume(float volume) {
        this.volume = volume;
    }

    public float getVolume() {
        return this.volume;
    }
}
```

## Associação
* Especifica um relacionamento entre entidades;
* Podendo determinar quantidade (cardinalidade);
* E até atribuir semântica/significado (função);
* Sendo esses relacionamentos com navegação ou não;

### Associação - Função
* Especifica o significado do relacionamento;
* Não obrigatório;
* Porém, deixa o diagrama mais rico;
* Pois atribui o significado da relação entre essas classes;
* No diagrama foram omitidos os métodos getters e setters, pois são inerentes a programação orientada a objetos em Java;
* Uma Pessoa terá uma Cidade;
* Uma Cidade terá habitantes;

```java
public class Pessoa {
    private String nome;
    private Cidade cidade;
}
```

```java
public class Cidade {
    private String nome;
    private Pessoa[] habitantes;
}
```

* Observe que a classe Pessoa é um atributo da classe Cidade assim como o inverso;
* Os relacionamentos de associação são caracterizados pelos atributos das classes;
* Novamente, como o objetivo desse exemplo é exemplificar a semântica, os métodos getters e setters não estão presentes no código e nem no diagrama, mas são inerentes a linguagem Java.

## Multiplicidade
* Representa de objetos que irão se relacionar;
* Utilizando as seguintes notações a quantidade:
  * `0..1`: nenhuma ou uma;
  * `0..*`: nenhuma ou muitas;
  * `1`: apenas uma;
  * `1..*`: uma ou muitas;
  * `*`: muitas (indeterminado);
  * `n`: muitas (determinado);
* A cardinalidade/multiplicidade em Java é representada na quantidade de instâncias do objeto que a classe pode ter;

```java
public class Pessoa {
    private List<Carro> carros;
}
```

* Note que a classe Pessoa possui uma lista de Carros como atributo, permitindo 0 ou mais Carros;

```java
public class Carro {
    private Pessoa dono;
    private Roda[] rodas = new Roda[4];
}
```

* Já a Classe Carro pode ter um e somente um dono, e 4 rodas;

```java
public class Roda {
    private Carro carro;
}
```

* Entretanto a classe Roda possui apenas um Carro (não tem como uma roda pertencer a dois carros);

## Navegação
* Observe que até o momento os relacionamentos de associação apresentados não possuíam setas;
* Entretanto é comum o uso das setas em relacionamentos;
* Pois elas determinam que apenas uma classe possui outra;
* A classe do qual a seta parte, possui um atributo da classe que a seta aponta;

```java
public class Pessoa {
    private List<Idioma> idiomas;
}
```

```java
public class Idioma {
    private char[] alfabeto;
}
```

* Observe que uma pessoa possui vários idiomas, mas um idioma não possui uma pessoa;
* É como se o idioma não soubesse da existência da pessoa;

## Agregação
* O relacionamento de agregação é uma associação;
* Porém, com um significado mais forte;
* É um relacionamento do tipo parte/todo;
* Onde o todo é constituído das partes.
* É representado por um losango branco;
* Observe que uma Rua é constítuida de Casas;

```java
public class Rua {
    private List<Casa> casas;
}
```

```java
public class Casa {
    private int numero;
}
```

* Note também que é exatamente igual a um relacionamento de associação;
* Porém representa parte/todo.

## Composição
* Assim como a Agregação é uma Associação, a Composição é uma Agregação;
* Logo, ela também é um relacionamento de parte/todo;
* Entretanto, um objeto não existe sem o outro.
* É representado pelo losango preto;
* E quando a parte é destruída, o todo também é;
* Linguagens que lidam com alocação de memória tratam esse relacionamento melhor;
* Em Java não é necessário se preocupar com isso, porém linguagens como C++, quando a parte ou o todo é destrúido, a contra-parte também é;
* Note que uma pessoa não existe sem o seu coração;

```java
public class Pessoa {
    private Coracao coracao;

    public Pessoa(Coracao coracao) {
        this.coracao = coracao;
    }
}
```

* Então, quando uma pessoa é "construída" ela "vem" com o seu coração;

```java
public class Coracao {
    public void bater() {
        System.out.println("Contraindo");
        System.out.println("Retraindo");
    }
}
```

## Dependência
* Quando uma entidade usa informações e serviços de outra entidade;
* Mas não necessariamente o inverso;
* Comum na utilização de pacotes;
* Esse relacionamento existe pois a classe Main usa pelo menos alguma classe do pacote dados, no caso, instancia objetos do tipo Pessoa para realizar o cadastro no pacote de negocio;

```java
package dados;

public class Pessoa {
    private String nome;
    private int idade;

    public Pessoa(String nome, int idade) {
        this.nome = nome;
        this.idade = idade;
    }

    public String toString() {
        return "Nome: " + this.nome + "\nIdade: " + this.idade;
    }
}
```

* Observe que a classe Pessoa pertence ao package dados;
* E que a classe Sistema (que pertence ao package negócio), possui instancias de classes do pacote de dados (relacionamento de associação).

```java
package negocio;

import java.util.LinkedList;
import dados.Pessoa;

public class Sistema {
    private LinkedList<Pessoa> pessoas = new LinkedList<Pessoa>();

    public void cadastrarPessoa(Pessoa p) {
        this.pessoas.add(p);
    }

    public LinkedList<Pessoa> mostrarPessoas() {
        return this.pessoas;
    }
}
```

* Já a classe Main, utiliza a classe Pessoa para enviar dados ao package sistema;
* Além de utilizar o método `toString()` da classe Pessoa;
* É esse uso que caracteriza a dependência entre a classe Pessoa e a classe Main.

```java
package apresentacao;

import java.util.Scanner;
import java.util.LinkedList;
import dados.Pessoa;
import negocio.Sistema;

public class Main {
    private static Sistema sistema = new Sistema();
    private static Scanner s = new Scanner(System.in);

    public static void main(String[] args) {
        int opcao = -1;
        while (opcao != 0) {
            System.out.println("Escolha uma opcao:");
            System.out.println("0 - Sair");
            System.out.println("1 - Cadastrar Pessoa");
            System.out.println("2 - Exibir Pessoas");
            opcao = s.nextInt();
            
            switch (opcao) {
                case 0:
                    break;
                case 1:
                    sistema.cadastrarPessoa(novaPessoa());
                    break;
                case 2:
                    exibirPessoas();
                    break;
                default:
                    System.out.println("Valor incorreto!");
                    break;
            }
        }
    }

    public static Pessoa novaPessoa() {
        System.out.println("Digite o nome da pessoa");
        String nome = s.nextLine();
        nome = s.nextLine();
        System.out.println("Digite a idade da pessoa");
        int idade = s.nextInt();
        return new Pessoa(nome, idade);
    }

    public static void exibirPessoas() {
        for (Pessoa pessoa : sistema.mostrarPessoas()) {
            System.out.println(pessoa.toString());
        }
    }
}
```

## Realização
* Relacionamento entre uma interface e uma classe;
* Uma classe implementa uma interface;
* Representado por uma seta tracejada pintada de branco;
* Por convenção, interfaces começam com nome minúsculo;

```java
public interface acelerar {
    public void acelera();
}
```

* Em Java, para uma classe implementar uma interface, ela precisa utilizar a palavra reservada `implements` após o nome da classe;
* Uma classe que implementa uma interface, precisa obrigatóriamente implementar todos os métodos da interface;

```java
public class Carro implements acelerar {
    private float velocidade;

    public void acelera() {
        velocidade += 10;
    }
}
```

```java
public class Aviao implements acelerar {
    private float velocidade;

    public void acelera() {
        velocidade += 50;
    }
}
```
