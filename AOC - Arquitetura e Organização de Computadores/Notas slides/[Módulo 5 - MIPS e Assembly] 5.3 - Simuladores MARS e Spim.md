# Módulo 5 - MIPS e Assembly
## 5.3 - Simuladores MARS e Spim

### Simuladores MARS e SPIM
![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.3%20-%20Simuladores%20MARS%20e%20Spim/slide_1_img_1.png)

Os simuladores MARS e SPIM são simuladores gratuitos e de código aberto para a arquitetura MIPS. O MARS utiliza a licença MIT, enquanto o SPIM utiliza a licença BSD.

**MARS (MIPS Assembler and Runtime Simulator)**
Desenvolvido por Pete Sanderson e Kenneth Vollmar. O programa consiste em um arquivo JAR (`java -jar Mars4_5.jar`), portanto, é necessário ter o Java instalado para executá-lo.
O download pode ser feito em: `courses.missouristate.edu/kenvollmar/mars/license.htm`

**SPIM (QtSpim)**
O nome SPIM é o inverso de "MIPS". Foi desenvolvido por James Larus e pode ser baixado em `http://spimsimulator.sourceforge.net/`.
Diferente de algumas outras ferramentas, o SPIM não é um editor ou IDE completo. A execução de um programa no SPIM deve iniciar no rótulo `main`. Além disso, para encerrar a execução, o programa deve enviar o código `10` para a instrução `syscall` ou retornar utilizando a instrução `jr $ra`.

### Interfaces dos Simuladores

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.3%20-%20Simuladores%20MARS%20e%20Spim/slide_2_img_1.png)
*(Interface do Simulador MARS)*

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.3%20-%20Simuladores%20MARS%20e%20Spim/slide_2_img_2.png)
*(Interface do Simulador SPIM - QtSpim)*

### Programas em Assembly
Programas escritos em Assembly MIPS costumam ser salvos com as extensões `.s`, `.as` ou `.asm`. Ao utilizar o plugin do SPIM no Moodle, é recomendado usar a extensão `.s`.

A indentação é utilizada para organizar o código, geralmente com apenas um nível de indentação:
- **Sem indentação**: Utilizado para definições de rótulos (labels) e importações.
- **Um nível de indentação**: Utilizado para todos os comandos e instruções.
- **Comentários**: O caractere `#` é utilizado para inserir comentários. É altamente recomendado comentar bem os programas.

### Exemplo de Programa: Cálculo de Fatorial

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.3%20-%20Simuladores%20MARS%20e%20Spim/slide_3_img_2.png)

Abaixo temos um exemplo de um programa que calcula $9!$ e armazena o resultado no registrador `$s0`:

```mips
.text
.globl main
main:
    li $s1, 9           # atribuição/carrega: $s1 = 9
    li $s0, 1           # $s0 = 1

while:
    mul $s0, $s0, $s1   # $s0 = $s0 * $s1 (32 bits baixos)
    subi $s1, $s1, 1    # $s1 = $s1 - 1
    bnez $s1, while     # se $s1 != 0 então vá para while

end:
    li $v0, 10          # Código para encerrar o programa
    syscall             # encerra o programa
```

### Usando o MARS
Para usar o MARS, primeiro você deve **montar** o seu programa. Durante a montagem, o simulador traduz pseudoinstruções (como a instrução `li` no exemplo anterior) para instruções reais do MIPS.
Após a montagem, você pode **executar** o programa. A execução pode ser feita de duas formas:
- Executando todo o programa de uma vez.
- Executando passo a passo (instrução por instrução), o que é útil para depuração.

**Dicas para o MARS:**
- Verifique o formato em que os valores estão sendo exibidos nos registradores (ex: decimal, hexadecimal).
- Você pode zerar os registradores na interface gráfica, o que é necessário para executar o programa novamente a partir de um estado limpo (para zerar o PC).
- O MARS segue uma implementação específica do MIPS, então alguns detalhes podem ser diferentes dos apresentados no livro texto de Patterson e Hennessy (2014).
- Existem diferenças de funcionamento entre o MARS e o SPIM.

### Entrada e Saída
As operações de entrada e saída são feitas com a ajuda do Sistema Operacional (S.O.). O MARS e o SPIM incluem um S.O. minimalista para permitir simulações.

Para interagir com este sistema operacional, usamos a instrução `syscall`.
O processo funciona da seguinte forma:
1. Colocamos o código correspondente à operação desejada no registrador `$v0`.
2. A instrução `syscall` devolve o controle ao S.O., que verifica o valor em `$v0` e realiza a ação requisitada (como ler um inteiro, imprimir uma string, encerrar o programa, etc.).

