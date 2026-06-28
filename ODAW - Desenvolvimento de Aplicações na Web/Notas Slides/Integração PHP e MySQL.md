# Integração entre PHP e MySQL
## Comunicação com Bancos de Dados no PHP

O PHP possui funções integradas para realizar a comunicação com diversos Sistemas Gerenciadores de Bancos de Dados (SGBDs), tais como:
- mSQL
- MS SQL Server
- MySQL
- Oracle
- PostgreSQL
- ODBC, entre outros.

> [!NOTE]
> Para este material, o foco será a utilização do **MySQL**.


---

## Estabelecendo Conexão com o MySQL

Para estabelecer uma conexão com o MySQL, utilizamos a função `mysqli_connect()`.

A assinatura da função é:
```php
resource mysqli_connect ( string $host, string $login, string $senha, string $nome_base_dados )
```

O valor de retorno da função identifica a conexão e deve ser armazenado em uma variável, que será utilizada nas próximas operações com o banco.

**Exemplo de Conexão:**
```php
$conexao = mysqli_connect('localhost', 'root', 'udesc');
```


---

### Verificando a Conexão e Encerrando-a

É essencial validar se a conexão foi estabelecida com sucesso antes de realizar operações e, ao final, fechá-la.

```php
<?php
$conexao = mysqli_connect('localhost', 'root', 'udesc');

if (!$conexao) {
    die('Não foi possível conectar: ' . mysqli_connect_error());
}

echo 'Conexão bem sucedida';

// Encerra a conexão com o banco de dados
mysqli_close($conexao);
?>
```


---

## Conectando a uma Base de Dados Específica

Você pode passar o nome da base de dados diretamente como o quarto parâmetro da função `mysqli_connect()`.

```php
<?php
$conexao = mysqli_connect('localhost', 'root', 'udesc', 'odaw');

if (!$conexao) {
    die('Não foi possível conectar: ' . mysqli_connect_error());
}

// ... operações na base de dados indicada

mysqli_close($conexao);
?>
```


---

## Executando Consultas (Queries)

Para enviar comandos SQL ao servidor, utilizamos a função `mysqli_query()`.

A assinatura da função é:
```php
resource mysqli_query ( resource $conexao, string $consulta )
```

*   O valor de retorno em comandos de escrita ou manipulação estrutural (como `INSERT`, `UPDATE`, `DELETE`, `CREATE`) pode ser um booleano (onde `0`/`false` representa falha e `1`/`true` significa que a consulta está sintaticamente correta e foi executada com sucesso).
*   Para comandos `SELECT`, o retorno é um objeto `mysqli_result` com os dados ou `false` em caso de erro.

**Exemplo:**
```php
$resultado = mysqli_query($conexao, $query);
```


---

### Exemplo: Criando uma Tabela no Banco de Dados

Podemos criar estruturas de dados diretamente via PHP enviando uma consulta do tipo `CREATE TABLE`.

```php
<?php
$conexao = mysqli_connect('localhost', 'root', 'udesc', 'odaw');

$consulta = "CREATE TABLE aluno (
    codigo INT AUTO_INCREMENT PRIMARY KEY, 
    nome VARCHAR(40), 
    email VARCHAR(50)
)";

$resultado = mysqli_query($conexao, $consulta);

if ($resultado) {
    echo "Sucesso";
} else {
    echo "Erro";    
}
?>
```


---

![Representação Criação 3](imagens/Integração%20PHP%20e%20MySQL/slide_8_img_3.png)

*(Imagens ilustrando o fluxo de execução das queries)*

---

## Inserindo Dados (`INSERT`)

Para adicionar dados, escrevemos a consulta `INSERT` e a enviamos com `mysqli_query()`.

```php
$consulta = 'INSERT INTO aluno (nome, email) VALUES ("Debora", "debora.nazario@udesc.br")';
$resultado = mysqli_query($conexao, $consulta);
```

**Resultado simulado no terminal MySQL:**
```sql
mysql> select * from aluno;
+--------+--------+-------------------------+
| codigo | nome   | email                   |
+--------+--------+-------------------------+
|      1 | Debora | debora.nazario@udesc.br |
+--------+--------+-------------------------+
```


---

## Atualizando Dados (`UPDATE`)

Para atualizar os registros existentes, utilizamos a cláusula `UPDATE`.

```php
$consulta = "UPDATE aluno SET nome='Debora Nazario' WHERE nome='Debora'";
$resultado = mysqli_query($conexao, $consulta);
```

