-- 1 - Faça uma expressão SQL que utilize o operador IN e que retorne o nome e CPF dos médicos que também são pacientes do hospital  
SELECT nome, cpf
FROM medicos WHERE cpf  
IN (SELECT cpf FROM pacientes)

-- 2 - Faça uma expressão SQL que utilize o operador IN e que retorne o nome e idade dos médicos que têm consulta com a paciente Ana 
SELECT nome, idade 
FROM medicos 
WHERE codm 
IN (SELECT m.codm 
	FROM medicos m 
	JOIN consultas c ON m.codm = c.codm
	JOIN pacientes p ON c.codp = p.codp
	WHERE p.nome = 'Ana')

-- 3 - Faça uma expressão SQL que utilize o operador IN e que retorne o número e andar dos ambulatórios onde nenhum médico dá atendimento  
SELECT nroa, andar 
FROM ambulatorios 
WHERE nroa NOT IN 
	(SELECT DISTINCT nroa 
	 FROM medicos)
-- 4 - Faça uma expressão SQL que utilize o operador IN e que retorne o nome, CPF e idade dos pacientes que têm consultas marcadas sempre para dias anteriores ao dia 16  
SELECT nome, cpf, idade
FROM pacientes 
WHERE codp IN(
	SELECT codp 
	FROM consultas
	WHERE date_part('DAY', data) < 16
	)
-- 5 - Faça uma expressão SQL que utilize o operador ANY/ALL e que retorne o números e andares de todos os ambulatórios, exceto o de menor capacidade 
SELECT DISTINCT nroa, andar
FROM ambulatorios
WHERE capacidade > ANY (
	SELECT capacidade
	FROM ambulatorios
)
-- 6 - Faça uma expressão SQL que utilize o operador ANY/ALL e que retorne o nome e idade dos médicos que têm consulta com a paciente Ana  
SELECT DISTINCT nome, idade 
FROM medicos 
WHERE codm = ANY(
	SELECT c.codm 
	FROM consultas c 
	JOIN pacientes p ON c.codp = p.codp
	WHERE p.nome = 'Ana'
)
-- 7 - Faça uma expressão SQL que utilize o operador ANY/ALL e que retorne o nome e a idade do médico mais jovem (sem usar função MIN!)  
SELECT nome, idade 
FROM medicos 
WHERE idade <= ALL (
	SELECT idade 
	FROM medicos
)

-- 8 - Faça uma expressão SQL que utilize o operador ANY/ALL e que retorne o nome e CPF dos pacientes com consultas marcadas para horários anteriores a todos os horários de consultas marcadas para o dia 12 de Novembro de 2006   
SELECT DISTINCT p.nome, p.cpf
FROM pacientes p
JOIN consultas c ON p.codp = c.codp
WHERE c.hora < ALL (
	SELECT hora
	FROM consultas 
	WHERE data = '2006-11-12'
)

-- 9 - Faça uma expressão SQL que utilize o operador EXISTS e que retorne o nome e idade dos médicos que têm consulta com a paciente Ana  
SELECT DISTINCT nome, idade 
FROM medicos m
WHERE EXISTS (
    SELECT 1
    FROM consultas c 
    JOIN pacientes p ON c.codp = p.codp
    WHERE p.nome = 'Ana'
    AND c.codm = m.codm
)
ORDER BY nome;

-- 10 - Faça uma expressão SQL que utilize o operador EXISTS e que retorne o número do ambulatório com a maior capacidade (sem usar função MAX!)  
SELECT nroa
FROM ambulatorios a1
WHERE NOT EXISTS (
    SELECT 1
    FROM ambulatorios a2
    WHERE a2.capacidade > a1.capacidade
)
ORDER BY nroa;
