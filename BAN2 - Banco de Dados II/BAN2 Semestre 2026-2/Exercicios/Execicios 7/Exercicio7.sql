-- Questão 1
CREATE OR REPLACE FUNCTION fn_registrar_entrada(
    p_id_produto INTEGER,
    p_id_deposito INTEGER,
    p_quantidade NUMERIC,
    p_id_usuario INTEGER,
    p_observacao TEXT
) RETURNS TEXT AS $$
DECLARE
    v_id_movimentacao INTEGER;
    v_estoque_global NUMERIC;
BEGIN
    INSERT INTO movimentacao (tipo_movimentacao, quantidade, id_produto, id_deposito_destino, id_usuario, observacao)
    VALUES ('ENTRADA', p_quantidade::INTEGER, p_id_produto, p_id_deposito, p_id_usuario, p_observacao)
    RETURNING id_movimentacao INTO v_id_movimentacao;

    UPDATE produto 
    SET estoque_atual = estoque_atual + p_quantidade::INTEGER
    WHERE id_produto = p_id_produto
    RETURNING estoque_atual INTO v_estoque_global;

    INSERT INTO estoque_deposito (id_produto, id_deposito, quantidade)
    VALUES (p_id_produto, p_id_deposito, p_quantidade::INTEGER)
    ON CONFLICT (id_produto, id_deposito)
    DO UPDATE SET quantidade = estoque_deposito.quantidade + p_quantidade::INTEGER;

    RETURN 'Entrada registrada. Movimentação: ' || v_id_movimentacao || '. Novo estoque global: ' || v_estoque_global;
END;
$$ LANGUAGE plpgsql;

-- Questão 2
CREATE OR REPLACE FUNCTION fn_abrir_pedido(
    p_id_cliente INTEGER,
    p_id_usuario INTEGER,
    p_itens JSONB
) RETURNS TABLE(id_pedido INTEGER, valor_total NUMERIC) AS $$
DECLARE
    v_id_pedido INTEGER;
    v_valor_total NUMERIC := 0;
    v_item JSONB;
    v_id_produto INTEGER;
    v_quantidade INTEGER;
    v_preco_venda NUMERIC;
    v_subtotal NUMERIC;
BEGIN
    INSERT INTO pedido_venda (id_cliente, id_usuario, status)
    VALUES (p_id_cliente, p_id_usuario, 'ABERTO')
    RETURNING id_pedido_venda INTO v_id_pedido;

    FOR v_item IN SELECT * FROM jsonb_array_elements(p_itens)
    LOOP
        v_id_produto := (v_item->>'id_produto')::INTEGER;
        v_quantidade := (v_item->>'quantidade')::INTEGER;

        SELECT preco_venda INTO v_preco_venda 
        FROM produto 
        WHERE id_produto = v_id_produto;

        INSERT INTO item_pedido_venda (id_pedido_venda, id_produto, quantidade, valor_unitario)
        VALUES (v_id_pedido, v_id_produto, v_quantidade, v_preco_venda);
        
        v_subtotal := v_quantidade * v_preco_venda;
        v_valor_total := v_valor_total + v_subtotal;
    END LOOP;

    UPDATE pedido_venda 
    SET valor_total = v_valor_total 
    WHERE id_pedido_venda = v_id_pedido;

    RETURN QUERY SELECT v_id_pedido, v_valor_total;
END;
$$ LANGUAGE plpgsql;

-- Questão 3
CREATE OR REPLACE FUNCTION fn_cancelar_pedido(
    p_id_pedido_venda INTEGER,
    p_id_usuario INTEGER
) RETURNS TABLE(status_anterior TEXT, status_novo TEXT) AS $$
DECLARE
    v_status_atual TEXT;
    v_item RECORD;
    v_id_deposito_origem INTEGER;
