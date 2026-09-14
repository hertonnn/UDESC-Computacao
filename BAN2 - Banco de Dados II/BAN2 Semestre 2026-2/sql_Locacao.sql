-- Script DDL para criação do banco de dados (PostgreSQL)
-- Baseado no diagrama ER fornecido

-- Tabela Status
CREATE TABLE Status (
    id_status SERIAL PRIMARY KEY,
    descricao VARCHAR(128) NOT NULL
);

-- Tabela Agencia
CREATE TABLE Agencia (
    id_agencia SERIAL PRIMARY KEY,
    telefone_agencia VARCHAR(128) NOT NULL,
    cidade VARCHAR(128) NOT NULL,
    cod_agencia VARCHAR(128) NOT NULL,
    nome_agencia VARCHAR(128) NOT NULL,
    endereco VARCHAR(128) NOT NULL
);

-- Tabela Cliente (Superclasse)
CREATE TABLE Cliente (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(128) NOT NULL,
    endereco VARCHAR(128) NOT NULL,
    email VARCHAR(128) NOT NULL,
    telefone VARCHAR(128) NOT NULL
);

-- Tabela Fisica (Subclasse)
CREATE TABLE Fisica (
    id_cliente INTEGER PRIMARY KEY REFERENCES Cliente(id_cliente) ON DELETE CASCADE,
    cpf VARCHAR(128) NOT NULL UNIQUE, -- CPF deve ser único
    rg VARCHAR(128) NOT NULL,
    data_nascimento DATE NOT NULL
);

-- Tabela CnhCliente (Atributo Multivalorado da Fisica)
CREATE TABLE CnhCliente (
    id_cliente INTEGER NOT NULL REFERENCES Fisica(id_cliente) ON DELETE CASCADE,
    numero_cnh VARCHAR(128) NOT NULL,
    PRIMARY KEY (id_cliente, numero_cnh)
);

-- Tabela Juridica (Subclasse)
CREATE TABLE Juridica (
    id_cliente INTEGER PRIMARY KEY REFERENCES Cliente(id_cliente) ON DELETE CASCADE,
    cnpj VARCHAR(128) NOT NULL UNIQUE, -- CNPJ deve ser único
    razao_social VARCHAR(128) NOT NULL,
    inscrição_estadual VARCHAR(128) NOT NULL -- Mantive o nome original para consistência
);

-- Tabela Frota
CREATE TABLE Frota (
    id_frota SERIAL PRIMARY KEY,
    quantidade_veiculos INTEGER NOT NULL DEFAULT 0,
    id_agencia INTEGER NOT NULL REFERENCES Agencia(id_agencia) ON DELETE RESTRICT -- Frota deve pertencer a uma agência
);

-- Tabela Adicional
CREATE TABLE Adicional (
    id_adicional SERIAL PRIMARY KEY,
    valor_diaria NUMERIC(10, 2) NOT NULL, -- Valor em reais
    descricao_adicional VARCHAR(128) NOT NULL
);

-- Tabela Locacao
CREATE TABLE Locacao (
    id_locacao SERIAL PRIMARY KEY,
    hora_retirada TIME NOT NULL,
    data_retirada DATE NOT NULL,
    data_prevista_devolucao DATE NOT NULL,
    hora_prevista_devolucao TIME NOT NULL,
    hora_devolucao TIME, -- Pode ser NULL se não devolvido
    data_devolucao DATE, -- Pode ser NULL se não devolvido
    valor_total NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    valor_adicionais NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    valor_diaria NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    quilometragem_devoluca INTEGER, -- Mantive o nome original para consistência
    quilometragem_retirada INTEGER NOT NULL DEFAULT 0,
    franquia_quilometragem INTEGER NOT NULL DEFAULT 0,
    local_retirada VARCHAR(128) NOT NULL,
    local_devolucao VARCHAR(128) NOT NULL,
    id_cliente INTEGER NOT NULL REFERENCES Cliente(id_cliente) ON DELETE RESTRICT, -- Locação deve ter um cliente
    id_agencia INTEGER NOT NULL REFERENCES Agencia(id_agencia) ON DELETE RESTRICT -- Locação deve ter uma agência
);

-- Tabela Veiculo
CREATE TABLE Veiculo (
    id_veiculo SERIAL PRIMARY KEY,
    quilometragem_atual INTEGER NOT NULL DEFAULT 0,
    ano_fabricacao INTEGER NOT NULL,
    placa VARCHAR(128) NOT NULL UNIQUE, -- Placa deve ser única
    cor VARCHAR(128) NOT NULL,
    marca VARCHAR(128) NOT NULL,
    capacidade_passageiros INTEGER NOT NULL,
    tipo_combustivel VARCHAR(128) NOT NULL,
    categoria VARCHAR(128) NOT NULL,
    id_status INTEGER NOT NULL REFERENCES Status(id_status) ON DELETE RESTRICT, -- Veículo deve ter um status
    id_locacao INTEGER REFERENCES Locacao(id_locacao) ON DELETE SET NULL, -- Veículo pode não estar em locação
    id_agencia INTEGER NOT NULL REFERENCES Agencia(id_agencia) ON DELETE RESTRICT, -- Veículo deve estar em uma agência
    id_frota INTEGER NOT NULL REFERENCES Frota(id_frota) ON DELETE RESTRICT -- Veículo deve pertencer a uma frota
);

-- Tabela LocacaoAdicional (Tabela Associativa)
CREATE TABLE LocacaoAdicional (
    id_locacao INTEGER NOT NULL REFERENCES Locacao(id_locacao) ON DELETE CASCADE,
    id_adicional INTEGER NOT NULL REFERENCES Adicional(id_adicional) ON DELETE RESTRICT,
    valo_negociado NUMERIC(10, 2) NOT NULL, -- Valor negociado para o adicional
    PRIMARY KEY (id_locacao, id_adicional)
);

-- Tabela Multas
CREATE TABLE Multas (
    id_multa SERIAL PRIMARY KEY,
    descricao_multa VARCHAR(128) NOT NULL,
    data_multa DATE NOT NULL,
    valor_multa NUMERIC(10, 2) NOT NULL,
    id_locacao INTEGER NOT NULL REFERENCES Locacao(id_locacao) ON DELETE CASCADE -- Multa deve pertencer a uma locação
);

-- Tabela Manutencao
CREATE TABLE Manutencao (
    id_manuntencao SERIAL PRIMARY KEY, -- Mantive o nome original para consistência
    data_manuntecao DATE NOT NULL, -- Mantive o nome original para consistência
    tipo_manutencao VARCHAR(128) NOT NULL,
    custo_manuntecao NUMERIC(12, 2) NOT NULL, -- Mantive o nome original para consistência
    descricao_servicos VARCHAR(128) NOT NULL,
    quilometragem_entrada INTEGER NOT NULL DEFAULT 0,
    quilometragem_saida INTEGER NOT NULL DEFAULT 0,
    id_veiculo INTEGER NOT NULL REFERENCES Veiculo(id_veiculo) ON DELETE CASCADE -- Manutenção deve pertencer a um veículo
);