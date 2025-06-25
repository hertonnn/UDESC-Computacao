-- Tabela 1: Pessoa
-- Armazena os dados de indivíduos ou empresas que podem ser parte em um processo.
CREATE TABLE Pessoa (
    id_pessoa SERIAL PRIMARY KEY,
    primeiro_nome VARCHAR(50) NOT NULL,
    ultimo_nome VARCHAR(50) NOT NULL,
    cpf_cnpj VARCHAR(18) UNIQUE NOT NULL,
    tipo_pessoa VARCHAR(20) NOT NULL,
    sexo CHAR(1) CHECK (sexo IN ('M', 'F')),
    data_nascimento DATE
);

-- Tabela 2: Vara
-- Descreve os locais onde os processos tramitam.
CREATE TABLE Vara (
    id_vara SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    entrancia VARCHAR(50)
);

-- Tabela 3: Processo
-- A entidade central, representando o caso judicial.
CREATE TABLE Processo (
    id_processo SERIAL PRIMARY KEY,
    numero_processo VARCHAR(50) UNIQUE NOT NULL,
    tipo_processo VARCHAR(50) NOT NULL,
    assunto VARCHAR(255) NOT NULL,
    status VARCHAR(30) NOT NULL,
    data_inicio DATE NOT NULL,
    data_encerramento DATE,
    fk_id_vara INT NOT NULL,
    
    CONSTRAINT fk_processo_vara
        FOREIGN KEY (fk_id_vara) 
        REFERENCES Vara(id_vara) ON DELETE CASCADE
);

-- Tabela 4: Parte
-- Tabela de junção que implementa a relação entre Pessoa e Processo.
CREATE TABLE Parte (
    fk_id_pessoa INT NOT NULL,
    fk_id_processo INT NOT NULL,
    parte_tipo VARCHAR(30) NOT NULL, -- 'Autor', 'Réu', 'Testemunha'
    
    CONSTRAINT fk_parte_pessoa
        FOREIGN KEY (fk_id_pessoa) 
        REFERENCES Pessoa(id_pessoa) ON DELETE CASCADE,
        
    CONSTRAINT fk_parte_processo
        FOREIGN KEY (fk_id_processo) 
        REFERENCES Processo(id_processo) ON DELETE CASCADE,
    PRIMARY KEY (fk_id_pessoa, fk_id_processo)
);

-- Tabela 5: Tramite
-- Registra o histórico de todos os andamentos e eventos de um processo.
-- Depende da tabela Processo.
CREATE TABLE Tramite (
    id_tramite SERIAL PRIMARY KEY,
    fk_id_processo INT NOT NULL,
    data_hora TIMESTAMP WITH TIME ZONE NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    descricao TEXT NOT NULL,
    
    CONSTRAINT fk_tramite_processo
        FOREIGN KEY (fk_id_processo) 
        REFERENCES Processo(id_processo) ON DELETE CASCADE
);

INSERT INTO Pessoa (primeiro_nome, ultimo_nome, cpf_cnpj, tipo_pessoa, sexo, data_nascimento) VALUES
('Adriano', 'Silva', '123.456.789-10', 'Física', 'M', '2001-01-10'),
('ABC', '', '83.891.283/0001-36', 'Jurídica', NULL, NULL),
('Herton', 'Silveira', '987.654.321-00', 'Física', 'M', '2000-11-30'),
('Carlos', 'Mendes', '123.789.456-10', 'Física', 'M', '1985-04-12'),
('Ana', 'Maria', '123.654.789-00', 'Física', 'F', '1998-12-30');

INSERT INTO Vara (nome, tipo, entrancia) VALUES
('1ª Vara Cível de Joinville', 'Cível', 'Final'),
('Vara da Família de Joinville', 'Família', 'Final'),
('2ª Vara Criminal de Blumenau', 'Criminal', 'Intermediária');

INSERT INTO Processo (numero_processo, tipo_processo, assunto, status, data_inicio, fk_id_vara) VALUES
('001/2025', 'Ação de Cobrança', 'Dívida Contratual', 'Em Andamento', '2025-01-15', 1),
('002/2025', 'Divórcio Consensual', 'Dissolução de Casamento', 'Concluído', '2025-02-20', 2),

-- Processo 1: Empresa ABC (id=2) processa Carlos Mendes (id=4)
INSERT INTO Parte (fk_id_pessoa, fk_id_processo, parte_tipo) VALUES
(2, 1, 'Autor'),
(4, 1, 'Réu');

-- Processo 2: Ana Maria (id=5) e Carlos Mendes (id=4) se divorciam
INSERT INTO Parte (fk_id_pessoa, fk_id_processo, parte_tipo) VALUES
(5, 2, 'Requerente'),
(4, 2, 'Requerido');

-- Trâmites do Processo 1 (Ação de Cobrança)
INSERT INTO Tramite (fk_id_processo, data_hora, tipo, descricao) VALUES
(1, '2025-01-15 14:30:00-03', 'Petição Inicial', 'Distribuído livremente para a 1ª Vara Cível.'),
(1, '2025-02-01 10:00:00-03', 'Citação', 'Mandado de citação do réu expedido.'),
(1, '2025-03-05 17:45:00-03', 'Contestação', 'Réu apresenta defesa e documentos.');

-- Trâmites do Processo 2 (Divórcio)
INSERT INTO Tramite (fk_id_processo, data_hora, tipo, descricao) VALUES
(2, '2025-02-20 11:00:00-03', 'Petição Inicial', 'Recebida petição de divórcio consensual.'),
(2, '2025-03-15 09:30:00-03', 'Sentença', 'Homologado o acordo e decretado o divórcio das partes. Processo arquivado.');
