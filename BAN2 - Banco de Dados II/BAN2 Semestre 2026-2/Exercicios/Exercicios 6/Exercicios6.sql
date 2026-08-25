-- 
-- Visão 1: Estoque Crítico — Produtos que Precisam de Reposição
-- Esta visão deve utilizar as tabelas produto, categoria e fornecedor, selecionando apenas 
-- os produtos cujo estoque atual é menor ou igual ao estoque mínimo, e deve projetar o 
-- código e o nome do produto, a categoria, o nome do fornecedor principal, o estoque atual, 
-- o estoque mínimo e uma coluna calculada com a quantidade sugerida para reposição.
-- 
CREATE VIEW vw_estoque_critico AS
SELECT 
    p.codigo_produto,
    p.nome_produto,
    c.nome_categoria,
    f.nome_fornecedor,
    p.estoque_atual,
    p.estoque_minimo,
    (p.estoque_minimo - p.estoque_atual) AS quantidade_sugerida_reposicao
FROM 
    PRODUTO p
JOIN 
    CATEGORIA c ON p.id_categoria = c.id_categoria
JOIN 
    FORNECEDOR f ON p.id_fornecedor = f.id_fornecedor
WHERE 
    p.estoque_atual <= p.estoque_minimo;


-- 
-- Visão 2: Posição de Estoque por Depósito
-- Esta visão deve utilizar as tabelas estoque_deposito, produto e deposito, considerando 
-- apenas registros com quantidade maior que zero, e deve projetar o nome do depósito, 
-- o código e o nome do produto, o preço de venda unitário, a quantidade disponível e 
-- o valor total daquele produto no depósito calculado como quantidade multiplicada pelo preço de venda.
-- 
CREATE VIEW vw_posicao_estoque_deposito AS
SELECT 
    d.nome_deposito,
    p.codigo_produto,
    p.nome_produto,
    p.preco_venda,
    ed.quantidade AS quantidade_disponivel,
    (ed.quantidade * p.preco_venda) AS valor_total_deposito
FROM 
    ESTOQUE_DEPOSITO ed
JOIN 
    PRODUTO p ON ed.id_produto = p.id_produto
JOIN 
    DEPOSITO d ON ed.id_deposito = d.id_deposito
WHERE 
    ed.quantidade > 0;


-- 
-- Visão 3: Resumo de Vendas por Produto
-- Esta visão deve utilizar as tabelas produto, item_pedido_venda e pedido_venda, considerando 
-- apenas os pedidos com status Faturado, e deve retornar por produto o total de pedidos 
-- distintos em que ele aparece, a quantidade total de unidades vendidas, a receita bruta 
-- acumulada e o ticket médio por linha de item, apresentando zero para produtos que ainda 
-- não possuam venda faturada.
-- 
CREATE VIEW vw_resumo_vendas_produto AS
SELECT 
    p.codigo_produto,
    p.nome_produto,
    COALESCE(COUNT(DISTINCT pv.id_pedido_venda), 0) AS total_pedidos,
    COALESCE(SUM(ipv.quantidade), 0) AS quantidade_total_vendida,
    COALESCE(SUM(ipv.subtotal), 0) AS receita_bruta_acumulada,
    COALESCE(AVG(ipv.subtotal), 0) AS ticket_medio_linha
FROM 
    PRODUTO p
LEFT JOIN 
    ITEM_PEDIDO_VENDA ipv ON p.id_produto = ipv.id_produto
LEFT JOIN 
    PEDIDO_VENDA pv ON ipv.id_pedido_venda = pv.id_pedido_venda AND pv.status = 'Faturado'
GROUP BY 
    p.id_produto, p.codigo_produto, p.nome_produto;