BEGIN
    SELECT status INTO v_status_atual 
    FROM pedido_venda 
    WHERE id_pedido_venda = p_id_pedido_venda;

    IF v_status_atual IN ('FATURADO', 'CANCELADO') THEN
        RAISE EXCEPTION 'Não é possível cancelar um pedido com status %.', v_status_atual;
    END IF;

    IF v_status_atual = 'CONFIRMADO' THEN
        FOR v_item IN (SELECT id_produto, quantidade FROM item_pedido_venda WHERE id_pedido_venda = p_id_pedido_venda)
        LOOP
            UPDATE produto 
            SET estoque_atual = estoque_atual + v_item.quantidade
            WHERE id_produto = v_item.id_produto;
            
            SELECT id_deposito INTO v_id_deposito_origem 
            FROM estoque_deposito 
            WHERE id_produto = v_item.id_produto 
            LIMIT 1;
            
            INSERT INTO movimentacao (tipo_movimentacao, quantidade, id_produto, id_deposito_origem, id_usuario, observacao)
            VALUES ('BAIXA_RESERVA', v_item.quantidade, v_item.id_produto, v_id_deposito_origem, p_id_usuario, 'Cancelamento do pedido de venda ' || p_id_pedido_venda);
        END LOOP;
    END IF;

    UPDATE pedido_venda 
    SET status = 'CANCELADO' 
    WHERE id_pedido_venda = p_id_pedido_venda;

    RETURN QUERY SELECT v_status_atual, 'CANCELADO'::TEXT;
END;
$$ LANGUAGE plpgsql;

-- Questão 4
CREATE OR REPLACE FUNCTION fn_transferir_estoque(
    p_id_produto INTEGER,
    p_id_deposito_origem INTEGER,
    p_id_deposito_destino INTEGER,
    p_quantidade NUMERIC,
    p_id_usuario INTEGER
) RETURNS TABLE(saldo_origem NUMERIC, saldo_destino NUMERIC) AS $$
DECLARE
    v_saldo_origem NUMERIC;
    v_saldo_destino NUMERIC;
BEGIN
    SELECT quantidade INTO v_saldo_origem 
    FROM estoque_deposito 
    WHERE id_produto = p_id_produto AND id_deposito = p_id_deposito_origem;

    IF v_saldo_origem IS NULL OR v_saldo_origem < p_quantidade THEN
        RAISE EXCEPTION 'Saldo insuficiente no depósito de origem.';
    END IF;

    UPDATE estoque_deposito 
    SET quantidade = quantidade - p_quantidade::INTEGER
    WHERE id_produto = p_id_produto AND id_deposito = p_id_deposito_origem
    RETURNING quantidade INTO v_saldo_origem;

    INSERT INTO estoque_deposito (id_produto, id_deposito, quantidade)
    VALUES (p_id_produto, p_id_deposito_destino, p_quantidade::INTEGER)
    ON CONFLICT (id_produto, id_deposito)
    DO UPDATE SET quantidade = estoque_deposito.quantidade + p_quantidade::INTEGER
    RETURNING quantidade INTO v_saldo_destino;

    INSERT INTO movimentacao (tipo_movimentacao, quantidade, id_produto, id_deposito_origem, id_deposito_destino, id_usuario)
    VALUES ('TRANSFERENCIA', p_quantidade::INTEGER, p_id_produto, p_id_deposito_origem, p_id_deposito_destino, p_id_usuario);

    RETURN QUERY SELECT v_saldo_origem, v_saldo_destino;
END;
$$ LANGUAGE plpgsql;

-- Questão 5
CREATE OR REPLACE FUNCTION fn_atualizar_precos(
    p_codigo_produto VARCHAR,
    p_novo_preco_custo NUMERIC,
    p_novo_preco_venda NUMERIC
) RETURNS TABLE(
    codigo TEXT, 
    nome TEXT, 
    preco_custo_anterior NUMERIC,
    preco_venda_anterior NUMERIC, 
    preco_custo_novo NUMERIC, 
    preco_venda_novo NUMERIC
) AS $$
DECLARE
    v_nome TEXT;
    v_custo_ant NUMERIC;
    v_venda_ant NUMERIC;
