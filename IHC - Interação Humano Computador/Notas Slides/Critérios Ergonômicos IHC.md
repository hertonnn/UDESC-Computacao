# Critérios Ergonômicos: Técnicas para Desenvolvimento de Interfaces Gráficas


O desenvolvimento de Interfaces Gráficas de Usuário (GUI - *Graphical User Interface*) baseia-se na aplicação de critérios ergonômicos e em princípios de design de sistemas. O foco central é a utilização de técnicas para projetar a estrutura, a interação e a apresentação visual.



---

## Pilares das Técnicas de Interface Gráfica

A estruturação das técnicas de interface gráfica divide-se em três categorias principais:

1. **Estrutura**: Envolve a organização de janelas, caixas de diálogo (*dialog boxes*) e menus.
2. **Interação**: Trata dos elementos que promovem a comunicação direta entre o usuário e o computador.
3. **Apresentação**: Define a exibição visual dos dados, textos, cores e componentes nas telas e janelas.

---

## 1. Estrutura

Os componentes estruturais definem como a interface é organizada e navegada pelo usuário. Os principais elementos incluem janelas primárias e secundárias, caixas de diálogo, abas (*tabs*), menus, barras de menu e barras de ferramentas.

### Janelas Primárias e Secundárias

O comportamento e a disposição das janelas impactam diretamente o fluxo de trabalho do usuário:

*   **Janelas em Cascata**: Devem ser a preferência, pois mantêm os usuários focados em uma tarefa por vez.
*   **Janelas Lado a Lado (*Tiled*)**: Utilizadas quando os usuários precisam visualizar ou comparar informações de janelas diferentes ao mesmo tempo.
*   **Rolagem Horizontal**: Deve ser evitada ao máximo.
    *   Sempre que possível, aumente o tamanho da janela para exibir todo o conteúdo.
    *   Utilize mais de uma janela ou recorra ao uso de guias/abas (*tabs*).
    *   Permita maximizar a tela, dar zoom ou "desmontar" (*tear-off*) o painel para mostrar informações de forma direcionada.

![Janelas em cascata](imagens/Critérios%20Ergonômicos%20IHC/slide_6_img_1.png)
![Janelas lado a lado](imagens/Critérios%20Ergonômicos%20IHC/slide_6_img_2.png)

#### Dimensões e Comportamento de Janelas Secundárias

*   **Redimensionamento**: Evite que o usuário seja obrigado a redimensionar as janelas para conseguir visualizá-las corretamente.
*   **Tamanhos Relativos**: As janelas secundárias não precisam, necessariamente, ter o mesmo tamanho da primária ou entre si.
*   **Janelas *Pop-up***: As caixas de diálogo e janelas *pop-up* devem ser sempre abertas no **centro** da área (ou da ação) com a qual estão relacionadas na aplicação, mantendo o foco visual do usuário.

### Agrupamento de Informações e Uso de Abas (Tabs)

Ao criar formulários e telas de cadastro, é fundamental aplicar lógicas claras de agrupamento.

*   **Agrupamento por Contexto**: Informações correlatas devem ficar próximas. Por exemplo, "Endereço e Fone 1" não devem ficar desconexos visualmente de "Endereço e Fone 2".

![Exemplo de agrupamento falho](imagens/Critérios%20Ergonômicos%20IHC/slide_8_img_1.png)

*   **Uso Consistente de Guias (*Tabs*)**: Todos os cartões (guias/abas) de um formulário devem estar relacionados ao mesmo objeto de domínio (ex: "Membro").
*   **Evitar Inconsistências**: Guias de funcionalidades externas (ex: "Configura Impressora") não devem estar misturadas a propriedades de um objeto ("Membro").

![Guias relacionadas ao objeto](imagens/Critérios%20Ergonômicos%20IHC/slide_9_img_1.png)
![Guia não relacionada ao contexto](imagens/Critérios%20Ergonômicos%20IHC/slide_10_img_1.png)

![Botões típicos de janela principal](imagens/Critérios%20Ergonômicos%20IHC/slide_11_img_1.png)

### Menus e Barras de Menu

Os menus representam a principal estrutura de navegação e descoberta de funcionalidades de um software.

#### Identificação e Formatação