*(Nota: Consulte os códigos de `syscall` disponíveis no material da disciplina).*

### Exercícios Práticos
1. Modifique o exemplo de cálculo de fatorial para que seja calculado $n!$, onde $n$ é lido da entrada padrão e o resultado é impresso em uma linha na saída padrão. Além disso, utilize a instrução `mult` no lugar de `mul`. *Como a instrução `mult` funciona? Por que o resultado é armazenado em dois registradores?* Nesse caso, pode imprimir apenas a parte baixa do resultado na tela para facilitar.
2. Faça um programa que leia continuamente valores inteiros da entrada padrão. O programa termina quando ler o valor `-1`. Ao final, o programa deve imprimir uma linha na saída padrão com a soma e outra linha com a média dos valores digitados.
3. Modifique o programa do exercício anterior para que ele termine quando o usuário digitar `-1`, **ou** quando a soma atingir um valor maior ou igual a `2048`.
4. Faça um programa que calcula o enésimo número da sequência de Fibonacci e exibe o resultado na saída padrão. O índice do número de Fibonacci deve ser lido da entrada padrão.
5. Crie um programa para um caixa eletrônico que calcula o menor número possível de cédulas que deve ser entregue a um usuário quando ele fizer um saque. Considere que a entrada do programa é o valor do saque, e a saída são as notas que o usuário receberá. Exiba as quantidades de notas como inteiros simples na tela, na seguinte ordem: notas de 50, 20, 10 e 5 reais, e moedas de 1 real. Utilize a entrada e saída padrão.
   - *Exemplo se o usuário solicitar um saque de 87 reais:* `1 1 1 1 2`
   - *Dica para imprimir um espaço:*
     ```mips
     li $a0, 32   # 32 é o código ASCII do espaço
     li $v0, 11   # código 11 em $v0 para S.O escrever $a0 na tela como char
     syscall      # chama o S.O. para escrever
     ```
6. Faça um programa que solicita repetidos valores inteiros ao usuário (pela entrada padrão), e imprime na saída padrão se o valor é par ou ímpar (pesquise sobre como funciona a instrução `div` no MIPS). O programa termina quando o usuário digita 0.
7. Faça um programa que leia da entrada padrão a idade do usuário em dias, e a exiba em anos, meses e dias no formato `anos/meses/dias` na saída padrão.
8. Escreva um programa que exibe as tabuadas do 2 até a do 10 na saída padrão.
9. Escreva um programa para ler da entrada padrão as coordenadas (x,y) de um ponto no plano cartesiano e escreve na saída padrão o quadrante ao qual o ponto pertence. Caso o ponto não pertença a nenhum quadrante, escrever se ele está sobre o eixo X, eixo Y, ou na origem.

### Diretivas do Montador

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.3%20-%20Simuladores%20MARS%20e%20Spim/slide_5_img_1.png)

As diretivas de montador começam com um ponto (`.`). Elas não geram instruções de máquina reais, mas servem para dizer ao montador o que fazer.
As diretivas ficam no mesmo nível de indentação das instruções (um nível de indentação).

**Exemplo:** `.globl main`
Informa que o rótulo `main` é visível globalmente. Isso significa que qualquer um que incluir o arquivo assembly será capaz de saber o endereço de `main`.

### Imprimindo Strings
Seria muito trabalhoso para o programador (e custoso para a CPU) imprimir os caracteres de uma string um a um (instrução por instrução). O montador nos ajuda com isso.

Escrevemos a string normalmente em uma seção de dados (usando a diretiva `.data`). O montador traduz cada caractere para o seu código específico, e coloca tudo na região de memória reservada para constantes do programa.
Ao usar a diretiva `.asciiz`, a string é terminada automaticamente com o caractere nulo `'\0'` pelo próprio montador.

**Exemplo de Código:**

```mips
.data
texto:
    .asciiz "Ola Mundo xyz\n"

.text
.globl main
main:
    la $a0, texto
    li $v0, 4     # código syscall para imprimir string
    syscall

end:
    li $v0, 10    # código syscall para encerrar o programa
    syscall
```

### Referências
- D. Patterson; J. Hennessy. *Organização e Projeto de Computadores: Interface Hardware/Software*. 5ª Edição. Elsevier Brasil, 2017.
- Andrew S. Tanenbaum. *Organização estruturada de computadores*. 5ª ed. São Paulo: Pearson, 2007.
- Harris, D. and Harris, S. *Digital Design and Computer Architecture*. 2ª ed. 2012.
- `courses.missouristate.edu/KenVollmar/mars/`
