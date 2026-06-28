# Aula Prática 4 - Implementação de Herança em Java

## Exemplo

O diagrama de classes a seguir representa um sistema bancário, onde existem contas bancárias de dois tipos: correntes e salário.

> *(Diagrama de Classes UML presente no slide 4 do PDF)*

### Descrição do Sistema

- A classe `ContaBancaria` possui dois métodos: `sacar()` e `gerarExtrato()`.
  - `sacar()` recebe um valor e subtrai do saldo.
  - `gerarExtrato()` retorna uma String contendo o estado atual da conta (o saldo).
- As extensões dessa classe (`ContaCorrente` e `ContaSalario`) possuem métodos para realizar o depósito:
  - Na `ContaCorrente`, basta passar o valor como parâmetro para realizar o depósito no método `depositar()`.
  - Na `ContaSalario` é necessário passar o valor e o CNPJ da empresa que está realizando o depósito.
- A classe `ContaSalario` também reescreve o método `gerarExtrato()`, adicionando o CNPJ da empresa.

### Classe Sistema

A classe `Sistema` possui os seguintes métodos:

- `cadastrarConta()`: recebe uma `ContaBancaria` (seja ela do tipo corrente ou salário) e adiciona ao array do tipo `ContaBancaria`.
- `realizarSaque()`: dado uma conta e um valor, retira esse valor da conta utilizando o próprio método da conta.
- Dois métodos para realizar depósitos específicos para cada tipo de conta bancária.
- Métodos que retornam as contas bancárias do sistema:
  - `getContas()`: retorna todas as contas do array.
  - `getContasCorrentes()` e `getContasSalario()`: realiza um filtro no array e retorna apenas o tipo de conta especificada no nome do método.

Também será criada uma classe `Main` para realizar a interface via console com o usuário.

---

## Resolução

### Pacote Dados

Primeiro vamos criar as classes pertencentes ao pacote de dados: `ContaBancaria` (superclasse), `ContaCorrente` e `ContaSalario`.

#### Classe ContaBancaria

Ela pertence ao pacote de dados. Possui dois atributos:
- `cpf`: do tipo inteiro e **private** (só a própria superclasse pode acessar).
- `saldo`: do tipo float e **protected** (qualquer classe que a estender poderá acessar).

> Os métodos getters e setters não serão apresentados aqui.

```java
package dados;

public class ContaBancaria {
    private int cpf;
    protected float saldo;

    public ContaBancaria() {
        this.saldo = 0;
    }
}
```

O método `sacar()` recebe um valor e subtrai do saldo:

```java
public float sacar(float valor) {
    saldo -= valor;
    return valor;
}
```

O método `gerarExtrato()` retorna o saldo:

```java
public String gerarExtrato() {
    return "Saldo disponível: R$" + this.saldo;
}
```

O método `toString()` retorna o CPF da conta:

```java
public String toString() {
    return "CPF: " + this.cpf;
}
```

#### Classe ContaCorrente

Também pertencente ao pacote `dados`, ela não possui nenhum atributo além dos atributos da sua superclasse. Para estender uma superclasse é necessário utilizar a palavra reservada `extends`. No construtor é necessário invocar o método `super()` — esse método deve ser sempre o primeiro a ser invocado dentro do construtor de classes estendidas!

```java
package dados;

public class ContaCorrente extends ContaBancaria {
    public ContaCorrente() {
        super();
    }
}
```

O método `depositar()` recebe um valor e soma ao atributo saldo, retornando `true` para confirmar que a operação foi realizada com sucesso:

```java
public boolean depositar(float valor) {
    this.saldo += valor;
    return true;
}
```

O método `gerarExtrato()` é sobrescrito para exibir o tipo de conta, utilizando o método da superclasse:

```java
public String gerarExtrato() {
    return "Conta Corrente:\n" + "CPF: " + this.getCpf() + "\n" + super.gerarExtrato();
}
```

A mesma coisa é realizada no método `toString()`:

