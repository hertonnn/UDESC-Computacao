# [Módulo 6 - Datapath e Pipeline] 6.7 - Hazards de Dados: Construindo Forwardings

### Introdução aos Hazards de Dados

O pipeline construído até o momento funciona caso nossas instruções não tenham dependências.
▶ Mas vimos que hazards de dados e de controle são comuns.
▶ Vamos começar pelo tratamento dos hazards de dados: **Forwardings** (bypasses).

### Exemplo de Dependências e Hazards de Dados

Considere as instruções a seguir:
```assembly
1 sub $2, $1, $3
2 and $12, $2, $5
3 or $13, $6, $2
4 add $14, $2, $2
5 sw $15, 100($2)
```
Onde estão os hazards de dados nessas instruções?
▶ Todas as instruções marcadas (and, or, add, sw) dependem do resultado do `sub` (registrador `$2`).
▶ Se isso vai causar hazards de dados ou não depende diretamente de como nosso pipeline é montado, e de sua profundidade.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_2_img_1.png)

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_2_img_2.png)

![Imagem Embutida 3](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_2_img_3.png)

**Exemplo: Pipeline de 5 estágios**
* `sub` armazena o resultado de `$2` no banco de registradores no clock 5.
* `sw` está lendo `$2` no clock 6, então não temos hazard.

* `add` está lendo `$2` no mesmo clock que o resultado está sendo escrito (clock 5). Isso não gera um hazard no banco de registradores. Os flip-flops são construídos de forma que o dado é escrito no início do ciclo, e são lidos no final do ciclo.

* `or` tenta usar `$2` antes do resultado estar pronto (gravado no banco de registradores). Temos hazard de dados aqui.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_3_img_1.png)

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_3_img_2.png)

![Imagem Embutida 3](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_3_img_3.png)

* `and` tenta usar `$2` antes do resultado estar pronto (gravado no banco de registradores). Temos hazard de dados aqui.

**Pergunta:** Em que estágio do `sub` (primeira instrução) o resultado já está pronto e só não foi gravado? E em que estágio esses valores são realmente utilizados pelas instruções subsequentes `and` e `or`?
▶ O resultado está pronto quando sai da ALU.
▶ O valor é utilizado pela ALU nas demais instruções. E é aqui que precisamos fazer um forward.

Para o `add`, o forward já é feito "automaticamente" pelo banco de registradores.

### Registradores de Pipeline e Forwardings

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_4_img_1.png)

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_4_img_2.png)

![Imagem Embutida 3](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_4_img_3.png)

Registradores de pipeline armazenam informações relevantes da instrução a cada estágio.
Nomes dos registradores de fronteira (pipeline): `IF/ID`, `ID/EX`, `EX/MEM`, `MEM/WB`.
* O dado do registrador fonte 1, armazenado em ID/EX: `ID/EX.DadoRS`
* O endereço do registrador destino, armazenado em ID/EX: `ID/EX.RegistradorRD`

No estágio EX, quando a ALU calcula um resultado, ele é armazenado no estágio EX/MEM.
Também é salvo o endereço do registrador de destino: `EX/MEM.RegistradorRD`.
O mesmo ocorre quanto a instrução passa pelo estágio MEM. O endereço do registrador de destino é salvo em: `MEM/WB.RegistradorRD`.

*(O passo a passo visual exemplifica as instruções caminhando pelos estágios e onde o Forwarding extrai os dados).*

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_5_img_1.png)

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_5_img_2.png)

![Imagem Embutida 3](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_5_img_3.png)

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_6_img_1.png)

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_6_img_2.png)

No exemplo a 1ª fonte da ALU deve vir de EX/MEM.
▶ O mesmo pode acontecer para a 2ª fonte da ALU.
▶ E o resultado pode vir ainda de MEM/WB.

Ainda temos o problema de que não é toda instrução que escreve nos registradores.
▶ O dado em EX/MEM, ou em MEM/WB, mesmo sendo mais recente, pode não fazer sentido.
▶ Como saber se o dado nesses estágios vai ser escrito no registrador?
* Uma solução é verificar se o sinal de controle `RegWrite` está ativo para a instrução que se encontra no estágio EX ou MEM.

### Forward do registrador `$zero`

Outro problema é se fizermos o forward do registrador `$zero`
e.g., `addi $0, $1, 2`
Podemos tratar esse problema de várias formas:
▶ Especificar que o montador gera um erro nesse código Assembly:
* Parece o correto, mas e se modificarmos o código de máquina diretamente? E quem garante que o montador vai fazer as coisas direito?
▶ Podemos fazer com que o processador lance uma exceção:
* Algo que acontece também quando fazemos uma divisão por zero.
* Seria uma boa solução, mas vamos deixar exceções de lado por enquanto.
▶ Ou podemos efetivamente realizar o cálculo e "armazenar" em `$zero` (`$0`):
* O que vai acontecer é que o banco de registradores vai ignorar esse resultado e manter `$0` com o valor 0.
* Mas devemos tomar cuidado:
```assembly
1 addi $0, $1, 2
2 sub $2, $3, $0
```
* se fizermos o forward do `$0`, vamos usar um valor que será descartado!

### A Unidade de Forwarding

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_7_img_1.png)

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_7_img_2.png)

![Imagem Embutida 3](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_7_img_3.png)

Para simplificar, essa versão do circuito não está com o multiplexador para escolher entre o registrador e o campo imediato como segundo operando da ALU. Como ficaria com este multiplexador?

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_8_img_1.png)

