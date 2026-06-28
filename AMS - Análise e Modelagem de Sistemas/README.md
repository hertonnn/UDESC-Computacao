# AMS

![img_ams](https://profissoes.vagas.com.br/wp-content/uploads/2023/01/o-que-faz-um-engenheiro-de-software-555x312.jpg)

"No mundo moderno, tudo é software. Hoje em dia, por exemplo, empresas de
qualquer tamanho dependem dos mais diversos sistemas de informação para
automatizar seus processos. Governos também interagem com os cidadãos por
meio de sistemas computacionais, por exemplo, para coletar impostos ou realizar eleições. Empresas vendem, por meio de sistemas de comércio eletrônico, uma
gama imensa de produtos, diretamente para os consumidores. Software está
também embarcado em diferentes dispositivos e produtos de engenharia, incluindo
automóveis, aviões, satélites, robôs, etc. Por fim, software está contribuindo para
renovar indústrias e serviços tradicionais, como telecomunicações, transporte em
grandes centros urbanos, hospedagem, lazer e publicidade.
Portanto, devido a sua relevância no nosso mundo, não é surpresa que exista uma
área da Computação destinada a investigar os desafios e propor soluções que
permitam desenvolver sistemas de software — principalmente aqueles mais
complexos e de maior tamanho — de forma produtiva e com qualidade. Essa área
é chamada de Engenharia de Software." - Livro Engenharia de Software Moderna

---

### **Resumo Final: Análise e Modelagem de Sistemas**

Este resumo está estruturado para facilitar seu entendimento, partindo do conceito geral de Engenharia de Software até os detalhes específicos de arquitetura e metodologias.

### **1. O que é Engenharia de Software? (A Base de Tudo)**

É a área da Computação que busca criar soluções para desenvolver **sistemas de software complexos com qualidade e de forma produtiva**. Ela se divide em várias subáreas, como:

- **Engenharia de Requisitos:** Entender e documentar o que o sistema deve fazer.
- **Projeto (Design) de Software:** Definir a arquitetura e os componentes do sistema.
- **Construção:** A codificação (programação) em si.
- **Testes:** Verificar se o sistema funciona como esperado.
- **Manutenção:** Corrigir, adaptar e evoluir o software após a entrega.
- **Gerência:** Gerenciar configurações (versões), projetos (prazos, riscos) e pessoas.

---

### **2. Requisitos: O Ponto de Partida**

Tudo começa com os requisitos, que são divididos em dois tipos principais:

- **Requisitos Funcionais:** O **"quê"** o sistema faz. São as funcionalidades e serviços.
    - *Exemplo:* "O sistema deve permitir que um cliente se cadastre na plataforma."
- **Requisitos Não-Funcionais:** O **"como"** o sistema opera. São as restrições e critérios de qualidade.
    - *Exemplo:* "A página de login deve carregar em no máximo 2 segundos." (Desempenho) ou "O sistema deve estar disponível 99.9% do tempo." (Disponibilidade).

**Ponto Chave em Testes:**

- **Verificação:** Estamos construindo o sistema **corretamente** (de acordo com as especificações)?
- **Validação:** Estamos construindo o sistema **certo** (o que o cliente realmente quer)?

---

### **3. Processos de Desenvolvimento: Como Organizar o Trabalho?**

Um processo define as atividades para construir o software. Existem dois modelos principais.

### **A. Modelo Waterfall (Cascata) - O Tradicional**

- **Características:** Sequencial e com planejamento detalhado no início (*big upfront design*). Cada fase (requisitos, projeto, implementação, teste) deve ser concluída antes de a próxima começar.
- **Problemas:**
    - **Pouca Flexibilidade:** Difícil de lidar com mudanças nos requisitos.
    - **Demora na Entrega:** O cliente só vê o produto finalizado no fim do projeto.
    - **Documentação Excessiva:** Gera muita documentação que rapidamente fica desatualizada.

### **B. Métodos Ágeis - O Moderno e Adaptativo**

Surgiram como uma resposta aos problemas do Waterfall. O **Manifesto Ágil** valoriza a **adaptação a mudanças, a colaboração e a entrega contínua de valor**. O trabalho é feito de forma **iterativa e incremental** (em ciclos curtos).

### 1. Scrum: O Framework de Gerenciamento

Pense no Scrum como um **manual de gerenciamento de projetos complexos**. Ele não diz *como* programar, mas sim *como organizar o time e o trabalho* para entregar valor de forma iterativa e incremental.

**Filosofia Central:** Baseia-se no **empirismo**, ou seja, aprender fazendo. A equipe trabalha, inspeciona o resultado e o processo, e se adapta para o próximo ciclo. Seus 3 pilares são:

- **Transparência:** Todos os envolvidos (time, gestores, cliente) têm visibilidade do que está acontecendo.
- **Inspeção:** O progresso e o produto são frequentemente avaliados para detectar desvios indesejados.
- **Adaptação:** Ao identificar problemas na inspeção, o processo ou o produto é ajustado.

**Estrutura do Scrum:**

| Elemento | Detalhe |
| --- | --- |
| **Papéis (As Pessoas)** | **Product Owner (PO):** O "dono do produto". É a voz do cliente. Sua função é definir *o que* será feito e priorizar os itens no Product Backlog para maximizar o valor do produto.
**Scrum Master (SM):** O "líder servidor". É um facilitador que garante que o time siga as regras do Scrum, remove impedimentos e protege a equipe de interrupções externas.
**Desenvolvedores (Time de Desenvolvimento):** A equipe multidisciplinar que executa o trabalho. São auto-organizáveis, decidindo *como* transformar os itens do backlog em um incremento funcional do produto. |
| **Eventos (As Reuniões)** | **Sprint:** O coração do Scrum. É um ciclo de trabalho com duração fixa (geralmente de 1 a 4 semanas) onde um incremento "pronto" e utilizável do produto é criado.
**Sprint Planning (Planejamento):** Reunião no início da Sprint onde o time seleciona os itens do Product Backlog que irá desenvolver e cria um plano de como fará isso.
**Daily Scrum (Reunião Diária):** Reunião rápida (15 min) para o time de desenvolvimento sincronizar o trabalho e planejar as próximas 24 horas. Responde basicamente a: "O que fizemos ontem? O que faremos hoje? Há algum impedimento?".
**Sprint Review (Revisão):** Ao final da Sprint, o time apresenta o que foi concluído (o incremento) para os stakeholders. O objetivo é obter feedback.
**Sprint Retrospective (Retrospectiva):** Após a Review, o time se reúne para refletir sobre o processo da Sprint que acabou, identificando pontos de melhoria para a próxima. |
| **Artefatos (As Ferramentas)** | **Product Backlog:** Uma lista única, viva e priorizada de tudo que é desejado para o produto. É gerenciada pelo PO.
**Sprint Backlog:** O conjunto de itens do Product Backlog selecionados para a Sprint atual, mais o plano para entregar esses itens. É gerenciado pelo Time de Desenvolvimento.
**Incremento:** A soma de todos os itens do Backlog concluídos durante uma Sprint, mais o valor dos incrementos de todas as Sprints anteriores. Deve estar em estado "pronto" (utilizável). |

**Ideal para:** Projetos com escopo que pode mudar, onde é preciso entregar valor rapidamente e receber feedback constante para ajustar a rota.

---

### 2. Extreme Programming (XP): A Disciplina da Engenharia

Se o Scrum foca na gestão, o XP foca na **excelência técnica e na qualidade do código**. É uma metodologia muito mais prescritiva sobre *como* o software deve ser construído. O objetivo é produzir software de alta qualidade e, ao mesmo tempo, ser capaz de responder rapidamente a mudanças de requisitos.

**Valores Centrais:**

- **Comunicação:** Incentivo máximo à comunicação cara a cara e colaboração constante.
- **Simplicidade:** Fazer a coisa mais simples que funcione. Evitar o excesso de engenharia (*over-engineering*).
- **Feedback:** Obter feedback o mais rápido possível, seja dos testes, do cliente ou do próprio time.
- **Coragem:** Ter coragem para refatorar código, descartar ideias ruins e dar/receber feedback honesto.
- **Respeito:** Respeitar os membros da equipe, suas opiniões e o trabalho de cada um.

**Práticas Fundamentais (O "Como" Fazer):**

| Prática | Descrição |
| --- | --- |
| **Programação em Par (Pair Programming)** | Dois desenvolvedores trabalham juntos no mesmo computador. Um (o piloto) escreve o código, enquanto o outro (o navegador) revisa, sugere melhorias e pensa estrategicamente. Aumenta a qualidade e dissemina conhecimento. |
| **Desenvolvimento Orientado a Testes (TDD)** | O ciclo é: 1) Escrever um teste automatizado que falha. 2) Escrever o código mais simples para fazer o teste passar. 3) Refatorar o código para melhorar sua estrutura. Garante uma cobertura de testes altíssima. |
| **Integração Contínua (CI)** | Os desenvolvedores integram seu trabalho ao repositório principal várias vezes ao dia. Cada integração dispara uma compilação e a execução de testes automatizados, detectando problemas rapidamente. |
| **Pequenas Entregas (Small Releases)** | Entregar versões funcionais do software em ciclos muito curtos (1 a 2 semanas), permitindo que o cliente use o sistema e forneça feedback real. |
| **Refatoração Constante (Refactoring)** | Melhorar continuamente a estrutura interna do código sem alterar seu comportamento externo. É como "limpar a casa" para facilitar futuras mudanças. |
| **Cliente Sempre Presente (On-site Customer)** | Um representante real do cliente trabalha fisicamente junto com a equipe de desenvolvimento, todos os dias, para tirar dúvidas e definir prioridades em tempo real. |
| **Propriedade Coletiva do Código** | Qualquer desenvolvedor pode (e deve) alterar qualquer parte do código a qualquer momento. Isso evita gargalos e aumenta a responsabilidade de todos pela qualidade do sistema inteiro. |
| **Padrão de Codificação (Coding Standard)** | Todos no time seguem as mesmas regras de formatação e nomenclatura, tornando o código uniforme e mais fácil de ler e entender. |