```java
public String toString() {
    return "Conta Corrente:\n" + super.toString();
}
```

#### Classe ContaSalario

A classe `ContaSalario` possui um atributo `cnpjEmpresa`, que representa a empresa que pode depositar nessa conta. O construtor também precisa invocar `super()`:

```java
package dados;

public class ContaSalario extends ContaBancaria {
    private int cpnjEmpresa;

    public ContaSalario() {
        super();
    }
}
```

O método `depositar()` recebe dois parâmetros: o valor a ser depositado e o CNPJ do depositante. O valor só é acrescentado à conta caso os CNPJs forem iguais:

```java
public boolean depositar(float valor, int cpnjEmpresa) {
    if (cpnjEmpresa == this.cpnjEmpresa) {
        this.saldo += valor;
        return true;
    }
    return false;
}
```

Essa classe também sobrescreve o método `gerarExtrato()`, exibindo o CNPJ da empresa:

```java
@Override
public String gerarExtrato() {
    return "Conta Salario:\n" + "CNPJ da Empresa: " + this.cpnjEmpresa + "\n" +
        super.gerarExtrato();
}
```

E sobrescreve o método `toString()`:

```java
public String toString() {
    return "Conta Salario:\n" + super.toString() + "\n" + "CNPJ: " + this.cpnjEmpresa;
}
```

---

### Pacote Negócio

Agora iremos implementar as funcionalidades do sistema. Teremos uma classe que irá administrar tudo: a classe `Sistema`.

#### Classe Sistema

Declaração do pacote e imports:

```java
package negocio;

import dados.ContaBancaria;
import dados.ContaCorrente;
import dados.ContaSalario;
```

A classe `Sistema` terá um array de `ContaBancaria` e um atributo que controla a quantidade de contas nesse array. As instâncias das classes serão mantidas através de polimorfismo — um array da superclasse armazena tanto instâncias da superclasse como instâncias de classes filhas:

```java
public class Sistema {
    private ContaBancaria[] contaBancarias = new ContaBancaria[100];
    private int quantidade = 0;
}
```

O método `cadastrarConta()` recebe um objeto do tipo `ContaBancaria` e adiciona ao array. Como Java implementa polimorfismo, tanto faz qual é o tipo de conta enviada como parâmetro:

```java
public void cadastrarConta(ContaBancaria conta) {
    if (quantidade < 100) {
        this.contaBancarias[quantidade] = conta;
        quantidade++;
    }
}
```

O método de realizar saque retorna o extrato e recebe a conta e o valor a ser retirado:

```java
public String realizarSaque(ContaBancaria conta, float valor) {
    conta.sacar(valor);
    return this.obterExtrato(conta);
}
```

Métodos de depositar — para `ContaCorrente` precisa apenas da conta e do valor:

```java
public boolean realizarDeposito(ContaCorrente conta, float valor) {
    return conta.depositar(valor);
}
```

Para `ContaSalario` precisa do CNPJ também:

```java
public boolean realizarDeposito(ContaSalario conta, float valor, int cnpj) {
    return conta.depositar(valor, cnpj);
}
```

> Em ambos o retorno é do tipo booleano, pois os métodos de depositar das duas classes são do tipo booleano.

Método que retorna apenas instâncias de `ContaCorrente` — utiliza `instanceof` para filtrar e **casting** para converter:

```java
public ContaCorrente[] getContasCorrentes() {
    int max = 0;
    for (int i = 0; i < quantidade; i++) {
        if (contaBancarias[i] instanceof ContaCorrente) {
            max++;
        }
    }

    ContaCorrente[] contas = new ContaCorrente[max];
    int qnt = 0;
    for (int i = 0; i < quantidade; i++) {
        if (contaBancarias[i] instanceof ContaCorrente) {
            contas[qnt] = (ContaCorrente) (contaBancarias[i]);
            qnt++;
        }
    }
    return contas;
}
```

