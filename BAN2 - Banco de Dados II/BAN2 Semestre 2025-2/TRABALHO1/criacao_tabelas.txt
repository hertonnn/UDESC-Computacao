-- TRABALHO 1 - PARTE 2: DDL-SQL
-- SCRIPT DE CRIAÇÃO DO BANCO DE DADOS PARA SISTEMA DE AGENDAMENTO DE QUADRAS
-- Gustavo de Souza e José Augusto Laube

-- Remove tabelas existentes para permitir a recriação do zero
DROP TABLE IF EXISTS agendamento_material, evento_quadra, quadra_esporte, chamado_manutencao, agendamento, extraordinario, recorrente, evento, aluno, admin, funcionario, servidor, usuario, material_esportivo, quadra, ginasio, esporte CASCADE;

------------- CRIAÇÃO DAS TABELAS BASE --------------------

CREATE TABLE ginasio (
    id_ginasio SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(255),
    capacidade INT
);

CREATE TABLE esporte (
    id_esporte SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    max_jogadores INT
);

CREATE TABLE usuario (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha TEXT NOT NULL, -- Usar TEXT para armazenar o hash da senha
    data_nasc DATE,
    status VARCHAR(20) NOT NULL CHECK (status IN ('ativo', 'inativo'))
);

----------------- CRIAÇÃO DAS TABELAS DEPENDENTES -----------------------

CREATE TABLE quadra (
    id_ginasio INT NOT NULL,
    num_quadra INT NOT NULL,
    capacidade INT,
    tipo_piso VARCHAR(50),
    cobertura BOOLEAN DEFAULT TRUE,
    status VARCHAR(50) CHECK (status IN ('disponivel', 'manutencao', 'interditada')),
    PRIMARY KEY (id_ginasio, num_quadra),
    FOREIGN KEY (id_ginasio) REFERENCES ginasio(id_ginasio) ON DELETE CASCADE
);

CREATE TABLE material_esportivo (
    id_material SERIAL PRIMARY KEY,
    id_ginasio INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    marca VARCHAR(50),
    status VARCHAR(50) CHECK (status IN ('bom', 'danificado', 'manutencao')),
    qnt_total INT NOT NULL DEFAULT 0,
    qnt_disponivel INT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_ginasio) REFERENCES ginasio(id_ginasio) ON DELETE RESTRICT
);

-- Tabelas especialização da tabela usuário --------------
CREATE TABLE aluno (
    cpf VARCHAR(11) PRIMARY KEY,
    matricula VARCHAR(20) NOT NULL UNIQUE,
    curso VARCHAR(100),
    ano_inicio INT,
	categoria varchar(20), -- para saber se o auno é bolsista ou não, caso for os itens abaixo não podem ser nulos (usar gatilho)
	valor_remuneracao NUMERIC(10, 2),
    carga_horaria INT,
    horario_inicio TIME,
    horario_fim TIME,
    id_supervisor_servidor VARCHAR(20), -- Referencia SERVIDOR(id_servidor)
    FOREIGN KEY (cpf) REFERENCES usuario(cpf) ON DELETE CASCADE
);

CREATE TABLE servidor (
    cpf VARCHAR(11) PRIMARY KEY,
    id_servidor VARCHAR(20) NOT NULL UNIQUE,
    data_admissao DATE,
    FOREIGN KEY (cpf) REFERENCES usuario(cpf) ON DELETE CASCADE
);


-- Tabelas de especialização de SERVIDOR
CREATE TABLE funcionario (
    cpf VARCHAR(11) PRIMARY KEY,
    departamento VARCHAR(100),
    cargo VARCHAR(100),
    FOREIGN KEY (cpf) REFERENCES servidor(cpf) ON DELETE CASCADE
);

CREATE TABLE admin (
    cpf VARCHAR(11) PRIMARY KEY,
    nivel_acesso INT DEFAULT 1,
    area_responsabilidade VARCHAR(100),
    data_ultimo_login TIMESTAMP,
    FOREIGN KEY (cpf) REFERENCES servidor(cpf) ON DELETE CASCADE
);

------------- CRIAÇÃO DAS TABELAS DE EVENTOS E AGENDAMENTOS --------------

