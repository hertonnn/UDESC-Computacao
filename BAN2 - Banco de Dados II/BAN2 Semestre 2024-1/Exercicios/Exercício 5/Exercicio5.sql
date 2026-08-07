-- 1) Recupere o CPF e o nome dos mecânicos que trabalham nos setores número 1 e 2 
-- (faça a consulta utilizado a cláusula IN).
		SELECT m.cpf, m.nome FROM mecanico m WHERE cods 
		IN (SELECT s.cods FROM setor s WHERE cods = 1 OR cods = 2)
		-- Outra opção
		SELECT m.cpf, m.nome FROM mecanico m WHERE cods IN (1, 2)
		-- Outra opção
		SELECT m.cpf, m.nome FROM mecanico m WHERE cods= 1 or cods= 2

-- 2) Recupere o CPF e o nome dos mecânicos que trabalham nos setores 'Funilaria' e 'Pintura' 
-- (faça a consulta utilizando sub-consultas aninhadas).
		SELECT m.cpf, m.nome FROM mecanico m WHERE cods IN (SELECT cods FROM setor WHERE nome IN ('Funilaria', 'Pintura'))
		-- Outra opção
		SELECT m.cpf, m.nome FROM mecanico m JOIN setor s using(cods) WHERE s.nome IN ('Funilaria','Pintura')

-- 3) Recupere o CPF e nome dos mecânicos que atenderam no dia 13/06/2014 (faça a consulta usando INNER JOIN).
		SELECT DISTINCT m.cpf, m.nome FROM mecanico m INNER JOIN conserto c ON m.codm = c.codm 
		WHERE c.data = '13/06/2014'

-- 4) Recupere o nome do mecânico, o nome do cliente e a hora do conserto para os consertos 
-- realizados no dia 12/06/2014 (faça a consulta usando INNER JOIN).
		SELECT m.nome, c.nome, con.hora FROM mecanico m INNER JOIN conserto con ON m.codm = con.codm 
		JOIN veiculo v using(codv) JOIN cliente c using(codc) WHERE con.data = '12/06/2014'

-- 5) Recupere o nome e a função de todos os mecânicos, e o número e o nome dos setores 
-- para os mecânicos que tenham essa informação.
		SELECT m.nome, m.funcao, s.cods, s.nome FROM mecanico m LEFT JOIN setor s using(cods)

-- 6) Recupere o nome de todos os mecânicos, e as datas dos consertos para os 
-- mecânicos que têm consertos feitos (deve aparecer apenas um registro de nome 
-- de mecânico para cada data de conserto).		
		SELECT m.nome, c.data, c.hora FROM mecanico m LEFT JOIN conserto c using(codm)
		-- Outra opção
		SELECT DISTINCT m.nome, c.data FROM mecanico m LEFT JOIN conserto c using(codm) ORDER BY m.nome	

-- 7) Recupere a média da quilometragem de todos os veículos dos clientes.
		SELECT avg(v.quilometragem) FROM veiculo v 
		-- Outra opção
		SELECT round(cast (avg(v.quilometragem) as numeric), 2) FROM veiculo v 
	

-- 8) Recupere a soma da quilometragem dos veículos de cada cidade onde residem seus proprietários.
		SELECT c.cidade, sum(v.quilometragem) FROM cliente c JOIN veiculo v ON(c.codc = v.codc) group by c.cidade

-- 9) Recupere a quantidade de consertos feitos por cada mecânico durante o período de 12/06/2014 até 19/06/2014
		SELECT m.nome, count(*) FROM mecanico m JOIN conserto c using(codm) 
		WHERE c.data between '12/06/2014' and '19/06/2014' 
		group by m.nome

-- 10) Recupere a quantidade de consertos feitos agrupada pela marca do veículo.
		SELECT v.marca, count(*) FROM veiculo v JOIN conserto c using(codv) group by v.marca

-- 11) Recupere o modelo, a marca e o ano dos veículos que têm quilometragem maior que a 
-- média de quilometragem de todos os veículos.
		SELECT v.modelo, v.modelo, v.ano, v.quilometragem FROM veiculo v WHERE v.quilometragem >
		(SELECT avg(v.quilometragem) FROM veiculo v)

-- 12) Recupere o nome dos mecânicos que têm mais de um conserto marcado para o mesmo dia.	
		SELECT m.nome, c.data, count(*) FROM mecanico m JOIN conserto c using(codm) 
		group by m.nome, c.data having count(*) > 1

		