Para `getContaSalarios()` é a mesma lógica, aplicada à classe `ContaSalario`:

```java
public ContaSalario[] getContaSalarios() {
    int max = 0;
    for (int i = 0; i < quantidade; i++) {
        if (contaBancarias[i] instanceof ContaSalario) {
            max++;
        }
    }

    ContaSalario[] contas = new ContaSalario[max];
    int qnt = 0;
    for (int i = 0; i < quantidade; i++) {
        if (contaBancarias[i] instanceof ContaSalario) {
            contas[qnt] = (ContaSalario) (contaBancarias[i]);
            qnt++;
        }
    }
    return contas;
}
```

Getter para a quantidade e para o array de contas:

```java
public int getQuantidadeContas() {
    return this.quantidade;
}

public ContaBancaria[] getContaBancarias() {
    return contaBancarias;
}
```

Método para obter extratos — através de polimorfismo, cada extensão da superclasse retorna a chamada do seu próprio `gerarExtrato()`:

```java
public String obterExtrato(ContaBancaria conta) {
    return conta.gerarExtrato();
}
```

---

### Pacote Apresentação

Esse pacote fará a interface via console com o usuário, refletindo as funcionalidades expressas na classe `Sistema`.

#### Classe Principal

Declaração do pacote e imports:

```java
package apresentacao;

import java.util.Scanner;
import dados.ContaBancaria;
import dados.ContaCorrente;
import dados.ContaSalario;
import negocio.Sistema;
```

A classe `Principal` terá dois atributos estáticos:

```java
public class Principal {
    private static Sistema sistema = new Sistema();
    private static Scanner s = new Scanner(System.in);
}
```

Método para instanciar uma nova `ContaCorrente`:

```java
private static ContaCorrente novaContaCorrente() {
    ContaCorrente conta = new ContaCorrente();
    System.out.println("Digite o cpf:");
    conta.setCpf(s.nextInt());
    return conta;
}
```

Método para instanciar uma nova `ContaSalario`:

```java
private static ContaSalario novaContaSalario() {
    ContaSalario conta = new ContaSalario();
    System.out.println("Digite o cpf:");
    conta.setCpf(s.nextInt());
    System.out.println("Digite o cnpj da empresa:");
    conta.setCpnjEmpresa(s.nextInt());
    return conta;
}
```

Método para cadastrar contas — requisita ao usuário o tipo de conta desejado:

```java
private static void cadastrarConta() {
    System.out.println("Digite o tipo de conta que deseja cadastrar:");
    System.out.println("1 - Conta Corrente");
    System.out.println("2 - Conta Salario");
    int escolha = s.nextInt();
    switch (escolha) {
        case 1:
            sistema.cadastrarConta(novaContaCorrente());
            break;
        case 2:
            sistema.cadastrarConta(novaContaSalario());
            break;
        default:
            System.out.println("Escolha inválida!");
            break;
    }
}
```

Método para exibir as contas do sistema — utiliza `toString()` de cada objeto:

```java
private static void exibirContas() {
    for (int i = 0; i < sistema.getQuantidadeContas(); i++) {
        System.out.println("Conta " + i + ":\n" + sistema.getContaBancarias()[i].toString() + "\n");
    }
}
```

> Como não é feito nenhum casting nos objetos, o método `toString()` utilizado é o da superclasse `ContaBancaria`!

Método para o usuário escolher uma conta:

```java
private static ContaBancaria escolherContaBancaria() {
    exibirContas();
    System.out.println("Escolha uma conta:");
    int conta = s.nextInt();
    if (conta < sistema.getQuantidadeContas()) {
        return sistema.getContaBancarias()[conta];
    }
    return null;
}
```

Método para realizar saque:

```java
private static void realizarSaque() {
    ContaBancaria conta = escolherContaBancaria();
    if (conta != null) {
        System.out.println("Digite o valor a ser sacado:");
        int valor = s.nextInt();
        System.out.println(sistema.realizarSaque(conta, valor));
    }
}
```

