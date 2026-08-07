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
INSERT INTO Professor VALUES (3, 'integral', 7, 30);
INSERT INTO Professor_PosGraduacao VALUES (4, 'meio período', 5, 21);

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
(3, 3, 'disponível', FALSE, 2),
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
