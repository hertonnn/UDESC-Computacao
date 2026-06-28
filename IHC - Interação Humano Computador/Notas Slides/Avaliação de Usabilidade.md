# Notas de Aula: Avaliação de Usabilidade em IHC

## Introdução e Qualidade de Uso
A avaliação de interfaces no contexto da Interação Humano-Computador (IHC) é fundamental para garantir que o sistema interativo seja adequado e eficiente.

### Qualidade de Uso em IHC
A qualidade de uso engloba os seguintes critérios principais:
*   **Usabilidade**
*   **Experiência do usuário**
*   **Acessibilidade**
*   **Comunicabilidade**

### Usabilidade
De acordo com a norma ISO 9241-11 (1998), a usabilidade é definida como o grau em que um produto é usado por usuários específicos para atingir objetivos específicos, focando em:
*   **Eficácia:** A precisão e a abrangência com as quais usuários alcançam objetivos específicos. Pode ser medida, por exemplo, pelos coeficientes de erro ou pela porcentagem de tarefas completadas com sucesso.
*   **Eficiência:** Os recursos gastos (como tempo e dinheiro) em relação à precisão e abrangência com as quais os usuários atingem objetivos. Pode ser medida pelo tempo para completar a tarefa ou pela quantidade de tarefas completadas por unidade de tempo.
*   **Satisfação:** O conforto, a aceitação e a atitude positiva em relação ao uso do produto. Pode ser medida por escalas de satisfação, frequência de uso e frequência de reclamações.

Todos esses fatores dependem e são avaliados dentro de um **contexto de uso específico**.



## Planejamento da Avaliação de IHC
### Problemas de Usabilidade
Um problema de usabilidade refere-se a qualquer aspecto do sistema ou da demanda sobre o usuário que torne o sistema desagradável, ineficiente, oneroso ou impossível de usar para realizar objetivos em uma situação típica. Tais problemas podem ser detectados (*a posteriori*) durante o uso real ou previstos (*a priori*) durante o design.

Para determinar a ocorrência e a causa de um problema, observam-se fatores como:
*   **Desempenho do usuário:** Avalia-se se a conclusão das tarefas teve sucesso, sucesso parcial ou não foi concluída, além do tempo exigido.
*   **Esforço desnecessário:** Exigido do usuário durante a interação.
*   **Ocorrência de erros e Operação:** Se a interface induz ao erro, se utiliza comandos complexos ou se há ausência de mensagens informativas adequadas.
*   **Atividade do sistema:** Como o sistema adverte o usuário e que tipo de suporte oferece para a recuperação de erros.
*   **Satisfação subjetiva** do usuário.
*   **Correspondência com os objetivos** e **adequação a padrões** de design estabelecidos.

Estes problemas podem ser classificados de acordo com sua **natureza** (barreira, obstáculo, ruído), a **tarefa** afetada (principal, secundária), o **usuário** (geral, preliminar, especializado, especial) e o **projeto** (falso, novo).

### Graus de Severidade
A severidade de um problema de usabilidade é uma métrica crucial, definida por uma combinação de fatores:
*   **Frequência:** O problema é comum ou raro?
*   **Impacto:** Será fácil ou difícil para os usuários superarem a dificuldade?
*   **Persistência:** É um problema pontual que o usuário supera após aprender, ou ele continuará sendo incomodado repetidamente?

Uma escala de graus de severidade típica (baseada em heurísticas) categoriza os problemas como:
*   **0 - Sem importância:** Não afeta a operação da interface e não requer reparo.
*   **1 - Cosmético:** Não há necessidade imediata de solução.
*   **2 - Simples:** Problema de baixa prioridade, mas que deve ser reparado se possível.
*   **3 - Grave:** Alta prioridade, necessita ser reparado o quanto antes.
*   **4 - Catastrófico:** Prioridade máxima; o problema impede completamente a operação ou causa danos graves, e o reparo é obrigatório.

### Fatores do Plano de Avaliação
O planejamento da avaliação verifica se o sistema atende aos requisitos dos usuários e se comporta como esperado. O plano deve ser norteado pelas seguintes questões essenciais:
*   **Objetivos (Por que avaliar?):** Pode ser para avaliar a funcionalidade do sistema (torná-la usável), avaliar o efeito da interface junto ao usuário (facilidade de aprendizado) ou identificar problemas específicos que causam confusão.
*   **Critérios (O que avaliar?):** Correções em projetos em desenvolvimento, revisões em produtos acabados, decisão de aceitação de projetos ou comparação de desempenho.
*   **Métodos e Técnicas (Como avaliar?):** Observar e registrar problemas, calcular métricas objetivas (tempo, produtividade), prever tempos de execução ou colher opiniões.
*   **Forma (Quando e onde avaliar?):**
    *   **Avaliação Formativa (construtiva / a priori):** Realizada ao longo de todo o processo de design (utilizando cenários, storyboards, modelagens da interação e protótipos).
    *   **Avaliação Somativa (conclusiva / a posteriori):** Realizada nas etapas finais de cada ciclo de desenvolvimento, com o produto ou protótipo funcional.