Método para realizar depósito — verifica o tipo da instância com `instanceof` e faz casting:

```java
private static void realizarDeposito() {
    ContaBancaria conta = escolherContaBancaria();
    if (conta != null) {
        if (conta instanceof ContaCorrente) {
            System.out.println("Digite um valor a ser depositado:");
            int valor = s.nextInt();
            sistema.realizarDeposito((ContaCorrente) (conta), valor);
            System.out.println("Deposito realizado com sucesso!");
            System.out.println(sistema.obterExtrato((ContaCorrente) (conta)));
        } else {
            System.out.println("Digite um valor a ser depositado:");
            int valor = s.nextInt();
            System.out.println("Digite o cnpj da empresa que está depositando:");
            int cnpj = s.nextInt();
            if (sistema.realizarDeposito((ContaSalario) (conta), valor, cnpj)) {
                System.out.println("Deposito realizado com sucesso!");
                System.out.println(sistema.obterExtrato((ContaSalario) (conta)));
            } else {
                System.out.println("Falha ao depositar!");
            }
        }
    }
}
```

Método para mostrar extrato:

```java
private static void mostrarExtrato() {
    ContaBancaria conta = escolherContaBancaria();
    if (conta != null) {
        System.out.println(sistema.obterExtrato(conta));
    }
}
```

Menu e método `main()`:

```java
public static void imprimeMenu() {
    System.out.println("Escolha uma opção:");
    System.out.println("0 - Sair");
    System.out.println("1 - Cadastrar Conta");
    System.out.println("2 - Realizar Saque");
    System.out.println("3 - Realizar Deposito");
    System.out.println("4 - Exibir Extrato");
}

public static void main(String[] args) {
    int opcao = -1;
    while (opcao != 0) {
        imprimeMenu();
        opcao = s.nextInt();
        switch (opcao) {
            case 0:
                break;
            case 1:
                cadastrarConta();
                break;
            case 2:
                realizarSaque();
                break;
            case 3:
                realizarDeposito();
                break;
            case 4:
                mostrarExtrato();
                break;
        }
    }
}
```

> O código-fonte desse exemplo está disponível em `github.com/takeofriedrich/monitoriapoo` nas aulas práticas. Os métodos não estão implementados seguindo a mesma ordem dos slides!

---

## Exercício

Implemente em Java um sistema que administre um Zoológico de acordo com o Diagrama de Classes UML a seguir:

> *(Diagrama de Classes UML presente nos slides 46 e 47 do PDF)*

### Regras

- O Zoológico possui viveiros, dos quais abrigam diversos animais.
- Apenas os **aquários** podem abrigar **peixes**.
- Os **viveiros comuns** podem abrigar **animais comuns**.
- Exemplos de instâncias das classes:
  - `Animal`: Zebra
  - `Peixe`: Peixe Espada
- Os animais apenas podem ser alocados em um viveiro caso a **área disponível** no viveiro seja maior que **70% da área do animal**. Para o aquário deve ser considerado o **volume**.
- Caso já existam animais no viveiro, é necessário subtrair a área de todos os animais já presentes no viveiro para calcular o espaço disponível. Para o aquário deve ser considerado o volume.
- Os animais aquáticos possuem uma **restrição de temperatura**. Caso a temperatura do aquário esteja **3 graus maior ou menor** que a temperatura ideal do animal, ele não pode ser colocado no aquário.
- Além das classes e funcionalidades expressas no diagrama, implemente uma **interface com o usuário via console** que permita utilizar todas as funcionalidades apresentadas no pacote de negócios.
- Na interface com o usuário, ao exibir os viveiros existentes no Zoológico:
  - Caso o viveiro **não contenha nenhum animal**, o sistema deve exibir uma mensagem de **viveiro vazio**.
  - Caso contrário, devem ser exibidos os animais dentro do viveiro com suas respectivas informações: **nome, cor, espécie** e **temperatura ideal** (caso seja um peixe).
