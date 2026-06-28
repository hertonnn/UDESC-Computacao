# Introdução ao JavaScript
### O que é o JavaScript?


* JavaScript é uma linguagem que permite injetar lógica em páginas escritas em HTML.
* Os scripts podem estar "soltos" ou atrelados à ocorrência de eventos.
* Parágrafos soltos são executados na sequência em que aparecem na página.
* Os atrelados a eventos são executados apenas quando o evento ocorre.

### Inserindo JavaScript no HTML


Para inserir parágrafos de programação dentro do HTML:

* Identificar o início e o fim do JavaScript:
```html
<script> 
// instruções 
</script>
```
* Para melhor visualização e facilidade de manutenção, a lógica deve ser escrita no início do documento.

### Criação e Invocação de Funções


* Criação de funções a serem invocadas quando se fizer necessário (normalmente atreladas a eventos).
* Os comandos JavaScript são sensíveis ao tipo de letra (maiúsculas e minúsculas) em sua sintaxe (*Case Sensitive*).
* **Erro comum:** o interpretador tratará o que seria um comando como sendo o nome de uma variável se não houver atenção às maiúsculas e minúsculas.

### Operadores Aritméticos e de Atribuição


* `+` : adição de valor e concatenação de strings 
* `-` : subtração de valores 
* `*` : multiplicação de valores 
* `/` : divisão de valores 
* `%` : obtém o resto de uma divisão 
* `+=` : concatena ou adiciona ao string/valor já existente

Da mesma forma, podem ser utilizados: `-=`, `*=`, `/=`, `%=`, `++`, `--`.

Para inverter o sinal de uma variável, pode-se usar: `X = -X`.

### Operadores Relacionais e Lógicos


Utilizados em comandos condicionais: `if`, `for` e `while`.

* `==` : Igual 
* `!=` : Diferente 
* `>`  : Maior 
* `>=` : Maior ou Igual 
* `<`  : Menor 
* `<=` : Menor ou Igual 
* `&&` : E (AND Lógico)
* `||` : Ou (OR Lógico)

### Comandos de Controle de Fluxo


**Comando `if`:**

```javascript
if (Idade < 18) {
    Categoria = "Menor";
} else {
    Categoria = "Maior";
}
```

**Comando `for`:**

```javascript
for (x = 0; x <= 10; x++) {
    alert("X igual a " + x);
}
```

**Comando `while`:**

```javascript
var contador = 10;
while (contador > 1) {
    contador--;
}
```

### Eventos em JavaScript


Eventos são fatos que ocorrem durante a execução do sistema. O programador pode definir ações a serem realizadas pelo programa em resposta a estes eventos:

* `onload`: na carga do documento (`<body>`).
* `onunload`: na descarga (saída) do documento (`<body>`).
* `onchange`: quando o objeto perde o foco e houve mudança de conteúdo (objetos Text, Select e Textarea).


* `onblur`: quando o objeto perde o foco, independente de ter havido mudança (Text, Select e Textarea).
* `onfocus`: quando o objeto recebe o foco (Text, Select e Textarea).
* `onclick`: quando o objeto recebe um clique do mouse (objetos Button, Checkbox, Radio, Link, Reset e Submit).
* `onmouseover`: quando o ponteiro do mouse passa sobre o objeto (apenas para Link).
* `onselect`: quando o objeto é selecionado (Text e Textarea).
* `onsubmit`: quando um botão do tipo Submit recebe um clique do mouse (Form).

### Saída de Dados no Documento


Para escrever diretamente na página HTML:

```javascript
document.write("<p>Minha primeira linha</p>");
```
*(Ver exemplo 1)*

### Caixas de Diálogo: Mensagens de Observação e Confirmação


* Apenas Observação:
```javascript
alert(mensagem);
```
* Mensagem que retorna confirmação de OK ou CANCELAR:
```javascript
confirm(mensagem);
```
*(Ver Exemplo 2)*

### Caixas de Diálogo: Entrada de Dados (Prompt)


Mensagem via caixa de texto (Input):

