# HTML - Parte III: Formulários e Frames

## Formulários em HTML

Formulários são definidos no HTML utilizando a tag `<form>` e sua respectiva tag de fechamento `</form>`. Os formulários são essenciais para coletar dados informados pelo usuário.


### Métodos de Envio (Atributo `method`)

O atributo `method` define como os dados do formulário serão enviados para o servidor. Os dois métodos principais são:

- **`METHOD = "GET"`**: Envia toda a sua informação ao final da URL ativada.
- **`METHOD = "POST"`**: Transmite toda a informação fornecida via formulário de forma mais segura.

### Atributos `action` e `name`


- **`ACTION`**: Define para onde enviar a informação (qual URL/arquivo irá processar os dados).
- **`NAME`**: Nome associado a cada entrada em um formulário para identificar o campo enviado.

Exemplo básico de um formulário:

```html
<form method="POST" action="teste.php">
  <!-- Marcações de campos de entrada e HTML em geral -->
</form>
```

---

## Elementos de Entrada de Dados (`<input>`)


O elemento `<input>` (identificado pela propriedade `type`) permite diversas formas de entrada de dados, tais como: `password`, `text`, `hidden`, `checkbox`, `radio`, `button`, `reset`, e `submit`.

### Entrada de Texto Comum (`type="text"`)

Utilizado para a inserção de textos simples.
- **Propriedades**: `type`, `size`, `maxlength`, `name` e `value`.
- *Exemplo TEXT (Exemplo 1)*

### Entrada de Texto Protegido (`type="password"`)


Usado para a entrada de senhas de acesso (onde os caracteres digitados não são exibidos na tela).

Exemplo:

```html
<input type="password" size="10" maxlength="10" name="Senha" value="">
```
- *Exemplo PASSWORD (Exemplo 2)*

### Entrada Oculta (`type="hidden"`)


Semelhante ao `input text`, porém, **invisível para o usuário**. Serve para passar informações ao servidor (quando o formulário for submetido) sem que o usuário tome conhecimento.

- **Propriedades**: `name` e `value`.

Exemplo:

```html
<input type="hidden" name="HdTexto" value="">
```

---

## Outros Elementos de Formulário

### Entrada de Várias Linhas de Texto (`<textarea>`)


Utilizada para entrada de textos longos.

```html
<textarea></textarea>
```
- *Exemplo TEXTAREA (Exemplo 3)*

### Menus com Opções (`<select>`)


Cria um menu de opções (lista suspensa) para seleção.

- **Propriedades**: `name`, `size`, `value` e `multiple`.
- *Exemplo SELECT - Exemplo 4*
- *Exemplo SELECT MULTIPLE - Exemplo 5*

### Botões Sim ou Não (`type="checkbox"`)


Permitem múltiplas seleções independentes de opções.

- **Propriedades**: `name`, `value` e `checked`.
- *Exemplo CHECKBOX - Exemplo 6*

### Botões com Opções (`type="radio"`)


Permitem a escolha de **apenas uma alternativa** dentro de um grupo.

- **Propriedades**: `name`, `value` e `checked`.
- *Exemplo de RADIO - Exemplo 7*

### Botões de Submissão e Limpeza (`submit` e `reset`)


- **Submit**: Utilizado para submeter (enviar) o conteúdo dos objetos do formulário ao servidor. O envio será submetido à URL especificada na propriedade `action` do formulário.
- **Reset**: Utilizado para restaurar os valores padrões (limpar) os campos.
- **Propriedades**: `name` e `value`.
- *Exemplo BOTÕES - Exemplo 8*

---

## Frames no HTML


Os *frames* permitem dividir a janela de visualização do navegador em partes independentes.

Principais tags e propriedades:
- `<frameset></frameset>`: Define o conjunto de frames.
- `<frame src="URL">`: Define um frame específico e a URL de seu conteúdo.
- `<frameset rows="valor, valor, valor">`: Define o tamanho de cada linha (divisão horizontal).
- `<frameset cols="valor, valor, valor">`: Define o tamanho de cada coluna (divisão vertical).

### Exemplo de Frames: Colunas (`cols`)


```html
<html>
<head>
  <title>Exemplo de frame</title>
</head>
<frameset cols="20%, 80%"> 
  <frame src="frame1.html">
  <frame src="frame2.html">
</frameset>
</html>
```

### Exemplo de Frames: Linhas (`rows`)


```html
<html>
<head>
  <title>Exemplo de frame - Linhas</title>
</head>
<frameset rows="50%, 50%"> 
  <frame src="frame1.html">
  <frame src="frame2.html">
</frameset>
</html>
```