**Ideal para:** Projetos onde os requisitos são incertos ou mudam com frequência e a qualidade técnica do software é crítica. **Scrum e XP são frequentemente usados juntos:** Scrum para a gestão do projeto e XP para as práticas de engenharia.

---

### 3. Kanban: A Gestão do Fluxo Contínuo

O Kanban não é um framework de desenvolvimento como Scrum ou XP, mas sim um **método para visualizar, gerenciar e otimizar o fluxo de trabalho**. Ele não prescreve papéis ou cerimônias. Sua origem vem do sistema de produção da Toyota.

**Filosofia Central:** Comece com o que você faz agora e busque melhorias evolutivas e incrementais. O foco é otimizar o fluxo de entrega de valor, tornando-o mais rápido e previsível.

**Princípios Fundamentais:**

1. **Visualizar o Trabalho:** O fluxo de trabalho é mapeado em um quadro (Quadro Kanban), com colunas que representam cada etapa do processo (ex: "A Fazer", "Em Desenvolvimento", "Em Teste", "Concluído"). As tarefas são representadas por cartões que se movem pelo quadro.
2. **Limitar o Trabalho em Progresso (WIP - Work in Progress):** Este é o princípio mais importante. Cada coluna (ou o fluxo todo) tem um limite máximo de tarefas que podem estar nela ao mesmo tempo. Isso evita que o time comece muitas coisas e não termine nada, expõe gargalos e força a equipe a focar em *concluir* tarefas antes de *começar* novas.
3. **Gerenciar o Fluxo:** O objetivo é observar como os cartões se movem pelo quadro e otimizar para que o fluxo seja o mais suave e rápido possível. A equipe mede o *Lead Time* (tempo total desde o pedido até a entrega) e tenta reduzi-lo.
4. **Tornar as Políticas do Processo Explícitas:** Todos devem entender "como as coisas funcionam". O que significa "pronto" para cada etapa? Quem pode puxar uma nova tarefa? Essas regras são claras e visíveis para todos.

