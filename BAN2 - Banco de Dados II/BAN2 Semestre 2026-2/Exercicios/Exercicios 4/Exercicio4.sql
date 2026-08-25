/*
Consulta 1: Listar Produtos com Estoque Abaixo do Mínimo

Esta consulta deve utilizar a tabela produto, selecionando apenas os
produtos que têm estoque atual abaixo do mínimo, e deve
projetar o seu código, nome, estoque atual e mínimo.
*/

select id_produto,codigo_produto,nome_produto,estoque_atual,estoque_minimo from produto where estoque_minimo > estoque_atual;

/*
Consulta 2: Relatório de Vendas por Período

Esta consulta deve utilizar as tabelas item_pedido_venda, pedido_venda e produto,
filtrando apenas os pedidos faturados em um intervalo de datas definido,
e deve retornar por produto o total de unidades vendidas e a receita total no período.
*/

select * from pedido_venda;

SELECT p.id_produto,p.nome_produto,
SUM(ipv.quantidade) AS total_unidades_vendidas,
SUM(ipv.subtotal) AS receita_total
FROM pedido_venda pv
JOIN item_pedido_venda ipv
ON pv.id_pedido_venda = ipv.id_pedido_venda
JOIN produto p
ON ipv.id_produto = p.id_produto
WHERE pv.status = 'FATURADO'
AND pv.data_pedido BETWEEN '2025-01-20' AND '2025-01-25'
GROUP BY
p.id_produto,
p.nome_produto
ORDER BY
receita_total DESC;


/*
Consulta 3: Posição de Estoque por Depósito

Esta consulta deve utilizar as tabelas estoque_deposito, deposito e produto, exibindo apenas as
posições com quantidade maior que zero, e deve projetar o nome do depósito, o nome do produto e a quantidade disponível.
*/

SELECT * from deposito;
SELECT * from produto;
SELECT * from estoque_deposito;

select d.nome_deposito, p.nome_produto, e.quantidade
from deposito d
join estoque_deposito e
on d.id_deposito = e.id_deposito
join produto p
on e.id_produto = p.id_produto where e.quantidade > 0;


/*
Consulta 4: Histórico de Movimentações de um Produto

Esta consulta deve utilizar a tabela movimentacao, incluindo o nome dos depósitos de origem e destino e o
nome do usuário responsável, filtrando por um produto específico, e deve projetar a data,
o tipo de movimentação, a quantidade, o depósito de origem, o depósito de destino e o responsável pelo registro.

*/

select * from movimentacao;


SELECT
m.data_movimentacao,
m.tipo_movimentacao,
m.quantidade,
d_origem.nome_deposito AS deposito_origem,
d_destino.nome_deposito AS deposito_destino,
u.nome_completo AS responsavel
FROM movimentacao m
LEFT JOIN deposito d_origem
ON m.id_deposito_origem = d_origem.id_deposito
LEFT JOIN deposito d_destino
ON m.id_deposito_destino = d_destino.id_deposito
JOIN usuario u
ON m.id_usuario = u.id_usuario
WHERE m.id_produto = 1
ORDER BY m.data_movimentacao;

/*
Consulta 5: Top 5 Produtos Mais Vendidos

Esta consulta deve utilizar as tabelas item_pedido_venda e produto, contando quantas vezes cada produto
foi incluído em pedidos de venda, e deve retornar apenas os cinco produtos com maior frequência de venda.
*/

SELECT p.id_produto,p.nome_produto,
COUNT(ipv.id_produto) AS frequencia_venda
FROM item_pedido_venda ipv
JOIN produto p
ON ipv.id_produto = p.id_produto
GROUP BY
p.id_produto,
p.nome_produto
ORDER BY
frequencia_venda DESC
LIMIT 5;


/*
Consulta 6: Relatório de Compras por Fornecedor

Esta consulta deve utilizar as tabelas ordem_compra e fornecedor, considerando apenas as ordens com
status Recebido, e deve retornar por fornecedor o total de ordens emitidas e o valor total comprado.
*/


SELECT
f.id_fornecedor,
f.nome_fornecedor,
COUNT(oc.id_ordem_compra) AS total_ordens,
SUM(oc.valor_total) AS valor_total_comprado
FROM ordem_compra oc
JOIN fornecedor f
ON oc.id_fornecedor = f.id_fornecedor
WHERE oc.status = 'Recebido'
GROUP BY
f.id_fornecedor,
f.nome_fornecedor
ORDER BY
valor_total_comprado DESC;