```javascript
Receptor = prompt("Minha mensagem", "Meu texto");
```
* **Receptor:** é o campo (variável) que vai receber a informação digitada pelo usuário.
* **Minha mensagem:** é a mensagem que vai aparecer como Label da caixa de input.
* **Meu texto:** é um texto, opcional, que aparecerá na linha de digitação do usuário.

*(Ver Exemplo 3)*

### Estruturação de Funções Personalizadas


As funções só devem ser executadas quando acionadas:

```javascript
function Idade(Anos) {
    if (Anos > 17) {
        alert("Maior de Idade");
    } else {
        alert("Menor de Idade");
    }
}
```
*(Ver Exemplo 4)*

### Funções Embutidas (Nativas)


A própria linguagem JavaScript possui funções embutidas. 
O formato geral é: `Result = função(informação a ser processada)`.

* `eval()`: Calcula o conteúdo de uma string como código executável.
* `parseInt()`: Transforma string em um número inteiro.
* `parseFloat()`: Transforma string em número com ponto flutuante (decimal).
* `Date()`: Retorna a data e a hora do sistema (veja o capítulo sobre manipulação de datas).


Outras categorias de funções embutidas incluem:
* Funções tipicamente Matemáticas.
* Manipulando Arrays.
* Manipulando Strings.
* Manipulando Datas.
*(Ver manual para mais detalhes).*

### Objetos de Formulário no HTML para o JavaScript


O JavaScript pode interagir com elementos do HTML utilizados em formulários:
* Objetos para entrada de dados (textos).
* Marcação de opções (radio, checkbox e combo).
* Botões.
* Links para outras páginas.

Eles são divididos, basicamente, em: **Input**, **Textarea** e **Select**.

### Objeto Input TEXT


O objeto `<input>` varia de acordo com sua propriedade `type`:
`Password`, `Text`, `Hidden`, `Checkbox`, `Radio`, `Button`, `Reset`, `Submit`.

**Objeto Input TEXT:**
* **Propriedades:** `type`, `size`, `maxlength`, `name` e `value`.
* **Eventos associados:** `onchange`, `onblur`, `onfocus` e `onselect`.
*(Ver Exemplo 5)*

### Objetos Input PASSWORD e HIDDEN


**Objeto Input PASSWORD:**
* Entrada de senhas de acesso (oculta os caracteres).
```html
<input type="password" size="10" maxlength="10" name="Senha" value="">
```

**Objeto Input HIDDEN:**
* Semelhante ao input de texto, porém invisível para o usuário.
* Usado para passar informações ao "server" (quando o formulário for submetido) sem que o usuário tome conhecimento.
* **Propriedades:** `name` e `value`.
```html
<input type="hidden" name="HdTexto" value="">
```

### Objetos Input CHECKBOX e RADIO


**Objeto Input CHECKBOX:**
* Permite múltiplas escolhas ou escolhas independentes.
* **Propriedades:** `name`, `value` e `checked`.
* **Evento associado:** `onclick`.
*(Ver Exemplo 6)*

**Objeto Input RADIO:**
* Permite a escolha de apenas uma alternativa dentre um conjunto de opções com o mesmo nome.
* **Propriedades:** `name`, `value` e `checked`.
* **Evento associado:** `onclick`.
*(Ver Exemplo 7)*

### Objetos Input BUTTON, RESET e SUBMIT


**Objeto Input BUTTON:**
* Botão genérico para disparar eventos.
* **Propriedades:** `name` e `value`.
* **Evento associado:** `onclick`.
*(Ver Exemplo 8)*

**Objeto Input RESET:**
* Usado para limpar os campos digitados pelo usuário no formulário.
*(Ver Exemplo 9)*

**Objeto Input SUBMIT:**
* Usado para submeter (enviar) o conteúdo dos objetos do formulário ao servidor.
* Os dados são submetidos para a URL especificada na propriedade `action` do `<form>`.
*(Ver Exemplo 10)*

### Objeto SELECT e Janelas


**Objeto SELECT:**
* Cria uma lista de seleção (*dropdown* ou lista visível).
* **Propriedades:** `name`, `size`, `value` e `multiple`.
*(Ver Exemplo 11 e 12)*

**Exemplo para abrir uma nova janela:**
*(Ver Exemplo janela.html)*
