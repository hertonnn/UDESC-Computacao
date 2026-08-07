-- Usuario
CREATE TABLE Usuario (
    id_usuario INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    endereco VARCHAR(150),
    categoria VARCHAR(30) -- aluno_grad, aluno_pos, professor, etc.
);

-- Subtipos de Usuario
CREATE TABLE Aluno_Graduacao (
    id_usuario INT PRIMARY KEY,
    quantidade_limite_emprestimos INT,
    tempo_emprestimo INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Aluno_PosGraduacao (
    id_usuario INT PRIMARY KEY,
    quantidade_limite_emprestimos INT,
    tempo_emprestimo INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Professor (
    id_usuario INT PRIMARY KEY,
    tipo_contrato VARCHAR(50),
    quantidade_limite_emprestimos INT,
    tempo_emprestimo INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Professor_PosGraduacao (
    id_usuario INT PRIMARY KEY,
    tipo_contrato VARCHAR(50),
    quantidade_limite_emprestimos INT,
    tempo_emprestimo INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Bibliotecário e Assistente
CREATE TABLE Bibliotecario (
    id_bibliotecario INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    cargo VARCHAR(50)
);

CREATE TABLE Assistente (
    id_assistente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    id_bibliotecario INT,
    FOREIGN KEY (id_bibliotecario) REFERENCES Bibliotecario(id_bibliotecario)
);

-- Livros
CREATE TABLE Colecao (
    id_colecao INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Livro (
    id_livro INT PRIMARY KEY,
    ISBN CHAR(13) UNIQUE,
    titulo VARCHAR(150) NOT NULL,
    id_colecao INT,
    FOREIGN KEY (id_colecao) REFERENCES Colecao(id_colecao)
);

CREATE TABLE Exemplar (
    id_exemplar INT PRIMARY KEY,
    numero_exemplar INT NOT NULL,
    situacao VARCHAR(30), -- disponível, emprestado, reservado
    is_colecao_reservada BOOLEAN DEFAULT FALSE,
    id_livro INT,
    FOREIGN KEY (id_livro) REFERENCES Livro(id_livro)
);

CREATE TABLE Autor (
    id_autor INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Editora (
    id_editora INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- Relacionamentos N:M
CREATE TABLE Autoria (
    id_livro INT,
    id_autor INT,
    PRIMARY KEY (id_livro, id_autor),
    FOREIGN KEY (id_livro) REFERENCES Livro(id_livro),
    FOREIGN KEY (id_autor) REFERENCES Autor(id_autor)
);

CREATE TABLE Edicao (
    id_livro INT,
    id_editora INT,
    PRIMARY KEY (id_livro, id_editora),
    FOREIGN KEY (id_livro) REFERENCES Livro(id_livro),
    FOREIGN KEY (id_editora) REFERENCES Editora(id_editora)
);

-- Reserva
CREATE TABLE Reserva (
    id_reserva INT PRIMARY KEY,
    data_reserva DATE,
    situacao VARCHAR(30), -- ativa, cancelada, concluída
    id_usuario INT,
    id_exemplar INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_exemplar) REFERENCES Exemplar(id_exemplar)
);

-- Empréstimos
CREATE TABLE Emprestimo (
    id_emprestimo INT PRIMARY KEY,
    data_emprestimo DATE NOT NULL,
    data_devolucao_prevista DATE NOT NULL,
    data_devolucao_real DATE,
    multas DECIMAL(8,2) DEFAULT 0,
    renovacoes INT DEFAULT 0,
    id_usuario INT,
    id_bibliotecario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_bibliotecario) REFERENCES Bibliotecario(id_bibliotecario)
);

-- Ligação N:M entre Emprestimo e Exemplar
CREATE TABLE Emprestimo_Exemplar (
    id_emprestimo INT,
    id_exemplar INT,
    PRIMARY KEY (id_emprestimo, id_exemplar),
    FOREIGN KEY (id_emprestimo) REFERENCES Emprestimo(id_emprestimo),
    FOREIGN KEY (id_exemplar) REFERENCES Exemplar(id_exemplar)
);