**Estrutura do Kanban:**

- **Não há papéis definidos:** O time existente continua com suas funções.
- **Não há iterações (Sprints):** O fluxo é contínuo. Quando uma tarefa é concluída, a equipe "puxa" a próxima tarefa mais prioritária da coluna anterior.
- **Métricas de Fluxo:** Foca em métricas como **Lead Time** (tempo de entrega) e **Cycle Time** (tempo de execução) para medir a eficiência.
- **Cadência de Reuniões:** Não há reuniões prescritas, mas as equipes geralmente adotam reuniões conforme a necessidade para gerenciar o fluxo (ex: uma reunião diária para olhar o quadro e uma reunião periódica para discutir melhorias).

**Ideal para:** Equipes que trabalham com um fluxo contínuo de demandas, como suporte, manutenção, DevOps, ou qualquer processo onde as prioridades podem mudar a qualquer momento e o trabalho não se encaixa bem em ciclos fixos como Sprints.

### **4. Projeto e Arquitetura de Software: Como Estruturar o Sistema?**

A arquitetura define a organização do sistema em componentes. É o "esqueleto" da aplicação.

### **A. Monolito vs. Microsserviços: A Grande Decisão Arquitetural**

- **Monolito:** O sistema inteiro é uma **única unidade**. Todos os módulos rodam juntos em um único processo.
    - **Problemas:**
        1. **Escalabilidade:** Para escalar uma parte, você precisa escalar o sistema inteiro.
        2. **Lentidão nas Entregas:** Uma mudança em um módulo pequeno exige testar e reimplantar todo o sistema, tornando o processo lento e arriscado.