*   **Significado**: Assegure-se de que os rótulos escolhidos façam sentido direto para os usuários. Identifique os itens cuidadosamente.
*   **Adaptabilidade**: Os menus podem e devem ser alterados dinamicamente conforme o contexto em que o usuário se encontra na aplicação.
*   **Capitalização**:
    *   **Barra de Menu (Topo)**: Primeira letra maiúscula, restante da palavra em minúsculas (Ex: *Arquivo*).
    *   **Menus *Drop-Down***: As iniciais das palavras principais devem ser maiúsculas (Ex: *Salvar Como...*).
*   **Padronização**: Siga os padrões consolidados de mercado para a localização e nomenclatura dos menus (Ex: "Arquivo", "Editar", "Exibir" sempre nessa ordem).

![Padrão Windows (Arquivo)](imagens/Critérios%20Ergonômicos%20IHC/slide_14_img_1.png)
![Padrão Windows (Editar)](imagens/Critérios%20Ergonômicos%20IHC/slide_14_img_2.png)
![Padrão OS/2 (Arquivo)](imagens/Critérios%20Ergonômicos%20IHC/slide_15_img_1.png)
![Padrão OS/2 (Editar)](imagens/Critérios%20Ergonômicos%20IHC/slide_15_img_2.png)

#### Comportamento da Barra de Menu

*   **Fluxo de Trabalho**: A organização da barra deve acompanhar o fluxo natural das atividades.
*   **Tamanho dos Rótulos**: Utilize, preferencialmente, **apenas uma palavra** para os itens da barra de menu superior.
*   **Layout em Linha Única**: A barra de menu deve ocupar estritamente **uma única linha** horizontal. Se necessário, agrupe mais itens em submenus em vez de quebrar a linha principal.
*   **Evitar Desabilitação (*Gray out*)**: Na barra superior, evite exibir um item raiz desabilitado. Se for necessário omiti-lo por falta de permissão/contexto, simplesmente não o apresente. As desabilitações devem ficar restritas aos itens internos (do menu *drop-down*).
*   **Não Iniciar Ações Diretas**: Itens da barra principal devem servir unicamente para abrir submenus, e não para acionar comandos (ações imediatas).

![Exemplo de barra de menu incorreta 1](imagens/Critérios%20Ergonômicos%20IHC/slide_17_img_1.png)
![Exemplo de barra de menu incorreta 2](imagens/Critérios%20Ergonômicos%20IHC/slide_17_img_2.png)

### Menus Drop-Down (Lista Suspensa)

*   **Quantidade Mínima**: Um menu suspenso deve conter no mínimo **dois itens**. Se houver apenas um subitem, ele deve ser remanejado ou agrupado em outro menu principal.
*   **Nomenclatura Única**: Não inicie o nome dos subitens utilizando a mesma palavra do item raiz da barra de menu. (Ex: Se o menu é "Imprimir", não nomeie os subitens como "Imprimir Rascunho", "Imprimir Final" — use "Rascunho", "Final").
*   **Agrupamento e Separação**: Utilize **linhas separadoras** horizontais para agrupar funcionalidades logicamente afins dentro da mesma lista.

![Agrupamento em drop-down](imagens/Critérios%20Ergonômicos%20IHC/slide_20_img_1.png)
![Nomenclatura de subitens](imagens/Critérios%20Ergonômicos%20IHC/slide_20_img_2.png)

*   **Tamanho Limitado**: O comprimento do menu deve exibir tudo em no máximo **uma tela**. Evite barras de rolagem vertical (*scroll*) dentro de menus; prefira cascatear categorias adicionais.
*   **Priorização**: Posicione tarefas mais frequentes ou críticas no topo do menu.
*   **Profundidade Restrita**: Não utilize mais de **dois níveis** de profundidade em menus encadeados (*cascata*), pois isso dificulta a precisão motora do mouse e confunde o usuário.

![Cascata profunda demais](imagens/Critérios%20Ergonômicos%20IHC/slide_22_img_1.png)

#### Indicadores Visuais e Atalhos

*   **Reticências ("...")**: Sempre que uma ação necessitar de mais dados (abrir um formulário ou diálogo secundário para prosseguir), insira três pontos ao final do nome do item.
*   **Teclas Aceleradoras (Atalhos)**:
    *   Utilize teclas de atalho com moderação, associando-as apenas às ações mais frequentes.
    *   Mantenha fidelidade total aos padrões de mercado (Ex: `Ctrl+C` para copiar, `Ctrl+V` para colar).

