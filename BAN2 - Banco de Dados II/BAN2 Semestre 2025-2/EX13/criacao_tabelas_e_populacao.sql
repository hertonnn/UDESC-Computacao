-- CRIAÇÃO DAS TABELAS:
-- Table: setor

-- DROP TABLE setor;

CREATE TABLE setor
(
  cods integer NOT NULL,
  nome character varying(50),
  CONSTRAINT setor_pkey PRIMARY KEY (cods)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE setor OWNER TO postgres;

-- Table: mecanico

-- DROP TABLE mecanico;

CREATE TABLE mecanico
(
  codm serial NOT NULL,
  cpf char(11),
  nome character varying(50),
  idade integer,
  endereco character varying(500),
  cidade character varying(500),
  funcao character varying(50),
  cods integer,
  CONSTRAINT mecanico_pkey PRIMARY KEY (codm),
  CONSTRAINT mecanico_cods_fkey FOREIGN KEY (cods)
      REFERENCES setor (cods) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET NULL
)
WITH (
  OIDS=FALSE
);
ALTER TABLE mecanico OWNER TO postgres;


-- Table: cliente

-- DROP TABLE cliente;

CREATE TABLE cliente
(
  codc integer NOT NULL,
  cpf char(11),
  nome character varying(50),
  idade integer,
  endereco character varying(500),
  cidade character varying(500),
  CONSTRAINT cliente_pkey PRIMARY KEY (codc) 
)
WITH (
  OIDS=FALSE
);
ALTER TABLE cliente OWNER TO postgres;

-- Table: veiculo

-- DROP TABLE veiculo;

CREATE TABLE veiculo
(
  codv integer NOT NULL,
  renavam char(10),
  modelo character varying(50),
  marca character varying(50),
  ano integer,
  quilometragem float,
  codc integer,
  CONSTRAINT veiculo_pkey PRIMARY KEY (codv),
  CONSTRAINT veiculo_codc_fkey FOREIGN KEY (codc)
      REFERENCES cliente (codc) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET NULL
)
WITH (
  OIDS=FALSE
);
ALTER TABLE veiculo OWNER TO postgres;

-- Table: conserto

-- DROP TABLE conserto;

CREATE TABLE conserto
(
  codm integer NOT NULL,
  codv integer NOT NULL,
  data date NOT NULL,
  hora time without time zone,
  CONSTRAINT consulta_pkey PRIMARY KEY (codm, codv, data),
  CONSTRAINT consulta_codm_fkey FOREIGN KEY (codm)
      REFERENCES mecanico (codm) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT consulta_codv_fkey FOREIGN KEY (codv)
      REFERENCES veiculo (codv) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
ALTER TABLE conserto OWNER TO postgres;



-- PREENCHIMENTO DE DADOS:

-- Popula Setor
create or replace function populaSetor() returns void as
$$
declare 
   cont int default 0;
begin
   for cont in 1..10000 loop
      execute 'insert into setor (cods, nome) values ('||cont||',''setor'||cont||''')'; 
   end loop;
end;
$$
language plpgsql;

select populaSetor();


-- Popula Mecanico
create or replace function populaMecanico() returns void as
$$
declare 
   cont int default 0;
   vcods int;
   vcpf bigint;
   vidade int;
   vfuncoes varchar(20)[] := '{''Pintor'',''Mecânico'',''Instalador'',''Eletrecista'',''Borracheiro'',''Ajudante''}';
   vfuncao varchar(20);
   vcidades varchar(20)[] := '{''Joinville'',''Florianópolis'',''Itajaí'',''Blumenau'',''Jaraguá do Sul'',''São Francisco''}';
   vcidade varchar(20);
begin
   for cont in 1..10000 loop
   	  vcods := random()*(10000-1)+1;
	  vcpf := random()*(100000000000-1)+1;
	  vidade := random()*(100-18)+18;
	  vfuncao := vfuncoes[random()*(6-1)+1];
	  vcidade := vcidades[random()*(6-1)+1];
      execute 'insert into mecanico (codm, cods, cpf, nome, idade, funcao, cidade) values ('||cont||','||vcods||','||vcpf||',''mecanico'||cont||''''||','||vidade||','||vfuncao||','||vcidade||')'; 
   end loop;
end;
$$
language plpgsql;

select populaMecanico()


-- Popula Cliente
create or replace function populaCliente() returns void as
$$
declare 
   cont int default 0;
   vcpf bigint;  
   vidade int;
   vcidades varchar(20)[] := '{''Joinville'',''Florianópolis'',''Itajaí'',''Blumenau'',''Jaraguá do Sul'',''São Francisco''}';
   vcidade varchar(20);
begin
   for cont in 1..10000 loop
   	  vcpf := random()*(100000000000-1)+1;
	  vidade := random()*(100-18)+18;
	  vcidade := vcidades[random()*(6-1)+1];
      execute 'insert into cliente (codc, nome, cpf, idade, cidade) values ('||cont||',''cliente'||cont||''''||','||vcpf||','||vidade||','||vcidade||')'; 
   end loop;
end;
$$
language plpgsql;

select populaCliente();

-- Popula Veiculo
create or replace function populaVeiculo() returns void as
$$
declare 
   cont int default 0;
   vcodc int;
   vrenavam bigint;
   vano int;
   vmarcas varchar(20)[] default ARRAY['VW','GM','Fiat','Ford'];
   vmarca varchar(20);
   vidMarca int;
   vmodelos varchar(100)[][] default ARRAY[ARRAY['Fusca','Gol','Polo'],ARRAY['Celta','Onix','Prisma'],ARRAY['Palio','Uno','Siena'],ARRAY['Ka','Fiesta','Eco Sport']];
   vmodelo varchar(20);
   vquilometragem float;
   vsql text;
begin
   for cont in 1..10000 loop
   	  vrenavam := random()*(10000000000-1)+1;
   	  vcodc := random()*(10000-1)+1;
	  vidMarca := random()*(4-1)+1;
	  vmarca := vmarcas[vidMarca];
	  vmodelo := vmodelos[vidMarca][random()*(3-1)+1];
	  vano := random()*(2020-1980)+1980;
	  vquilometragem := round((random()*(1000000-1)+1)::numeric, 3);
	  vsql := 'insert into veiculo (codv, renavam, marca, modelo, ano, quilometragem, codc) values ('||cont||','||vrenavam||','''||vmarca||''','''||vmodelo||''','||vano||','||vquilometragem||','||vcodc||')'; 
      execute vsql;
   end loop;
end;
$$
language plpgsql;

select populaVeiculo()


-- Popula Conserto
create or replace function populaConserto() returns void as
$$
declare 
   cont int default 0;
   vcodm int;
   vcodv int;
   vdata date;
   vdia int;
   vmes int;
   vhora time;
begin
   for cont in 1..10000 loop
   	  vcodm := random()*(10000-1)+1;
	  vcodv := random()*(10000-1)+1;
	  vdia := random()*(28-1)+1;
	  vmes := random()*(12-1)+1;
	  vdata := vdia||'/'||vmes||'/'||'2018';
	  vhora := CAST(random()*(18-8)+8 as int) ||':00:00';
      execute 'insert into conserto (codm, codv, data, hora) values ('||vcodm||','||vcodv||','||''''||vdata||''''||','||''''||vhora||''''||')'; 
   end loop;
end;
$$
language plpgsql;

select populaConserto()