CREATE TABLE evento (
    id_evento SERIAL PRIMARY KEY,
    cpf_admin_organizador VARCHAR(11) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    FOREIGN KEY (cpf_admin_organizador) REFERENCES admin(cpf) ON DELETE RESTRICT
);

-- Tabelas de especialização de EVENTO
CREATE TABLE extraordinario (
    id_evento INT PRIMARY KEY,
    data_hora_inicio TIMESTAMP NOT NULL,
    data_hora_fim TIMESTAMP NOT NULL,
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento) ON DELETE CASCADE
);

CREATE TABLE recorrente (
    id_evento INT PRIMARY KEY,
    regra_recorrencia TEXT NOT NULL, 
    data_fim_recorrencia DATE,
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento) ON DELETE CASCADE
);

CREATE TABLE agendamento (
    id_agendamento SERIAL PRIMARY KEY,
    cpf_usuario VARCHAR(11) NOT NULL,
    id_ginasio INT NOT NULL,
    num_quadra INT NOT NULL,
    data_solicitacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    hora_ini TIMESTAMP NOT NULL,
    hora_fim TIMESTAMP NOT NULL,
    motivo TEXT,
    status_agendamento VARCHAR(50) NOT NULL CHECK (status_agendamento IN ('confirmado', 'cancelado', 'realizado', 'nao_compareceu')),
    id_bolsista_operador VARCHAR(11), 
    data_operacao_bolsista TIMESTAMP,
    FOREIGN KEY (cpf_usuario) REFERENCES usuario(cpf) ON DELETE RESTRICT,
    FOREIGN KEY (id_ginasio, num_quadra) REFERENCES quadra(id_ginasio, num_quadra) ON DELETE RESTRICT,
    FOREIGN KEY (id_bolsista_operador) REFERENCES aluno(cpf) ON DELETE SET NULL
);

CREATE TABLE chamado_manutencao (
    id_cha SERIAL PRIMARY KEY,
    cpf_usuario_abriu VARCHAR(11) NOT NULL,
    id_ginasio INT NOT NULL,
    num_quadra INT NOT NULL,
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descricao TEXT NOT NULL,
    FOREIGN KEY (cpf_usuario_abriu) REFERENCES usuario(cpf) ON DELETE RESTRICT,
    FOREIGN KEY (id_ginasio, num_quadra) REFERENCES quadra(id_ginasio, num_quadra) ON DELETE CASCADE
);

--------------- CRIAÇÃO DAS TABELAS DE JUNÇÃO ----------------

CREATE TABLE quadra_esporte (
    id_ginasio INT NOT NULL,
    num_quadra INT NOT NULL,
    id_esporte INT NOT NULL,
    PRIMARY KEY (id_ginasio, num_quadra, id_esporte),
    FOREIGN KEY (id_ginasio, num_quadra) REFERENCES quadra(id_ginasio, num_quadra) ON DELETE CASCADE,
    FOREIGN KEY (id_esporte) REFERENCES esporte(id_esporte) ON DELETE CASCADE
);

CREATE TABLE evento_quadra (
    id_evento INT NOT NULL,
    id_ginasio INT NOT NULL,
    num_quadra INT NOT NULL,
    PRIMARY KEY (id_evento, id_ginasio, num_quadra),
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento) ON DELETE CASCADE,
    FOREIGN KEY (id_ginasio, num_quadra) REFERENCES quadra(id_ginasio, num_quadra) ON DELETE CASCADE
);

CREATE TABLE agendamento_material (
    id_agendamento INT NOT NULL,
    id_material INT NOT NULL,
    quantidade_solicitada INT NOT NULL DEFAULT 1,
    PRIMARY KEY (id_agendamento, id_material),
    FOREIGN KEY (id_agendamento) REFERENCES agendamento(id_agendamento) ON DELETE CASCADE,
    FOREIGN KEY (id_material) REFERENCES material_esportivo(id_material) ON DELETE RESTRICT
);

-- Adiciona a FK do supervisor para o aluno bolsista 
ALTER TABLE aluno ADD CONSTRAINT fk_supervisor
FOREIGN KEY (id_supervisor_servidor) REFERENCES servidor(id_servidor) ON DELETE SET NULL;