![Símbolo de reticências no menu](imagens/Critérios%20Ergonômicos%20IHC/slide_24_img_1.png)
![Atalhos em menu de edição](imagens/Critérios%20Ergonômicos%20IHC/slide_25_img_1.png)

### Menus Pop-Up (Contextuais)

Os menus *pop-up* (abertos via clique direito, por exemplo) fornecem ações frequentes, rápidas e relativas a um objeto específico ou contexto particular da tela.
**Atenção**: Uma boa prática ergonômica dita que os comandos ali presentes também **devem estar disponíveis em locais alternativos** (nos menus principais ou barra de ferramentas), garantindo a acessibilidade.

![Menu Pop-Up](imagens/Critérios%20Ergonômicos%20IHC/slide_27_img_1.png)

### Barra de Ferramentas (Toolbars)

*   **Itens Ativos**: Devem exibir predominantemente os itens ativos. Itens não pertinentes ao contexto atual devem ser indisponibilizados visualmente (*gray out*) ou ocultados.
*   **Personalização**: O usuário deve ter autonomia para mover, desativar ou adicionar botões à barra de ferramentas conforme suas preferências e fluxos de trabalho.
*   **Uso de *Tooltips***: Essencial. Rótulos flutuantes que surgem ao passar o mouse sobre o ícone, explicando a função do botão.
*   **Agrupamento**: A organização visual (espaçamentos e divisórias) deve aproximar itens com propósitos correlatos.

![Exemplo de Tooltip](imagens/Critérios%20Ergonômicos%20IHC/slide_30_img_1.png)

---

## 2. Interação

O pilar de interação foca em como o usuário transmite comandos e seleciona opções dentro do sistema, utilizando controles dedicados.

### Botões de Comando (Command Buttons)

*   **Frequência e Criticidade**: Botões de comando devem ser aplicados somente para ações frequentes ou conclusivas (ex: "Salvar", "Cancelar"). Recomenda-se limitar a no máximo 6 botões globais por janela.
*   **Clareza e Padrão**: Iniciais maiúsculas, seguindo jargões padronizados do mercado.
*   **Tamanho Uniforme**: Os botões em um agrupamento devem ter larguras idênticas, ditadas pelo tamanho do maior rótulo. Se os textos variarem drasticamente a ponto de inviabilizar um tamanho único, utilize **no máximo dois tamanhos distintos**.
*   **Espaçamento**: Jamais grude os botões em outros campos ou elementos; preserve o "respiro" visual (*whitespace*).

![Botões de Comando - Exemplo](imagens/Critérios%20Ergonômicos%20IHC/slide_34_img_1.png)
![Botões de tamanhos iguais](imagens/Critérios%20Ergonômicos%20IHC/slide_36_img_1.png)
![Botões de tamanhos variados](imagens/Critérios%20Ergonômicos%20IHC/slide_36_img_2.png)
![Botões bem espaçados](imagens/Critérios%20Ergonômicos%20IHC/slide_37_img_1.png)
![Botões sem espaçamento](imagens/Critérios%20Ergonômicos%20IHC/slide_37_img_2.png)

#### Disposição e Fluxo

*   Agrupe os botões caso tenham similaridade semântica de funções.
*   O posicionamento dos botões de encerramento da tela deve espelhar o **fluxo de leitura (Z-Pattern / F-Pattern)**:
    *   **Fluxo Horizontal**: Botões no canto superior direito.
    *   **Fluxo Vertical**: Botões alinhados na base inferior da janela.
*   **Contexto Específico**: Se um botão realizar ação apenas em um trecho ou objeto (Ex: Pesquisar CEP), ele deve ficar o mais próximo possível desse campo, e não junto aos botões globais da janela.
*   **Ordem Consistente**: Sempre apresente ações parecidas na mesma ordem (Ex: "OK" à esquerda, "Cancelar" à direita).
*   **Botão Padrão (*Default*)**: Defina qual botão tem a ação principal pré-selecionada. **Nunca** coloque um botão de destruição (como "Excluir") como padrão, para evitar perdas acidentais de dados.
*   **Desabilitação Contextual**: Utilize o esmaecimento (*gray out*) para deixar claro quais botões não têm efeito no estado atual.

