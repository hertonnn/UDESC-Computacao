# XHTML: Introdução e Boas Práticas
## O que é o XHTML?

O **XHTML** significa *EXtensible HyperText Markup Language* (Linguagem de Marcação para Hipertexto Extensível). Ele é quase idêntico ao HTML, porém é mais rigoroso em sua sintaxe, pois é definido como uma aplicação XML. Atualmente, o XHTML é suportado pela grande maioria dos navegadores modernos e aplicações web.

## Por que utilizar o XHTML?

A adoção do XHTML traz diversas justificativas e vantagens para o desenvolvimento de aplicações na web:
- É um código consistente que dispensa o uso de "truques" e "hacks" para contornar "bugs" comuns em navegadores.
- Editar um código XHTML existente é uma tarefa simples por se tratar de uma escrita limpa e bem estruturada.
- O tempo de carga de uma página XHTML costuma ser mais rápido em processadores XML.
- Uma página XHTML é mais acessível aos navegadores e aplicações, possuindo maior interoperabilidade e portabilidade.
- Uma página XHTML é totalmente compatível com todas as aplicações de usuários voltadas para o HTML, desde as modernas até as mais antigas e já ultrapassadas.

Para entender a motivação, observe um exemplo clássico de um HTML "ruim" ou malformado que o XHTML tenta prevenir:

```html
<html>
<head>
<title>Isso é um HTML ruim</title>
<body>
<h1>HTML ruim
<p>Isso é um parágrafo
</body>
```

## Principais Diferenças entre XHTML e HTML

O XHTML impõe regras estritas que o diferenciam do HTML tradicional:
- Todas as tags devem ser escritas obrigatoriamente em letras minúsculas.
- Os elementos (tags) devem estar convenientemente e corretamente aninhados.
- Os documentos devem ser sempre bem formados (seguindo as regras do XML).
- O uso de tags de fechamento é obrigatório para todos os elementos não vazios.
- Elementos vazios também devem ser devidamente fechados.
- Existem regras específicas e rigorosas para a declaração de atributos.

## Estrutura Básica de um Documento

Um documento XHTML exige que certos elementos estejam presentes em sua estrutura:
- A declaração do `DOCTYPE` (XHTML DOCTYPE) é mandatória.
- O atributo `xmlns` dentro da tag `<html>` é obrigatório.
- As tags estruturais `<html>`, `<head>`, `<title>` e `<body>` são mandatórias.

### Exemplo de Estrutura do Documento

```html
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Title of document</title>
</head>
<body>
some content
</body>
</html>
```

### Para que serve o DOCTYPE?

O *Document Type Definition* (ou DTD) especifica qual é a sintaxe SGML usada no documento. Ele descreve com precisão a sintaxe e a gramática da linguagem de marcação XHTML que está sendo aplicada.
- O `DOCTYPE` deve ser sempre a **primeira declaração** em um documento web.

Existem três tipos principais de DTDs para XHTML 1.0:
1. **Strict:** Usado quando você deseja uma marcação limpa, separando estruturação de apresentação (CSS).
2. **Transitional:** Usado quando o documento inclui recursos de apresentação e precisa ser compatível com navegadores que não suportam CSS integralmente.
3. **Frameset:** Usado para documentos com frames HTML.

