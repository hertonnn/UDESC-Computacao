CREATE TABLE Artista(
    id_artista INT PRIMARY KEY,
    nome VARCHAR(100),
    estilo_principal VARCHAR(50),
    periodo VARCHAR(50),
    pais_origem VARCHAR(50),
    data_morte DATE,
    data_nascimento DATE,
    descricao VARCHAR(200)
);

CREATE TABLE Colecao(
    id_colecao INT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE Estilo(
    id_estilo INT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE Exposicoes(
    id_exposicao INT PRIMARY KEY,
    nome VARCHAR(100),
    data_inicio DATE,
    data_fim DATE
);

CREATE TABLE ObjetoArte(
    id_objeto_arte INT PRIMARY KEY,
    titulo VARCHAR(100),
    descricao VARCHAR(200),
    ano INT,
    tipo VARCHAR(100),
    colecao VARCHAR(100) DEFAULT 'permanente'
        CHECK (colecao IN ('permanente', 'emprestada')),
    data_aquisicao DATE,
    em_exposicao BOOLEAN,
    custo FLOAT,
    id_colecao INT,
    FOREIGN KEY (id_colecao) REFERENCES Colecao(id_colecao),
    data_emprestimo DATE,
    data_devolucao DATE,
    id_estilo INT,
    FOREIGN KEY (id_estilo) REFERENCES Estilo(id_estilo) ON DELETE CASCADE,
    id_exposicao INT,
    FOREIGN KEY (id_exposicao) REFERENCES Exposicoes(id_exposicao)
);

CREATE TABLE Pintura(
    id_objeto_arte INT PRIMARY KEY,
    tipo_tinta VARCHAR(100),
    suporte VARCHAR(100),
    FOREIGN KEY (id_objeto_arte) REFERENCES ObjetoArte(id_objeto_arte) ON DELETE CASCADE
);

CREATE TABLE Escultura(
    id_objeto_arte INT PRIMARY KEY,
    altura INT,
    material VARCHAR(50),
    peso FLOAT,
    FOREIGN KEY (id_objeto_arte) REFERENCES ObjetoArte(id_objeto_arte) ON DELETE CASCADE
);

CREATE TABLE Estatuaria(
    id_objeto_arte INT PRIMARY KEY,
    altura INT,
    material VARCHAR(50),
    peso FLOAT,
    FOREIGN KEY (id_objeto_arte) REFERENCES ObjetoArte(id_objeto_arte) ON DELETE CASCADE
);

CREATE TABLE Outros(
    id_objeto_arte INT PRIMARY KEY,
    tipo VARCHAR(50),
    FOREIGN KEY (id_objeto_arte) REFERENCES ObjetoArte(id_objeto_arte) ON DELETE CASCADE
);