**Resultado simulado no terminal MySQL:**
```sql
mysql> select * from aluno;
+--------+----------------+---------------------------+
| codigo | nome           | email                     |
+--------+----------------+---------------------------+
|      1 | Debora Nazario | debora.nazario@udesc.br   |
+--------+----------------+---------------------------+
```


---

## Excluindo Dados (`DELETE`)

Para remover dados da base, usamos a instrução `DELETE`.

```php
<?php
// ... conexão já estabelecida
$consulta = "DELETE FROM aluno WHERE nome='Debora Nazario'";
$resultado = mysqli_query($conexao, $consulta);

if ($resultado) {
    echo "Sucesso";
} else {
    echo "Erro";
}
?>
```


---

## Consultando Dados (`SELECT`) e Recebendo Resultados

Após executar um `SELECT`, os dados retornados devem ser extraídos ou iterados para exibição.

```php
$consulta = "SELECT nome, email FROM aluno";
$resultado = mysqli_query($conexao, $consulta);
```

Para receber e iterar os resultados da consulta, o PHP disponibiliza as seguintes funções:
- `mysqli_result` (Nota: Não existe nativamente na extensão `mysqli` padrão orientada a objetos moderna, mas era comum no extinto `mysql_result` e possui alternativas ou implementações personalizadas; será descrito a seguir conforme o material)
- `mysqli_fetch_row()`
- `mysqli_fetch_array()`


---

### Obtendo um campo específico do resultado

O conceito mostrado usa uma assinatura típica para obter dados diretos.

> [!WARNING]
> No PHP moderno utilizando a extensão `mysqli`, não existe uma função nativa chamada `mysqli_result()` com esta exata assinatura. Geralmente, utilizam-se métodos de *fetch* (como mostrado nos próximos tópicos) para alcançar esse objetivo. Contudo, conforme o material didático:

```php
// Representação teórica/didática
// string mysqli_result ( resource $result, int $row [, mixed $field] )

echo mysqli_result($resultado, 0, 'nome');
echo " - "; 
echo mysqli_result($resultado, 0, 'email');
```


---

### Utilizando `mysqli_fetch_row()`

Retorna uma linha de resultado na forma de um *array indexado numericamente* (índices 0, 1, 2...).

Assinatura:
```php
array mysqli_fetch_row ( resource $result )
```

**Exemplo de uso:**
```php
while ($linha = mysqli_fetch_row($resultado)) {
    // $linha[0] corresponde ao primeiro campo, $linha[1] ao segundo...
    echo $linha[0] . " - " . $linha[1] . "<br>";
}
```


---

### Utilizando `mysqli_fetch_array()`

Retorna uma linha de resultado na forma de um *array associativo*, *numérico* ou *ambos*, dependendo do parâmetro passado.

**Exemplo com índices numéricos (`MYSQLI_NUM`):**
```php
while ($linha = mysqli_fetch_array($resultado, MYSQLI_NUM)) {
    echo $linha[0] . " - " . $linha[1] . "<br>";
}
```

**Exemplo com índices associativos (`MYSQLI_ASSOC`):**
```php
while ($linha = mysqli_fetch_array($resultado, MYSQLI_ASSOC)) {
    echo $linha['nome'] . " - " . $linha['email'] . "<br>";
}
```


---

**Exemplo com ambos os índices (`MYSQLI_BOTH`):**

Retorna tanto os índices numéricos quanto as chaves associativas.

```php
while ($linha = mysqli_fetch_array($resultado, MYSQLI_BOTH)) {
    // Pode acessar tanto por índice numérico quanto pelo nome da coluna
    echo $linha[0] . " - " . $linha['email'] . "<br>";
}
```

![Fetch Both 3](imagens/Integração%20PHP%20e%20MySQL/slide_16_img_3.png)

---

## Exercícios Práticos

### Exercício 1: Operações Básicas
1. Criar uma base de dados e uma tabela com no mínimo 3 campos via terminal MySQL (shell).
2. Criar um script PHP (sem utilização de formulário) para:
   - Inserir alguns registros;
   - Alterar registros;
   - Visualizar registros;
   - Apagar registros.


---

### Exercício 2: Sistema com Formulário
Você pode utilizar a mesma base de dados e tabela já criados anteriormente. A tarefa é desenvolver um sistema de cadastro com interface (HTML form) que permita:
- Realizar um NOVO cadastro;
- Visualizar TODOS os cadastros existentes;
- APAGAR um cadastro;
- EDITAR um cadastro.

*Sugestão de projeto: Criar um pequeno Cadastro (Agenda de Contatos).*

