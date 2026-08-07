DROP TABLE IF EXISTS estoque, contagem_fisica, inventario_fisico,
    item_compra, compra, item_venda, venda, historico_preco,
    produto_fornecedor, produto, fornecedor_endereco, fornecedor,
    cliente, usuario, categoria_produto CASCADE;

DROP TYPE IF EXISTS tipo_movimento_estoque;

CREATE TYPE tipo_movimento_estoque AS ENUM ('ENTRADA', 'SAIDA', 'AJUSTE');

CREATE TABLE categoria_produto (
    id_categoria    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    descricao       VARCHAR(255)
);

CREATE TABLE usuario (
    id_usuario      INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    email           VARCHAR(150) NOT NULL UNIQUE,
    senha_hash      VARCHAR(255) NOT NULL,
    perfil          VARCHAR(30) NOT NULL
        CHECK (perfil IN ('ADMIN', 'VENDEDOR', 'ESTOQUISTA', 'GERENTE'))
);

CREATE TABLE cliente (
    id_cliente      INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome            VARCHAR(150) NOT NULL,
    cpf             VARCHAR(11) NOT NULL UNIQUE CHECK (cpf ~ '^[0-9]{11}$'),
    endereco        VARCHAR(255),
    telefone        VARCHAR(20)
);

CREATE TABLE fornecedor (
    cnpj            VARCHAR(14) PRIMARY KEY CHECK (cnpj ~ '^[0-9]{14}$'),
    razao_social    VARCHAR(150) NOT NULL,
    nome_fantasia   VARCHAR(150),
    telefone        VARCHAR(20)
);

-- Atributo multivalorado "endereco" do EER original -> tabela propria
CREATE TABLE fornecedor_endereco (
    id_endereco       INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cnpj_fornecedor   VARCHAR(14) NOT NULL REFERENCES fornecedor(cnpj) ON DELETE CASCADE,
    endereco          VARCHAR(255) NOT NULL,
    UNIQUE (cnpj_fornecedor, endereco)
);

CREATE TABLE produto (
    id_produto      INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descricao       VARCHAR(150) NOT NULL,
    unidade         VARCHAR(10) NOT NULL,
    preco_custo     NUMERIC(10,2) NOT NULL CHECK (preco_custo >= 0),
    preco_venda     NUMERIC(10,2) NOT NULL CHECK (preco_venda >= 0),
    id_categoria    INTEGER NOT NULL REFERENCES categoria_produto(id_categoria)
);

CREATE INDEX idx_produto_categoria ON produto(id_categoria);

CREATE TABLE produto_fornecedor (
    id_produto          INTEGER NOT NULL REFERENCES produto(id_produto) ON DELETE CASCADE,
    cnpj_fornecedor      VARCHAR(14) NOT NULL REFERENCES fornecedor(cnpj) ON DELETE CASCADE,
    preco                NUMERIC(10,2) NOT NULL CHECK (preco >= 0),
    prazo_entrega_dias   INTEGER NOT NULL CHECK (prazo_entrega_dias >= 0),
    PRIMARY KEY (id_produto, cnpj_fornecedor)
);

CREATE TABLE historico_preco (
    id_historico    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_produto      INTEGER NOT NULL REFERENCES produto(id_produto) ON DELETE CASCADE,
    id_usuario      INTEGER NOT NULL REFERENCES usuario(id_usuario),
    data_alteracao  TIMESTAMP NOT NULL DEFAULT now(),
    preco_anterior  NUMERIC(10,2) NOT NULL CHECK (preco_anterior >= 0),
    preco_novo      NUMERIC(10,2) NOT NULL CHECK (preco_novo >= 0)
);

CREATE INDEX idx_historico_preco_produto ON historico_preco(id_produto);

CREATE TABLE venda (
    id_venda        INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_cliente      INTEGER NOT NULL REFERENCES cliente(id_cliente),
    data_venda      DATE NOT NULL DEFAULT CURRENT_DATE,
    hora_venda      TIME NOT NULL DEFAULT CURRENT_TIME,
    valor_total     NUMERIC(10,2) NOT NULL CHECK (valor_total >= 0)
);

CREATE INDEX idx_venda_cliente ON venda(id_cliente);