![Botões agrupados](imagens/Critérios%20Ergonômicos%20IHC/slide_39_img_1.png)
![Fluxo horizontal](imagens/Critérios%20Ergonômicos%20IHC/slide_40_img_1.png)
![Fluxo vertical](imagens/Critérios%20Ergonômicos%20IHC/slide_41_img_1.png)
![Botão local](imagens/Critérios%20Ergonômicos%20IHC/slide_43_img_1.png)
![Posicionamento Padrão](imagens/Critérios%20Ergonômicos%20IHC/slide_44_img_1.png)

### Radio Buttons (Botões de Opção)

*   **Finalidade Exclusiva**: Utilizados **unicamente** quando, dentro de uma lista de opções visíveis, **apenas uma escolha** é permitida (mutuamente excludentes).
*   **Limites Ergonômicos**: Recomenda-se um máximo de **6 opções**. Se o leque for maior, é preferível o uso de *List Boxes* (Listas Suspensas) ou *Drop-Downs*.
*   **Agrupamento Visual**: Devem ser agrupados explicitamente sob um rótulo que defina o contexto das escolhas.
*   **Alinhamento**: A disposição preferencial é a **vertical**, facilitando o rastreamento visual e clique.
*   **Ordenação**: Estabeleça um critério claro (por frequência de escolha, por sequência de tarefas, ordem lógica ou alfabética).
*   **Má Prática**: Nunca utilize *Radio Buttons* para opções booleanas isoladas ("Sim / Não", "Ativo / Inativo"). A ferramenta correta para isso é o *Check Box* ou um comutador (*Toggle*).

![Alinhamento Vertical Radio](imagens/Critérios%20Ergonômicos%20IHC/slide_47_img_1.png)
![Alinhamento Horizontal Radio](imagens/Critérios%20Ergonômicos%20IHC/slide_47_img_2.png)
![Checkbox para Sim/Não](imagens/Critérios%20Ergonômicos%20IHC/slide_49_img_1.png)
![Uso errado de Radio Button](imagens/Critérios%20Ergonômicos%20IHC/slide_49_img_2.png)

### Check Boxes (Caixas de Seleção)

*   **Finalidade**: Aplicados para casos onde **múltiplas escolhas** simultâneas são permitidas.
*   **Limites Ergonômicos**: Recomenda-se um máximo de **10 opções**. Para listas mais extensas, considere o emprego de *List Boxes de múltipla seleção*.
*   **Apresentação e Disposição**: Seguem as mesmas regras dos *Radio Buttons*: alinhamento preferencial na vertical, agrupamento lógico com rótulo geral e ordenação inteligente (tarefa, lógica, alfabética).

![Alinhamento Vertical Checkbox](imagens/Critérios%20Ergonômicos%20IHC/slide_51_img_1.png)
![Alinhamento Horizontal Checkbox](imagens/Critérios%20Ergonômicos%20IHC/slide_51_img_2.png)

### Text Boxes (Caixas de Texto)

As caixas de texto exigem pistas visuais que comuniquem instantaneamente seu estado de interação:

*   **Campos Editáveis**: Sempre utilize bordas definidas para deixar evidente que o espaço permite inserção de dados.
*   **Campos de Leitura**: Não utilize bordas afundadas ou caixas delimitadoras, fazendo com que dados puramente informativos (apenas leitura/display) fiquem com a aparência plana e protegida.
*   **Campos Protegidos**: Descolorir o preenchimento ou aplicar máscaras acinzentadas (*gray out*) para sinalizar campos inativos que não podem receber edição no momento.

![Borda para entrada de dados](imagens/Critérios%20Ergonômicos%20IHC/slide_54_img_1.png)
![Sem borda para display](imagens/Critérios%20Ergonômicos%20IHC/slide_54_img_2.png)
![Dados mutáveis](imagens/Critérios%20Ergonômicos%20IHC/slide_54_img_3.png)
![Dados imutáveis](imagens/Critérios%20Ergonômicos%20IHC/slide_54_img_4.png)

#### Formatação Física e Agrupamento

