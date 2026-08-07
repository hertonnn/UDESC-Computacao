-- 1) Mostre o nome e a função dos mecânicos.
		CREATE OR REPLACE VIEW mec_nome_funcao AS
		SELECT m.nome, m.funcao FROM mecanico m

		INSERT INTO mec_nome_funcao VALUES ('Teste1', 'Pintor')	

		SELECT nextval('mecanico_codm_seq')

		SELECT * FROM mecanico	

-- 2) Mostre o modelo e a marca dos veículos dos clientes.
		CREATE OR REPLACE VIEW cliente_modelo_marca AS
		SELECT c.nome, v.modelo, v.marca FROM veiculo v JOIN cliente c using(codc)

		SELECT * FROM cliente_modelo_marca

-- 3) Mostre o nome dos mecânicos, o nome dos clientes, o modelo dos veículos 
-- e a data e hora dos consertos realizados.
		CREATE OR REPLACE VIEW mec_cli_mdl_data_hora (nome_mecanico, nome_cliente, modelo, data, hora)AS
		SELECT m.nome, c.nome, v.modelo, con.data, con.hora FROM mecanico m JOIN conserto con USING(codm) 
		JOIN veiculo v USING(codv) JOIN cliente c USING (codc)

		SELECT * FROM mec_cli_mdl_data_hora

-- 4) Mostre o ano dos veículos e a média de quilometragem para cada ano.
		CREATE OR REPLACE VIEW ano_media_quilometragem AS
		SELECT v.ano, avg(v.quilometragem) AS quilometragem FROM veiculo v GROUP BY ano ORDER BY ano

		SELECT * FROM ano_media_quilometragem 

-- 5) Mostre o nome dos mecânicos e o total de consertos feitos por um mecânico em cada dia.
		CREATE OR REPLACE VIEW mecanico_concerto_dia AS
		SELECT m.nome, c.data, COUNT(c.codm)FROM mecanico m JOIN conserto c using(codm) 
		GROUP BY m.nome, c.data

		SELECT * FROM mecanico_concerto_dia

-- 6) Mostre o nome dos setores e o total de consertos feitos em um setor em cada dia.
		CREATE OR REPLACE VIEW setor_total_dia AS
		SELECT s.nome, COUNT(con.codm), con.data FROM setor s JOIN mecanico m using(cods) JOIN 
		conserto con USING(codm) GROUP BY s.nome, con.data ORDER BY con.data

		SELECT * FROM setor_total_dia

-- 7) Mostre o nome das funções e o número de mecânicos que têm uma destas funções.
		CREATE OR REPLACE VIEW funcoes_mecanicos AS 
		SELECT m.funcao, COUNT(m.codm) AS mecanicos FROM mecanico m GROUP BY funcao 

		SELECT * FROM funcoes_mecanicos 

-- 8) Mostre o nome dos mecânicos e suas funções e, para os mecânicos que estejam alocados
-- a um setor, informe também o número e nome do setor.
		CREATE OR REPLACE VIEW mecanicos_setores AS 
		SELECT m.nome AS nome_mecanico, m.funcao, s.cods, s.nome AS nome_setor 
		FROM mecanico m LEFT JOIN setor s using(cods) 

		SELECT * FROM mecanicos_setores

-- 9) Mostre o nome das funções dos mecânicos e a quantidade de consertos feitos agrupado por cada função.
		CREATE OR REPLACE VIEW funcao_consertos AS
		SELECT m.funcao, COUNT(con.codm) FROM mecanico m JOIN conserto con using(codm) GROUP BY m.funcao

		SELECT * FROM funcao_consertos