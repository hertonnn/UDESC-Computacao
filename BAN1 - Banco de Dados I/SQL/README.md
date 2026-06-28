# 📘 Resumo Geral dos Aprendizados em SQL

Este repositório contém um resumo organizado e prático dos principais conceitos e boas práticas aprendidas em SQL, com foco em consultas aplicadas ao banco de dados "Clínica".

---

## 🧠 1. Comandos e Operadores Aprendidos

- **`SELECT`**: Consulta dados com filtros (`WHERE`), ordenação (`ORDER BY`) e limites (`LIMIT` / `OFFSET`).
- **JOINs**:
  - `INNER JOIN`: Retorna registros com correspondência em ambas as tabelas.
  - `LEFT/RIGHT JOIN`: Retorna todos os registros de uma tabela, mesmo sem correspondência.
  - `CROSS JOIN`: Produto cartesiano (combina todas as linhas).
- **Agregação**:
  - `COUNT`, `SUM`, `AVG`, `MAX`, `MIN` com `GROUP BY` para agrupamento e `HAVING` para filtragem.
- **Subconsultas**:
  - `IN`, `EXISTS`, `ANY`, `ALL` para condições complexas.
  - `EXISTS` geralmente é mais eficiente que `IN`.
- **Operadores de Conjuntos**:
  - `UNION`: Combina resultados e remove duplicatas.
  - `EXCEPT`: Retorna diferença entre conjuntos.
- **Manipulação de Strings**:
  - `LIKE` com `%` (qualquer caractere) e `_` (um caractere), `LOWER()`, `UPPER()`, `TRIM()`.
- **Datas**:
  - `BETWEEN` para intervalos.
  - `date_part` para extrair partes de datas.

---

## 🔍 2. Padrões de Resolução

1. **Identificar Tabelas e Relacionamentos**:
   - Analisar chaves primárias e estrangeiras.
2. **Filtrar Dados**:
   - `WHERE` para condições simples.
   - Subconsultas para lógicas mais complexas.
3. **Agrupar e Ordenar**:
   - `GROUP BY` para análise agregada.
   - `ORDER BY` para organização dos resultados.
4. **Verificar Existência**:
   - `EXISTS` preferível em subconsultas correlacionadas.
5. **Evitar Duplicatas**:
   - Usar `DISTINCT` ou `GROUP BY` conforme necessário.
6. **Paginação**:
   - `LIMIT` e `OFFSET` para controle de resultados.

---

## ✅ 3. Boas Práticas

- **Formatação**:
  - Indentação clara.
  - Aliases descritivos (ex: `m` para `medicos`).
- **Performance**:
  - Evitar `SELECT *`; listar apenas colunas necessárias.
  - Priorizar `JOIN` sobre subconsultas quando possível.
  - Criar índices em colunas filtradas frequentemente.
- **Legibilidade**:
  - Nomes autoexplicativos para tabelas e colunas.
  - Comentários para trechos complexos.
- **Tratamento de Dados**:
  - Converter tipos (`CAST()`), padronizar textos (`LOWER()`), etc.

---

## 🏥 4. Casos Específicos no Banco "Clínica"

- **Médicos e Pacientes**:
  - Médicos que também são pacientes (`JOIN` ou `IN` no CPF).
- **Consultas**:
  - Filtro por data com `BETWEEN`.
  - Uso de `EXISTS` para identificar relacionamentos (ex: médico atendeu "Ana").
- **Ambulatórios**:
  - Encontrar o de maior capacidade com `MAX()` ou `NOT EXISTS`.
- **Estatísticas**:
  - Médias de idade (`AVG`), total de consultas por médico (`COUNT` + `GROUP BY`).

---

## 💡 5. Exemplos Práticos

### 🔸 Médicos mais jovens:
```sql
SELECT nome, idade
FROM medicos
WHERE idade <= ALL (SELECT idade FROM medicos)
ORDER BY nome;
```

### 🔸 Pacientes com consultas antes de 16/06:
```sql
SELECT DISTINCT p.nome
FROM pacientes p
INNER JOIN consultas c ON p.codp = c.codp
WHERE c.data < '2006-06-16';
```

### 🔸 Médicos sem consultas:
```sql
SELECT nome
FROM medicos m
WHERE NOT EXISTS (
  SELECT 1
  FROM consultas c
  WHERE c.codm = m.codm
);
```

---

## 📝 6. Lições Importantes

- **Subconsultas Correlacionadas**:
  - Sempre referenciar a consulta externa corretamente.
- **Alternativas a Funções Agregadas**:
  - `ALL`, `ANY` ou `NOT EXISTS` podem substituir `MAX`/`MIN`.
- **Cuidado com Duplicatas**:
  - Usar `DISTINCT` ou `GROUP BY` ao combinar múltiplas tabelas.

---

📌 **Autor**: Herton Silveira  
📆 **Última atualização**: Junho de 2025  
🎓 **Curso**: Ciência da Computação – UDESC  
🏥 **Contexto**: Projeto de estudo com base no banco de dados relacional de uma clínica
