# [Módulo 6 - Datapath e Pipeline] 6.8 - Hazards de Controle

### O Problema dos Hazards de Controle

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.8%20-%20Hazards%20de%20Controle/slide_1_img_1.png)

Por que as instruções abaixo geram um hazard de controle?
Não sabemos qual a próxima instrução que deve ir para o pipeline.
▶ Será `0x44` ou `0x60`?

```assembly
1 0x40 beq $1, $3, 7
2 0x44 and $12, $2, $5
3 0x48 or $13, $6, $2
4 0x4C add $14, $2, $2
5 ...
6 0x60 lw $4, 50($7)
7 ...
```

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.8%20-%20Hazards%20de%20Controle/slide_2_img_1.png)

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.8%20-%20Hazards%20de%20Controle/slide_2_img_2.png)

O `beq` ainda não terminou de ser executado, e não sabemos se devemos executar o salto ou não!

### Soluções Iniciais para Hazards de Controle

Podemos fazer com que o pipeline entre em stall.
▶ Inserir `nops`.
▶ Ineficiente.

Outras soluções?
▶ Partir do princípio que o desvio nunca é tomado.
▶ Sempre carregamos e executamos a próxima instrução.
▶ Se chegarmos à conclusão que estávamos errados, desfazemos tudo e continuamos a partir do endereço correto.
▶ Podemos assumir que acertamos em 50% das vezes.

**Assumir que o desvio nunca é tomado:**
Continuamos a execução normalmente.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.8%20-%20Hazards%20de%20Controle/slide_3_img_1.png)

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.8%20-%20Hazards%20de%20Controle/slide_3_img_2.png)

Se concluirmos que o "chute" sobre o endereço da próxima instrução estava errado, será necessário descartar esses resultados intermediários.
Caso a "previsão" esteja incorreta, temos 3 instruções que precisam ser descartadas:
▶ Uma no estágio EX, uma no ID, e uma no IF.
▶ Como podemos fazer esse descarte?
* Injetar `nop` em IF.
* Zerar sinais de controle para instruções que estão em ID e EX.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.8%20-%20Hazards%20de%20Controle/slide_4_img_1.png)

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.8%20-%20Hazards%20de%20Controle/slide_4_img_2.png)

No caso de "previsão incorreta", estamos desperdiçando três instruções:
* Três `nop` são processados.
* Três ciclos de clock inutilizados.

### Reduzindo Atrasos: Antecipando o Branch

No nosso processador MIPS visto até então:
▶ Por enquanto, assumimos que o resultado do branch só está pronto nos registradores EX/MEM.
* A instrução deve estar no estágio MEM.

Se conseguirmos calcular os resultados antes, podemos reduzir o custo de uma previsão incorreta.
▶ Chegamos antes à conclusão de que o desvio está incorreto ou não.
▶ Se a previsão está incorreta, menos trabalho executado é jogado fora.

Como realizar tudo no estágio ID?
**Trazer branch para o estágio ID:**

1. **Calcular o endereço do salto:**
* Deslocar os bits do imediato para a esquerda 2x e somar com PC + 4.
* Todas essas informações já estão disponíveis no estágio ID.
* Mudança simples, basta mover os componentes responsáveis.
* Não há atraso extra: esses valores podem ser calculados em paralelo, enquanto o banco de registradores busca pelas informações.

2. **Comparação:**
* É mais complicada. No momento quem faz isso é a ALU através de uma subtração.
* Podemos criar um circuito rápido especialista, que faz a comparação.
* `REG1 xnor REG2`: retorna 1 se forem iguais.
* Precisamos colocar esse circuito após a carga dos dados dos registradores.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.8%20-%20Hazards%20de%20Controle/slide_5_img_1.png)

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.8%20-%20Hazards%20de%20Controle/slide_5_img_2.png)

*(Os diagramas destacam o cálculo do endereço e xnor entre registradores movidos para o estágio ID).*

**Exercício**
1. Quais são os custos envolvidos nessa alteração?
▶ Custo em dinheiro, tempo, complexidade.
▶ Parte da resposta: O estágio ID vai necessitar de tempo extra devido à comparação (só pode ser feita após a carga dos registradores).

2. Trazer a comparação para um estágio anterior, adicionando-se mais hardware como fizemos, é uma boa ideia em qualquer processador?

### Novos Hazards de Dados com Branch em ID

Diminuímos o custo de uma previsão incorreta.
▶ Agora no máximo uma bolha (`nop`) é necessária devido ao hazard de controle.
▶ **Criamos novos hazards de dados!**
* Por quê? Onde? Como?

