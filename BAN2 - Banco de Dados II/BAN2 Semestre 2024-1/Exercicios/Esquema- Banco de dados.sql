-- Table setor

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

-- Table mecanico

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


-- Table cliente

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

-- Table veiculo

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

-- Table conserto

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


-- Dados

INSERT INTO setor VALUES (1, 'Elétrica'),
(2, 'Mecânica'),
(3, 'Funilaria'),
(4, 'Pintura');

INSERT INTO mecanico VALUES (1, '10000100000', 'João', 40, 'América', 'Joinville', 'som', 1),
(2, '10000110000', 'Luiz', 42, 'Vila Nova', 'Joinville', 'motor', 2),
(3, '11000100000', 'Pedro', 51, 'Cobrasol', 'São José', 'câmbio', 2),
(4, '11000110000', 'Carlos', 28, 'Trindade', 'Florianópolis', 'estofado', null),
(5, '11000111000', 'Márcio', 33, 'Pantanal', 'Florianópolis', 'desamassa', 3);

INSERT INTO cliente VALUES (1, '20000200000', 'Ana', 20, 'América', 'Joinville'),
(2, '20000220000', 'Paulo', 24, 'Saguaçú', 'Joinville'),
(3, '22000200000', 'Lucia', 30, 'Vila Nova', 'Joinville'),
(4, '11000110000', 'Carlos', 28, 'Trindade', 'Florianópolis'),
(5, '51000110000', 'Carlos', 44, 'Centro', 'Florianópolis'),
(6, '71000111000', 'João', 38, 'Praia Comprida', 'São José'),
(7, '10000110000', 'Luiz', 42, 'Vila Nova', 'Joinville');

INSERT INTO veiculo VALUES (1, '2000010000', 'Ka', 'Ford', '2013', 1200.300, 1),
(2, '3000011000', 'Celta', 'GM', '2014', 1220.800, 2),
(3, '4100010000', 'Palio', 'Fiat', '2012', 51000.200, 3),
(4, '5100011000', 'C3', 'Citroen', '2015', 5000.700, 4),
(5, '6100011100', 'Fox', 'VW', '2011', 79000.900, 5),
(6, '7100011100', 'Palio', 'Fiat', '2010', 110000.450, 6),
(7, '7100011111', 'Gol', 'VW', '2009', 130000.500, 7);

INSERT INTO conserto VALUES (1, 1, '12062014', '1400'),
(1, 4, '13062014', '1000'),
(2, 1, '13062014', '0900'),
(2, 2, '13062014', '1100'),
(2, 3, '14062014', '1400'),
(2, 4, '14062014', '1700'),
(3, 1, '19062014', '1800'),
(3, 3, '12062014', '1000'),
(3, 4, '19062014', '1300'),
(4, 4, '20062014', '1300');