-------------------------------------------------------------------
--Criação do Esquema de Dados
-------------------------------------------------------------------

--Tabela Empregado
CREATE TABLE empregado(
	pnome varchar NOT NULL,
	minicial char(1) NOT NULL,
	unome varchar NOT NULL,
	ssn char(9) NOT NULL PRIMARY KEY,
	datanasc Date NOT NULL,
	endereco varchar NOT NULL,
	sexo char(1) NOT NULL,
	salario integer NOT NULL,
	superssn char(9),
	dno integer,
	FOREIGN KEY (superssn) REFERENCES empregado(ssn)
);

-------------------------------------------------------------------
--Tabela Departamento
CREATE TABLE departamento(
	dnome varchar NOT NULL,
	dnumero integer NOT NULL PRIMARY KEY,
	gerssn char(9) NOT NULL,
	gerdatainicio Date NOT NULL,
	FOREIGN KEY (gerssn) REFERENCES empregado(ssn)
);

-------------------------------------------------------------------
-- Tabela de Localização do Departamento
CREATE TABLE depto_localizacoes(
	dnumero integer NOT NULL,
	dlocalizacao varchar NOT NULL,
	PRIMARY KEY(dnumero,dlocalizacao),
	FOREIGN KEY (dnumero) REFERENCES departamento(dnumero)
);

-------------------------------------------------------------------
-- Tabela Projeto
CREATE TABLE projeto(
	pjnome varchar NOT NULL,
	pnumero integer NOT NULL PRIMARY KEY,
	plocalizacao varchar NOT NULL,
	dnum integer NOT NULL,
	FOREIGN KEY (dnum) REFERENCES departamento(dnumero)
);

-------------------------------------------------------------------
-- Tabela Trabalha_em
CREATE TABLE trabalha_em(
	essn char(9) NOT NULL,
	pno integer NOT NULL,
	horas numeric(3,1),
	PRIMARY KEY(essn,pno),
	FOREIGN KEY (pno) REFERENCES projeto(pnumero),
	FOREIGN KEY (essn) REFERENCES empregado(ssn)
);

-------------------------------------------------------------------
-- Tabela Dependente
CREATE TABLE dependente(
	essn char(9) NOT NULL,
	nome_dependente varchar NOT NULL,
	sexo char(1) NOT NULL,
	datanasc Date NOT NULL,
	parentesco varchar NOT NULL,
	PRIMARY KEY(essn,nome_dependente),
	FOREIGN KEY (essn) REFERENCES empregado(ssn)
);

-------------------------------------------------------------------
--Dados
-------------------------------------------------------------------

INSERT INTO empregado VALUES
	('James','E','Borg','888665555','1937-11-10','450 Stone, Houston, TX','M',55000,null,1),
	('Franklin','T','Wong','333445555','1955-12-08','638 Voss, Houston, TX','M',40000,888665555,5),
	('Jennifer','S','Wallace','987654321','1941-06-20','291 Berry, Bellaire,TX','F',43000,888665555,4),
	('John','B','Smith','123456789','1965-01-09','731 Fondren, Houston, TX','M',30000,333445555,5),
	('Alicia','J','Zelaya','999887777','1968-01-19','3321 Castle, Spring, TX','F',25000,987654321,4),
	('Ramesh','K','Narayan','666884444','1962-09-15','975 Fire Oak, Humble, TX','M',38000,333445555,null),
	('Joyce','A','English','453453453','1972-07-31','5631 Rice, Houston, TX','F',25000,null,5),
	('Ahmad','V','Jabbar','987987987','1969-03-29','980 Dallas, Houston, TX','M',25000,987654321,4);

-------------------------------------------------------------------
	
INSERT INTO departamento VALUES
	('Pesquisa',5,'333445555','1988-05-22'),
	('Administração',4,'987654321','1995-01-01'),
	('Recursos Humanos',2,'987987987','2000-01-01'),
	('Sede Administrativa',1,'888665555','1981-06-19');

-------------------------------------------------------------------

INSERT INTO depto_localizacoes VALUES
	(1,'Houston'),
	(4,'Stafford'),
	(5,'Bellaire'),
	(5,'Sugarland');

-------------------------------------------------------------------

INSERT INTO projeto VALUES
	('ProdutoX',1,'Bellaire',5),
	('ProdutoY',2,'Suaarland',5),
	('ProdutoZ',3,'Houston',5),
	('ProdutoW',4,'Albuquerque',5),
	('Automatização',10,'Stafford',4),
	('Reorganização',20,'Houston',1),
	('Novos Benefícios',30,'Stafford',4);

-------------------------------------------------------------------

INSERT INTO trabalha_em VALUES
	('123456789',1,'32.5'),
	('123456789',2,'7.5'),
	('453453453',1,'20.0'),
	('453453453',2,'20.0'),
	('333445555',2,'10.0'),
	('333445555',3,'10.0'),
	('333445555',10,'10.0'),
	('333445555',20,'10.0'),
	('999887777',30,'30.0'),
	('999887777',10,'10.0'),
	('987987987',10,'35.0'),
	('987987987',30,'5.0'),
	('987654321',30,'20.0'),
	('987654321',20,'15.0'),
	('888665555',20,null);

-------------------------------------------------------------------

INSERT INTO dependente VALUES
	('333445555','Alice','F','1986-04-05','FILHA'),
	('333445555','Theodore','M','1983-10-25','FILHO'),
	('333445555','Joy','F','1958-05-03','CÔNJUGE'),
	('987654321','Abner','M','1942-02-28','CÔNJUGE'),
	('123456789','Michael','M','1988-01-04','FILHO'),
	('123456789','Alice','F','1988-12-30','FILHA'),
	('123456789','Elizabeth','F','1967-05-05','CÔNJUGE');