*   **Fatores Práticos:** Deve-se considerar o estágio do design, o nível de ineditismo do projeto, o número esperado de usuários, a criticidade da interface (ex: um sistema de controle de tráfego vs. um site informativo), o orçamento, o tempo e a experiência dos avaliadores.



## Métodos de Avaliação em IHC
Existem diversas abordagens para avaliar interfaces, variando quanto à participação do público-alvo e à técnica empregada.

### Verificação (Sem participação de Usuários)
Técnicas que confiam no julgamento de avaliadores especialistas ou em modelos teóricos:
*   **Baseada em Modelos Formais ou Cognitivos:** Utiliza modelos analíticos, como a Inspeção Cognitiva.
*   **Baseada no Julgamento do Avaliador:** Métodos como a Avaliação Heurística, em que inspetores verificam o sistema buscando violações de heurísticas de usabilidade.
*   **Baseada em Conformidade:** Inspeção para confrontar o sistema com princípios, diretrizes, recomendações e normas de design e acessibilidade.
*   **Modelos Preditivos:** Aplicação teórica de modelos de tempo e movimento humano, como o Modelo GOMS ou a Lei de Fitts.

### Validação (Com Participação de Usuários)
Técnicas empíricas que exigem a interação direta do público-alvo com a interface:
*   **Baseada na Opinião:** Coleta da percepção subjetiva dos usuários sobre a interação.
*   **Baseada em Dados Comportamentais:** Observação ou coleta sistemática do comportamento real de uso.
*   **Baseada em Experimentos:** Testes rigorosamente controlados para testar hipóteses.

Para coletar e avaliar dados, utilizam-se comumente as seguintes técnicas: **Questionários, Entrevistas, Grupos de Foco e Observação.**







## Técnicas de Coleta de Dados: Entrevistas
A entrevista é uma técnica qualitativa frequentemente descrita como "uma conversa com um propósito". Geralmente ocorrem de forma síncrona e presencial.

### Tipos de Entrevistas
Classificam-se de acordo com o nível de controle imposto ao roteiro:
*   **Não estruturadas (Abertas):** Fluxo livre, focado em explorar tópicos de forma ampla.
*   **Semi-estruturadas:** Possuem um roteiro guia, mas permitem flexibilidade para o aprofundamento em tópicos de interesse que surjam.
*   **Estruturadas:** Seguem rigorosamente um conjunto de perguntas fechadas.
*   **Grupos de Foco:** Uma variação de entrevista realizada em pequeno grupo, conduzida por um facilitador, ideal para observar o consenso ou conflito de ideias.

### Recomendações e Etapas de Execução
A preparação rigorosa das perguntas e o formato de condução garantem melhores resultados empíricos:
1.  **Introdução:** Explicar o objetivo e as questões éticas envolvidas no uso dos dados.
2.  **Aquecimento:** Questões fáceis e demográficas (ex: onde reside, profissão) para deixar o participante confortável.
3.  **Sessão Principal:** Abordagem aprofundada dos tópicos de coleta de dados.
4.  **Descanso:** Um período de encerramento com questões mais leves.
5.  **Encerramento Claro:** Agradecer, desligar gravadores e sinalizar explicitamente que a avaliação acabou.





## Técnicas de Coleta de Dados: Questionários
Questionários são conjuntos de perguntas destinadas a serem respondidas de forma assíncrona (em papel, por telefone, e-mail ou via web), sem a influência direta e imediata do investigador.

### Projeto e Recomendações
Um questionário bem-sucedido requer um bom design:
*   **Organização Estrutural:** Inicie solicitando dados demográficos e de experiência (contexto do usuário). Siga com perguntas específicas alinhadas aos objetivos da pesquisa. Se o questionário for longo, agrupe por tópicos.
*   **Ordem e Viés:** A ordem em que as perguntas são apresentadas pode influenciar as respostas; deve-se estruturar a lógica com cuidado.
*   **Versões Alternativas:** Pode haver necessidade de adaptar termos ou perguntas a depender das diferentes populações investigadas.
*   **Instruções e Clareza Visual:** O design tipográfico deve ser limpo. Equilibre o espaço em branco sem tornar o documento excessivamente longo (o que desestimula a conclusão). Deixe claro se uma pergunta admite resposta única ou múltipla.

