------------------------------ DADOS DE TESTE ------------------------------

-- Usuários
INSERT INTO Usuario VALUES
(1, 'Maria Silva', '11988887777', 'Rua das Flores, 123', 'aluno_grad'),
(2, 'João Pereira', '21999996666', 'Av. Brasil, 45', 'aluno_pos'),
(3, 'Carla Souza', '31955554444', 'Rua Goiás, 99', 'professor'),
(4, 'Ana Lima', '21933332222', 'Rua Copacabana, 21', 'professor_pos');

-- Subtipos
INSERT INTO Aluno_Graduacao VALUES (1, 3, 7);
INSERT INTO Aluno_PosGraduacao VALUES (2, 5, 14);
INSERT INTO Professor VALUES (3, 'Efetivo', 7, 30);
INSERT INTO Professor_PosGraduacao VALUES (4, 'Visitante', 5, 21);

-- Bibliotecários e assistentes
INSERT INTO Bibliotecario VALUES
(1, 'Fernanda Ribeiro', '12345678901', 'Chefe de Setor'),
(2, 'Lucas Andrade', '98765432100', 'Atendente');

INSERT INTO Assistente VALUES
(1, 'Rafaela Lima', '11122233344', 1),
(2, 'Carlos Mendes', '55566677788', 2);

-- Coleções
INSERT INTO Colecao VALUES
(1, 'Engenharia de Software'),
(2, 'Literatura Brasileira');

-- Autores e editoras
INSERT INTO Autor VALUES
(1, 'Ian Sommerville'),
(2, 'Machado de Assis'),
(3, 'Robert C. Martin');

INSERT INTO Editora VALUES
(1, 'Pearson'),
(2, 'Companhia das Letras'),
(3, 'Alta Books');

-- Livros
INSERT INTO Livro VALUES
(1, '9780137035151', 'Engenharia de Software', 1),
(2, '9788535914849', 'Dom Casmurro', 2),
(3, '9788576082675', 'Código Limpo', 1);

-- Relacionamentos N:M
INSERT INTO Autoria VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO Edicao VALUES
(1, 1),
(2, 2),
(3, 3);

-- Exemplares
INSERT INTO Exemplar VALUES
(1, 1, 'disponível', FALSE, 1),
(2, 2, 'emprestado', FALSE, 1),
(3, 1, 'disponível', FALSE, 2),
(4, 1, 'reservado', FALSE, 3);

-- Reservas
INSERT INTO Reserva VALUES
(1, '2025-09-28', 'ativa', 1, 4),
(2, '2025-09-30', 'concluída', 2, 3);

-- Empréstimos
INSERT INTO Emprestimo VALUES
(1, '2025-09-20', '2025-09-27', '2025-09-28', 0, 1, 1, 1),
(2, '2025-10-01', '2025-10-08', NULL, 0, 0, 2, 2);

-- Ligação Emprestimo ↔ Exemplar
INSERT INTO Emprestimo_Exemplar VALUES
(1, 2),
(2, 1);

------------------------------ FUNÇÕES ------------------------------ 

-- Veirificar se a categoria do usuário é professor em tempo integral

CREATE OR REPLACE FUNCTION verificar_categoria_integral(pid_usuario INT) RETURNS INT AS
$$ 
DECLARE
    contrato INT;