- **Microsserviços:** O sistema é dividido em **serviços pequenos e independentes**, cada um rodando em seu próprio processo. Eles se comunicam entre si (geralmente via APIs).
    - **Vantagens:**
        1. **Escalabilidade Independente:** Pode-se escalar apenas o serviço que tem um gargalo de desempenho.
        2. **Agilidade nas Entregas:** Times podem desenvolver e implantar seus serviços de forma independente e rápida.

### **B. Padrões Arquiteturais Comuns**

- **Arquitetura em Camadas:** Organiza o sistema de forma hierárquica (ex: Camada de Apresentação, Lógica de Negócio, Acesso a Dados). Uma camada só pode usar serviços da camada imediatamente inferior.
- **MVC (Model-View-Controller):** Um padrão clássico para organizar interfaces gráficas.
    - **Model (Modelo):** Os dados e a lógica de negócio da aplicação.
    - **View (Visão):** A interface com o usuário (telas, botões). É o que o usuário vê.
    - **Controller (Controle):** Recebe as entradas do usuário (cliques, teclado) e aciona as atualizações no Model e na View.
- **Arquitetura Orientada a Mensagens:** Os componentes não se comunicam diretamente. Eles usam um intermediário chamado **fila de mensagens (ou broker)**.
    - **Vantagem Principal:** **Tolerância a Falhas**. Se um serviço estiver fora do ar, a mensagem fica na fila esperando que ele volte, em vez de gerar um erro imediato.
- **Publish/Subscribe (Pub/Sub):** Uma evolução da orientação a mensagens.
    - Um sistema **publica** um evento (ex: "Novo Pedido Criado").
    - Outros sistemas **assinam** (se inscrevem) para serem notificados quando aquele evento ocorrer, sem que o publicador precise saber quem são os assinantes. Promove um **baixo acoplamento**.

---

### **5. Outros Conceitos Importantes**

- **Stakeholders:** Todas as "partes interessadas" no projeto (clientes, usuários, desenvolvedores, gerentes, etc.).
- **Modelagem de Software (UML):** Criar representações visuais (diagramas) do sistema para facilitar o entendimento, a documentação e a comunicação. **UML (Unified Modeling Language)** é a notação mais comum para isso.
- **Classificação de Sistemas (ABC):**
    - **Tipo C (Casual):** Pequenos, descartáveis.
    - **Tipo B (Business):** Importantes para o negócio de uma empresa.
    - **Tipo A (Acute):** Críticos, onde falhas são inaceitáveis (aviação, medicina).