-- 
-- Visão 4: Resumo de Compras por Fornecedor
-- Esta visão deve utilizar as tabelas fornecedor e ordem_compra, garantindo que fornecedores 
-- sem ordens também apareçam no resultado, e deve retornar por fornecedor o total de ordens 
-- emitidas, o total de ordens já recebidas, o valor total comprado em ordens recebidas e 
-- o valor médio por ordem, apresentando zero quando não houver registros.
-- 
CREATE VIEW vw_resumo_compras_fornecedor AS
SELECT 
    f.nome_fornecedor,
    COUNT(oc.id_ordem_compra) AS total_ordens_emitidas,
    COALESCE(SUM(CASE WHEN oc.status = 'Recebido' THEN 1 ELSE 0 END), 0) AS total_ordens_recebidas,
    COALESCE(SUM(CASE WHEN oc.status = 'Recebido' THEN oc.valor_total ELSE 0 END), 0) AS valor_total_comprado,
    COALESCE(AVG(CASE WHEN oc.status = 'Recebido' THEN oc.valor_total ELSE NULL END), 0) AS valor_medio_ordem
FROM 
    FORNECEDOR f
LEFT JOIN 
    ORDEM_COMPRA oc ON f.id_fornecedor = oc.id_fornecedor
GROUP BY 
    f.id_fornecedor, f.nome_fornecedor;


-- 
-- Visão 5: Movimentações Detalhadas de Estoque
-- Esta visão deve utilizar as tabelas movimentacao, produto, usuario e deposito (com dois 
-- LEFT JOINs usando aliases distintos para origem e destino), e deve projetar a data da 
-- movimentação, o tipo, o código e o nome do produto, a quantidade movimentada, os nomes 
-- do depósito de origem e do depósito de destino e o nome do usuário que registrou o evento.
-- 
CREATE VIEW vw_movimentacoes_detalhadas AS
SELECT 
    m.data_movimentacao,
    m.tipo_movimentacao,
    p.codigo_produto,
    p.nome_produto,
    m.quantidade,
    d_origem.nome_deposito AS deposito_origem,
    d_destino.nome_deposito AS deposito_destino,
    u.nome_completo AS nome_usuario
FROM 
    MOVIMENTACAO m
JOIN 
    PRODUTO p ON m.id_produto = p.id_produto
JOIN 
    USUARIO u ON m.id_usuario = u.id_usuario
LEFT JOIN 
    DEPOSITO d_origem ON m.id_deposito_origem = d_origem.id_deposito
LEFT JOIN 
    DEPOSITO d_destino ON m.id_deposito_destino = d_destino.id_deposito;


-- 
-- Visão 6: Pedidos de Venda em Aberto ou Confirmados
-- Esta visão deve utilizar as tabelas pedido_venda, cliente e usuario, filtrando apenas 
-- os pedidos com status Aberto ou Confirmado, e deve projetar o identificador do pedido, 
-- a data, o status, o nome do cliente, o CPF ou CNPJ do cliente, o nome do usuário 
-- responsável pelo lançamento e o valor total do pedido.
-- 
CREATE VIEW vw_pedidos_abertos_confirmados AS
SELECT 
    pv.id_pedido_venda,
    pv.data_pedido,
    pv.status,
    c.nome_cliente,
    c.cpf_cnpj,
    u.nome_completo AS usuario_responsavel,
    pv.valor_total
FROM 
    PEDIDO_VENDA pv
JOIN 
    CLIENTE c ON pv.id_cliente = c.id_cliente
JOIN 
    USUARIO u ON pv.id_usuario = u.id_usuario
WHERE 
    pv.status IN ('Aberto', 'Confirmado');


-- 
-- Visão 7: Ordens de Compra Pendentes
-- Esta visão deve utilizar as tabelas ordem_compra e fornecedor, filtrando apenas as 
-- ordens com status Pendente, e deve projetar o identificador da ordem, a data de emissão, 
-- a data prevista de recebimento, o nome e o CNPJ do fornecedor, o valor total estimado e 
-- o número de dias restantes até a data de previsão calculado em relação à data atual.
-- 
CREATE VIEW vw_ordens_compra_pendentes AS
SELECT 
    oc.id_ordem_compra,
    oc.data_emissao,
    oc.data_previsao,
    f.nome_fornecedor,
    f.cnpj,
    oc.valor_total AS valor_total_estimado,
    -- A função DATEDIFF pode variar dependendo do banco. Abaixo está a sintaxe para MySQL/SQL Server:
    DATEDIFF(oc.data_previsao, CURRENT_DATE) AS dias_restantes
    -- Para PostgreSQL, use: (oc.data_previsao - CURRENT_DATE) AS dias_restantes
