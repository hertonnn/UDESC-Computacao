# HTML Parte II
## Cores no HTML


* Códigos de cores podem ser utilizados em documentos HTML.
* Alguns nomes de cores (com asterisco na tabela) podem ser utilizados no lugar dos códigos.
* Ver tabela de Cores RGB.
* Exemplo: [Tabela de Cores](http://erikasarti.net/html/tabela-cores/)

---

## Caracteres e Notações Especiais


* Notações especiais para serem exibidas em tela.
* Iniciam por `&` (e comercial) e encerram-se com `;` (ponto e vírgula).

| Caractere de Tela | Descrição | Notação HTML |
| :---: | :--- | :--- |
| `<` | "Menor que" | `&lt;` |
| `>` | "Maior que" | `&gt;` |
| `&` | E comercial | `&amp;` |
| `"` | Aspas duplas | `&quot;` |

*(Nota: a associação original dos sinais de maior/menor no slide bruto foi ajustada para refletir a semântica correta do HTML).*

---

## Acentuação Padrão


* Facilidades de acentuação (padrão do Windows, por exemplo).
* Apenas poderá visualizar a acentuação o computador que reconhecer este padrão.
* Padrão para acentuação: **ISO Latin-1 alphabet**.
* Visualizado pela grande maioria das máquinas.
* Uso de ISO-8859-1 e UTF-8: [Como resolver problemas de acentuações em seu site](https://wiki.locaweb.com.br/pt-br/Como_resolver_problemas_de_acentuações_em_seu_site)

---

## Códigos de Acentuação e Caracteres Especiais


* **Acento agudo:** `&xacute;` onde *x* é uma letra qualquer
* **Acento grave:** `&xgrave;`
* **Acento circunflexo:** `&xcirc;`
* **Letra com til:** `&xtilde;`
* **Letra com trema:** `&xuml;`
* **Letras unidas:** `&Aelig;` = Æ e `&aelig;` = æ
* **Letra com argola:** `&Aring;` = Å e `&aring;` = å
* **Cedilha:** `&Ccedil;` = Ç e `&ccedil;` = ç
* **N com til:** `&Ntilde;` = Ñ e `&ntilde;` = ñ
* **O cortado:** `&Oslash;` = Ø e `&oslash;` = ø

---

## Listas de Definição


* `<dl>` e `</dl>`: Início e fim de uma lista de definição.
* Devem ser usados com as tags `<dt>` e `<dd>`.
* Aceito por todos os navegadores.


* `<dt>` e `</dt>`: Os títulos de uma lista de definição. Usados junto com as tags `<dl>` e `<dd>`.
* `<dd>` e `</dd>`: Início e fim do texto de uma lista de definição. Usados junto com as tags `<dl>` e `<dt>`.

### Exemplo: Lista de Definição


```html
<dl>  
  <dt>Título 1</dt>  
  <dd>Texto 1</dd>  
  <dt>Título 2</dt>  
  <dd>Texto 2</dd>  
</dl>
```

---

## Listas Não Ordenadas


* `<ul>` e `</ul>`: Início e fim de uma lista não ordenada.
* Usado junto com a tag `<li>`.

```html
<ul> 
  <li>Item 1</li>
  <li>Item 2</li>
  <li>Item 3</li>
</ul>
```

---

## Listas Ordenadas


* `<ol>` e `</ol>`: Início e fim de uma lista ordenada.
* Usados junto com a tag `<li>`.

```html
<ol> 
  <li>Item 1</li>
  <li>Item 2</li>
  <li>Item 3</li>
</ol>
```

### Atributo `start`


O atributo `start="n"` especifica o número inicial da lista.

```html
<ol start="2"> 
  <li>Item 1</li>
  <li>Item 2</li>
  <li>Item 3</li>
</ol>
```

### Atributo `type` em Listas Não Ordenadas


O atributo `type="n"` modifica o tipo de marca de cada item da lista. Podem ser usados valores como `circle` e `square`.

```html
<ul>  
  <li type="square">Item 1</li>
  <li type="circle">Item 2</li>
</ul>
```

### Atributo `type` em Listas Ordenadas


O atributo `type="n"` também pode ser usado em listas ordenadas com os valores: `A`, `a`, `1`, `I`, `i`.

**Tipo de Numeração com Letras Maiúsculas (`A`):**
```html
<ol>   
  <li type="A">Item 1</li>
  <li type="A">Item 2</li>
  <li type="A">Item 3</li>
</ol>
```


**Tipo de Numeração com Letras Minúsculas (`a`):**
```html
<ol>   
  <li type="a">Item 1</li>
  <li type="a">Item 2</li>
  <li type="a">Item 3</li>
</ol>
```

**Tipo de Numeração com Números (`1`):**
```html
<ol>   
  <li type="1">Item 1</li>
  <li type="1">Item 2</li>
  <li type="1">Item 3</li>
</ol>
```


**Tipo de Numeração com Algarismos Romanos Maiúsculos (`I`):**
```html
<ol>   
  <li type="I">Item 1</li>
  <li type="I">Item 2</li>
  <li type="I">Item 3</li>
</ol>
```

**Tipo de Numeração com Algarismos Romanos Minúsculos (`i`):**
```html
<ol>   
  <li type="i">Item 1</li>
  <li type="i">Item 2</li>
  <li type="i">Item 3</li>
</ol>
```

---

## Tabelas em HTML


* `<table> </table>`: Define início e fim da tabela.
* `<tr> </tr>`: Define cada linha da tabela (Table Row).
* `<td> </td>`: Define cada célula da tabela / coluna (Table Data).
* `<th> </th>`: Define títulos na tabela (Table Header). Na prática, são células onde o texto aparece em destaque (negrito). Podem aparecer em qualquer posição na tabela.
* **Exemplo Tabela 1**

### Atributos: `border` e `align`


* `border`: Determina que uma tabela tenha bordas (`<table border>`).
* `align`: Controla o alinhamento horizontal do texto. Pode ser associado a `<tr>`, `<td>` ou `<th>`.
  * `left`: alinha à esquerda.
  * `right`: alinha à direita.
  * `center`: centraliza.
* **Exemplo Tabela 2**

### Atributo: `valign`


* `valign`: Controla o alinhamento vertical do texto. Pode ser associado a `<tr>`, `<td>` ou `<th>`.
  * `top`: alinha com o alto da célula.
  * `middle`: alinha no meio.
  * `bottom`: alinha com a parte de baixo da célula.
* **Exemplo Tabela 3**

### Atributo: `colspan`


* `colspan`: Aparece associado a células (`<td>` ou `<th>`). Determina quantas colunas uma célula abrange.
* **Exemplo Tabela 4**

### Atributo: `rowspan`


* `rowspan`: Aparece associado a células (`<td>` ou `<th>`). Determina quantas linhas uma célula abrange.
* **Exemplo Tabela 5**

### Outros Atributos de Tabela


* `border="<valor>"`: Define a largura da borda.
* `cellspacing="<valor>"`: Define espaçamento entre células.
* `cellpadding="<valor>"`: Define distância entre o texto e a borda das células.
* `width="<valor_ou_percentual>"`: Determina o quanto da tela uma tabela deve ocupar.
* `bgcolor="<cor>"`: Define a cor de fundo da tabela ou da célula.
