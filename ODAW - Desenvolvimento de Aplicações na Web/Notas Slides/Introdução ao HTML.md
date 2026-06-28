# Introdução ao HTML

## O que é HTML?



* **HTML** significa *HyperText Markup Language* (Linguagem de Marcação de Hipertexto).
* Trata-se de uma linguagem para criar páginas Web.
* É formada por textos e comandos chamados de **Tags**.
* **Finalidade:**
  * Formatar textos e imagens.
  * Criar ligações (links) entre páginas Web.
  * Criar documentos baseados no conceito de Hipertexto.

---

## Funcionamento Básico



* O programador escreve o código-fonte seguindo as regras de sintaxe da linguagem.
* Esse código é interpretado pelo navegador (browser).
* O navegador executará os comandos ou tags do código para formatar e acessar recursos da Web.
* Existem vários programas para editoração HTML. Inicialmente, usaremos o **Bloco de Notas**.



* As tags irão dizer ao browser como o texto, a informação e as imagens serão exibidas na tela (ex: negrito, itálico, tipo de fonte, link, etc).
* A sintaxe básica de uma tag é: `<Nome do tag> Texto </Nome do tag>`.
* Não é necessário estar conectado à Web para visualizar o resultado.
* Basta salvar o arquivo com a extensão `.HTM` ou `.HTML` e abri-lo com o navegador.

---

## Estrutura Básica do Documento HTML



* A tag `<html>` é usada em conjunto com seu tag de fechamento `</html>`.
* Ela marca o início e o final do documento, delimitando a área onde serão colocados os demais tags HTML.
* As tags `<head>` e `</head>` servem para delimitar uma área de cabeçalho, que conterá poucas tags. Não é estritamente obrigatório ter essa tag para a página funcionar, mas é uma boa prática.



* A tag `<title> título </title>` é usada dentro da seção `<head>`.
* Ela servirá para colocar um título que aparecerá na barra de título do navegador.



* As tags `<body>` e `</body>` representam o corpo da página.
* Dentro delas serão colocados todos os comandos, textos e imagens da sua página.
* **Comentários:**
  * Podem ser inseridos com a tag `<! >`.
  * Exemplo: `<! comentário qualquer >`.

### Exemplo de Estrutura



```html
<html>  
  <head>  
    <title> Título da página </title>  
  </head>  
  <body>  
    Aqui você coloca os comandos em HTML, seus Textos e Imagens.  
  </body>  
</html> 
```



**Exercício Prático:**
* Faça o exemplo acima.
* Salve-o como `TESTE.HTML`.
* Abra-o com o navegador.

---

## Formatação de Texto

### Cabeçalhos



* As tags `<h1>` até `<h6>` (e seus respectivos fechamentos `</h1>` ... `</h6>`) servem para criar uma espécie de cabeçalho com padrões de formatação prontos.
* Eles aplicam negrito e um determinado tamanho à fonte, além de adicionar uma linha em branco após o texto.
* Após a tag `H` deve vir um número de 1 a 6 indicando o tamanho do cabeçalho.
* O número 1 indica o maior tamanho e o 6, o menor.
  * `<h1> Cabeçalho Grande </h1>`
  * `<h6> Cabeçalho Pequeno </h6>`

### Alinhamento e Parágrafos



* As tags `<center>` e `</center>` são utilizadas para centralizar um texto, uma imagem ou qualquer outro elemento da página.
  * Exemplo: `<center> Essa frase está centralizada na página </center>`
* A tag `<p>` é responsável pela quebra de parágrafos.
  * Ela iniciará um novo parágrafo e pulará uma linha entre o texto anterior e o novo.
  * Exemplo: `Texto Texto <p>`

### Quebras de Linha e Linhas Horizontais



* A tag `<br>` quebra a linha e continua o texto na linha seguinte sem pular uma linha em branco.
  * Exemplo: `Texto Texto <br>`



