**Questão 1:**

Elabore a modelagem para o seguinte cenário: Uma companhia planeja adquirir caminhões dos modelos C1, C2 e C3 (as especificações e valores estão detalhados na tabela a seguir), considerando as seguintes restrições:

* O limite de capital disponível para as aquisições é de R$ 4.000.000,00.
* A companhia conta com um contingente máximo de 150 operadores.
* A capacidade de manutenção da empresa é restrita a, no máximo, 30 caminhões.

Determine a quantidade exata de cada modelo de caminhão que deve ser comprada para garantir que a capacidade diária total da frota (medida em toneladas x Km) atinja o seu valor máximo.

| Caminhões | C1 | C2 | C3 |
| --- | --- | --- | --- |
| Limite de carga | 10 Ton. | 20 Ton. | 18 Ton. |
| Velocidade média | 56 Km/h | 48 Km/h | 48 Km/h |
| Valor por caminhão [R$] | 80.000 | 130.000 | 150.000 |
| Quantidade de operadores | 1 operador | 2 operadores | 2 operadores |
| Jornada diária | 18 h/dia | 18 h/dia | 21 h/dia |

---

**Questão 2:**

A partir do problema de otimização apresentado a seguir:
a. Determine a solução através da abordagem gráfica.
b. Determine a solução através da aplicação do método SIMPLEX.
c. Identifique e aponte no gráfico qual é a solução básica inicial estabelecida durante a fase I do SIMPLEX.

Minimizar $z = x_1 + 2x_2$

Sujeito às restrições:
$-x_1 + 3x_2 \le 9$
$x_1 - 2x_2 \le 0$
$2x_1 + x_2 \le 10$
$2x_1 + x_2 \ge 5$
$x_1, x_2 \ge 0$