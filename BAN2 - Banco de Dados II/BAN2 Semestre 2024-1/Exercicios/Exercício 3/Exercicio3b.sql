create table Curso(
    sigla_curso char(10) primary key,
    nome varchar(100),
    titulacao varchar(100)
);

create table Disciplina(
    sigla_disc char(10) primary key,
    nome varchar(100),
    carga_horaria int
);

create table Grade(
    sigla_curso char(10) references Curso(sigla_curso) on update cascade on delete cascade,
    sigla_disc char(10) references Disciplina(sigla_disc) on update cascade on delete cascade,
    primary key (sigla_curso, sigla_disc)
);

create table Requisito(
    sigla_disc_req char(10),
    sigla_curso_req char(10),
    sigla_disc char(10),
    sigla_curso char(10),
    primary key(sigla_disc_req, sigla_curso_req, sigla_disc, sigla_curso),
    foreign key (sigla_curso_req, sigla_disc_req) references Grade(sigla_curso, sigla_disc) on update cascade on delete cascade,
    foreign key (sigla_curso, sigla_disc) references Grade(sigla_curso, sigla_disc) on update cascade on delete cascade
);

create table Aluno(
    cpf char(11) primary key,
    nome varchar(100),
    rua varchar(255),
    numero int,
    estado char(2),
    cidade varchar(100),
    cep int
);

create table Inscricao(
    matricula int primary key,
    sigla_curso char(10) references Curso(sigla_curso) on update cascade on delete cascade,
    cpf char(11) references Aluno(cpf) on delete cascade
);

create table Matricula(
    ano date,
    matricula int,
    sigla_disc char(10),
    semestre int,
    primary key(ano, matricula, sigla_disc, semestre),
    foreign key (matricula) references Inscricao(matricula) on delete cascade,
    foreign key (sigla_disc) references Disciplina(sigla_disc) on update cascade on delete cascade
);

create table Professor(
    reg_mec int primary key,
    nome varchar(100),
    rua varchar(255),
    numero int,
    cidade varchar(100),
    estado char(2),
    cep int
);

create table Leciona(
    sigla_disc char(10),
    reg_mec int,
    ano date,
    semestre int,
    primary key(sigla_disc, reg_mec, ano, semestre),
    foreign key (sigla_disc) references Disciplina(sigla_disc) on update cascade on delete cascade,
    foreign key (reg_mec) references Professor(reg_mec) on update cascade on delete cascade
);

create table Habilitacao(
    sigla_disc char(10),
    reg_mec int,
    primary key(sigla_disc, reg_mec),
    foreign key (sigla_disc) references Disciplina(sigla_disc) on update cascade on delete cascade,
    foreign key (reg_mec) references Professor(reg_mec) on update cascade on delete cascade
);

create table Area(
    cod_area int primary key,
    descricao varchar(100)
);

create table Titulo(
    reg_mec int,
    cod_area int, 
    data date,
    primary key(reg_mec, cod_area),
    foreign key(reg_mec) references Professor(reg_mec) on update cascade on delete cascade,
    foreign key(cod_area) references Area(cod_area) on update cascade on delete cascade
);

create table Responsavel(
    reg_mec int,
    cod_area int,
    data date,
    primary key(reg_mec, cod_area),
    foreign key(reg_mec) references Professor(reg_mec) on update cascade on delete cascade,
    foreign key(cod_area) references Area(cod_area) on update cascade on delete cascade
);