* A tag `<hr>` cria uma linha horizontal.
* Serve como uma quebra visual entre um item de informação e outro.
* Possui atributos de largura e espessura (altura):
  * Exemplo: `<hr size="8" width="80%">`
  * O atributo `width` indica que a linha ocupará 80% da largura da janela do browser.
  * O atributo `size` indica que a linha será exibida com 8 pixels de espessura.

### Estilos de Fonte



Você pode criar uma série de efeitos no texto, alterando a forma ou o tipo da fonte. Tags de formatação e estilo de texto devem ter seu respectivo tag de fechamento.



* **Negrito:** `<b> Texto </b>`
* **Itálico:** `<i> Texto </i>`
* **Sublinhado:** `<u> Texto </u>` (Internet Explorer)
* **Letreiro:** `<marquee> Texto </marquee>`
* **Pulsante (Blink):** `<blink> Texto </blink>`

### Tag Font



* As tags `<font>` e `</font>` servem para formatar as fontes da página.
* A tag `font` pode ser usada com seus complementos (atributos): `face`, `color` e `size`.
* `<font face="FONTE">`: Define o tipo de fonte (recomenda-se usar fontes padrão).
  * Exemplo: `<font face="TIMES"> Coloque aqui seu texto </font>`



* `<font size="TAMANHO DA FONTE">`: Define o tamanho da fonte (varia de 1 a 6).
  * `<font size="+3"> Irá deixar o texto com o tamanho 6 </font>`
  * `<font size="3"> Irá deixar seu texto com o tamanho 3 </font>`



* `<font color="COR">`: Aplica uma cor na fonte escolhida.
* Utiliza o padrão de cores RGB. A cor padrão do texto é preta.
* Pode ser definido com o nome da cor em inglês ou com o código hexadecimal.
  * `<font color="BLACK"> Veja um texto preto! </font>`



* Exemplo combinando atributos:
  * `<font face="ARIAL" color="RED" size="3"> TEXTO EXEMPLO !!!! </font>`
* Lembre-se de fechar a tag com `</font>` para que a formatação seja aplicada apenas ao texto escolhido e não em toda a página.

---

## Cores de Fundo da Página



* O atributo `bgcolor` pode ser adicionado à tag `<body>` para colocar uma cor de fundo em sua página.
  * `<body bgcolor="COR">`
* A cor pode ser escrita em inglês ou usando o código hexadecimal RGB (Red/Green/Blue).
  * `<body bgcolor="RED">` ou `<body bgcolor="#FF0000">`
  * `<body bgcolor="YELLOW">` ou `<body bgcolor="#FFFF00">`



### Tabela de Cores

| Cor (Inglês) | Português | Código Hexadecimal |
| :--- | :--- | :--- |
| Black | Preto | `#000000` |
| White | Branco | `#FFFFFF` |
| Yellow | Amarelo | `#FFFF00` |
| Blue | Azul | `#0000FF` |
| Green | Verde | `#00FF00` |
| Dark Green | Verde escuro | `#2F4F2F` |
| Red | Vermelho | `#FF0000` |
| Magenta | Rosa | `#FF00FF` |
| Cyan | Ciano | `#00FFFF` |

*Referência de cores:* `http://erikasarti.net/html/tabela-cores/`


![Imagem Embutida 2](imagens/Introdução%20ao%20HTML/slide_22_img_2.png)

---

## Inserindo Imagens



* Os formatos de imagem mais comuns suportados são GIF e JPEG.
* Usa-se a tag `<img>` com o atributo `src`.
  * `<img src="Nome da imagem.GIF">` ou `<img src="Nome da imagem.JPG">`
* Se a imagem estiver num diretório diferente do arquivo do documento:
  * `<img src="../figuras/carta.gif">`



### Exemplo com a tag `img`

```html
<html>  
  <head>  
    <title> Teste com a tag img</title>  
  </head>  
  <body>  
    <h1> 
      <center>Imagem</h1> 
        <img src="imagem.GIF"> 
      </center> 
  </body>  
</html> 
```



