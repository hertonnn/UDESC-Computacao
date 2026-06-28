# PHP
### O que é o PHP? / Características Gerais


- Linguagem script
- Código PHP é executado no servidor, embutido no HTML, não expõe o código-fonte
- Criar páginas dinâmicas
- Interação com usuário:
  - Formulários
  - Parâmetros URL
- Interação com Banco de Dados (BD)
- Pode conter: HTML, CSS, JavaScript e código PHP (extensão do arquivo: `.php`)

---

### O que o PHP pode fazer? / Capacidades do PHP


- Coletar dados de um formulário
- Gerar páginas com conteúdo dinâmico
- Manipular arquivos no servidor (criar, abrir, ler, escrever, apagar e fechar)
- Suporte a grande número de Bancos de Dados
- Construção de páginas baseadas em Banco de Dados de forma simples
- Construção de relatórios
- Templates HTML (ex: `rodape.php`)
- Envio de e-mail

---

### História do PHP


- **1994**: Criado por Rasmus Lerdof para sua *home page* pessoal.
- **1995**: Disponibilizado para uso (livro de visitas, contador, etc.).
- **1995**: Reescrito como PHP/FI (Form Interpreter) com suporte a Banco de Dados.
- Site oficial: [http://www.php.net](http://www.php.net)
  - Contém documentação, exemplos, etc.

---

### Vantagens do PHP


- **Portabilidade**: Ambiente disponível para diferentes plataformas.
- **Facilidade de acesso a bases de dados**.
- **Suporte para diversas bases de dados**.
- A saída não é limitada ao HTML, podendo gerar:
  - Imagens, PDF, Flash, XHTML, XML.
- Obtido gratuitamente.
- Fácil de aprender.

---

### Instalação e Ambiente


Para utilizar o PHP, é necessário obter e instalar:
- Servidor Web que suporte ou seja suportado por PHP (ex: Apache).
- Ambiente PHP (seguindo as regras de instalação).
- Gerenciador de bases de dados (ex: MySQL).
- Pacotes integrados disponíveis: XAMPP, LAMP, PHP Triad (Apache + PHP + MySQL).

---

### Sintaxe Básica e Delimitadores


Formas de delimitar o código PHP:

```php
<?php comandos ?>
```

```html
<script language="php">
comandos
</script>
```

```php
<? comandos ?>
```

```php
<% comando; comando; %>
```

---

### Exemplo Prático: Informações do PHP


- Crie um arquivo `info.php`.
- Salve-o no diretório `htdocs` (do seu servidor Web).

```php
<?php
phpinfo();
?>
```

---

### Variáveis e Comentários


#### Variáveis
- Usam o caractere `$` seguido de uma string (ex: `$aux`, `$temp`).
- Devem iniciar por uma letra ou o caractere `_` (sublinhado).
- O texto menciona que o "PHP não é *case sensitive*" (Nota: No PHP, funções e classes não são sensíveis a maiúsculas/minúsculas, mas variáveis **são** *case-sensitive*. A informação foi mantida conforme o material original).

#### Comentários
- Para uma linha: `//` ou `#`
- Para mais de uma linha: `/* comentário */`

---

### Impressão de Dados


Funções/Construtores para exibir dados:
- `print(argumento);`
- `echo (argumento1, argumento2, ...);`
- `echo argumento;`

**Exemplo:**
```php
<?php
$texto = "Primeiro Script";
echo $texto;
?>
```

---

### Tipos de Dados


- **Inteiro:** 
  ```php
  $aux = 234; 
  $aux = -234;
  ```
- **Ponto Flutuante:** 
  ```php
  $f = 1.234; 
  $f = 23e4;
  ```
- **String:** 
  ```php
  $teste = 'Debora'; 
  $teste2 = "ab";
  ```
- **Array:**
  ```php
  $cor[0] = "vermelho";
  $cor[1] = "azul";
  ```
- **Objeto:** Uso da palavra reservada `new` para instanciar uma classe para uma variável.

---

### Exercício Proposto


- Crie uma página que mostre a data e hora atual no seguinte formato:
  - *Hoje é 09/07/20 e agora são 16:00*

---

### Operadores


- **Aritméticos:** `+`, `-`, `*`, `/`, `%`
- **String (Concatenação):** `.`
- **Atribuição:** `=`, `+=`, `-=`, `*=`, `/=`, `%=`, `.=`
- **Bit a bit (Bitwise):** `&`, `|`, `^`, `~`, `<<`, `>>`
- **Lógicos:** `and`, `or`, `xor`, `!`, `&&`, `||`
- **Comparação:** `==`, `!=`, `<`, `>`, `<=`, `>=`
- **Incremento e Decremento:** `++`, `--`

---

### Estrutura Condicional (`if`)


```php
if ($a > $b) {
    $maior = $a;
    echo $a;
} else {
    $maior = $b;
}
```

---

### Estrutura de Repetição (`while`)


```php
$i = 0;
while ($i <= 10) {
    print $i;
    $i++;
}
```

---

### Outras Estruturas de Repetição (`for`, `switch`, `do .. while`)


- **For:**
  ```php
  for ($i = 0; $i <= 10; $i++) {
      echo "valor = " . $i;
  }
  ```
- **Switch**
- **Do .. while**

---

### Outros Recursos e Tópicos


O PHP ainda fornece funcionalidades avançadas e estruturas diversas, tais como:
- Tratamento de formulários
- Funções
- Classes
- Acesso a Banco de Dados (ex: MySQL)
- Arrays, strings, funções matemáticas, calendário, data, diretórios, arquivos, sessões, cookies, XML, AJAX.

---

### Referências e Links Úteis


- [www.php.net](http://www.php.net)
- [http://www.w3schools.com/php/default.asp](http://www.w3schools.com/php/default.asp)
