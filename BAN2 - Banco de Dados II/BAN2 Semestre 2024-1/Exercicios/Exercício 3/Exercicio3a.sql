
create table Setor (
	cods int primary key,
	nome varchar(100)
);

create table Mecanico (
	codm int primary key,
	cpf char(11) not null,
	nome varchar(100),
	idade int,
	endereco varchar(100),
	cidade varchar(100),
	funcao varchar(100),
	cods int references Setor(cods) on update cascade
);

create table Cliente(
	codc int primary key,
	cpf varchar(100),
	nome varchar(100),
	idade int,
	endereco varchar(100),
	cidade varchar(100)
);

create table Veiculo(
	codv int primary key,
	renavam int,
	modelo varchar(100),
	marca varchar(100),
	ano int,
	quilometragem int,
	codc int references Cliente(codc) on delete cascade
);

create table Conserto(
	codm int,
	codv int,
	data date,
	hora varchar(100),
	primary key(codm, codv, data),
	foreign key (codm) references Mecanico(codm) on update cascade,
	foreign key (codv) references Veiculo(codv) on delete cascade	
);