> [!TIP]
> **Validador online:** Você pode verificar se o seu código XHTML está correto acessando o validador do W3C: [https://validator.w3.org/](https://validator.w3.org/)

## Regras para Elementos no XHTML

Os elementos no XHTML devem seguir os preceitos de um documento XML bem formado.

### 1. Elementos Devem Ser Propriamente Aninhados

As tags devem ser fechadas na exata ordem inversa em que foram abertas. O elemento que é aberto por último deve ser fechado primeiro.

**Errado:**
```html
<b><i>This text is bold and italic</b></i>
```

**Certo:**
```html
<b><i>This text is bold and italic</i></b>
```

### 2. Elementos Devem Sempre Ser Fechados

Diferente do HTML clássico, onde a omissão de fechamentos às vezes era perdoada, no XHTML toda tag de conteúdo deve ser explícita no fechamento.

**Errado:**
```html
<p>This is a paragraph
<p>This is another paragraph
```

**Certo:**
```html
<p>This is a paragraph</p>
<p>This is another paragraph</p>
```

### 3. Elementos Vazios Devem Ser Fechados

Elementos que não possuem conteúdo também exigem fechamento. Isso é feito adicionando-se uma barra `/>` ao final da tag.

**Errado:**
- Quebra de linha: `<br>`
- Régua horizontal: `<hr>`
- Imagem: `<img src="happy.gif" alt="Happy face">`

**Certo:**
- Quebra de linha: `<br />`
- Régua horizontal: `<hr />`
- Imagem: `<img src="happy.gif" alt="Happy face" />`

### 4. Elementos Devem Ser Escritos em Caixa Baixa (Minúsculas)

A linguagem XML é *case-sensitive* (diferencia maiúsculas de minúsculas). Por isso, as tags devem ser sempre escritas em letras minúsculas.

**Errado:**
```html
<BODY>
<P>This is a paragraph</P>
</BODY>
```

**Certo:**
```html
<body>
<p>This is a paragraph</p>
</body>
```

### 5. Elementos Aninhados no Elemento Raiz

Todos os elementos no XHTML devem estar corretamente aninhados dentro do elemento raiz `<html>`.

## Regras para Atributos no XHTML

Os atributos também sofrem padronizações rigorosas na linguagem:

### Nomes de Atributos em Caixa Baixa

Todos os atributos das tags devem ser escritos em letras minúsculas.

**Errado:**
```html
<table WIDTH="100%">
```

**Certo:**
```html
<table width="100%">
```

### Valores dos Atributos Entre Aspas

Independentemente do tipo de valor (número, texto ou porcentagem), os valores devem ser sempre delimitados por aspas.

**Errado:**
```html
<table width=100%>
```

**Certo:**
```html
<table width="100%">
```

### Minimização de Atributos é Proibida

No HTML, alguns atributos que não requerem valor (atributos booleanos) podiam ser apenas declarados. No XHTML, isso é proibido; o atributo deve receber como valor o seu próprio nome.

**Errado:**
```html
<input type="checkbox" name="vehicle" value="car" checked />
```

**Certo:**
```html
<input type="checkbox" name="vehicle" value="car" checked="checked" />
```

> [!NOTE]
> Outros atributos que devem respeitar essa regra incluem: `compact`, `declare`, `readonly`, `disabled`, `selected`, `defer`, `ismap`, `nohref`, `noshade`, `nowrap`, `multiple` e `noresize`.

### O Atributo `alt` para Imagens é Obrigatório

O texto alternativo é crucial para acessibilidade e validação.

**Errado:**
```html
<img src="smiley.gif"/>
```

**Certo:**
```html
<img src="smiley.gif" alt="Smiley face"/>
```

*(No caso de uma imagem meramente decorativa, pode-se utilizar o atributo `alt` vazio: `<img src="imagem.gif" alt=" " />`)*

### Os Atributos `id` e `name`

O XHTML privilegia o uso do atributo `id` para identificação única, substituindo o uso do `name` em muitos casos.

**Errado:**
```html
<img src="imagem.gif" name="minha_imagem" alt=" " />
```

**Certo:**
```html
<img src="imagem.gif" id="minha_imagem" alt=" " />
```

*(Por razões de compatibilidade com navegadores mais antigos, você pode adicionar ambos simultaneamente: `<img src="imagem.gif" id="minha_imagem" name="minha_imagem" alt=" " />`)*

### Pontos de Âncora

Em HTML antigo, para criar um ponto de âncora, associávamos um `name` ao elemento `<a>`:

**Errado (em XHTML):**
```html
<p><a name="topo">Início</a> do parágrafo..bla...</p>
```

Em XHTML, nós adicionamos o atributo `id`:

**Certo:**
```html
<p><a id="topo" name="topo">Início</a> do parágrafo..bla...</p>
```

### Separadores de Comentários

O uso excessivo de hífens (`-`) dentro de comentários pode confundir o processador XML.

**Evite:**
```html
<!-- Aqui começa o menu -->
<!-- -------------------------------------------- -->
```

**Faça:**
```html
<!-- Aqui começa o menu -->
<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -->
```
Ou:
```html
<!-- ============================ -->
```

### O Caractere `&` e Caracteres Especiais

O caractere `&` (e comercial) inicia declarações de entidades no XML. Por isso, ao exibi-lo textualmente, ele deve ser escapado como `&amp;`.

**Errado:**
```html
<h:outputText value="Tom & Jerry Show" />
```

**Certo:**
```html
<h:outputText value="Tom &amp; Jerry Show" />
```

*(O mesmo vale para outros caracteres especiais da marcação, como `"` (`&quot;`), `'` (`&apos;`), `<` (`&lt;`) e `>` (`&gt;`).)*

## Conclusão

Podemos afirmar que o XHTML transforma boas práticas de formatação e sintaxe do HTML em regras que devem ser seguidas rigorosamente. Todo este rigor visa a escrita e formulação de códigos com alta portabilidade, acessibilidade aprimorada e de fácil manutenção por desenvolvedores e máquinas.

## Referências

- [Linha de Código - Tutorial XHTML](http://www.linhadecodigo.com.br/artigo/280/tutorial-xhtml.aspx)
- [Maujor - Tutorial XHTML](http://www.maujor.com/tutorial/xhtml.php)
- [W3Schools - HTML vs XHTML](https://www.w3schools.com/html/html_xhtml.asp)
- [StackOverflow - How to insert special characters into JSF](https://stackoverflow.com/questions/6883860/how-to-insert-special-characters-like-and-into-jsf-components-value-attribu)
- [UVU DGM 2120 - Lesson 03](http://desource.uvu.edu/dgm/2120/in/steinja/lessons/03/03_09.html)

---

## Anexo: Imagens Originais Extraídas

Conforme a fidelidade ao conteúdo bruto, seguem as mídias embutidas originalmente na apresentação (preservando o layout de extração dos slides):