/*
Consulta 7: Total de Produtos por Categoria (incluindo categorias sem produtos)

Esta consulta deve utilizar as tabelas categoria e produto, garantindo que categorias sem produtos
associados também apareçam no resultado, e deve retornar para cada categoria o total de produtos a ela vinculados.
*/
SELECT
c.id_categoria,
c.nome_categoria,
COUNT(p.id_produto) AS total_produtos
FROM categoria c
LEFT JOIN produto p
ON c.id_categoria = p.id_categoria
GROUP BY
c.id_categoria,
c.nome_categoria
ORDER BY
c.nome_categoria;

/*
Consulta 8: Valor Total em Estoque por Depósito com Média de Preços

Esta consulta deve utilizar as tabelas deposito, estoque_deposito e produto, considerando apenas posições
com quantidade maior que zero, e deve retornar por depósito o número de produtos
distintos armazenados, a quantidade total de itens, o valor total em estoque e o preço médio dos produtos.
*/

SELECT
d.id_deposito,
d.nome_deposito,
COUNT(DISTINCT p.id_produto) AS produtos_distintos,
SUM(e.quantidade) AS quantidade_total,
SUM(e.quantidade * p.preco_venda) AS valor_total_estoque,
AVG(p.preco_venda) AS preco_medio
FROM deposito d
JOIN estoque_deposito e
ON d.id_deposito = e.id_deposito
JOIN produto p
ON e.id_produto = p.id_produto
WHERE e.quantidade > 0
GROUP BY
d.id_deposito,
d.nome_deposito
ORDER BY
d.nome_deposito;
/*
Consulta 9: Fornecedores e Total de Ordens de Compra (incluindo fornecedores sem ordens)

Esta consulta deve utilizar as tabelas fornecedor e ordem_compra,
garantindo que fornecedores sem ordens também apareçam no resultado, e deve
retornar por fornecedor o total de ordens emitidas, o valor total comprado e o valor
médio por ordem, apresentando zero quando não houver registros.
*/

SELECT
f.id_fornecedor,
f.nome_fornecedor,
COUNT(oc.id_ordem_compra) AS total_ordens,
COALESCE(SUM(oc.valor_total), 0) AS valor_total_comprado,
COALESCE(AVG(oc.valor_total), 0) AS valor_medio_por_ordem
FROM fornecedor f
LEFT JOIN ordem_compra oc
ON f.id_fornecedor = oc.id_fornecedor
GROUP BY
f.id_fornecedor,
f.nome_fornecedor
ORDER BY
f.nome_fornecedor;


/*
Consulta 10: Clientes com Total de Pedidos e Valores (incluindo clientes sem pedidos)

Esta consulta deve utilizar as tabelas cliente e pedido_venda,
garantindo que clientes sem pedidos também apareçam no resultado, e deve retornar
por cliente o total de pedidos realizados, o valor total comprado e o ticket médio,
apresentando zero quando não houver registros.
*/

SELECT
c.id_cliente,
c.nome_cliente,
COUNT(pv.id_pedido_venda) AS total_pedidos,
COALESCE(SUM(pv.valor_total), 0) AS valor_total_comprado,
COALESCE(AVG(pv.valor_total), 0) AS ticket_medio
FROM cliente c
LEFT JOIN pedido_venda pv
ON c.id_cliente = pv.id_cliente
GROUP BY
c.id_cliente,
c.nome_cliente
ORDER BY
c.nome_cliente;


/*
Consulta 11: Histórico de Entradas e Saídas por Produto

Esta consulta deve utilizar as tabelas produto e movimentacao, garantindo
que produtos sem movimentações também apareçam no resultado, e deve retornar por
produto os totais separados de entradas, saídas e reservas, além do número total de movimentações registradas.
*/

SELECT
p.id_produto,
p.nome_produto,
COALESCE(SUM(
CASE
WHEN m.tipo_movimentacao = 'ENTRADA' THEN m.quantidade
ELSE 0
END
), 0) AS total_entradas,
COALESCE(SUM(
CASE
WHEN m.tipo_movimentacao = 'SAIDA' THEN m.quantidade
ELSE 0
END
), 0) AS total_saidas,
COALESCE(SUM(
CASE
WHEN m.tipo_movimentacao = 'RESERVA' THEN m.quantidade
ELSE 0
END
), 0) AS total_reservas,
COUNT(m.id_movimentacao) AS total_movimentacoes
FROM produto p
LEFT JOIN movimentacao m
ON p.id_produto = m.id_produto
GROUP BY
p.id_produto,
p.nome_produto
ORDER BY
p.nome_produto;