A lógica para os sinais da Unidade de Forwarding:

```text
ForwardA = 00
ForwardB = 00

if EX/MEM.RegWrite and (EX/MEM.RegisterRd != 0) and (EX/MEM.RegisterRd = ID/EX.RegisterRs):
    ForwardA = 10

if EX/MEM.RegWrite and (EX/MEM.RegisterRd != 0) and (EX/MEM.RegisterRd = ID/EX.RegisterRt):
    ForwardB = 10

if MEM/WB.RegWrite and (MEM/WB.RegisterRd != 0) and (MEM/WB.RegisterRd = ID/EX.RegisterRs):
    ForwardA = 01

if MEM/WB.RegWrite and (MEM/WB.RegisterRd != 0) and (MEM/WB.RegisterRd = ID/EX.RegisterRt):
    ForwardB = 01
```

* `EX/MEM.RegWrite` e `MEM/WB.RegWrite`: Testa o sinal de controle para verificar se a instrução em EX/MEM e MEM/WB (respectivamente) pretende escrever o resultado no registrador.
* `EX/MEM.RegisterRd != 0` e `MEM/WB.RegisterRd != 0`: O registrador de destino não pode ser o `$zero`.
* `EX/MEM.RegisterRd = ID/EX.RegisterRs`, `EX/MEM.RegisterRd = ID/EX.RegisterRt`, `MEM/WB.RegisterRd = ID/EX.RegisterRs` e `MEM/WB.RegisterRd = ID/EX.RegisterRt`: Testa se o endereço do registrador da 1ª e 2ª fonte no estágio EX é o mesmo de destino das instruções nos estágios MEM e/ou WB.

### Mais Complicações com Forwarding

O resultado ainda não salvo de um registrador pode estar em EX/MEM, e também em MEM/WB:
```assembly
1 add $1, $1, $2
2 add $1, $1, $3
3 add $1, $1, $4
```

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_9_img_1.png)

Condições atualizadas:
```text
ForwardA = 00
ForwardB = 00

if EX/MEM.RegWrite and (EX/MEM.RegisterRd != 0) and (EX/MEM.RegisterRd = ID/EX.RegisterRs):
    ForwardA = 10

if EX/MEM.RegWrite and (EX/MEM.RegisterRd != 0) and (EX/MEM.RegisterRd = ID/EX.RegisterRt):
    ForwardB = 10

if MEM/WB.RegWrite and (MEM/WB.RegisterRd != 0) and (MEM/WB.RegisterRd = ID/EX.RegisterRs)
and not(EX/MEM.RegWrite and (EX/MEM.RegisterRd != 0) and (EX/MEM.RegisterRd != ID/EX.RegisterRs)):
    ForwardA = 01

if MEM/WB.RegWrite and (MEM/WB.RegisterRd != 0) and (MEM/WB.RegisterRd = ID/EX.RegisterRt)
and not(EX/MEM.RegWrite and (EX/MEM.RegisterRd != 0) and (EX/MEM.RegisterRd != ID/EX.RegisterRt)):
    ForwardB = 01
```

Deve-se dar preferência ao resultado no estágio MEM (registrador de pipeline EX/MEM) por ser o mais recente.

A unidade desenvolvida serve para (os dados necessários no)/o estágio EX.
Hazards de dados ainda podem acontecer para (os dados necessários no)/o estágio MEM.
▶ e.g., um `lw` seguido de um `sw` se referenciando ao mesmo endereço de memória.
A unidade de forwarding em MEM é mais simples do que a em EX.

### Stalls causados por hazards de dados

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_10_img_1.png)

Não é possível solucionar qualquer hazard de dados através de forwardings. Nesses casos precisamos de um **pipeline stall**.
▶ Inserir bolhas no pipeline.
▶ Uma bolha é inserida efetivamente inserindo-se uma instrução que não executa operação alguma.
▶ Esse tipo de instrução geralmente é chamada de `nop` (*no operation*).
* Não escreve em nenhum registrador (Incluindo o PC, que não é atualizado).
* Não escreve na memória.
* Não altera as informações nos registradores de pipeline.

Nosso processador e pipeline são simples.
▶ A única combinação que causará stalls são loads seguidos de alguma instrução que usa o conteúdo do registrador sendo carregado.
```assembly
1 lw $s1, 4($s2)
2 add $s4, $s1, $s5
```
E o stall é de somente uma instrução.
▶ Não precisamos adicionar mais de um `nop` no meio das instruções.

O controle da unidade de detecção pode ser o seguinte:
```text
if ID/EX.MemRead and (
    (ID/EX.RegisterRt = IF/ID.RegisterRs) or
    (ID/EX.RegisterRt = IF/ID.RegisterRt)
):
    pipeline stall
```

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.7%20-%20Hazards%20de%20Dados%20Construindo%20Forwardings/slide_11_img_1.png)

### Exercícios

**1.** Volte nas aulas anteriores e verifique que ao enviar zero em todos os sinais de controle, nada será alterado ao final de uma instrução.

**2.** Usando os slides como exemplo, crie uma unidade de forwaring para o estágio MEM do pipeline.

### Referências
* D. Patterson; J. Henessy. Organização e Projeto de Computadores: Interface Hardware/Software. 5a Edição. Elsevier Brasil, 2017.
* Andrew S. Tanenbaum. Organização estruturada de computadores. 5. ed. São Paulo: Pearson, 2007.
* Harris, D. and Harris, S. Digital Design and Computer Architecture. 2a ed. 2012.
