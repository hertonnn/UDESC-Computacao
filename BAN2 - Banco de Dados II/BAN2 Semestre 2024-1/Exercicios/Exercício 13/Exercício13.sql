-- Índices para a tabela mecanico
CREATE INDEX idx_mecanico_cods ON mecanico(cods);
CREATE INDEX idx_mecanico_cpf ON mecanico(cpf);
CREATE INDEX idx_mecanico_nome ON mecanico(nome);
CREATE INDEX idx_mecanico_funcao ON mecanico(funcao);

-- Índices para a tabela cliente
CREATE INDEX idx_cliente_cpf ON cliente(cpf);
CREATE INDEX idx_cliente_nome ON cliente(nome);
CREATE INDEX idx_cliente_cidade ON cliente(cidade);

-- Índices para a tabela veiculo
CREATE INDEX idx_veiculo_codc ON veiculo(codc);
CREATE INDEX idx_veiculo_marca ON veiculo(marca);
CREATE INDEX idx_veiculo_modelo ON veiculo(modelo);
CREATE INDEX idx_veiculo_ano ON veiculo(ano);
CREATE INDEX idx_veiculo_quilometragem ON veiculo(quilometragem);

-- Índices para a tabela conserto
CREATE INDEX idx_conserto_codm ON conserto(codm);
CREATE INDEX idx_conserto_codv ON conserto(codv);
CREATE INDEX idx_conserto_data ON conserto(data);
CREATE INDEX idx_conserto_hora ON conserto(hora);
CREATE INDEX idx_conserto_data_codm ON conserto(data, codm);

-- Índices para a tabela setor
CREATE INDEX idx_setor_nome ON setor(nome);

-- 1) CPF e nome dos mecânicos que trabalham nos setores 
--    maiores que 100 e menores que 200

SELECT m.cpf, m.nome 
FROM mecanico m 
INNER JOIN setor s ON m.cods = s.cods 
WHERE s.cods BETWEEN 101 AND 199;

-- 2) CPF e nome dos mecânicos que atenderam no dia 13/06/2018

SELECT DISTINCT m.cpf, m.nome 
FROM mecanico m 
INNER JOIN conserto c ON m.codm = c.codm 
WHERE c.data = '2018-06-13';

-- 3) Nome do mecânico, nome do cliente e hora do conserto 
--    para consertos de 12/06/2018 à 25/09/2018

SELECT m.nome AS nome_mecanico, 
       cl.nome AS nome_cliente, 
       c.hora 
FROM conserto c 
INNER JOIN mecanico m ON c.codm = m.codm 
INNER JOIN veiculo v ON c.codv = v.codv 
INNER JOIN cliente cl ON v.codc = cl.codc 
WHERE c.data BETWEEN '2018-06-12' AND '2018-09-25';

-- 4) Nome e função de todos os mecânicos, e número e nome dos setores
--    (LEFT JOIN para incluir mecânicos sem setor)

SELECT m.nome AS nome_mecanico, 
       m.funcao, 
       s.cods AS numero_setor, 
       s.nome AS nome_setor 
FROM mecanico m 
LEFT JOIN setor s ON m.cods = s.cods 
ORDER BY m.nome;

-- 5) Nome de todos os mecânicos e datas dos consertos 
--    (um registro por mecânico/data)

SELECT DISTINCT m.nome AS nome_mecanico, 
                c.data 
FROM mecanico m 
INNER JOIN conserto c ON m.codm = c.codm 
ORDER BY m.nome, c.data;

-- 6) Média da quilometragem de veículos por cliente
--    (ordenado da maior para menor média)

SELECT cl.nome AS nome_cliente, 
       ROUND(AVG(v.quilometragem), 2) AS media_km 
FROM cliente cl 
INNER JOIN veiculo v ON cl.codc = v.codc 
GROUP BY cl.codc, cl.nome 
HAVING AVG(v.quilometragem) IS NOT NULL 
ORDER BY media_km DESC;

-- 7) Soma da quilometragem dos veículos por cidade dos proprietários

SELECT cl.cidade, 
       ROUND(SUM(v.quilometragem), 2) AS total_km 
FROM cliente cl 
INNER JOIN veiculo v ON cl.codc = v.codc 
WHERE v.quilometragem IS NOT NULL 
GROUP BY cl.cidade 
ORDER BY total_km DESC;

-- 8) Quantidade de consertos por mecânico (12/06/2018 até 19/10/2018)

SELECT m.nome AS nome_mecanico, 
       COUNT(*) AS qtd_consertos 
FROM mecanico m 
INNER JOIN conserto c ON m.codm = c.codm 
WHERE c.data BETWEEN '2018-06-12' AND '2018-10-19' 
GROUP BY m.codm, m.nome 
ORDER BY qtd_consertos DESC;

-- 9) Quantidade de consertos agrupada por marca do veículo

SELECT v.marca, 
       COUNT(*) AS qtd_consertos 
FROM veiculo v 
INNER JOIN conserto c ON v.codv = c.codv 
GROUP BY v.marca 
ORDER BY qtd_consertos DESC;

-- 10) Veículos com quilometragem maior que a média geral

WITH media_geral AS (
    SELECT AVG(quilometragem) AS media_km 
    FROM veiculo 
    WHERE quilometragem IS NOT NULL
)
SELECT v.modelo, v.marca, v.ano, v.quilometragem 
FROM veiculo v 
CROSS JOIN media_geral mg 
WHERE v.quilometragem > mg.media_km 
ORDER BY v.quilometragem DESC;

-- 11) Mecânicos com mais de um conserto no mesmo dia

SELECT m.nome AS nome_mecanico, 
       c.data, 
       COUNT(*) AS qtd_consertos_dia 
FROM mecanico m 
INNER JOIN conserto c ON m.codm = c.codm 
GROUP BY m.codm, m.nome, c.data 
HAVING COUNT(*) > 1 
ORDER BY c.data, qtd_consertos_dia DESC;

-- ANÁLISE DE PERFORMANCE
-- Para analisar a performance de qualquer consulta, usar: EXPLAIN ANALYZE [consulta];
-- Consulta 1:
EXPLAIN ANALYZE 
SELECT m.cpf, m.nome 
FROM mecanico m 
INNER JOIN setor s ON m.cods = s.cods 
WHERE s.cods BETWEEN 101 AND 199;

-- Atualizar estatísticas das tabelas
ANALYZE setor;
ANALYZE mecanico;
ANALYZE cliente;
ANALYZE veiculo;
ANALYZE conserto;

-- Uso dos índices
SELECT schemaname, tablename, indexname, idx_scan, idx_tup_read, idx_tup_fetch 
FROM pg_stat_user_indexes 
WHERE schemaname = 'public';