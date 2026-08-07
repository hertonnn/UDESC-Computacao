CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(50),
    sobrenome VARCHAR(100),
    endereco VARCHAR(100),
    telefone VARCHAR(20)
);

CREATE TABLE Emprestimo (
    id_emprestimo INT PRIMARY KEY,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) ON DELETE CASCADE
);

CREATE TABLE ItemEmprestimo (
    id_item INT PRIMARY KEY,
    id_emprestimo INT,
    FOREIGN KEY (id_emprestimo) REFERENCES Emprestimo(id_emprestimo) ON DELETE CASCADE
);

CREATE TABLE Categoria (
    id_categoria INT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE Filme (
    id_filme INT PRIMARY KEY,
    titulo VARCHAR(100),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria) ON DELETE CASCADE
);

CREATE TABLE Fita (
    id_fita INT PRIMARY KEY,
    parte INT,
    FOREIGN KEY (id_fita) REFERENCES ItemEmprestimo(id_item) ON DELETE CASCADE,
    id_filme INT,
    FOREIGN KEY (id_filme) REFERENCES Filme(id_filme) ON DELETE CASCADE
);

CREATE TABLE Artista (
    id_artista INT PRIMARY KEY,
    estilo VARCHAR(50),
    nacionalidade VARCHAR(50),
    nome VARCHAR(100)
);

CREATE TABLE Album (
    id_album INT PRIMARY KEY,
    nome VARCHAR(100),
    id_artista INT,
    FOREIGN KEY (id_artista) REFERENCES Artista(id_artista) ON DELETE SET NULL
);

CREATE TABLE Vinil (
    id_vinil INT PRIMARY KEY,
    numero_musicas INT,
    FOREIGN KEY (id_vinil) REFERENCES ItemEmprestimo(id_item) ON DELETE CASCADE,
    id_album INT,
    FOREIGN KEY (id_album) REFERENCES Album(id_album) ON DELETE SET NULL
);

CREATE TABLE Ator (
    id_ator INT PRIMARY KEY,
    nome_artistico VARCHAR(50)
);

CREATE TABLE atuaram (
    id_filme INT,
    id_ator INT,
    PRIMARY KEY (id_filme, id_ator),
    FOREIGN KEY (id_filme) REFERENCES Filme(id_filme) ON DELETE CASCADE,
    FOREIGN KEY (id_ator) REFERENCES Ator(id_ator) ON DELETE CASCADE
);

CREATE TABLE Estrela (
    id_estrela INT PRIMARY KEY,
    nome_real VARCHAR(100),
    data_nascimento DATE,
    FOREIGN KEY (id_estrela) REFERENCES Ator(id_ator) ON DELETE CASCADE
);