CREATE TABLE item_venda (
    id_item         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_venda        INTEGER NOT NULL REFERENCES venda(id_venda) ON DELETE CASCADE,
    id_produto      INTEGER NOT NULL REFERENCES produto(id_produto),
    quantidade      NUMERIC(10,3) NOT NULL CHECK (quantidade > 0),
    preco_unitario  NUMERIC(10,2) NOT NULL CHECK (preco_unitario >= 0),
    subtotal        NUMERIC(10,2) GENERATED ALWAYS AS (quantidade * preco_unitario) STORED,
    UNIQUE (id_venda, id_produto)
);

CREATE INDEX idx_item_venda_produto ON item_venda(id_produto);

CREATE TABLE compra (
    id_compra           INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cnpj_fornecedor      VARCHAR(14) NOT NULL REFERENCES fornecedor(cnpj),
    data_compra          DATE NOT NULL DEFAULT CURRENT_DATE,
    data_entrega         DATE,
    valor_total          NUMERIC(10,2) NOT NULL CHECK (valor_total >= 0),
    status               VARCHAR(20) NOT NULL DEFAULT 'PENDENTE'
        CHECK (status IN ('PENDENTE', 'APROVADA', 'ENTREGUE', 'CANCELADA')),
    CHECK (data_entrega IS NULL OR data_entrega >= data_compra)
);

CREATE INDEX idx_compra_fornecedor ON compra(cnpj_fornecedor);

CREATE TABLE item_compra (
    id_item_compra          INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_compra               INTEGER NOT NULL REFERENCES compra(id_compra) ON DELETE CASCADE,
    id_produto               INTEGER NOT NULL REFERENCES produto(id_produto),
    quantidade_solicitada    NUMERIC(10,3) NOT NULL CHECK (quantidade_solicitada > 0),
    quantidade_recebida      NUMERIC(10,3) NOT NULL DEFAULT 0 CHECK (quantidade_recebida >= 0),
    preco_unitario           NUMERIC(10,2) NOT NULL CHECK (preco_unitario >= 0),
    UNIQUE (id_compra, id_produto)
);

CREATE INDEX idx_item_compra_produto ON item_compra(id_produto);

CREATE TABLE inventario_fisico (
    id_inventario   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_inventario DATE NOT NULL DEFAULT CURRENT_DATE,
    status          VARCHAR(20) NOT NULL DEFAULT 'EM_ANDAMENTO'
        CHECK (status IN ('EM_ANDAMENTO', 'FINALIZADO', 'CANCELADO')),
    observacoes     VARCHAR(500)
);

CREATE TABLE contagem_fisica (
    id_contagem         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_inventario       INTEGER NOT NULL REFERENCES inventario_fisico(id_inventario) ON DELETE CASCADE,
    id_produto          INTEGER NOT NULL REFERENCES produto(id_produto),
    quantidade_contada  NUMERIC(10,3) NOT NULL CHECK (quantidade_contada >= 0),
    UNIQUE (id_inventario, id_produto)
);

CREATE INDEX idx_contagem_produto ON contagem_fisica(id_produto);

CREATE TABLE estoque (
    id_estoque      INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_produto      INTEGER NOT NULL REFERENCES produto(id_produto),
    id_usuario      INTEGER NOT NULL REFERENCES usuario(id_usuario),
    tipo            tipo_movimento_estoque NOT NULL,
    quantidade      NUMERIC(10,3) NOT NULL CHECK (quantidade > 0),
    data_movimento  DATE NOT NULL DEFAULT CURRENT_DATE,
    hora_movimento  TIME NOT NULL DEFAULT CURRENT_TIME,
    id_compra       INTEGER REFERENCES compra(id_compra),
    id_venda        INTEGER REFERENCES venda(id_venda),
    id_inventario   INTEGER REFERENCES inventario_fisico(id_inventario),
    CONSTRAINT chk_origem_movimento CHECK (
        (tipo = 'ENTRADA' AND id_compra IS NOT NULL AND id_venda IS NULL AND id_inventario IS NULL)
        OR (tipo = 'SAIDA' AND id_venda IS NOT NULL AND id_compra IS NULL AND id_inventario IS NULL)
        OR (tipo = 'AJUSTE' AND id_inventario IS NOT NULL AND id_compra IS NULL AND id_venda IS NULL)
    )
);

CREATE INDEX idx_estoque_produto ON estoque(id_produto);
CREATE INDEX idx_estoque_usuario ON estoque(id_usuario);
CREATE INDEX idx_estoque_compra ON estoque(id_compra);
CREATE INDEX idx_estoque_venda ON estoque(id_venda);
CREATE INDEX idx_estoque_inventario ON estoque(id_inventario);