* **Alinhamento e Título de Imagens:**
  * `<img src="imagem.GIF" align="LEFT">`: Alinha a imagem à esquerda da página.
  * `<img src="imag.GIF" align="RIGHT">`: Alinha a imagem à direita da página.
  * O atributo `title` define um texto explicativo que aparece ao passar o mouse sobre a imagem.
    * `<img src="imagem.GIF" align="LEFT" title="texto sobre a imagem">`

### Imagem como Fundo da Página



* O atributo `background` na tag `<body>` define imagens como papel de parede para o fundo da página.
  * `<body background="IMAGEM.GIF">`
* O fundo da página acompanhará o movimento da tela (scroll).
* Com a adição de `bgproperties="FIXED"`, o fundo da página ficará estático e apenas o conteúdo irá rolar:
  * `<body background="PISO.GIF" bgproperties="FIXED">`

---

## Links e Navegação

### Âncoras



* A âncora é usada dentro do documento para marcar o início de uma seção.
* Você nomeia uma seção da sua página através da tag:
  * `<a name="NOME_DA_ANCORA"> Texto </a>`
* Depois disso, escreva o conteúdo associado a esse nome.
* Para criar um link que leva diretamente até esse local, use a tag:
  * `<a href="#NOME_DA_ANCORA">Clique Aqui</a>`
* Ao clicar na mensagem "Clique Aqui", o navegador irá rolar até a seção nomeada. O sinal `#` avisa ao browser para procurar o link dentro do documento atual.

### Linkando Arquivos



* **Arquivos Locais:** É a ligação de um texto com outra página, figura ou outros arquivos que estejam na mesma pasta que o seu documento atual.
  * `<a href="página.html"> Clique aqui para ir à próxima página </a>`
  * `<a href="página1.HTM#index"> Vai para a ancora INDEX </a>`



* **Arquivos de Outros Diretórios:** Para especificar o endereço em outras pastas, utilize a barra `/` para separar diretórios (padrão Web).
  * O navegador usa como referencial o diretório atual do arquivo HTML.
  * `../` é usado para subir um nível hierárquico.
    * `<a href="../TESTE/INDEX.HTM">`
  * Para navegar a um diretório abaixo do atual, apenas cite a pasta:
    * `<a href="TESTE/INDEX.HTM">`



* **Arquivos de Outros Servidores:**
  * `<a href="http://www.joinville.udesc.br"> Página do CCT</a>`
* **Link para E-mail:**
  * `<a href="mailto:xyz@algumlugar.br">`
  * Ao ser selecionado, abrirá o programa de e-mail padrão do usuário para composição de uma mensagem eletrônica direcionada ao endereço digitado após `mailto:`.

### Configurando Cores dos Links



* No elemento `<body>` você pode definir as cores padrão dos textos e dos diferentes estados dos links usando os seguintes atributos (com códigos hexadecimais de cor, por exemplo):
  * `<body text="#rrggbb" link="#rrggbb" vlink="#rrggbb" alink="#rrggbb">`
  * `text` = Define a cor do texto normal da página.
  * `link` = Define a cor padrão dos links não visitados da página.
  * `vlink` = Define a cor dos links já visitados (*visited link*).
  * `alink` = Define a cor dos links quando estão ativados/clicados (*active link*).

---

## Referências e Atividades



* **Tutorial:**
  * `http://www.w3schools.com/html/default.asp`
  * Oferece muitos exemplos que podem ser visualizados e editados na hora.
  * Traz exercícios sugeridos em algumas seções com as respectivas respostas para verificação do aprendizado.



* **Atividade Prática:**
  * Desenvolva algumas páginas HTML contemplando:
    * Textos variados: cabeçalhos (`<h1>` ... `<h6>`), estilos variados (negrito, itálico, sublinhado), fontes diferentes, tamanhos e cores variados.
    * Parágrafos e quebra de linha.
    * Linha horizontal.
    * Imagens.
    * Âncoras.
    * Links.
    * Fundo com cor sólida ou imagem.
