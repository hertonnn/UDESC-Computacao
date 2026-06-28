# Interação Humano-Computador: Interfaces WIMP versus WEB


## A Linguagem do Meio Digital

O meio digital possui uma linguagem própria. Para ilustrar essa diferença, pode-se comparar a experiência de leitura e a disposição das informações em:

*   Um jornal no meio impresso
*   Um jornal no meio digital

A linguagem da nova mídia está em constante descoberta e é essencialmente **mutável**, evoluindo juntamente com o avanço tecnológico e a experiência do usuário.

![Imagem Embutida 1](imagens/WIMP%20e%20Web/slide_3_img_1.jpeg)
![Imagem Embutida 2](imagens/WIMP%20e%20Web/slide_3_img_2.png)

## Estudo de Caso Prático: Design de Interface para Biblioteca

Como exercício de concepção de design de interação, imagine a tarefa de projetar um sistema para uma biblioteca, especificamente a interface onde o usuário fará a consulta de um livro ou artigo. Reflita sobre as seguintes questões:

1.  Que informações são consideradas mais importantes para a realização desta tarefa?
2.  Qual é a mensagem ou o direcionamento que se pretende passar ao usuário durante o uso?
3.  De que forma a tela deveria ser organizada para transmitir essa mensagem de forma clara e eficiente?

## Comparativo: Interfaces WIMP x Interfaces Web

![Imagem Embutida 1](imagens/WIMP%20e%20Web/slide_4_img_1.png)
![Imagem Embutida 2](imagens/WIMP%20e%20Web/slide_4_img_2.png)
![Imagem Embutida 3](imagens/WIMP%20e%20Web/slide_4_img_3.jpeg)
![Imagem Embutida 4](imagens/WIMP%20e%20Web/slide_4_img_4.png)
![Imagem Embutida 5](imagens/WIMP%20e%20Web/slide_4_img_5.jpeg)

A transição e as diferenças entre os estilos de interface clássicos WIMP (*Windows, Icons, Menus, Pointer*) e as interfaces voltadas para a Web envolvem diversos paradigmas, abordados nos tópicos a seguir.

### 1. Dinamicidade na Estrutura

*   **Interfaces WIMP:** Em geral, as estruturas de apresentação e navegação são estáticas e predefinidas pelo sistema ou pela aplicação instalada.
*   **Interfaces Web:** A estrutura e os *links* são inerentemente dinâmicos e diretamente relacionados com a informação exibida. Ou seja, a estrutura da interface e a informação evoluem em paralelo, adaptando-se com maior fluidez ao conteúdo.

### 2. Propriedade e Controle da Aplicação

*   **Interfaces Web:** Os usuários possuem acesso às páginas, mas não são proprietários da aplicação. Como consequência, o sistema pode ser modificado no servidor a qualquer momento, refletindo as alterações instantaneamente sem a necessidade de aviso prévio ou atualização manual pelo usuário.
*   **Interfaces WIMP:** Nas aplicações tradicionais, o usuário tem a posse (ou uma cópia instalada) da aplicação em sua máquina. Dessa forma, caso exista uma insatisfação com a interface, o projetista precisa lançar uma nova versão que o usuário deverá adquirir e instalar para observar a mudança.

### 3. A Figura do Navegador (Browser)

*   **Interfaces WIMP:** O usuário interage diretamente com as aplicações individuais. Existe um programa subjacente — por exemplo, o Sistema Operacional — que assegura a coerência global entre os diversos softwares instalados.
*   **Interfaces Web:** O usuário sempre interage por meio de um *browser* (navegador). Nesse contexto, mudar de um site para outro na mesma janela do navegador equivale funcionalmente a trocar de uma aplicação para outra no desktop tradicional.

### 4. Frequência e Custo de Modificação

*   **Interfaces WIMP:** Uma modificação ou lançamento de versão implica a liberação de muitos recursos, o que torna o processo mais custoso, demandando distribuição e instalação, despendendo muito mais tempo.
*   **Interfaces Web:** A publicação de uma nova versão ou ajuste de layout é barata e imediata para todos os usuários que acessam. As modificações são, em geral, mais fáceis de gerenciar e implementar de forma centralizada.

### 5. Potencial de Falhas e Comportamento do Usuário

*   **Interfaces Web:** O número potencial de falhas é significativamente maior, pois a arquitetura e a tecnologia de comunicação são essencialmente distribuídas. Podem ocorrer falhas de acesso a páginas e o tempo de resposta é variável (dependendo do número de usuários simultâneos, tráfego da rede, carga do servidor, etc.). Quando ocorre uma falha ou instabilidade, o usuário tende a abandonar o ambiente e ir para um site alternativo quase que imediatamente.
*   **Interfaces WIMP:** Diante de um erro ou travamento, os usuários geralmente tentam resolver o problema localmente ou buscam o suporte do software, ficando, de certa forma, mais "presos" ou tolerantes a persistirem no uso da aplicação.

### 6. Dependência do Navegador Adotado

*   **Interfaces Web:** Dependem intrinsicamente de um *browser*, o que faz com que possuam restrições e funcionalidades diferentes das interfaces tradicionais de desktop. Deve-se levar em conta o uso e espaço da janela, a forma de implementação das ligações (*links*), e a distribuição contínua de conteúdo na tela.
*   **Variação Visual e Sobreposição de Funções:** O ambiente visual experimentado pelo usuário pode variar bastante de acordo com o navegador utilizado. Além disso, o próprio navegador oferece controles e funções sobrepostas à aplicação Web (como os botões de voltar, avançar, atualizar, favoritos, etc.), alterando o fluxo de navegação previsto unicamente pela interface do site.

## Referências Bibliográficas

*   SCAPIN, D.; VANDERDONCKT, J.; FARENC, Ch.; BASTIDE, R.; BASTIEN, Ch.; LEULIER, C.; MARIAGE, C.; PALANQUE, Ph. *Transferring Knowledge of User Interfaces Guidelines to the Web*. Proc. of Int. Workshop on Tools for Working with Guidelines TFWWG’2000 (Biarritz, 7-8 October 2000), Springer-Verlag, London, 2000, pp. 293-304, edited by J. Vanderdonckt and C. Farenc, Springer Verlag, ISBN: 1-852233-355-3.
