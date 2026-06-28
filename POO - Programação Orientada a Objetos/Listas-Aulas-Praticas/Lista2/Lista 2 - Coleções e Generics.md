# Lista 2: Coleções e Generics

---

## Exercício 1

Crie um programa em Java que leia do usuário as informações relacionadas a várias pessoas. Cada pessoa possui **nome**, **idade**, **cpf** e **cidade**.

O programa termina a leitura quando o usuário digita o valor **-1**. A cada nova pessoa lida, o programa deve exibir a lista de pessoas (ordenada alfabeticamente pelo nome) com suas respectivas informações, agrupando-as de acordo com as faixas etárias a seguir:

- **1 até 12: crianças**
  - Igor Pereira, 5, 472.938.253-43, Jaraguá do Sul;
  - Lucas da Silva, 6, 272.938.273-93, Joinville;
- **13 até 18: adolescentes**
  - João Pedro Oliveira, 17, 475.458.343-21, Florianópolis;
  - Luiz Otávio Ramos, 14, 343.945.234-04, Joinville;
- **19 até 25: jovens**
- **26 até 59: adultos**
- **60 ou mais: idosos**

**Dica:** utilize a classe Scanner passando um File para ler um arquivo com as pessoas a serem cadastradas:

```java
Scanner sc;
try {
    sc = new Scanner(new File("nomeArquivo.extensao"));
} catch (FileNotFoundException e) {
    sc = new Scanner(System.in);
}
sc.nextInt();
// Utilize o scanner normalmente
```

---

## Exercício 2

Crie a classe `Matriz<T>`, ela deve possuir como atributos a **ordem da matriz** e uma **matriz de elementos do tipo T** a serem alocados pelo método construtor, que deve receber dois parâmetros `n` e `m`, estes correspondentes à ordem da matriz.

Crie um enumerável `Quadrante`, contendo os valores: **PRIMEIRO**, **SEGUNDO**, **TERCEIRO** e **QUARTO**.

A classe `Matriz` deve possuir os seguintes métodos:

- **`boolean set(T objeto, int i, int j)`**: esse método deve colocar o objeto na posição i,j da matriz e retornar `true`. Caso um dos valores i ou j forem maiores que a ordem da matriz, o método deve retornar `false`.

- **`T get(int i, int j)`**: esse método deve retornar o objeto na posição i,j da matriz. Caso um dos valores i ou j forem maiores que a ordem da matriz, o método deve retornar `null`.

- **`List<T> getLinha(int linha)`**: esse método deve retornar uma lista contendo os elementos presentes na linha especificada como parâmetro.

- **`List<T> getColuna(int coluna)`**: esse método deve retornar uma lista contendo os elementos presentes na coluna especificada como parâmetro.

- **`List<T> getElementosQuadrante(Quadrante quadrante)`**: esse método deve retornar uma lista contendo os elementos presentes no quadrante passado como parâmetro.

### Exemplo — `getElementosQuadrante()`

Matriz 5×4 original:

| | Col 0 | Col 1 | Col 2 | Col 3 |
|---|---|---|---|---|
| **Linha 0** | 50 | 43 | 19 | 19 |
| **Linha 1** | 41 | 11 | 24 | 72 |
| **Linha 2** | 23 | 63 | 26 | 92 |
| **Linha 3** | 84 | 49 | 64 | 46 |
| **Linha 4** | 52 | 73 | 53 | 91 |
| **Linha 5** | 64 | 11 | 93 | 62 | 15 |

Resultados:

- `matriz.getElementosQuadrante(Quadrante.PRIMEIRO)` → `[50, 43, 19, 11, 24, 72, 26, 92, 84]`
- `matriz.getElementosQuadrante(Quadrante.SEGUNDO)` → `[19, 41, 23, 63, 49, 64]`
- `matriz.getElementosQuadrante(Quadrante.TERCEIRO)` → `[46, 52, 73, 64, 11, 93]`
- `matriz.getElementosQuadrante(Quadrante.QUARTO)` → `[53, 91, 62, 15]`

> Exemplo de chamadas do método `getElementosQuadrante()` para cada um dos valores do enumerável Quadrante em uma matriz não-quadrada.

---

## Exercício 3

Utilizando a classe criada no exercício anterior, crie um programa em Java que leia do console uma matriz **5 × 5**, até que o usuário digite **-1** e exiba no console o **menor elemento** presente na matriz.

Para encontrar o menor elemento, o programa deve encontrar o menor elemento dos quadrantes e exibir o menor deles.

---

## Exercício 4

Crie um programa em Java que possui as classes **Equipe**, **Aluno** e **Turma**.

A **Turma** possui uma lista de Alunos, estes com **nome**, **idade** e **cinco notas**. A classe Turma possui:

- Um método para **adicionar novos alunos**
- Um método privado **`ordenarAlunosPorMedia()`** — deve rearranjar a lista de alunos, ordenando-os em ordem crescente de média
- Um método **`separarEmEquipes()`** — retorna uma lista de equipes contendo 3 ou 4 alunos, agrupados levando em consideração a média

### Agrupamento

Agrupe os alunos pegando um ou dois elementos do começo da lista ordenada por média e um ou dois alunos do final da lista.

**Exemplo de separação em equipes:**

| Nome | Média |
|---|---|
| Julia | 9.7 |
| Gabriela | 9.2 |
| Matheus | 8.7 |
| Isabela | 8.4 |
| Lucas | 7.8 |
| Marcos | 7.5 |
| Letícia | 7.2 |
| Beatriz | 6.6 |
| Rafael | 5.6 |
| Gabriel | 4.7 |

O programa deve ler do console os alunos (utilize o mesmo método apresentado no Exercício 1) e adicioná-los à Turma. Após terminada a leitura, o programa deve chamar o método `separarEmEquipes()` e após isso exibir as equipes, seus membros e a média de cada membro.

---

## Exercício 5

Crie um algoritmo em **Python** que seja capaz de ler um JSON e transformá-lo em um ou vários objetos do tipo **Filme**. Cada Filme possui: **titulo**, **ano**, **classificação indicativa** e **nota dos usuários**.

O programa deve ser capaz de listar todos os filmes do arquivo `.json` e ordená-los por nota.

Na classe Filme deve haver um método que, dado um pedaço de JSON recebido como parâmetro que represente um Filme, atribua os valores do JSON aos atributos do objeto.

### Formato do JSON esperado

```json
[
    {
        "titulo": "A Rainy Day in New York",
        "ano": 2019,
        "classificacao": "PG-13",
        "nota": 6.6
    },
    {
        "titulo": "Jurassic World: Fallen Kingdom",
        "ano": 2018,
        "classificacao": "PG-13",
        "nota": 6.2
    },
    {
        "titulo": "2001: A Space Odyssey",
        "ano": 1968,
        "classificacao": "G",
        "nota": 8.3
    },
    {
        "titulo": "Toy Story 4",
        "ano": 2019,
        "classificacao": "G",
        "nota": 7.8
    }
]
```

### Dica — Usando a biblioteca JSON em Python

```python
# importa a biblioteca do json
import json

# instancia uma string que contem um json
string_json = "{'cidade':'Joinville', 'bairros':['Floresta','America','Bom Retiro']}"

# transforma a string em um json/dicionario
json_do_exemplo = json.loads(string_json)

# acessando o array bairros
print(json_do_exemplo['bairros'])
```

> Os dados foram retirados do dataset *Complete IMDB Movies Dataset* e adaptados para o português de forma a tornar o exemplo mais didático. Caso deseje, utilize o arquivo .json original e transforme-o para um objeto.
