CREATE TABLE setor (
	cods integer primary key,
	nome varchar(100) NOT NULL
);

CREATE TABLE mecanico (
	codm integer primary key,
	cpf char(11),
	nome varchar(100) NOT NULL,
	idade integer,
	endereco varchar(200) NOT NULL,
	cidade varchar(30),
	funcao varchar(20),
	cods integer,
	FOREIGN KEY (cods) REFERENCES setor
);


CREATE TABLE cliente (
	codc integer primary key,
	cpf char(11),
	nome varchar(200) NOT NULL,
	idade integer,
	endereco varchar(200),
	cidade varchar(30)
);

CREATE TABLE veiculo (
	codv integer primary key,
	renavam integer,
	modelo varchar(20),
	marca varchar(20),
	ano integer,
	quilometragem integer,
	codc integer,
	FOREIGN KEY (codc)references cliente
);

CREATE TABLE concerto (
	codm integer,
	codv integer,
	dataConcerto date,
	hora timestamp,
	primary key (codm, codv, dataConcerto),
	foreign key (codm) references mecanico,
	foreign key (codv) references veiculo
);
