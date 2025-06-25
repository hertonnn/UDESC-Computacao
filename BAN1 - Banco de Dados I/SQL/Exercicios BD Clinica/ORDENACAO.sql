-- 1 - Faça uma expressão SQL que retorne o nome e CPF dos médicos que têm consultas marcadas com todos os pacientes  
SELECT DISTINCT m.nome, m.cpf
FROM medicos m
WHERE NOT EXISTS (
    SELECT p.codp
    FROM pacientes p
    WHERE NOT EXISTS (
        SELECT 1
        FROM consultas c
        WHERE c.codm = m.codm
        AND c.codp = p.codp
    )
)
ORDER BY m.nome;

-- 2 - Faça uma expressão SQL que retorne o nome e CPF dos médicos ortopedistas que têm consultas marcadas com todos os pacientes de Florianópolis  
SELECT DISTINCT m.nome, m.cpf
FROM medicos m 
WHERE m.especialidade = 'ortopedia'
AND NOT EXISTS (
    SELECT p.codp
    FROM pacientes p
    WHERE p.cidade = 'Florianopolis'
    AND NOT EXISTS (
        SELECT 1 
        FROM consultas c 
        WHERE c.codm = m.codm
        AND c.codp = p.codp
    )
)
ORDER BY m.nome;

-- 3 - Faça uma expressão SQL que retorne todos os dados das consultas marcadas para a médica Maria. Faça esta expressão utilizando subconsulta na cláusula FROM  
SELECT * FROM (
	medicos m 
	JOIN consultas c ON m.codm = c.codm
) 
WHERE m.nome = 'Maria'

-- 4 - Faça uma expressão SQL que retorne os dados de todos os funcionários ordenados pelo salário (decrescente) e pela idade (crescente). Os 3 peimeiros.
SELECT * 
FROM funcionarios
ORDER BY salario DESC, idade ASC
LIMIT 3;

-- 5 - Faça uma expressão SQL que retorne o nome do médico e o nome dos pacientes com consulta marcada, ordenado pela data e pela hora. Buscar apenas as tuplas 3 a 5, nesta ordem  
SELECT m.nome as nome_medico, p.nome as nome_paciente
FROM medicos m
INNER JOIN consultas c ON m.codm = c.codm
INNER JOIN pacientes p ON c.codp = p.codp
ORDER BY c.data, c.hora
LIMIT 3 OFFSET 2;

-- 6 - Faça uma expressão SQL que retorne as idades dos médicos e o total de médicos com a mesma idade  
SELECT idade, COUNT(*) as total_medicos
FROM medicos
GROUP BY idade
ORDER BY idade;

-- 7 - Faça uma expressão SQL que retorne andares onde existem ambulatórios cuja média de capacidade no andar seja >= 40  
SELECT andar, AVG(capacidade) AS media_capacidade
FROM ambulatorios
GROUP BY andar
HAVING AVG(capacidade) >= 40;

-- 8 - Faça uma expressão SQL que retorne o nome dos médicos que possuem mais de uma consulta marcada  
SELECT m.nome 
FROM medicos m 
JOIN consultas c ON c.codm = m.codm
GROUP BY m.codm, m.nome
HAVING COUNT(*) > 1;

-- 9 - Faça uma expressão SQL capaz de passar para 21/11/2006 todas as consultas do médico Pedro marcadas antes do meio-dia  
UPDATE consultas
SET data = '2006-11-21'
WHERE codm IN (
    SELECT codm 
    FROM medicos 
    WHERE nome = 'Pedro'
)
AND data < '2006-11-21'
AND hora < '12:00';

-- 10 - O funcionário Caio (codf = 3) tornou-se médico. Sua especialidade é a mesma da médica Maria (codm = 2) e ele vai atender no mesmo ambulatório dela. Faça uma expressão SQL capaz de inserir Caio na tabela Médicos  
INSERT INTO medicos (codm, nome, idade, especialidade, cpf, cidade, nroa)
SELECT 5, f.nome, f.idade, m.especialidade, f.cpf, f.cidade, m.nroa
FROM funcionarios f
CROSS JOIN medicos m
WHERE f.codf = 3 
AND m.codm = 2;
