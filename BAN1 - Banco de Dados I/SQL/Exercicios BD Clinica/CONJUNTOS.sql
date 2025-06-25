-- 1 - Faça uma consulta SQL que retorne o nome e cpf de médicos, e logo abaixo dos dados de médicos, mostrar nome e cpf de pacientes  
SELECT nome, cpf, 'Médico' as tipo
FROM medicos
UNION
SELECT nome, cpf, 'Paciente' as tipo
FROM pacientes
ORDER BY tipo, nome;

-- 2 - Faça uma consulta em SQL que retorne o nome e cpf dos Pacientes que são também funcionários da Clínica  
SELECT nome, cpf
FROM pacientes
INTERSECT 
SELECT nome, cpf
FROM funcionarios
ORDER BY nome; 
-- 3 - Faça uma consulta SQL que retorne o código e nome dos pacientes que nunca consultaram o médico que se chama Pedro  
SELECT codp, nome 
FROM pacientes 
EXCEPT
SELECT p.codp, 
	   p.nome 
FROM pacientes p 
JOIN consultas c ON p.codp = c.codp
JOIN medicos m ON c.codm = m.codm
WHERE m.nome = 'Pedro'
-- 4 - Faça uma consulta SQL que retorne o código e nome dos pacientes que APENAS consultaram o médico que se chama Pedro  
SELECT p.codp, 
	   p.nome
FROM pacientes p
JOIN consultas c ON p.codp = c.codp
EXCEPT 
SELECT p.codp, 
	   p.nome
FROM pacientes p
JOIN consultas c ON p.codp = c.codp
JOIN medicos m ON c.codm = m.codm
AND m.nome != 'Pedro'
-- 5 - Faça uma consulta SQL que retorne o nome e cpf do(s) funcionário(s) que tem o maior salário  
SELECT nome, cpf 
FROM funcionarios
WHERE salario = 
(SELECT MAX(salario) FROM funcionarios)

-- ou

SELECT nome, cpf FROM funcionarios
EXCEPT 
SELECT f1.nome, f1.cpf 
FROM funcionarios f1 
JOIN funcionarios f2 ON f1.salario < f2.salario; 