### Formatos de Respostas
*   **Abertas:** Permitem escrita livre do usuário.
*   **Fechadas:** Restringem as opções (ex: escolha única ou múltipla).
*   **Escalas:** Frequentes para medir atitudes ou sentimentos. Destacam-se a **Escala de Likert** (onde o usuário indica seu grau de concordância com uma afirmação) e o **Diferencial Semântico** (posicionamento da resposta em uma faixa de valor entre dois extremos opostos).

### Questionários Padronizados em IHC
Existem ferramentas prontas e amplamente validadas na literatura para medir satisfação e qualidade:
*   **ISONORM / ErgoNorm:** Baseados nos princípios da ISO 9241-10.
*   **QUIS:** Questionnaire for User Interaction Satisfaction (Universidade de Maryland).
*   **SUS:** System Usability Scale, muito popular para avaliação de usabilidade global.
*   **WAMMI:** Website Analysis and MeasureMent Inventory (específico para web).
*   **CSUQ / Isometrics:** Sistemas computacionais genéricos.



## Técnicas de Coleta de Dados: Observação
A observação busca entender como as atividades acontecem no mundo real, podendo gerar dados qualitativos e quantitativos.

*   **Observação Direta:** O avaliador gasta tempo presente com as pessoas, monitorando ativamente. Pode ocorrer em campo (ambiente natural de trabalho do usuário) ou em laboratórios controlados. Pode-se utilizar a técnica de "Pensamento em Voz Alta" (Thinking Aloud), onde o usuário verbaliza o que está tentando fazer e o porquê de cada ação.
*   **Observação Indireta:** Registro retrospectivo ou assíncrono. Envolve o monitoramento através de sistemas espiões, registros de *log* de interação ou diários manuais escritos pelo próprio usuário. Garante que o participante não seja influenciado pela presença do pesquisador.

## Testes de Usabilidade
O teste de usabilidade é uma experimentação aplicada. Consiste no ensaio de interação, no qual usuários reais representativos da população-alvo realizam tarefas típicas com uma versão ou protótipo do sistema.

### Planejamento do Teste
Exige a elaboração de um escopo estrito e a condução de **estudos piloto** prévios para ajuste do material. O planejamento deve responder:
*   Objetivo principal da avaliação e métricas de sucesso (ex: ausência de erros com severidade alta).
*   Ambiente, duração da sessão, suporte computacional necessário e estado inicial do sistema.
*   Seleção do perfil da amostra de participantes e a quantidade necessária.
*   Definição clara do roteiro de tarefas e o critério de sucesso para a conclusão de cada tarefa.
*   Diretrizes sobre o nível de intervenção e ajuda permitida pelo experimentador.
*   Métodos de registro (vídeo, *log*, áudio, tela) e posterior análise de dados.

### Vantagens e Desvantagens
*   **Vantagens:** Apresentam a interação genuína e real do usuário com o sistema, sendo o meio mais eficaz para identificar os problemas mais graves de usabilidade, superando largamente métodos de inspeção.
*   **Desvantagens:** É consideravelmente caro (custos podem ser até 50 vezes superiores aos da inspeção), consome mais tempo, e, em sua forma mais rigorosa, exige laboratórios de usabilidade estruturados e treinamento altamente especializado para os moderadores.

### Instalações Físicas
Em ambientes controlados (laboratórios de usabilidade), as sessões ocorrem em salas com espelhos falsos (onde observadores tomam notas sem perturbar o participante), com suporte a múltiplas câmeras, softwares de gravação de tela, captação de áudio limpo, etc. Atualmente, os testes também podem ser portáteis (para contextos in loco ou móveis) utilizando dispositivos compactos de gravação.

### Testes de Usabilidade x Pesquisa Científica Experimental
Embora o teste de usabilidade aplique métodos empíricos e observacionais controlados, difere de um experimento puramente científico. 
O **teste de usabilidade** visa melhorar um produto, trabalha com amostras pequenas, foca em resolver falhas específicas de design, não é 100% replicável e atende a um ciclo corporativo/desenvolvedor. A **pesquisa experimental**, por sua vez, visa descobrir novo conhecimento válido para a comunidade científica, requer alta replicabilidade, validação estatística com muitos participantes, rigor experimental e controle rígido de variáveis.




## Comparativo e Síntese de Métodos
A literatura aponta características complementares para cada técnica empregada.

