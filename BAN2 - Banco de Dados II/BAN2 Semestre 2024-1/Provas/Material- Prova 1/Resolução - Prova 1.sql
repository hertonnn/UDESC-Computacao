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

-------------------------------------------------------------------
-- QUESTÕES 
-------------------------------------------------------------------

-- Questão 01.a) Função que calcule e retorne o salário do empregado passado por parâmetro 
-- com acréscimo de 2% para cada dependente com parentesco do tipo ‘filho’ e ‘filha’.

create or replace function novo_salario(pssn char(9)) returns integer as
$$
declare 
	salario_base integer;
	quantidade_filhos integer;
	percentual_aumento numeric;
begin
	select salario into salario_base from empregado e where e.ssn = pssn;

	select count(*) into quantidade_filhos from dependente d where d.essn = pssn
		and d.parentesco in ('FILHO', 'FILHA');

	if quantidade_filhos > 0 then
		percentual_aumento := quantidade_filhos * 0.02;
		salario_base := round(salario_base * (1 + percentual_aumento));
	end if;

	return salario_base;
end;
$$
language plpgsql;

-- Questão 01.b) Função que retorne a soma das horas trabalhadas pelo empregado passado como parâmetro em 
-- projetos do mesmo departamento em que ele está alocado.

create or replace function horas_trabalhadas(pnss char(9)) returns numeric as
$$
declare
	total_horas numeric;
begin 
		select sum(t.horas) into total_horas 
		from empregado e
		join projeto p on e.dnumero = p.dnum
		join trabalha_em t on e.ssn = t.essn and p.pnumero = t.pno
		where e.ssn = pnss;

		return total_horas;
end;
$$ 
language plpgsql;


-- Questão 01.c) Função que retorne o nome dos empregados que têm alocação em projetos de um departamento passado
-- como parâmetro maior que a média de alocação dos empregados em todos os projetos.

create or replace function empregados_acima_media_alocacao(depto_num integer)
returns table (nome_empregado varchar, sobrenome_empregado varchar) as
$$
    select
        e.pnome,
        e.unome
    from
        empregado e
    join trabalha_em t on e.ssn = t.essn
    join projeto p on t.pno = p.pnumero
    where
        p.dnum = depto_num
    group by
        e.ssn, e.pnome, e.unome
    having
        count(p.pnumero) > (
            select count(*)::numeric / count(distinct essn) from trabalha_em
        );
$$
language sql;

-- Questão 02.a) Gatilho para impedir que um empregado seja supervisionado por ele mesmo.

create or replace function impede_auto_supervisao() returns trigger as
$$
begin
    if new.ssn = new.superssn then
        raise exception 'um empregado nao pode supervisionar a si mesmo.';
    end if;
    
    return new;
end;
$$
language plpgsql;

create trigger tr_impede_auto_supervisao before insert or update on empregado
for each rowexecute procedure impede_auto_supervisao();

-- Questão 02.b) Gatilho para impedir que um empregado que tenha mais de um cônjuge. Ou seja, tenha mais de um 
-- dependente com PARENTESCO = ‘cônjuge’

-- onde: dependente
-- quanto: before
-- operações: insert, update
-- nivel: row level

create or replace function verifica_conjuge() returns trigger as
$$ 
declare 
	total_conjuges int;
begin
	if(new.parentesco = 'CÔNJUGE') then
		select count(*) into total_conjuges from dependente d where d.essn = new.essn and d.parentesco = 'CÔNJUGE';

		if (TG_OP= 'insert') then
			if total_conjuges > 0 then
				raise exception 'Esse empregado já tem um cônjuge';
			end if;
		end if;

		if (TG_OP = 'update') then
			if (old.parentesco != 'CÔNJUGE') or (old.essn != new.essn) then
				if total_conjuges > 0 then
					raise exception 'Esse empregado já tem um cônjuge';
				end if;
			end if;
		end if;
	end if;

	return new;
end;
$$
language plpgsql;
		
create trigger verifica_conjuge before insert or update
on dependente for each row execute procedure verifica_conjuge();

-- Questão 02.c) Gatilho para impedir que um gerente gerencie mais do que um departamento

-- onde: departamento
-- quanto: before
-- operações: insert, update
-- nivel: row level

create or replace function verifica_gerente() returns trigger as
$$ 
declare
	contagem integer;
begin
	if(tg_op = 'update' and new.gerssn is not distinct from old.gerssn) then
		return new;
	end if;

	select count(*) into contagem from departamento where gerssn = new.gerssn;

	if contagem > 0 then 
		raise exception 'Gerente já gerencia outro departamento';
	end if;

	return new;
end;
$$
language plpgsql;
		
create trigger verifica_gerente before insert or update
on departamento for each row execute procedure verifica_gerente();

-- Questão 02.d) Gatilho para impedir que um empregado seja supervisionado por um empregado de outro departamento diferente do dele

create or replace function impede_supervisor_depto_diferente() returns trigger as
$$
declare
    depto_empregado integer;
    depto_supervisor integer;
begin

    if new.superssn is not null then

        depto_empregado := new.dno;

        select dno into depto_supervisor from empregado where ssn = new.superssn;
        
        if depto_empregado is not distinct from depto_supervisor then
            return new;
        else
            raise exception 'o supervisor deve pertencer ao mesmo departamento do empregado.';
        end if;
    end if;
    
    return new;
end;
$$
language plpgsql;

create trigger tr_impede_supervisor_depto_diferente before insert or update on empregado
for each row execute procedure impede_supervisor_depto_diferente();

-- Questão 03.a) Visão que mostre o nome de todos os empregados, e para aqueles que estão alocados a projetos, mostre também a quantidade de horas alocadas

create or replace view vw_empregado_horas_alocadas as
    select
        e.pnome,
        e.unome,
        sum(t.horas) as total_horas_alocadas
    from
        empregado e
    left join trabalha_em t on e.ssn = t.essn
    group by e.ssn, e.pnome, e.unome
    order by e.pnome, e.unome;

-- Questão 03.b) Visão que mostre o nome dos empregados e de seus dependentes do tipo ‘filho’ e ‘filha’

create or replace view empregados_dependentes as
		select e.pnome as nome_empregado, e.unome as sobrenome_empregado, d.nome_dependente as nome_filho 
		from empregado e join dependente d on e.ssn = d.essn
		where d.parentesco IN ('FILHO', 'FILHA');

select * from empregados_dependentes;

-- Questão 03.c) Visão que mostra o nome de todos os departamentos, e para aqueles que tem projeto, 
-- mostre os nomes dos projetos e de seus empregados alocados.

create or replace view departamento_projetos_empregados as 
	select d.dnome as nome_departamento, p.pjnome as nome_projeto, e.pnome as nome_empregado 
	from departamento d 
	left join projeto p on d.dnumero = p.dnum
	left join trabalha_em t on p.pnumero = t.pno
	left join empregado e on e.ssn = t.essn;

select * from departamento_projetos_empregados;