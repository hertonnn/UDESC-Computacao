-- 1 - Faça uma consulta SQL que retorne o nome e CPF dos médicos que também são pacientes do hospital  
SELECT m.nome, 
	   m.cpf 
FROM medicos m 
JOIN pacientes p ON 
m.cpf = p.cpf
-- 2 - Faça uma consulta SQL que busque número e andar dos ambulatórios utilizados por médicos ortopedistas  
SELECT a.nroa,
	   a.andar
FROM  ambulatorios a
JOIN  medicos m ON a.nroa = m.nroa
WHERE m.especialidade = 'ortopedia'

-- 3 - Faça uma consulta SQL que busque nome e idade dos médicos que têm consulta com a paciente Ana 
SELECT DISTINCT m.nome,
	   m.idade
FROM medicos m 
JOIN consultas c ON m.codm = c.codm
JOIN pacientes p ON c.codp = p.codp
WHERE p.nome = 'Ana' 

-- 4 - Faça uma consulta SQL que busque código e nome dos médicos que atendem no mesmo ambulatório do médico Pedro e que possuem consultas marcadas para dia 14/06/2006  
SELECT DISTINCT m.codm,
	   m.nome 
FROM medicos m 
JOIN consultas c ON m.codm = c.codm
JOIN ambulatorios a ON m.nroa = a.nroa
WHERE m.nroa IN
(SELECT nroa FROM medicos WHERE nome = 'Pedro') 
AND c.data = '2006-06-14'
-- 5 - Faça uma consulta SQL que busque nome, CPF e idade dos pacientes que têm consultas marcadas com ortopedistas para dias anteriores ao dia 16  
SELECT DISTINCT p.nome,
       p.cpf,
       p.idade
FROM pacientes p 
JOIN consultas c ON p.codp = c.codp
JOIN medicos m ON c.codm = m.codm
WHERE m.especialidade = 'ortopedia' 
AND date_part('DAY', data) < 16;

-- 6 - Faça uma consulta SQL que busque dados de todos os ambulatórios e, para aqueles ambulatórios onde médicos dão atendimento, exibir também os seus códigos e nomes 
SELECT a.*, m.codm, m.nome
FROM ambulatorios a
LEFT JOIN medicos m ON a.nroa = m.nroa


-- 7 - Faça uma consulta SQL que busque CPF e nome de todos os médicos e, para aqueles médicos com consultas marcadas, exibir os CPFs e nomes dos seus pacientes e as datas das consultas  

SELECT DISTINCT m.cpf,
	   m.nome,
	   p.cpf AS cpf_paciente,
	   p.nome AS nome_paciente,
	   c.data
FROM medicos m 
LEFT JOIN consultas c ON m.codm = c.codm
LEFT JOIN pacientes p ON c.codp = p.codp;

-- ou 

SELECT DISTINCT m.cpf,
	   m.nome,
	   p.cpf,
	   p.nome,
	   c.data
FROM pacientes p 
JOIN consultas c ON p.codp = c.codp
RIGHT JOIN medicos m ON m.codm = c.codm;