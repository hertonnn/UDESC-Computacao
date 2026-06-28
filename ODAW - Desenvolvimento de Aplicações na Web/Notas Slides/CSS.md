# Folha de Estilo em Cascata (CSS)

## O que é CSS?

O CSS (Folha de Estilo em Cascata) é um mecanismo simples para adicionar estilos (por exemplo, fontes, cores, espaçamentos) aos documentos Web. Ele permite ao designer um controle maior sobre os atributos de uma página (Home Page), tais como:
- Tamanho e cor das fontes;
- Espaçamento entre linhas e caracteres;
- Margem do texto;
- Caixas de texto e botões de formulário, entre outros.


## Vantagens do Uso de CSS

- **Separação de Responsabilidades:** A principal vantagem do uso de CSS é a de separar a marcação HTML da apresentação "visual" do site.
- **Facilidade de Manutenção:** As folhas de estilo (*style sheets*) permitem isolar os códigos de formatação aplicados a várias páginas. Assim, mudanças gerais de estilo podem ser feitas editando apenas um único arquivo.
- **Desempenho:** Há uma redução do tamanho dos arquivos HTML e, consequentemente, do tempo de carregamento das páginas.

> [!WARNING]
> Atenção: Sempre teste seu código CSS para diversos navegadores e versões diferentes para garantir a compatibilidade.


## Formas de Inserção de Estilos CSS

Existem três maneiras principais de adicionar CSS às páginas web:

1. **Arquivo de Style Sheet em separado (Externo):** Utilizado para estilizar uma ou mais páginas através de um link.
2. **Folha de estilos incorporada (Interno):** Inserida diretamente na seção `<head>` de uma única página.
3. **Acréscimo de atributos de estilo inline:** Declarados diretamente em algumas tags HTML.


### 1. Arquivo Externo

Por meio de um link direcionado para um arquivo de *style sheet* em separado, funcionando para uma ou mais páginas web.

```html
<html> 
<head> 
  <link rel="stylesheet" href="styles/stylesheets.css" type="text/css"> 
  <title>Título da Página</title> 
</head> 
<body>
  ...
</body>
</html>
```


### 2. Estilos Incorporados

Por meio da inserção de um *style sheet* dentro do cabeçalho de uma única página web.

```html
<html> 
<head> 
<style type="text/css"> 
<!-- 
p { 
  font-size: 10pt; 
  font-family: "Verdana, Arial, Sans-Serif"; 
  color: #000066; 
} 
h1 { 
  font-size: 16pt; 
  font-family: "Impact, Arial, Sans-Serif"; 
  color: #990000; 
} 
--> 
</style> 
</head> 
<body>
  ...
</body>
</html>
```


#### Exemplo Prático: Pseudo-classes e Classes

Criação de classes personalizadas e estilização de pseudo-classes de links (`a:link`, `a:visited`, etc.):

```html
<html> 
<head> 
<style type="text/css">  
a:link { font-family: Verdana; font-size: 10px; color: #476DAE; } 
a:visited { font-family: Verdana; font-size: 10px; color: #476DAE; } 
a:hover { font-family: Verdana; font-size: 10px; color: #44B30F; } 
a:active { font-family: Verdana; font-size: 10px; color: #476DAE; } 

.Titulo { padding-left: 10px; color: red; } 
.Conteudo { text-align: justify; line-height: 130%; color: #343434; } 
.Campo { border: solid #6D8EC1 1pt; } 
</style>  
</head>
```


#### Aplicando as Classes Criadas

Para utilizar a folha de estilos criada, aplica-se o atributo `class` na estrutura do HTML:

```html
<body> 
  <table> 
    <tr> 
      <td class="Titulo">Título da notícia</td> 
    </tr> 
    <tr> 
      <td class="Conteudo">...texto texto texto...</td> 
    </tr> 
  </table> 
</body> 
```


### 3. Estilos Inline

Pelo acréscimo de atributos de estilo *inline* diretamente em algumas tags, como `<p>`, `<div>` ou `<span>`.

```html
<div style="margin-left: 0.5in; font-size: 10pt"> 
  Este deve ser um bloco indentado com algum 
  <span style="font-weight: bold; background: #FFFF00"> texto selecionado </span> 
  dentro dele.
</div> 
```


## Ordem de Precedência (Cascata)

A ordem de precedência (Cascata) dita quais regras sobrescrevem as outras. A regra é:

1. **Atributos de estilos inline** têm a maior precedência, sobrescrevendo outras regras;
2. **Tags de `<style>` incorporadas (Interno)** têm precedência sobre os *style sheets* vinculados externamente via `<link>`.
3. **Arquivo de estilo externo** tem a menor prioridade entre as três formas de inserção.


## Estilizando a Barra de Rolagem

Podemos definir cores personalizadas na barra de rolagem usando propriedades específicas (suportadas nativamente em algumas versões do Internet Explorer ou em navegadores com prefixos baseados em WebKit).

```css
body {
  scrollbar-face-color: #4677B9;  
  scrollbar-shadow-color: #95AFCF;  
  scrollbar-highlight-color: #95AFCF;  
  scrollbar-3dlight-color: #4677B9;  
  scrollbar-darkshadow-color: #4677B9;  
  scrollbar-track-color: #4373A9;  
  scrollbar-arrow-color: #FFFFFF;  
  font-size: 8pt; 
  font-family: Verdana; 
  line-height: 150%;
}
```


## Propriedades CSS Comuns

Nos tutoriais da linguagem, podemos observar propriedades e valores aplicáveis a:

- Fontes;
- Textos;
- Background (Plano de fundo);
- Borda;
- Margem;
- Posicionamento;
- Impressão, entre outros.

> [!TIP]
> Editores de código contemporâneos auxiliam significativamente na criação de estilos através de autocompletar e verificação de sintaxe.


## Referências e Tutoriais Sugeridos

**Tutorial 1:** [Hugo Ribeiro - Curso de HTML e CSS](http://hugoribeiro.com.br/Curso_HTML/css/default.htm)
- Diversos exemplos com visualização do código CSS e seu respectivo resultado no navegador.

**Tutorial 2:** [W3Schools - CSS Tutorial](http://www.w3schools.com/css/default.asp)
- Mais completo e atualizado;
- Possui muitos exemplos que podem ser visualizados e editados diretamente ("Try it Yourself");
- Exercícios sugeridos em algumas seções com as respostas para verificação.


## Exercícios e Tarefas (Moodle)

Explore os tutoriais mencionados e, em seguida, poste os resultados no Moodle:

1. **CSS1:** Realize o exercício disponível no Moodle (PDF com explicações).
2. **CSS2:** Crie um arquivo CSS para redefinir o estilo de algumas tags HTML. Crie novas classes com seus respectivos estilos e utilize-as nas suas páginas HTML desenvolvidas nos exercícios das aulas anteriores.