*   **Tamanhos Padronizados**: Quando possível, uniformize a largura das caixas de texto de um formulário. A exceção se aplica a campos cujo tamanho semântico seja estrito e previsível (Ex: campo de "UF" precisando ter espaço apenas para 2 letras).
*   **Posição dos Rótulos (*Labels*)**:
    *   Posicione o texto à **esquerda** da caixa de entrada, seguido por dois-pontos (":").
    *   Evite posicionar *labels* acima da caixa em todas as linhas, criando formulários muito longos e esticados sem necessidade.
    *   Os *labels* e caixas devem possuir um alinhamento unificado pela esquerda para reduzir o número de quebras de margem visual, poupando esforço cognitivo do leitor.

![Tamanhos iguais](imagens/Critérios%20Ergonômicos%20IHC/slide_56_img_1.png)
![Tamanho por contexto real](imagens/Critérios%20Ergonômicos%20IHC/slide_56_img_2.png)
![Alinhamento à esquerda correto](imagens/Critérios%20Ergonômicos%20IHC/slide_58_img_1.png)
![Alinhamento incorreto](imagens/Critérios%20Ergonômicos%20IHC/slide_58_img_2.png)

### List Boxes (Caixas de Listagem)

Substitutos diretos para conjuntos longos de *Radio Buttons*.

*   **Quantidade Visível**: A janela do controle deve exibir de 3 a 8 itens por vez sem precisar de rolagem intensa.
*   **Rótulo**: Fica acima da lista (ao contrário das caixas de texto), à esquerda, seguido de dois-pontos.
*   **Tratamento de Listas Longas**: Se a lista exceder 40 itens, é altamente recomendado a inclusão de um mecanismo de **filtro** de busca embutido.
*   **Uso Otimizado do Espaço**: Utilize caixas *drop-down* (listas retraídas) para poupar espaço em tela, sobretudo se o primeiro item ou opção padrão for responsável pela maioria estatística das seleções.

![Exemplo de List Box](imagens/Critérios%20Ergonômicos%20IHC/slide_61_img_1.png)
![Uso de Filtros na Lista](imagens/Critérios%20Ergonômicos%20IHC/slide_63_img_1.png)

#### List Boxes de Múltipla Seleção

Alternativa ao excesso de *Check Boxes*. Uma prática ergonômica excelente para longas matrizes de múltipla seleção é o uso da arquitetura de duas listas ("Listas Gêmeas" / *Transfer List*): uma contendo as opções disponíveis e um **Box secundário exibindo apenas os itens já selecionados**, o que viabiliza e simplifica a conferência rápida do usuário.

![Box de itens selecionados (Transfer List)](imagens/Critérios%20Ergonômicos%20IHC/slide_65_img_1.png)

### Tabelas e Grids (Matrizes)

Utilizadas massivamente para ordenação, leitura transversal e comparação. Tabelas de *Seleção* permitem marcar registros específicos em lotes.

*   **Cabeçalhos**: Definir nomes sucintos e representativos para as colunas.
*   **Rótulos nas Linhas**: Devem ser aplicados apenas se as linhas contiverem entidades ou categorias fundamentalmente distintas.
*   **Regras de Alinhamento na Tabela**:
    *   **Números Inteiros/Moeda**: Alinhamento à direita.
    *   **Números com Decimais**: Alinhamento fixo pela posição da vírgula/ponto decimal.
    *   **Texto/Alfabéticos**: Alinhamento à esquerda.
    *   **Datas e Horários**: Seguir estritamente os formatos padronizados (dia, mês, ano / hora, minuto, segundo).

![Exemplo de Tabela/Grid](imagens/Critérios%20Ergonômicos%20IHC/slide_68_img_1.png)
![Exemplo Especial: Calendário](imagens/Critérios%20Ergonômicos%20IHC/slide_68_img_2.png)

### Spin Boxes (Botões de Variação)

Campo de texto ou numérico dotado de setas incrementais adjacentes. É indicado para navegar ciclicamente em listas cujos valores são lógicos, restritos e previsíveis (Ex: dias da semana, meses do ano, controle de incremento numérico). 
Caso o limite de itens supere 10, o *Spin Box* precisa, obrigatoriamente, permitir a digitação de texto direto (*Text Box* associado) para atalhar o preenchimento.

![Exemplo de Spin Box](imagens/Critérios%20Ergonômicos%20IHC/slide_69_img_1.png)

### Tree Views (Visão Hierárquica em Árvore)