## Perguntas e Respostas

1 - Como XP preconiza que devem ser os contratos de desenvolvimento de software?

R: o XP preconiza que os contratos devem ser **instrumentos de colaboração, não de contenção**. Eles devem refletir a natureza dinâmica do desenvolvimento de software, permitindo que cliente e equipe trabalhem juntos em uma parceria para adaptar o produto às reais necessidades do mercado, garantindo a entrega contínua de valor.

2 - Quais as semelhanças entre XP e Scrum?

R: Proximidade entre cliente e equipe de trabalho. Possuem prescrições de papéis. Valorizam a agilidade, feedback e etc.

3 - Qual a diferença entre uma sprint review e uma
retrospectiva?

R: Review é a entrega aos stakeholders para assim se ter o feedback, enquanto a retrospectiva é após o review sendo uma reflexao do processo no final das contas.

4 - Qual a diferença entre as histórias do topo e do fundo do
Backlog do Produto, em Scrum?

R: Em Scrum, o **Backlog do Produto** é uma lista priorizada de tudo que pode ser necessário no produto, mantida pelo **Product Owner**. A diferença entre as **histórias do topo e do fundo** do backlog está principalmente no seu **nível de detalhe, clareza e prontidão para desenvolvimento**:

5 - Quais as diferenças entre XP e Scrum?

XP é feito visando a implementação do código e scrum é para a organização do projeto. Práticas técnicas, em xp temos testes, programação em par e etc, enquanto que em Scrum n temos essa procupação, apenas eventos, tarefas e etc.

6 -  Quais são as semelhanças entre Scrum e Kanban?

O constante feedback, valor contínuo, autonomia da equipe.

7 - Quais as principais diferenças entre Scrum e Kanban?

Scrun visa o desenvolvimento do projeto com ciclos (sprints), enquanto o kanban visa o desenvolvimento contínuo sem ciclos. Scrum possui papéis prescritos, como o PO e o SM, enquanto kanban não.

8 - Descreva os principais recursos oferecidos por Waterfall,
Scrum e Kanban para controlar riscos e garantir um fluxo de
trabalho sustentável e que propicie o desenvolvimento de
software com qualidade.

Waterfall - Prioriza o desenvolvimento de forma sequencial, resolvendo cada parte de forma concisa 

Scrum - Ciclos com feedbacks e conexão equipe de devs e cliente.

Kankan - Visualização, organização de forma contínua

### Sobre o Professor
CARLA DIACUI MEDEIROS BERKENBROCK

Professora na Universidade do Estado de Santa Catarina - UDESC. Possui doutorado em Engenharia Eletrônica e Computação pelo Instituto Tecnológico de Aeronáutica - ITA (2009); mestrado em Ciências da Computação pela Universidade Federal de Santa Catarina - UFSC (2005); e graduação em Bacharelado em Ciência da Computação pela Universidade do Estado de Santa Catarina - UDESC (2002). É professora do Departamento de Ciência da Computação e do Programa de Pós-Graduação em Ensino de Ciências, Matemática e Tecnologias (PPGECMT). Atualmente, coordena o Grupo de Pesquisa em Educação Inclusiva e Necessidades Educacionais Especiais (PEINE). Suas áreas de interesse incluem tecnologia assistiva, educação inclusiva e sistemas colaborativos

### Email:
carla.berkenbrock@udesc.br
### Lattes:
http://lattes.cnpq.br/5460117776241230


## Trabalhos Acadêmicos Relacionados (UDESC)

Abaixo estão alguns trabalhos acadêmicos desenvolvidos na UDESC que se relacionam com o conteúdo desta disciplina:

- **Ferramenta de auxílio ao gerente de projeto de software**
  - *Autor(es)/Ano:* Guilherme Pfützenreuter (Orientadora: Carla D. M. Berkenbrock) / 2013
  - *Link:* [https://repositorio.udesc.br/entities/publication/9e419ecf-4dcf-457d-9629-dad83de51d2f](https://repositorio.udesc.br/entities/publication/9e419ecf-4dcf-457d-9629-dad83de51d2f)