BEGIN
	SELECT COUNT(*) INTO contrato FROM(
		SELECT pp.id_usuario FROM Professor pp 
			WHERE pp.id_usuario = pid_usuario AND pp.tipo_contrato = 'Integral'
		UNION
		SELECT ppg.id_usuario FROM Professor_PosGraduacao ppg 
			WHERE ppg.id_usuario = pid_usuario AND ppg.tipo_contrato = 'Integral'
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
BEGIN
	
	IF new.renovacoes > old.renovacoes THEN
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

------------------------------ TESTES ------------------------------

INSERT INTO Usuario VALUES (5, 'Pedro Costa', '47912345678', 'Rua Nova, 10', 'professor');
INSERT INTO Professor VALUES (5, 'Integral', 7, 30);

SELECT verificar_categoria_integral(1)

-------------------------------------------------------------------

INSERT INTO Emprestimo (id_emprestimo, data_emprestimo, data_devolucao_prevista, id_usuario, id_bibliotecario)
VALUES (3, '2025-10-06', '2025-10-20', 2, 1);

UPDATE Emprestimo SET multas = 5.00 WHERE id_emprestimo = 1;

INSERT INTO Emprestimo (id_emprestimo, data_emprestimo, data_devolucao_prevista, id_usuario, id_bibliotecario)
VALUES (4, '2025-10-07', '2025-10-14', 1, 2);

-------------------------------------------------------------------

INSERT INTO Emprestimo (id_emprestimo, data_emprestimo, data_devolucao_prevista, id_usuario, id_bibliotecario)
VALUES (5, '2025-10-08', '2025-10-15', 3, 1);

INSERT INTO Emprestimo_Exemplar (id_emprestimo, id_exemplar) VALUES (5, 3);

INSERT INTO Emprestimo (id_emprestimo, data_emprestimo, data_devolucao_prevista, id_usuario, id_bibliotecario)
VALUES (6, '2025-10-09', '2025-10-16', 4, 2);

INSERT INTO Emprestimo_Exemplar (id_emprestimo, id_exemplar) VALUES (6, 1);

-------------------------------------------------------------------

UPDATE Exemplar SET is_colecao_reservada = TRUE WHERE id_exemplar = 3;

INSERT INTO Emprestimo (id_emprestimo, data_emprestimo, data_devolucao_prevista, id_usuario, id_bibliotecario)
VALUES (5, '2025-10-08', '2025-10-15', 3, 1);

INSERT INTO Emprestimo_Exemplar (id_emprestimo, id_exemplar) VALUES (5, 3);

-------------------------------------------------------------------

UPDATE Emprestimo SET data_devolucao_prevista = '2025-10-05' WHERE id_emprestimo = 2;

INSERT INTO Emprestimo (id_emprestimo, data_emprestimo, data_devolucao_prevista, id_usuario, id_bibliotecario)
VALUES (8, '2025-10-10', '2025-10-17', 2, 2);

-------------------------------------------------------------------

INSERT INTO Emprestimo (id_emprestimo, data_emprestimo, data_devolucao_prevista, id_usuario, id_bibliotecario)
VALUES (9, '2025-09-20', '2025-09-27', 5, 1);

UPDATE Emprestimo SET data_devolucao_real = '2025-09-30' WHERE id_emprestimo = 9;

-------------------------------------------------------------------

UPDATE Emprestimo SET renovacoes = 2 WHERE id_emprestimo = 1;

UPDATE Emprestimo SET renovacoes = 4 WHERE id_emprestimo = 1;

-------------------------------------------------------------------
UPDATE Emprestimo SET multas = 0 WHERE id_emprestimo = 1;

INSERT INTO Emprestimo (id_emprestimo, data_emprestimo, data_devolucao_prevista, id_usuario, id_bibliotecario)
VALUES (10, '2025-10-06', '2025-10-13', 1, 1);

INSERT INTO Emprestimo (id_emprestimo, data_emprestimo, data_devolucao_prevista, id_usuario, id_bibliotecario)
VALUES (11, '2025-10-06', '2025-10-13', 1, 2);

INSERT INTO Emprestimo (id_emprestimo, data_emprestimo, data_devolucao_prevista, id_usuario, id_bibliotecario)
VALUES (12, '2025-10-06', '2025-10-13', 1, 1);

INSERT INTO Emprestimo (id_emprestimo, data_emprestimo, data_devolucao_prevista, id_usuario, id_bibliotecario)
VALUES (13, '2025-10-06', '2025-10-13', 1, 2);