Elemento que exibe metadados de forma encadeada, suportando nós com categorias-pai e filhos. É extremamente útil quando compreender a cadeia hierárquica facilita a navegação até o item.
**Cuidado**: Jamais utilize elementos em árvore como tela inicial ("home base") da aplicação ou como única substituição forçada para o menu de navegação global.

![Tree View](imagens/Critérios%20Ergonômicos%20IHC/slide_71_img_1.png)

---

## 3. Apresentação

O pilar de apresentação discute a ergonomia cognitiva visual, moldando como as informações são dispostas na tela: layout, escolhas tipográficas, ícones, cores e linguagem.

### Layout das Telas

*   **Tela Base ("Home")**: Crie sempre uma "ancoragem" principal e útil para o usuário. A tela base da aplicação pode ser uma visualização consolidada de informações (*dashboard*), um formulário pronto para preenchimento ou um painel de listagem de tarefas. **Evite telas vazias** contendo apenas menus ou um logotipo central isolado, pois causam desorientação e obrigam passos extras.

![Tela Vazia - Incorreto](imagens/Critérios%20Ergonômicos%20IHC/slide_75_img_1.png)
![Somente título - Incorreto](imagens/Critérios%20Ergonômicos%20IHC/slide_76_img_1.png)
![Tela de seleção (Base adequada)](imagens/Critérios%20Ergonômicos%20IHC/slide_77_img_1.png)
![Formulário de preenchimento (Base adequada)](imagens/Critérios%20Ergonômicos%20IHC/slide_78_img_1.png)

*   **Fluxo Consistente de Janela**:
    *   O percurso de leitura deve seguir um fluxo harmonioso (vertical ou horizontal), não devendo ser abruptamente interrompido e misturado na mesma interface.
    *   **Fluxo Horizontal**: Dados essenciais/críticos no topo, menos críticos nas seções inferiores; ações e botões localizados no topo, à direita.
    *   **Fluxo Vertical**: Dados críticos mantidos na área primária e de origem da leitura (coluna esquerda); ações/botões mantidos na parte inferior.
    *   **Minimizar Margens**: Agrupe itens correlatos aplicando contornos visuais (painéis/boxes) e espaços em branco. Acima de tudo, **alinhe os blocos e rótulos** para eliminar o excesso de margens irregulares soltas pela tela, o que fadiga a visão.

![Fluxo horizontal](imagens/Critérios%20Ergonômicos%20IHC/slide_81_img_1.png)
![Fluxo vertical](imagens/Critérios%20Ergonômicos%20IHC/slide_82_img_1.png)
![Alinhamento de Margens e Agrupamentos](imagens/Critérios%20Ergonômicos%20IHC/slide_84_img_1.png)

### Imagens, Simbologia e Ícones

Empregadas para propiciar um rápido reconhecimento intuitivo e funcionarem como atalhos mentais, especialmente em ações difíceis de serem descritas apenas de forma textual. 

Modelos de representação icônica:
*   **Objeto Direto**: Usa o desenho explícito do objeto (Ex: figura do disquete para *Salvar*).
*   **Ação / Efeito**: Indica a consequência visual de uma função (Ex: pessoa correndo para indicar "rápido" ou "aceleração").
*   **Ferramenta Indicando Ação**: A imagem da ferramenta do mundo físico (Ex: uma régua remetendo à ação de *Medição*).
*   **Analogia Física**: O objeto transfere seu propósito mental (Ex: Lupa de aumento para representar *Zoom* ou busca).
*   **Símbolos Culturais Comuns**: Elementos padronizados de vivência global (Ex: O "proibido", com um traço atravessado sobre um círculo).
*   **Aviso**: Por maior que pareça a intuição do *designer*, imagens mais complexas exigem testes práticos com o usuário para garantir seu rápido reconhecimento.

![Símbolo - Objeto](imagens/Critérios%20Ergonômicos%20IHC/slide_86_img_1.png)
![Símbolo - Ação](imagens/Critérios%20Ergonômicos%20IHC/slide_86_img_2.png)
![Símbolo - Ferramenta](imagens/Critérios%20Ergonômicos%20IHC/slide_86_img_3.png)
![Símbolo - Analogia](imagens/Critérios%20Ergonômicos%20IHC/slide_86_img_4.png)
![Símbolo - Proibição](imagens/Critérios%20Ergonômicos%20IHC/slide_86_img_5.png)

