# Prova 1 (17/04/2024)

Em uma empresa, a admissão de um funcionário deve ser registrada no sistema pela inserção dos dados deste. Assim, um funcionário é descrito pelos atributos:
- nome: `char[250]`
- cpf: `char[12]`
- numero de dependentes: `0`, `1` ou `vários`
- ano de admissão: `int`
- estado civil (solteiro, casado/união estável, divorciado, viúvo): pode ser `int`

Inicialmente um funcionário é cadastrado. Somente em um outro momento, ele poderá vincular dependentes no seu cadastro junto à empresa. Cada dependente deve ter os atributos:
- nome
- cpf
- relação (cônjuge, filho(a)/enteado(a), mãe, pai): pode ser `int`

**Parte 1)** Crie as estruturas de dados descritas e as funções para acessar a EDA de forma segura (para criar pessoas e dependentes, assim como fazer a inserção do funcionário na empresa e a inserção do dependente). 
Construa seu código de forma que os dados sejam inseridos por teclado (não fixos dentro do código). 

**Parte 2)** Crie uma função para gravar em arquivo os dados cadastrados, sem perda de informação a medida que novos dados são cadastrados. Um arquivo de funcionários e um arquivo para os dependentes. No arquivo de dependentes, cada linha contém um dependente e começa com o campo de cpf do funcionário vinculado.

**Exemplo:**
Funcionário: 
`BRANCA DE NEVE, 02492917832, [10080997077183, 80983765321, 12222222222], 2020, 0`
`Harry Potter, 11356789031, 0, 2020, 0`

Dependentes:
`10080997077183, ATCHIM, 1`
`80983765321, ZANGADO, 1`
`12222222222, DUNGA, 1`