/*
Consulta 12: Resumo de Movimentações por Mês e Tipo

Esta consulta deve utilizar a tabela movimentacao, agrupando os
registros por mês e por tipo de movimentação, e deve retornar para cada
combinação o total de movimentações, o volume total movimentado e a quantidade
de produtos e usuários distintos envolvidos.
*/

SELECT
DATE_FORMAT(m.data_movimentacao, '%Y-%m') AS mes,
m.tipo_movimentacao,
COUNT(m.id_movimentacao) AS total_movimentacoes,
SUM(m.quantidade) AS volume_total_movimentado,
COUNT(DISTINCT m.id_produto) AS produtos_distintos,
COUNT(DISTINCT m.id_usuario) AS usuarios_distintos
FROM movimentacao m
GROUP BY
DATE_FORMAT(m.data_movimentacao, '%Y-%m'),
m.tipo_movimentacao
ORDER BY
mes,
m.tipo_movimentacao;


/*
Consulta 13: Depósitos com Resumo de Estoque e Produtos (incluindo depósitos vazios)

Esta consulta deve utilizar as tabelas deposito, estoque_deposito e
produto, garantindo que depósitos sem produtos em estoque também apareçam no
resultado, e deve retornar por depósito o número de produtos distintos armazenados, a
quantidade total de itens e o valor total em estoque.
*/

SELECT
d.id_deposito,
d.nome_deposito,
COUNT(DISTINCT p.id_produto) AS produtos_distintos,
COALESCE(SUM(e.quantidade), 0) AS quantidade_total_itens,
COALESCE(SUM(e.quantidade * p.preco_venda), 0) AS valor_total_estoque
FROM deposito d
LEFT JOIN estoque_deposito e
ON d.id_deposito = e.id_deposito
AND e.quantidade > 0
LEFT JOIN produto p
ON e.id_produto = p.id_produto
GROUP BY
d.id_deposito,
d.nome_deposito
ORDER BY
d.nome_deposito;


/*
Consulta 14: Usuários e Volume de Movimentações Registradas (incluindo usuários sem registros)

Esta consulta deve utilizar as tabelas usuario e movimentacao,
garantindo que usuários sem movimentações também apareçam no resultado,
e deve retornar por usuário o total de movimentações realizadas, o volume
total de itens movimentados e a quantidade de produtos e tipos de operação distintos.
*/

SELECT
u.id_usuario,
u.nome_completo,
COUNT(m.id_movimentacao) AS total_movimentacoes,
COALESCE(SUM(m.quantidade), 0) AS volume_total_itens,
COUNT(DISTINCT m.id_produto) AS produtos_distintos,
COUNT(DISTINCT m.tipo_movimentacao) AS tipos_operacao_distintos
FROM usuario u
LEFT JOIN movimentacao m
ON u.id_usuario = m.id_usuario
GROUP BY
u.id_usuario,
u.nome_completo
ORDER BY
u.nome_completo;

/*
Consulta 15: Produtos e Total Vendido com Receita por Período (incluindo produtos sem vendas)

Esta consulta deve utilizar as tabelas produto, item_pedido_venda e
pedido_venda, filtrando por status e período de datas e garantindo que
produtos sem vendas no período também apareçam, e deve retornar por produto
o total de pedidos, as unidades vendidas, a receita bruta e o ticket médio por item.
*/

SELECT
p.id_produto,
p.nome_produto,
COUNT(DISTINCT pv.id_pedido_venda) AS total_pedidos,
COALESCE(SUM(ipv.quantidade), 0) AS unidades_vendidas,
COALESCE(SUM(ipv.subtotal), 0) AS receita_bruta,
COALESCE(AVG(ipv.valor_unitario), 0) AS ticket_medio_por_item
FROM produto p
LEFT JOIN item_pedido_venda ipv
ON p.id_produto = ipv.id_produto
LEFT JOIN pedido_venda pv
ON ipv.id_pedido_venda = pv.id_pedido_venda
AND pv.status = 'Faturado'
AND pv.data_pedido BETWEEN '2026-01-01' AND '2026-12-31'
GROUP BY
p.id_produto,
p.nome_produto
ORDER BY
p.nome_produto;