### Escolha e Limite de Fontes (Tipografia)

*   **Fontes Sem Serifa**: Para uso digital, as fontes limpas (como *Arial* e *Helvetica*) são as mais recomendadas, por garantirem alta definição e legibilidade da tela.
*   **Fontes Com Serifa**: Famílias serifadas, como *Times New Roman*, não possuem boa definição luminosa em leituras nativas e atrasam a fluência das palavras, devendo ser evitadas fora da área impressa.
*   **Práticas Restritas**:
    *   Não utilize textos discursivos formatados continuamente em *itálico* ou sublinhado, que sobrecarregam e distorcem a base visual.
    *   Utilize variação de tamanhos com responsabilidade. Intercalar tamanhos distintos repetidas vezes na mesma seção quebra as âncoras da hierarquia.
    *   **Contraste e Cor**: Fontes altamente coloridas dispersam o foco. A melhor legibilidade advém de fontes escuras sobre um fundo claro. Use apenas o **negrito** e tamanho de peso quando precisar efetivamente chamar a atenção para títulos ou campos de notificação.

![Fonte recomendada](imagens/Critérios%20Ergonômicos%20IHC/slide_88_img_1.png)
![Fonte não recomendada](imagens/Critérios%20Ergonômicos%20IHC/slide_89_img_1.png)
![Excesso de tamanhos na tela](imagens/Critérios%20Ergonômicos%20IHC/slide_91_img_1.png)

### Redação, Textos e Layout de Blocos

*   **Justificação e Alinhamento**: Aplique alinhamento justificado apenas pela **margem esquerda**. O texto totalmente justificado nas duas extremidades forma "rios brancos" ou lacunas esquisitas.
*   **Caixa Alta**: É exaustivo ler blocos formados totalmente por letras MAIÚSCULAS. Evite usar esse recurso fora de chamamentos curtos e avisos capitais.
*   **Linguagem Simples**: Use redação clara, acessível ao perfil dos seus usuários, omitindo vocabulários excessivamente rebuscados sem necessidade.
*   **Espaçamento Textual**: Evite ao máximo a hifenização (quebras artificiais com hífen para forçar o tamanho da linha). Parágrafos devem ser bem espaçados, tipicamente com uma linha em branco de distanciamento entre blocos de mesma importância.
*   **Comprimento de Linha**: A varredura ocular atinge a fadiga caso atravesse telas imensas. A ergonomia de leitura recomenda restrições como **55 caracteres por linha** no leiaute principal e cerca de **35 caracteres por linha** quando diagramado em formato de colunas.

### Uso Inteligente de Cores

*   **Significação**: A aplicação das cores em sistemas atende não a requisitos puramente estéticos (decorativos), mas **funcionais**: transmitir informações essenciais de status, atrair o foco ou indicar contraste de estado do objeto da interface.
*   **Código Controlado**: A paleta interativa geral de um software ergonômico não deve possuir mais de 10 ou 11 opções de cores lógicas e recorrentes.
*   **Fundos (*Backgrounds*)**: Prefira tons absolutamente neutros (branco, cinza claro e pastéis) para áreas base.
*   **Primeiro Plano (*Foregrounds*)**: O foco e os elementos interativos são preenchidos por contornos e preenchimentos escuros e definidos (preto, azul marinho/escuro).
*   **Personalização**: Para acessibilidade e adaptação, deve-se possibilitar sempre que o usuário possa reajustar (em um painel de tema ou configurações) as matrizes cromáticas do sistema.

---

## Referências Bibliográficas

*   **CYBIS, W; Betiol, A.; FAUST, R.** – *Ergonomia e Usabilidade: Conhecimentos, Métodos e Aplicações.* Novatec, 2007/2010.
*   **BASTIEN, J. M. Christian; SCAPIN, Dominique L.** – *Ergonomic Criteria for the Evaluation of Human-Computer Interfaces.*
*   **SCHUMHMACHER, Vera R. N.** – *Guia de Estilos para Seleção de Objetos de Interação.*
*   **Apostila: Abordagem ergonômica para IHC** – Utilizada como base conceitual acadêmica de IHC.
*   **Ergolist** – Compilação unificada de critérios ergonômicos e listas de heurísticas em laboratório de usabilidade.
