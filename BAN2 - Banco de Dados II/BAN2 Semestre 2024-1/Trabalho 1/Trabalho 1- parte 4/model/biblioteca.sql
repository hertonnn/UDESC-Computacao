------------------------------ BANCO DE DADOS ------------------------------ 

-- Usuario 
CREATE TABLE Usuario (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    endereco VARCHAR(150),
    categoria VARCHAR(30) 
    CHECK (categoria IN ('aluno_grad', 'aluno_pos', 'professor', 'professor_pos'))
);

-- Subtipos de Usuario
CREATE TABLE Aluno_Graduacao (
    id_usuario INT PRIMARY KEY,
    quantidade_limite_emprestimos INT,
    tempo_emprestimo INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

CREATE TABLE Aluno_PosGraduacao (
    id_usuario INT PRIMARY KEY,
    quantidade_limite_emprestimos INT,
    tempo_emprestimo INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

CREATE TABLE Professor (
    id_usuario INT PRIMARY KEY,
    tipo_contrato VARCHAR(50),
    CHECK (tipo_contrato IN ('integral', 'meio período')),
    quantidade_limite_emprestimos INT,
    tempo_emprestimo INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

CREATE TABLE Professor_PosGraduacao (
    id_usuario INT PRIMARY KEY,
    tipo_contrato VARCHAR(50),
    quantidade_limite_emprestimos INT,
    tempo_emprestimo INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

-- Bibliotecário e Assistente
CREATE TABLE Bibliotecario (
    id_bibliotecario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    cargo VARCHAR(50)
);

CREATE TABLE Assistente (
    id_assistente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    id_bibliotecario INT,
    FOREIGN KEY (id_bibliotecario) REFERENCES Bibliotecario(id_bibliotecario) ON DELETE SET NULL
);

-- Livros
CREATE TABLE Colecao (
    id_colecao SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Livro (
    id_livro SERIAL PRIMARY KEY,
    ISBN CHAR(13) UNIQUE,
    titulo VARCHAR(150) NOT NULL,
    id_colecao INT,
    FOREIGN KEY (id_colecao) REFERENCES Colecao(id_colecao) ON DELETE SET NULL
);

CREATE TABLE Exemplar (
    id_exemplar SERIAL PRIMARY KEY,
    numero_exemplar INT NOT NULL,
    situacao VARCHAR(30), 
    CHECK (situacao IN ('disponível', 'emprestado', 'reservado')),
    is_colecao_reservada BOOLEAN DEFAULT FALSE,
    id_livro INT,
    FOREIGN KEY (id_livro) REFERENCES Livro(id_livro) ON DELETE CASCADE
);

CREATE TABLE Autor (
    id_autor SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Editora (
    id_editora SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);

-- Relacionamentos N:M
CREATE TABLE Autoria (
    id_livro INT,
    id_autor INT,
    PRIMARY KEY (id_livro, id_autor),
    FOREIGN KEY (id_livro) REFERENCES Livro(id_livro) ON DELETE CASCADE,
    FOREIGN KEY (id_autor) REFERENCES Autor(id_autor) ON DELETE CASCADE
);

CREATE TABLE Edicao (
    id_livro INT,
    id_editora INT,
    PRIMARY KEY (id_livro, id_editora),
    FOREIGN KEY (id_livro) REFERENCES Livro(id_livro) ON DELETE CASCADE,
    FOREIGN KEY (id_editora) REFERENCES Editora(id_editora) ON DELETE CASCADE
);

-- Reserva
CREATE TABLE Reserva (
    id_reserva SERIAL PRIMARY KEY,
    data_reserva DATE,
    situacao VARCHAR(30), 
    CHECK (situacao IN ('ativa', 'cancelada', 'concluída')),
    id_usuario INT,
    id_exemplar INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_exemplar) REFERENCES Exemplar(id_exemplar)
);

-- Empréstimos
CREATE TABLE Emprestimo (
    id_emprestimo SERIAL PRIMARY KEY,
    data_emprestimo DATE NOT NULL,
    data_devolucao_prevista DATE NOT NULL,
    data_devolucao_real DATE,
    multas DECIMAL(8,2) DEFAULT 0 CHECK (multas >= 0),
    renovacoes INT DEFAULT 0 CHECK (renovacoes >= 0),
    id_usuario INT NOT NULL,
    id_bibliotecario INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_bibliotecario) REFERENCES Bibliotecario(id_bibliotecario) 
);

-- Ligação N:M entre Emprestimo e Exemplar
CREATE TABLE Emprestimo_Exemplar (
    id_emprestimo INT,
    id_exemplar INT,
    PRIMARY KEY (id_emprestimo, id_exemplar),
    FOREIGN KEY (id_emprestimo) REFERENCES Emprestimo(id_emprestimo) ON DELETE CASCADE,
    FOREIGN KEY (id_exemplar) REFERENCES Exemplar(id_exemplar)
);

------------------------------ FUNÇÕES ------------------------------ 

-- Veirificar se a categoria do usuário é professor em tempo integral

CREATE OR REPLACE FUNCTION verificar_categoria_integral(pid_usuario INT) RETURNS INT AS
$$ 
DECLARE
    contrato INT;
BEGIN
	SELECT COUNT(*) INTO contrato FROM(
		SELECT pp.id_usuario FROM Professor pp 
			WHERE pp.id_usuario = pid_usuario AND pp.tipo_contrato = 'integral'
		UNION
		SELECT ppg.id_usuario FROM Professor_PosGraduacao ppg 
			WHERE ppg.id_usuario = pid_usuario AND ppg.tipo_contrato = 'integral'
	) sub;
	
	IF contrato > 0  THEN
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;
END;
$$
LANGUAGE plpgsql;

------------------------------ GATILHOS ------------------------------

-- Verificar se há multa pendentes antes de realizar um empréstimo
	-- Onde: Empréstimo
	-- Quando: Before
	-- Operações: Inserção
	-- Nível: Row Level

CREATE OR REPLACE FUNCTION verifica_multa() RETURNS TRIGGER AS
$$
BEGIN
	IF((SELECT COUNT(*) FROM Emprestimo WHERE id_usuario = new.id_usuario AND multas > 0) > 0) THEN
		RAISE EXCEPTION 'Este usuário tem um ou mais empréstimos com multa pendente.';
	END IF;

	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER verifica_multa BEFORE INSERT ON Emprestimo	
	FOR EACH ROW EXECUTE PROCEDURE verifica_multa();

-- Verificar se o exemplar do empréstimo que esta sendo realizado já esta emprestado por outro usuário
	-- Onde: Emprestimo_Exemplar
	-- Quando: Before
	-- Operações: Inserção
	-- Nível: Row Level

CREATE OR REPLACE FUNCTION verifica_emprestado() RETURNS TRIGGER AS
$$
DECLARE 
	quantidade INT;
BEGIN
	SELECT COUNT(*) INTO quantidade FROM Emprestimo e JOIN Emprestimo_Exemplar ee USING(id_emprestimo) 
		WHERE ee.id_exemplar = new.id_exemplar AND e.data_devolucao_real IS NULL;

	IF quantidade > 0 THEN
			RAISE EXCEPTION 'Este exemplar já está emprestado.';
	END IF;
	
	RETURN NEW;
END;
$$ 
LANGUAGE plpgsql;
	
CREATE TRIGGER verifica_emprestado BEFORE INSERT ON Emprestimo_Exemplar
	FOR EACH ROW EXECUTE PROCEDURE verifica_emprestado();

-- Verificar se o exemplar do empréstimo que esta sendo realizado pertence a coleção reservada
	-- Onde: Emprestimo_Exemplar
	-- Quando: Before
	-- Operações: Inserção
	-- Nível: Row Level

CREATE OR REPLACE FUNCTION verifica_colecao_reservada() RETURNS TRIGGER AS
$$ 
BEGIN
	IF((SELECT COUNT(*) FROM Exemplar WHERE id_exemplar = new.id_exemplar AND is_colecao_reservada = TRUE) > 0) THEN
		RAISE EXCEPTION 'Este exemplar pertence a coleção reservada.';
	END IF;

	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER verifica_colecao_reservada BEFORE INSERT ON Emprestimo_Exemplar 
	FOR EACH ROW EXECUTE PROCEDURE verifica_colecao_reservada();

-- Verificar se o usuário do empréstimo que esta sendo realizado apresenta livro atrasado
	-- Onde: Emprestimo
	-- Quando: Before
	-- Operações: Inserção
	-- Nível: Row Level

CREATE OR REPLACE FUNCTION livro_atrasado() RETURNS TRIGGER AS
$$
DECLARE 
	quantidade INT;
BEGIN
	SELECT COUNT(*) INTO quantidade FROM Emprestimo 
		WHERE id_usuario = new.id_usuario AND data_devolucao_real IS NULL 
			AND data_devolucao_prevista < CURRENT_DATE;

	IF quantidade > 0  THEN
		RAISE EXCEPTION 'Usuário apresenta livros atrasados';
	END IF;

	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER livro_atrasado BEFORE INSERT ON Emprestimo
	FOR EACH ROW EXECUTE PROCEDURE livro_atrasado();

-- Cálculo da multa na devolução, ou seja, no update do empréstimo
	-- Onde: Emprestimo
	-- Quando: Before
	-- Operações: Update
	-- Nível: Row Level

CREATE OR REPLACE FUNCTION calculo_multa_devolucao() RETURNS TRIGGER AS
$$
DECLARE
	is_integral INT;
BEGIN
	IF new.data_devolucao_real IS NOT NULL AND old.data_devolucao_real IS NULL
		AND new.data_devolucao_real > old.data_devolucao_prevista THEN
	
		is_integral := verificar_categoria_integral(old.id_usuario);

		IF is_integral = 1 THEN
			new.multas := 0;
		ELSE
			new.multas := (new.data_devolucao_real - old.data_devolucao_prevista) * 1.00;
		END IF;
	END IF;

	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER calculo_multa_devolucao BEFORE UPDATE ON Emprestimo 
	FOR EACH ROW EXECUTE PROCEDURE calculo_multa_devolucao();

-- Restrição demáximo de 3 renovações 
	-- Onde: Emprestimo
	-- Quando: Before
	-- Operações: Update
	-- Nível: Row Level

CREATE OR REPLACE FUNCTION verifica_maximo_renovacoes() RETURNS TRIGGER AS
$$
DECLARE
    quantidade_atrasos INT; 
BEGIN
    
    IF new.renovacoes > old.renovacoes THEN
    
        SELECT COUNT(*) INTO quantidade_atrasos
        FROM Emprestimo
        WHERE id_usuario = new.id_usuario 
          AND data_devolucao_real IS NULL
          AND data_devolucao_prevista < CURRENT_DATE;

        IF quantidade_atrasos > 0 THEN
            RAISE EXCEPTION 'Usuário apresenta livros atrasados. Renovação não permitida.';
        END IF;
        IF old.renovacoes >= 3 THEN
            RAISE EXCEPTION 'Este empréstimo já atingiu o limite de renovação = 3';
        END IF;
        
    END IF;
    
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;


CREATE TRIGGER verifica_maximo_renovacoes BEFORE UPDATE ON Emprestimo
    FOR EACH ROW EXECUTE PROCEDURE verifica_maximo_renovacoes();

-- Restrição de número máximo de livros por usuário na hora do empréstimo
	-- Onde: Emprestimo
	-- Quando: Before
	-- Operações: Insert
	-- Nível: Row Level

CREATE OR REPLACE FUNCTION verifica_maximo_emprestimos() RETURNS TRIGGER AS
$$
DECLARE
    limite_emprestimos INT;
    quantidade_emprestimos INT;
    categoria_usuario VARCHAR;
BEGIN
    SELECT categoria INTO categoria_usuario FROM Usuario WHERE id_usuario = new.id_usuario;

    IF categoria_usuario = 'aluno_grad' THEN
        SELECT quantidade_limite_emprestimos INTO limite_emprestimos FROM Aluno_Graduacao WHERE id_usuario = new.id_usuario;
    ELSIF categoria_usuario = 'aluno_pos' THEN
        SELECT quantidade_limite_emprestimos INTO limite_emprestimos FROM Aluno_PosGraduacao WHERE id_usuario = NEW.id_usuario;
    ELSIF categoria_usuario = 'professor' THEN
        SELECT quantidade_limite_emprestimos INTO limite_emprestimos FROM Professor WHERE id_usuario = NEW.id_usuario;
    ELSIF categoria_usuario = 'professor_pos' THEN
        SELECT quantidade_limite_emprestimos INTO limite_emprestimos FROM Professor_PosGraduacao WHERE id_usuario = new.id_usuario;
    END IF;

    SELECT COUNT(*) INTO quantidade_emprestimos FROM Emprestimo
        WHERE id_usuario = new.id_usuario AND data_devolucao_real IS NULL;

    IF quantidade_emprestimos >= limite_emprestimos THEN
        RAISE EXCEPTION 'Não é possível realizar mais empréstimos, pois o limite foi atingido.';
    END IF;

    RETURN NEW;
END;
$$
LANGUAGE plpgsql; 

CREATE TRIGGER verifica_maximo_emprestimos BEFORE INSERT ON Emprestimo
    FOR EACH ROW EXECUTE PROCEDURE verifica_maximo_emprestimos();


