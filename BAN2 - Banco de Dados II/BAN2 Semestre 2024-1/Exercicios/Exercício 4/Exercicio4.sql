 -- 1) Recupere o nome e o endereço de cada cliente.
 	
	SELECT c.nome, c.endereco FROM cliente c  

-- 2) Recupere o nome e a função dos mecânicos que trabalham no setor número 2 (cods 2).
	
	SELECT m.nome, m.funcao FROM mecanico m WHERE cods = 2

-- 3) Recupere o CPF e o nome de todos os mecânicos que são clientes da oficina (utilize operação de conjuntos).
	
	SELECT m.cpf, m.nome FROM mecanico m NATURAL JOIN cliente c WHERE m.cpf = c.cpf AND m.nome = c.nome
	-- Outra forma de resolver
	SELECT m.cpf, m.nome FROM mecanico m 
	INTERSECT 
	SELECT c.cpf, c.nome FROM cliente c
	-- Fazer uma interseccao na tabela, no qual o nome e o cpf são iguais

-- 4) Recupere as cidades das quais os mecânicos e clientes são oriundos.
	
	SELECT m.cidade FROM mecanico m 
	UNION 
	SELECT c.cidade FROM cliente c

-- 5) Recupere as marcas distintas dos veículos dos clientes que moram em Joinville.
	
	SELECT DISTINCT v.marca FROM veiculo v NATURAL JOIN cliente c WHERE c.cidade = 'Joinville'
	-- Outra forma de resolver
	SELECT DISTINCT v.marca FROM veiculo v INNER JOIN cliente c ON c.codc = v.codc WHERE c.cidade = 'Joinville'
	-- Outra forma de resolver
	SELECT DISTINCT v.marca FROM veiculo v JOIN cliente c using (codc) WHERE c.cidade ILIKE 'Joinville'

-- 6) Recupere as funções distintas dos mecânicos da oficina.
	
	SELECT DISTINCT funcao FROM mecanico 

-- 7) Recupere todas as informações dos clientes que têm idade maior que 25 anos.
	
	SELECT * FROM cliente WHERE idade > 25

-- 8) Recupere o CPF e o nome dos mecânicos que trabalham no setor de mecânica.
	
	SELECT m.cpf, m.nome FROM mecanico m INNER JOIN setor s ON m.cods = s.cods WHERE s.nome = 'Mecânica'
	-- Outra forma de fazer
	SELECT m.cpf, m.nome FROM mecanico m JOIN setor s using(cods) WHERE s.nome ilike 'mecânica'

-- 9) Recupere o CPF e nome dos mecânicos que trabalharam no dia 13/06/2014.
	
	SELECT DISTINCT m.cpf, m.nome FROM mecanico m NATURAL JOIN conserto c WHERE c.data = '13/06/2014'

-- 10) Recupere o nome do cliente, o modelo do seu veículo, o nome do mecânico e sua função para todos 
-- os consertos realizados (utilize join para realizar a junção).
	
	SELECT c.nome as nome_cliente, v.modelo, m.nome as nome_mecanico, m.funcao 
	FROM cliente c JOIN veiculo v using (codc) JOIN conserto con using (codv)
	JOIN mecanico m using (codm)

-- 11) Recupere o nome do mecânico, o nome do cliente e a hora do conserto para as serviços realizados 
-- no dia 19/06/2014 (utilize join para realizar a junção).
	
	SELECT m.nome as nome_mecanico, c.nome as nome_cliente, con.hora 
	FROM cliente c JOIN veiculo v using (codc) JOIN conserto con using (codv) JOIN mecanico m using (codm)
	WHERE con.data = '19/06/2014' order by con.hora

-- 12) Recupere o código e o nome dos setores que foram utilizados entre os dias 12/06/2014 e 14/06/2014 
-- (utilize join para realizar a junção).

	SELECT s.cods, s.nome, c.data
	FROM setor s JOIN mecanico m using (cods)
	JOIN conserto c using (codm)
	WHERE c.data between '12/06/2014' and '14/06/2014' 
	order by c.data




		