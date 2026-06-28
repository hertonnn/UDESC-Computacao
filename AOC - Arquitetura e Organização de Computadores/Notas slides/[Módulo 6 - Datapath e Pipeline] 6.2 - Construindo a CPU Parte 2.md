# Construindo a CPU: Parte 2

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.2%20-%20Construindo%20a%20CPU%20Parte%202/slide_1_img_1.png)

### Revisão: Parte 1
Caminho de dados inicial para instruções do tipo-R.

### Loads e Stores
Vamos adicionar instruções para *loads* (`lw`) e *stores* (`sw`) de palavras (*words*).
- Instruções do tipo-I

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.2%20-%20Construindo%20a%20CPU%20Parte%202/slide_2_img_2.png)
![Imagem Embutida 3](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.2%20-%20Construindo%20a%20CPU%20Parte%202/slide_2_img_3.png)

```mips
lw $regDestino, deslocamento($regBase)
```
`$regDestino = MEM[$regBase + deslocamento]`

O deslocamento é um imediato, que pode ser positivo ou negativo.

```mips
sw $regFonte, deslocamento($regBase)
```
`MEM[$regBase + deslocamento] = $regFonte`

Exemplo:
```mips
lw $t0, 32($s3)
```

### Memória de Dados para Loads e Stores
Vamos precisar de uma memória para dados.

**Entradas:**
- Endereço de memória
- Dados a ser escrito
- Sinais de Controle `MemWrite` e `MemRead`: Indica se a memória deve escrever na posição, ou se deve ler o dado especificado na posição e direcioná-lo para a saída

**Saídas:**
- Dado lido pela memória

### Somando o Imediato
O campo de constante (imediato) contém 16 bits. Este será somado com o registrador para obter o endereço de memória a ser lido/escrito.
Temos um problema: estamos somando um valor de 16 bits (do imediato) com um de 32 (do registrador).
Simplesmente colocar zeros à esquerda não funciona em complemento a 2.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.2%20-%20Construindo%20a%20CPU%20Parte%202/slide_3_img_1.png)
![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.2%20-%20Construindo%20a%20CPU%20Parte%202/slide_3_img_2.png)
![Imagem Embutida 3](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.2%20-%20Construindo%20a%20CPU%20Parte%202/slide_3_img_3.png)

### Extensão de Sinal em Complemento a 2
Vamos utilizar um componente para extensão de sinal.
- Dado um sinal de 16 bits, gera o seu correspondente em 32 bits
- Leva em consideração o complemento de 2 para gerar o sinal correto

### Caminho de Dados (Datapath)
Nas imagens seguintes, observamos a inserção dos multiplexadores extras e a construção passo a passo do caminho de dados (*datapath*).

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.2%20-%20Construindo%20a%20CPU%20Parte%202/slide_4_img_1.png)
![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.2%20-%20Construindo%20a%20CPU%20Parte%202/slide_4_img_2.png)
![Imagem Embutida 3](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.2%20-%20Construindo%20a%20CPU%20Parte%202/slide_4_img_3.png)

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.2%20-%20Construindo%20a%20CPU%20Parte%202/slide_5_img_1.png)
![Imagem Embutida 3](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.2%20-%20Construindo%20a%20CPU%20Parte%202/slide_5_img_3.png)

### Desvio beq (Branch Equal)
Um desvio `beq` (*Branch Equal*) soma o valor de deslocamento (que está no campo imediato) ao `PC+4` caso os registradores `rs` e `rt` sejam iguais.
O valor de deslocamento (*offset*) está em palavras (de 4 bytes), e não em bytes.
- Devemos deslocar 2x à esquerda para multiplicar por 4, para então obtermos o deslocamento em bytes que será armazenado em PC.

Como podemos comparar `rs` com `rt`?

### Caminho de Dados: Branches

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.2%20-%20Construindo%20a%20CPU%20Parte%202/slide_6_img_1.png)

### Exercícios

**1)** Dado o caminho de dados que inclui *loads*/*stores*, adicione o caminho de dados de *branches* do slide anterior. Ligue os componentes faltantes dos circuitos.
- Deve haver um multiplexador para escolher entre `PC+4` ou `PC+4+deslocamento`
- Este multiplexador é controlado pelo sinal `PCSrc`
- O `PCSrc` é definido pelo controlador com base na saída Zero da ALU
  - Não é necessário mostrar o controlador e suas ligações neste exercício

**2)** Descreva cada um dos sinais de controle (em azul) da resposta do exercício 1.

**3)** Adicione o caminho de dados para as instruções de desvio incondicional `j` (*jumps*)
- O endereço é especificado em palavras
- Para obter o endereço em bytes, precisamos multiplicar por 4 (deslocar para a esquerda 2x)
- Teremos como resultado um valor com 28 bits
- Emprestamos os 4 primeiros bits de `PC+4`, e os demais 28 bits do endereço do *jump* (depois do deslocamento), para formar o endereço final
- Precisamos concatenar o sinal (parte do sinal vêm do `PC+4`, e parte do endereço do *jump*). Veja a notação de concatenação abaixo
- Não precisa implementar os sinais de controle (linhas em azul, pode deixar esses sinais "soltos")

### Referências
- D. Patterson; J. Henessy. Organização e Projeto de Computadores: Interface Hardware/Software. 5ª Edição. Elsevier Brasil, 2017.
- Andrew S. Tanenbaum. Organização estruturada de computadores. 5. ed. São Paulo: Pearson, 2007.
- Harris, D. and Harris, S. Digital Design and Computer Architecture. 2ª ed. 2012.
- courses.missouristate.edu/KenVollmar/mars/