BEGIN
    IF p_novo_preco_venda <= p_novo_preco_custo THEN
        RAISE EXCEPTION 'O preço de venda deve ser estritamente maior que o preço de custo.';
    END IF;

    SELECT nome_produto, preco_custo, preco_venda 
    INTO v_nome, v_custo_ant, v_venda_ant 
    FROM produto 
    WHERE codigo_produto = p_codigo_produto;

    UPDATE produto 
    SET preco_custo = p_novo_preco_custo, preco_venda = p_novo_preco_venda
    WHERE codigo_produto = p_codigo_produto;

    RETURN QUERY SELECT 
        p_codigo_produto::TEXT, 
        v_nome, 
        v_custo_ant, 
        v_venda_ant, 
        p_novo_preco_custo, 
        p_novo_preco_venda;
END;
$$ LANGUAGE plpgsql;

-- Questão 6
CREATE OR REPLACE FUNCTION fn_relatorio_estoque_critico()
RETURNS TABLE(
    codigo_produto VARCHAR, 
    nome_produto VARCHAR, 
    nome_categoria VARCHAR, 
    nome_fornecedor VARCHAR,
    estoque_atual INTEGER, 
    estoque_minimo INTEGER, 
    qtd_sugerida_reposicao INTEGER
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.codigo_produto,
        p.nome_produto,
        c.nome_categoria,
        f.nome_fornecedor,
        p.estoque_atual,
        p.estoque_minimo,
        (p.estoque_minimo - p.estoque_atual + 10)::INTEGER
    FROM produto p
    LEFT JOIN categoria c ON p.id_categoria = c.id_categoria
    LEFT JOIN fornecedor f ON p.id_fornecedor = f.id_fornecedor
    WHERE p.estoque_atual <= p.estoque_minimo
    ORDER BY p.estoque_atual ASC;
END;
$$ LANGUAGE plpgsql;

-- Questão 7
CREATE OR REPLACE FUNCTION fn_relatorio_vendas_produto(
    p_data_inicio DATE,
    p_data_fim DATE
) RETURNS TABLE(
    codigo_produto VARCHAR, 
    nome_produto VARCHAR, 
    qtd_pedidos BIGINT, 
    total_unidades_vendidas BIGINT,
    receita_bruta_total NUMERIC, 
    ticket_medio_item NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.codigo_produto,
        p.nome_produto,
        COUNT(DISTINCT pv.id_pedido_venda)::BIGINT,
        COALESCE(SUM(ipv.quantidade), 0)::BIGINT,
        COALESCE(SUM(ipv.subtotal), 0.00)::NUMERIC,
        COALESCE(AVG(ipv.subtotal), 0.00)::NUMERIC
    FROM produto p
    LEFT JOIN (
        item_pedido_venda ipv
        JOIN pedido_venda pv ON ipv.id_pedido_venda = pv.id_pedido_venda 
            AND pv.status = 'FATURADO' 
            AND pv.data_pedido::DATE BETWEEN p_data_inicio AND p_data_fim
    ) ON p.id_produto = ipv.id_produto
    GROUP BY p.codigo_produto, p.nome_produto;
END;
$$ LANGUAGE plpgsql;

-- Questão 8
CREATE OR REPLACE FUNCTION fn_historico_movimentacao(
    p_id_produto INTEGER,
    p_data_inicio DATE,
    p_data_fim DATE
) RETURNS TABLE(
    data_movimentacao TIMESTAMP, 
    tipo_movimentacao VARCHAR, 
    quantidade INTEGER, 
    nome_produto VARCHAR,
    deposito_origem VARCHAR, 
    deposito_destino VARCHAR, 
    usuario_responsavel VARCHAR, 
    observacao TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        m.data_movimentacao,
        m.tipo_movimentacao,
        m.quantidade,
        p.nome_produto,
        do.nome_deposito,
        dd.nome_deposito,
        u.nome_completo,
        m.observacao
    FROM movimentacao m
    JOIN produto p ON m.id_produto = p.id_produto
    JOIN usuario u ON m.id_usuario = u.id_usuario
    LEFT JOIN deposito do ON m.id_deposito_origem = do.id_deposito
    LEFT JOIN deposito dd ON m.id_deposito_destino = dd.id_deposito
    WHERE m.id_produto = p_id_produto 
      AND m.data_movimentacao::DATE BETWEEN p_data_inicio AND p_data_fim
    ORDER BY m.data_movimentacao DESC;
END;
$$ LANGUAGE plpgsql;

-- Questão 9
CREATE OR REPLACE FUNCTION fn_desempenho_fornecedor()
RETURNS TABLE(
    nome_fornecedor VARCHAR, 
    cnpj VARCHAR, 
    total_ordens_emitidas BIGINT, 
    total_ordens_recebidas BIGINT,
    valor_total_comprado NUMERIC, 
    valor_medio_por_ordem NUMERIC, 
    qtd_produtos_distintos BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        f.nome_fornecedor,
        f.cnpj,
        COUNT(DISTINCT oc.id_ordem_compra)::BIGINT,
        COUNT(DISTINCT CASE WHEN oc.status = 'RECEBIDO' THEN oc.id_ordem_compra END)::BIGINT,
        COALESCE(SUM(CASE WHEN oc.status = 'RECEBIDO' THEN oc.valor_total END), 0.00)::NUMERIC,
        COALESCE(AVG(CASE WHEN oc.status = 'RECEBIDO' THEN oc.valor_total END), 0.00)::NUMERIC,
        COUNT(DISTINCT ioc.id_produto)::BIGINT
    FROM fornecedor f
    LEFT JOIN ordem_compra oc ON f.id_fornecedor = oc.id_fornecedor
    LEFT JOIN item_ordem_compra ioc ON oc.id_ordem_compra = ioc.id_ordem_compra
    GROUP BY f.id_fornecedor, f.nome_fornecedor, f.cnpj
    ORDER BY valor_total_comprado DESC;
END;
$$ LANGUAGE plpgsql;

-- Questão 10
CREATE OR REPLACE FUNCTION fn_lucratividade_categoria(
    p_data_inicio DATE,
    p_data_fim DATE
) RETURNS TABLE(
    nome_categoria VARCHAR, 
    qtd_produtos BIGINT, 
    qtd_total_estoque BIGINT, 
    valor_total_estoque NUMERIC,
    receita_bruta_periodo NUMERIC, 
    custo_estimado_vendas NUMERIC, 
    margem_bruta_valor NUMERIC,
    margem_bruta_pct NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    WITH Vendas AS (
        SELECT 
            ipv.id_produto,
            SUM(ipv.quantidade) as qtd_vendida,
            SUM(ipv.subtotal) as receita
        FROM item_pedido_venda ipv
        JOIN pedido_venda pv ON ipv.id_pedido_venda = pv.id_pedido_venda
        WHERE pv.status = 'FATURADO' 
          AND pv.data_pedido::DATE BETWEEN p_data_inicio AND p_data_fim
        GROUP BY ipv.id_produto
    )
    SELECT 
        c.nome_categoria,
        COUNT(DISTINCT p.id_produto)::BIGINT,
        COALESCE(SUM(p.estoque_atual), 0)::BIGINT,
        COALESCE(SUM(p.estoque_atual * p.preco_venda), 0.00)::NUMERIC,
        COALESCE(SUM(v.receita), 0.00)::NUMERIC,
        COALESCE(SUM(v.qtd_vendida * p.preco_custo), 0.00)::NUMERIC,
        COALESCE(SUM(v.receita) - SUM(v.qtd_vendida * p.preco_custo), 0.00)::NUMERIC AS margem_bruta_valor,
        CASE 
            WHEN COALESCE(SUM(v.receita), 0) = 0 THEN 0.00
            ELSE ROUND( ((SUM(v.receita) - SUM(v.qtd_vendida * p.preco_custo)) / SUM(v.receita) * 100)::NUMERIC, 2)
        END
    FROM categoria c
    LEFT JOIN produto p ON c.id_categoria = p.id_categoria
    LEFT JOIN Vendas v ON p.id_produto = v.id_produto
    GROUP BY c.id_categoria, c.nome_categoria
    ORDER BY margem_bruta_valor DESC;
END;
$$ LANGUAGE plpgsql;