FROM 
    ORDEM_COMPRA oc
JOIN 
    FORNECEDOR f ON oc.id_fornecedor = f.id_fornecedor
WHERE 
    oc.status = 'Pendente';


-- 
-- Visão 8: Desempenho de Estoque por Categoria
-- Esta visão deve utilizar as tabelas categoria, produto e estoque_deposito, garantindo que 
-- categorias sem produtos em estoque também apareçam no resultado, e deve retornar por 
-- categoria o número de produtos distintos cadastrados, a quantidade total de itens em estoque, 
-- o valor total e o custo total em estoque calculados pelos preços de venda e de custo, 
-- respectivamente, além da margem bruta média estimada em percentual.
-- 
CREATE VIEW vw_desempenho_estoque_categoria AS
SELECT 
    c.nome_categoria,
    COUNT(DISTINCT p.id_produto) AS num_produtos_cadastrados,
    COALESCE(SUM(ed.quantidade), 0) AS quantidade_total_estoque,
    COALESCE(SUM(ed.quantidade * p.preco_venda), 0) AS valor_total_estoque,
    COALESCE(SUM(ed.quantidade * p.preco_custo), 0) AS custo_total_estoque,
    CASE 
        WHEN SUM(ed.quantidade * p.preco_venda) > 0 
        THEN ((SUM(ed.quantidade * p.preco_venda) - SUM(ed.quantidade * p.preco_custo)) / SUM(ed.quantidade * p.preco_venda)) * 100
        ELSE 0 
    END AS margem_bruta_media_percentual
FROM 
    CATEGORIA c
LEFT JOIN 
    PRODUTO p ON c.id_categoria = p.id_categoria
LEFT JOIN 
    ESTOQUE_DEPOSITO ed ON p.id_produto = ed.id_produto
GROUP BY 
    c.id_categoria, c.nome_categoria;


-- 
-- Visão 9: Clientes Sem Pedidos de Venda
-- Esta visão deve utilizar as tabelas cliente e pedido_venda, retornando apenas os clientes 
-- que nunca realizaram nenhum pedido de venda, e deve projetar o identificador, o nome, 
-- o CPF ou CNPJ, o telefone e o e-mail do cliente, sendo útil para campanhas de prospecção e 
-- reativação comercial.
-- 
CREATE VIEW vw_clientes_sem_pedidos AS
SELECT 
    c.id_cliente,
    c.nome_cliente,
    c.cpf_cnpj,
    c.telefone,
    c.email
FROM 
    CLIENTE c
LEFT JOIN 
    PEDIDO_VENDA pv ON c.id_cliente = pv.id_cliente
WHERE 
    pv.id_pedido_venda IS NULL;


-- 
-- Visão 10: Produtos Sem Movimentação de Estoque
-- Esta visão deve utilizar as tabelas produto, categoria e movimentacao, retornando apenas 
-- os produtos que nunca tiveram nenhum registro de movimentação de estoque, e deve projetar 
-- o código, o nome, a categoria, o preço de venda e o estoque mínimo do produto, sendo 
-- útil para identificar itens inativos ou ainda não operacionalizados no sistema.
-- 
CREATE VIEW vw_produtos_sem_movimentacao AS
SELECT 
    p.codigo_produto,
    p.nome_produto,
    c.nome_categoria,
    p.preco_venda,
    p.estoque_minimo
FROM 
    PRODUTO p
JOIN 
    CATEGORIA c ON p.id_categoria = c.id_categoria
LEFT JOIN 
    MOVIMENTACAO m ON p.id_produto = m.id_produto
WHERE 
    m.id_movimentacao IS NULL;