CREATE TABLE curso (
	sigla_curso char(10) primary key,
	nome varchar(100),
	titulacao varchar(100)
);

CREATE TABLE disciplina (
	sigla_disc char(10) primary key,
	nome varchar(100),
	carga_horaria integer
);

CREATE TABLE grade(
	sigla_curso char(10) references curso
		ON UPDATE CASCADE ON DELETE CASCADE,
	sigla_disc char(10) references disciplina
		ON UPDATE CASCADE ON DELETE CASCADE,
	primary key (sigla_curso, sigla_disc)
);

CREATE TABLE requisito (
	sigla_disc_req char(10),
	sigla_curso_req char(10),
	sigla_disc char(10),
	sigla_curso char(10),
	primary key(sigla_disc_req, sigla_curso_req, sigla_disc, sigla_curso),
	foreign key (sigla_disc_req, sigla_curso_req)
		references grade(sigla_disc, sigla_curso),
	foreign key (sigla_disc, sigla_curso)
		references grade(sigla_disc, sigla_curso)
);


CREATE TABLE aluno (
	cpf char(11) primary key,
	nome varchar(100) NOT NULL,
	rua varchar(255),
	numero integer,
	estado char(2),
	cidade varchar(100),
	cep integer
);


CREATE TABLE inscricao (
	matricula int primary key,
	sigla_curso char(10),
	FOREIGN KEY (sigla_curso) REFERENCES curso(sigla_curso) ON DELETE NO ACTION,
	cpf char(10),
	FOREIGN KEY (cpf) REFERENCES aluno(cpf) ON DELETE NO ACTION
);

CREATE TABLE matricula (
	ano date NOT NULL,
	matricula integer NOT NULL,
	semestre integer NOT NULL,
	sigla_disc char(10) NOT NULL,
	primary key(ano, matricula, sigla_disc, semestre),
	foreign key (matricula)
		references inscricao(matricula) ON DELETE CASCADE,
	foreign key (sigla_disc)
		references disciplina(sigla_disc) ON DELETE CASCADE
);

CREATE TABLE professor (
	reg_mec INTEGER primary key,
	nome varchar(100) NOT NULL,
	rua varchar(100),
	numero integer,
	cidade varchar(100),
	estado char(2),
	cep integer
);

CREATE TABLE habilitacao (
	sigla_disc char(10),
	reg_mec integer, 
	primary key (sigla_disc, reg_mec),
	foreign key (sigla_disc) references disciplina ON DELETE CASCADE,
	foreign key (reg_mec) references professor ON DELETE CASCADE
);

CREATE TABLE leciona (
	sigla_disc char(10),
	reg_mec integer,
	ano DATE,
	semestre integer,
	primary key (sigla_disc, reg_mec, ano, semestre),
	FOREIGN KEY (sigla_disc, reg_mec) 
		REFERENCES habilitacao(sigla_disc, reg_mec) ON DELETE CASCADE
);


CREATE TABLE area (
	cod_area integer primary key,
	descricao varchar(100) NOT NULL
);

CREATE TABLE responsavel (
	reg_mec integer, 
	cod_area integer,
	ate date,
	primary key(reg_mec, cod_area),
	foreign key (reg_mec) references professor,
	foreign key (cod_area) references area
);

CREATE TABLE titulo (
	reg_mec integer,
	cod_area integer,
	data_da_titulacao date,
	primary key(reg_mec, cod_area),
	foreign key (reg_mec) references professor,
	foreign key (cod_area) references area
);