| Técnica | Ideal para | Vantagens | Desvantagens |
| :--- | :--- | :--- | :--- |
| **Entrevistas** | Explorar questões aprofundadas. | Avaliador pode guiar, contato direto e rico com o participante. | Demorada, ambiente artificial pode gerar viés. |
| **Grupos de Foco** | Coletar múltiplos pontos de vista. | Mostra áreas de consenso e conflito rapidamente. | Risco de participantes dominantes ofuscarem os mais tímidos. |
| **Questionários** | Questões específicas em volume. | Grande alcance e baixo custo. | Baixa taxa de resposta, dificuldade de aprofundamento das perguntas. |
| **Observação de Campo** | Contexto natural. | *Insights* ricos e verídicos não detectáveis em laboratório. | Alto tempo investido e enorme massa de dados ruidosos. |
| **Testes de Laboratório** | Detalhes microscópicos. | Foco profundo nas tarefas e interrupções bloqueadas. | Condições artificiais limitam validade ecológica externa. |
| **Logs/Indireta** | Observação sem perturbação. | Escalonável, captura contínua e fidedigna das ações reais. | Dados quantitativos exigem alta especialização analítica, e diários perdem acurácia dependendo da memória. |

Embora os métodos de inspeção heurística (especialistas) ofereçam o melhor custo-benefício financeiro e identifiquem grandes falhas arquiteturais precocemente, estatísticas relatam que até 56% dos problemas reais de uso podem passar despercebidos. Por esta razão, nenhuma inspeção substitui plenamente um teste de usabilidade empírico.






## A Abordagem dos Experimentos
Para hipóteses mais rígidas ou de predição comportamental com rigor acadêmico, modelam-se relacionamentos através de experimentos estritos.

### Variáveis e Designs
A predição ocorre mapeando as manipulações experimentais:
*   **Variáveis Independentes:** Fatores manipulados e controlados pelo pesquisador (por exemplo, uso do teclado numérico versus painel touch).
*   **Variáveis Dependentes:** O resultado aferido, isto é, as métricas de desempenho (frequência de erros, velocidade em milissegundos, avaliações em questionários).

Os experimentos podem adotar modelos (designs) específicos baseados nos perfis da amostragem (participantes diferentes em cada teste vs. mesmos participantes executando tarefas em interfaces diferentes).

As medidas incluem dados qualitativos, logs, tempo por atividade concluída, quantidade absoluta de desvios, etc. A correta compilação exige a formulação e a apresentação através de métodos estatísticos descritivos e inferenciais para provar ou rejeitar hipóteses.









## O Framework DECIDE
O **DECIDE** é um acrônimo/framework estruturado que orienta o pesquisador a não esquecer os eixos fundamentais do planejamento e da condução sistemática da avaliação de usabilidade. Cada etapa compreende:

*   **D - Determinar os objetivos gerais:** Delimitar o que a avaliação deverá tratar (ex: resolver gargalos de conversão, checar adequação a uma norma).
*   **E - Explorar perguntas específicas:** Questionamentos pragmáticos derivados dos objetivos (quem é o público-alvo, quais suas tarefas contextuais, que ambiente utilizam).
*   **C - Choose (Escolher):** Selecionar o paradigma e as técnicas (teste de laboratório, entrevista, heurística) que possuam o melhor alinhamento entre as perguntas, prazo, orçamento e ferramentas disponíveis.
*   **I - Identificar questões práticas:** Lidar logisticamente com o recrutamento de voluntários, verificação da infraestrutura técnica, definição do perfil, preparo físico da sala e definição do roteiro piloto.
*   **D - Decidir sobre ética:** Cumprir diretrizes éticas sobre o tratamento com as pessoas durante o teste (exigência de consentimento).
*   **E - Evaluate (Examinar/Avaliar):** Realizar a coleta, interpretação e apresentação consolidada dos dados garantindo confiabilidade e validade. Validar se a resposta condiz tecnicamente com a pergunta inicial explorada.




## Questões Éticas na Pesquisa
Nenhuma pesquisa com seres humanos, testes de interface incluídos, deve ser feita sem respeito aos preceitos éticos. 
É indispensável a utilização de um **Termo de Consentimento Livre e Esclarecido (TCLE)** em que:
*   O voluntário seja informado clara e abertamente do propósito e objetivos da atividade.
*   Sejam garantidos a confidencialidade e a privacidade dos dados brutos coletados.
*   Seja garantido o anonimato nas divulgações.
*   Haja solicitação oficial de permissão caso dados como voz, vídeo e face sejam capturados.
*   Assegure-se o direito do indivíduo a declinar e desistir de continuar sem precisar dar explicações e sem sofrer qualquer tipo de represália ou punição.

---
## Referências Bibliográficas e Metodológicas
O conteúdo revisa e embasa técnicas descritas por fundamentações clássicas da área:
*   ISO 9241-11 / ISO 9241-10
*   BARBOSA, S.D.J.; SILVA, B.S. Interação Humano-Computador.
*   PREECE, J.; ROGERS, Y.; SHARP, H. Design de Interação.
*   ROCHA, H.V.; BARANAUSKAS, M.C.C. Design e Avaliação de Interfaces Humano-Computador.
*   NIELSEN, J. Usability Engineering.