/*
Consulta 16: Categorias com Valor Total em Estoque e Margem Média (incluindo categorias sem estoque)

Esta consulta deve utilizar as tabelas categoria, produto e estoque_deposito,
garantindo que categorias sem produtos em estoque também apareçam no resultado,
e deve retornar por categoria o número de produtos distintos, o valor total e o
custo total em estoque, além da margem bruta média.
*/

SELECT
c.id_categoria,
c.nome_categoria,
COUNT(DISTINCT p.id_produto) AS produtos_distintos,
COALESCE(SUM(e.quantidade * p.preco_venda), 0) AS valor_total_estoque,
COALESCE(SUM(e.quantidade * p.preco_custo), 0) AS custo_total_estoque,
COALESCE(
AVG(
CASE
WHEN p.preco_venda > 0
THEN ((p.preco_venda - p.preco_custo) / p.preco_venda) * 100
ELSE 0
END
),
0
) AS margem_bruta_media
FROM categoria c
LEFT JOIN produto p
ON c.id_categoria = p.id_categoria
LEFT JOIN estoque_deposito e
ON p.id_produto = e.id_produto
AND e.quantidade > 0
GROUP BY
c.id_categoria,
c.nome_categoria
ORDER BY
c.nome_categoria;

/*
Consulta 17: Clientes com Detalhes de Pedidos e Itens Comprados (RIGHT OUTER JOIN)

Esta consulta deve utilizar as tabelas cliente, pedido_venda e item_pedido_venda,
garantindo que todos os pedidos apareçam mesmo sem cliente associado, filtrando
pelos status Faturado e Confirmado, e deve retornar por pedido os dados do c
liente, o número de itens e o total de unidades compradas.
*/

SELECT
pv.id_pedido_venda,
pv.data_pedido,
c.id_cliente,
c.nome_cliente,
COUNT(ipv.id_item_venda) AS numero_itens,
COALESCE(SUM(ipv.quantidade), 0) AS total_unidades_compradas
FROM cliente c
RIGHT JOIN pedido_venda pv
ON c.id_cliente = pv.id_cliente
LEFT JOIN item_pedido_venda ipv
ON pv.id_pedido_venda = ipv.id_pedido_venda
WHERE pv.status IN ('Faturado', 'Confirmado')
GROUP BY
pv.id_pedido_venda,
pv.data_pedido,
c.id_cliente,
c.nome_cliente
ORDER BY
pv.data_pedido;


/*
Consulta 18: Produtos com Compras e Vendas Consolidadas por Fornecedor (incluindo produtos sem movimentação comercial)

Esta consulta deve utilizar as tabelas produto, fornecedor, item_ordem_compra,
ordem_compra, item_pedido_venda e pedido_venda, garantindo que produtos sem compras ou
vendas registradas também apareçam, e deve retornar por fornecedor e produto o total comprado,
o custo total, o total vendido, a receita total e a margem bruta estimada.
*/

SELECT
f.id_fornecedor,
f.nome_fornecedor,
p.id_produto,
p.nome_produto,
COALESCE(c.total_comprado, 0) AS total_comprado,
COALESCE(c.custo_total, 0) AS custo_total,
COALESCE(v.total_vendido, 0) AS total_vendido,
COALESCE(v.receita_total, 0) AS receita_total,
COALESCE(v.receita_total, 0) - COALESCE(c.custo_total, 0) AS margem_bruta_estimada
FROM produto p
JOIN fornecedor f
ON p.id_fornecedor = f.id_fornecedor
LEFT JOIN (
SELECT
ioc.id_produto,
SUM(ioc.quantidade) AS total_comprado,
SUM(ioc.subtotal) AS custo_total
FROM item_ordem_compra ioc
JOIN ordem_compra oc
ON ioc.id_ordem_compra = oc.id_ordem_compra
GROUP BY
ioc.id_produto
) c
ON p.id_produto = c.id_produto
LEFT JOIN (
SELECT
ipv.id_produto,
SUM(ipv.quantidade) AS total_vendido,
SUM(ipv.subtotal) AS receita_total
FROM item_pedido_venda ipv
JOIN pedido_venda pv
ON ipv.id_pedido_venda = pv.id_pedido_venda
GROUP BY
ipv.id_produto
) v
ON p.id_produto = v.id_produto
ORDER BY
f.nome_fornecedor,
p.nome_produto;