Criamos novos hazards de dados, agora no estágio ID:
* Os operandos do `beq` podem estar sendo calculados em algum dos estágios do pipeline.
* Precisamos de lógica extra de forwarding para o estágio ID.
* Precisamos detectar hazards de dados sem solução, para inserir `nops`.
▶ e.g., um `lw` antes de um `beq`, sendo que o `beq` precisa do dado do `lw`.
▶ Mais complexidade na unidade de detecção de hazards.
Vamos nos contentar em saber que esses novos problemas existem, mas não vamos colocar o hardware para resolver.

### Previsão Dinâmica de Desvios

O custo de uma previsão incorreta pode ser excessivamente alto em uma CPU de pipeline profundo.
Podemos melhorar o sistema através de um sistema que tenta aprender se os desvios estão sendo tomados ou não.
e.g., **buffer de previsão de desvios**.

Um buffer de previsão de desvios é uma pequena memória, que contém uma tabela com o endereço da instrução, e um bit indicando se o desvio foi tomado ou não a última vez que executamos a instrução nesse endereço.
Especialmente útil em casos de loops.
Depois de calcular se o endereço realmente foi tomado ou não, podemos atualizar o valor no buffer.
▶ Para melhorar nossa escolha na próxima vez que passarmos por esta instrução.
* Pense em loops.

O buffer é pequeno, e obviamente não podemos armazenar o endereço de todas as instruções.
Solução: utilizar os bits mais baixos do endereço de memória (a partir do 3º bit menos significativo) para endereçar o buffer.
▶ Muitas instruções vão compartilhar o mesmo local no buffer.
* O único problema é que se verificarmos o buffer para uma instrução, mas o bit se refere a alguma outra, nossa probabilidade de errar é muito maior.
* Porém nem todas as instruções compartilhando o mesmo endereço do buffer são desvios.
* Ideia similar a de uma memória cache.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.8%20-%20Hazards%20de%20Controle/slide_8_img_1.png)

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.8%20-%20Hazards%20de%20Controle/slide_8_img_2.png)

*(Exemplo visual de um buffer com capacidade para 8 instruções).*

O buffer pode ser facilmente instalado no estágio IF do pipeline.
▶ Primeiro estágio do pipeline.
▶ Não precisamos da instrução em si, apenas do seu endereço que está em PC.

### Outros Esquemas de Previsão

**Buffers de previsão que utilizam mais de 1 bit**
▶ Pipelines mais profundos.
▶ Utilização de máquinas de estados simples.
▶ e.g., quatro estados (2 bits), necessita duas decisões erradas seguidas.
▶ A última decisão de um loop (quando sai) é sempre errada (ficar no loop).
* Com um bit: a primeira decisão do `while` também é sempre errada (trocou para sair na última saída do `while`).
* Com dois bits: isto é resolvido. Como?
```c
1 for (int i = 0; i < 100; i++){
2     j = 3;
3     while(j--) {
4         ...
5     }
6 }
```

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.8%20-%20Hazards%20de%20Controle/slide_9_img_1.png)

**Delayed Slots**
▶ Pipelines rasos e com decisões sobre desvios tomadas no início do pipeline.
▶ Um bom exemplo é o processador MIPS sendo analisado em aula.
▶ **Branch Delayed Slots**: No MIPS: um slot, abaixo de um branch com atraso, que é ocupado por uma instrução que não afeta o desvio.
* Sempre executa a instrução abaixo do Delayed Branch (no slot).
* Tenta-se colocar uma instrução que é sempre executada após o branch (independentemente dele ter sido tomado ou não).
* Instrução sempre útil.

Esquemas sofisticados conseguem uma taxa de acertos de cerca de 90%.
Objetivo: Reduzir o custo de um desvio quando nossa previsão está incorreta.

### Exemplo em Pipelines Profundos

Considere o custo de uma previsão de branch incorreta em um Pentium 4 Prescott!
Note que depois do Pentium 4, o número de estágios no pipeline reduziu.
Um pipeline profundo é ideal se conseguimos mantê-lo cheio.
▶ Mas é complexo, e stalls custam caro.
▶ Difícil manter o pipeline sempre cheio.
▶ Principalmente considerando que a memória principal da máquina, de onde vêm as instruções, é muito mais lenta que a CPU.

### Referências
* D. Patterson; J. Henessy. Organização e Projeto de Computadores: Interface Hardware/Software. 5a Edição. Elsevier Brasil, 2017.
* Andrew S. Tanenbaum. Organização estruturada de computadores. 5. ed. São Paulo: Pearson, 2007.
* Harris, D. and Harris, S. Digital Design and Computer Architecture. 2a ed. 2012.
