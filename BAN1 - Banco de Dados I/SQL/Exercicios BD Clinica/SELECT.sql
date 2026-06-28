-- 1 - Buscar o nome e o cpf dos médicos com menos de 40 anos ou com especialidade diferente de traumatologia  
SELECT nome, cpf FROM medicos WHERE idade < 40 OR especialidade != 'traumatologia'
-- 2 - Buscar todos os dados das consultas marcadas no período da tarde após o dia 19/06/2006  
SELECT * FROM consultas 
WHERE hora BETWEEN '12:00' AND '17:59' 
AND data > '2006-06-19'
-- 3 - Buscar o nome e a idade dos pacientes que não residem em Florianópolis  
SELECT nome, idade FROM pacientes WHERE cidade != 'Florianopolis'
-- 4 - Buscar a hora das consultas marcadas antes do dia 14/06/2006 e depois do dia 20/06/2006  
SELECT hora FROM consultas 
WHERE data < '2006-06-14' OR data > '2006-06-20'
-- 5 - Buscar o nome e a idade (em meses) dos pacientes  
SELECT nome, (idade * 12) as idade_meses 
FROM pacientes
-- 6 - Em quais cidades residem os funcionários?  
SELECT DISTINCT cidade 
FROM funcionarios
ORDER BY cidade
-- 7 - Qual o menor e o maior salário dos funcionários da Florianópolis?  
SELECT MAX(salario) as maior_salario, 
       MIN(salario) as menor_salario 
FROM funcionarios 
WHERE cidade = 'Florianopolis'
-- 8 - Qual o horário da última consulta marcada para o dia 13/06/2006?  
SELECT MAX(hora) as ultima_consulta 
FROM consultas 
WHERE data = '2006-06-13'
-- 9 - Qual a média de idade dos médicos e o total de ambulatórios atendidos por eles?  
SELECT AVG(idade) as media_idade_medicos,
       COUNT(DISTINCT nroa) as total_ambulatorios  
FROM medicos
-- 10 - Buscar o código, o nome e o salário líquido dos funcionários. O salário líquido é obtido pela diferença entre o salário cadastrado menos 20% deste mesmo salário  
SELECT codf, nome, (0.8 * salario)
		as salario_liquido 
FROM funcionarios

-- 11 - Buscar o nome dos funcionários que terminam com a letra "a"  
SELECT nome 
FROM funcionarios 
WHERE nome LIKE '%a' 
-- 12 - Buscar o nome e CPF dos funcionários que não possuam a seqüência "00000" em seus CPFs 
SELECT nome, 
       cpf 
FROM funcionarios
WHERE CAST(cpf AS TEXT) NOT LIKE '%00000%'
ORDER BY nome
-- 13 - Buscar o nome e a especialidade dos médicos cuja segunda e a última letra de seus nomes seja a letra "o" 
SELECT nome, especialidade 
FROM medicos 
WHERE nome LIKE '_o%' 
AND nome LIKE '%o'
-- 14 - Buscar os códigos e nomes dos pacientes com mais de 25 anos que estão com tendinite, fratura, gripe e sarampo  
SELECT codp, 
       nome
FROM pacientes 
WHERE idade > 25 
  AND doenca IN ('tendinite', 'fratura', 'gripe', 'sarampo')
ORDER BY nome
