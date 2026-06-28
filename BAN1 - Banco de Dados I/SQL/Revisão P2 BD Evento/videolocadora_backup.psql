--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1
-- Dumped by pg_dump version 12.1

-- Started on 2020-09-09 16:16:16

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 202 (class 1259 OID 115676)
-- Name: categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias (
    id integer NOT NULL,
    nome character varying(30),
    preco numeric(5,2)
);


ALTER TABLE public.categorias OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 115679)
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientes (
    id integer NOT NULL,
    nome character varying(30),
    endereco character varying(30),
    fone character varying(20),
    cidade character varying(20),
    responsavel integer,
    cpf character varying(30)
);


ALTER TABLE public.clientes OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 115682)
-- Name: copias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.copias (
    id integer NOT NULL,
    filme integer NOT NULL,
    midia character varying(10),
    tipo character varying(10)
);


ALTER TABLE public.copias OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 115685)
-- Name: estilos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estilos (
    id integer NOT NULL,
    nome character varying(30)
);


ALTER TABLE public.estilos OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 115688)
-- Name: filmes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.filmes (
    id integer NOT NULL,
    titulo character varying(30),
    duracao integer,
    ano integer,
    categoria integer,
    estilo integer
);


ALTER TABLE public.filmes OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 115691)
-- Name: funcionarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.funcionarios (
    id integer NOT NULL,
    nome character varying(30),
    endereco character varying(30),
    fone character varying(20),
    cidade character varying(20),
    salario numeric(5,2),
    turno character(1),
    cpf character varying(30)
);


ALTER TABLE public.funcionarios OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 115694)
-- Name: locacoes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locacoes (
    id integer NOT NULL,
    filme integer NOT NULL,
    cliente integer NOT NULL,
    datar date NOT NULL,
    datapd date,
    funcionario integer,
    datad date
);


ALTER TABLE public.locacoes OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 115697)
-- Name: reservas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservas (
    id integer NOT NULL,
    filme integer NOT NULL,
    cliente integer NOT NULL,
    datar date NOT NULL,
    datapd date,
    funcionario integer,
    datares date
);


ALTER TABLE public.reservas OWNER TO postgres;

--
-- TOC entry 2866 (class 0 OID 115676)
-- Dependencies: 202
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categorias VALUES (1, 'lançamento', 5.00);
INSERT INTO public.categorias VALUES (2, 'normal', 3.00);


--
-- TOC entry 2867 (class 0 OID 115679)
-- Dependencies: 203
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.clientes VALUES (1, 'Rui Hack', 'Rua Benjamin Constant', '434578741', 'Joinville', NULL, '1111111');
INSERT INTO public.clientes VALUES (2, 'Fabiane Hack', 'Rua Benjamin Constant', '434578741', 'Joinville', 1, '2222222');
INSERT INTO public.clientes VALUES (6, 'Isaque Freitas', 'Rua Brasil', '32071468', 'Joinville', 5, '6666666');
INSERT INTO public.clientes VALUES (3, 'Juanir Vix', 'Rua Dr João Colin', '34333665', 'Joinville', NULL, '3333333');
INSERT INTO public.clientes VALUES (4, 'Roberta Vix', 'Rua Dr João Colin', '34333665', 'Joinville', 3, '4444444');
INSERT INTO public.clientes VALUES (5, 'Diogo Freitas', 'Rua Brasil', '32071468', 'Joinville', NULL, '5555555');
INSERT INTO public.clientes VALUES (7, 'Maria Joaquina', 'Rua Xanxerê', '32081414', 'Joinville', NULL, '7777777');
INSERT INTO public.clientes VALUES (8, 'Victor Hugo Freitas', 'Rua Marechal Deodoro', '33554455', 'Florianópolis', NULL, '8888888');
INSERT INTO public.clientes VALUES (9, 'Rui Hack', 'Rua Benjamim Constant', '434578741', 'Joinville', NULL, '1111111');
INSERT INTO public.clientes VALUES (10, 'Rui Hack', 'Rua Benjamim Constant', '434578741', 'Joinville', NULL, '1111111');


--
-- TOC entry 2868 (class 0 OID 115682)
-- Dependencies: 204
-- Data for Name: copias; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.copias VALUES (1, 1, 'DVD', 'legendado');
INSERT INTO public.copias VALUES (2, 1, 'DVD', 'dublado');
INSERT INTO public.copias VALUES (1, 2, 'DVD', 'legendado');
INSERT INTO public.copias VALUES (2, 2, 'DVD', 'legendado');
INSERT INTO public.copias VALUES (3, 2, 'DVD', 'legendado');
INSERT INTO public.copias VALUES (1, 3, 'VHS', 'legendado');
INSERT INTO public.copias VALUES (2, 3, 'VHS', 'dublado');
INSERT INTO public.copias VALUES (1, 4, 'DVD', 'dublado');
INSERT INTO public.copias VALUES (2, 4, 'DVD', 'legendado');
INSERT INTO public.copias VALUES (1, 5, 'DVD', 'legendado');
INSERT INTO public.copias VALUES (2, 5, 'DVD', 'legendado');
INSERT INTO public.copias VALUES (1, 6, 'VHS', 'legendado');
INSERT INTO public.copias VALUES (2, 6, 'VHS', 'legendado');
INSERT INTO public.copias VALUES (2, 7, 'DVD', 'legendado');
INSERT INTO public.copias VALUES (3, 7, 'DVD', 'dublado');
INSERT INTO public.copias VALUES (1, 7, 'VHS', 'legendado');
INSERT INTO public.copias VALUES (1, 8, 'DVD', 'legendado');
INSERT INTO public.copias VALUES (1, 9, 'DVD', 'legendado');
INSERT INTO public.copias VALUES (1, 10, 'DVD', 'legendado');
INSERT INTO public.copias VALUES (1, 11, 'DVD', 'legendado');


--
-- TOC entry 2869 (class 0 OID 115685)
-- Dependencies: 205
-- Data for Name: estilos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.estilos VALUES (1, 'ação');
INSERT INTO public.estilos VALUES (2, 'drama');
INSERT INTO public.estilos VALUES (3, 'comédia');
INSERT INTO public.estilos VALUES (4, 'romance');
INSERT INTO public.estilos VALUES (5, 'policial');
INSERT INTO public.estilos VALUES (6, 'terror');
INSERT INTO public.estilos VALUES (7, 'suspense');


--
-- TOC entry 2870 (class 0 OID 115688)
-- Dependencies: 206
-- Data for Name: filmes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.filmes VALUES (3, 'Tomates Verdes Fritos', 180, 1995, 2, 2);
INSERT INTO public.filmes VALUES (4, 'Ressurg', 115, 2015, 1, 2);
INSERT INTO public.filmes VALUES (6, 'Dossie Pelicano', 125, 1998, 2, 7);
INSERT INTO public.filmes VALUES (1, 'Um amor para recordar', 118, 2002, 2, 4);
INSERT INTO public.filmes VALUES (5, 'Os outros', 110, 2003, 2, 6);
INSERT INTO public.filmes VALUES (7, 'O menino da flauta', 90, 2015, 1, 2);
INSERT INTO public.filmes VALUES (8, 'Vex', 118, 2016, 1, 2);
INSERT INTO public.filmes VALUES (2, 'X-Men 3', 188, 2001, 2, 1);
INSERT INTO public.filmes VALUES (9, 'Zero à esquerda', 120, 2017, 1, 1);
INSERT INTO public.filmes VALUES (10, 'Um morto muito louco', 120, 1995, 1, 3);
INSERT INTO public.filmes VALUES (11, 'Risco Duplo', 180, 2005, 1, 5);


--
-- TOC entry 2871 (class 0 OID 115691)
-- Dependencies: 207
-- Data for Name: funcionarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.funcionarios VALUES (2, 'Paola Silva', 'Rua Bajé', '346539874', 'Joinville', 450.00, 'T', '7777777');
INSERT INTO public.funcionarios VALUES (3, 'Isaque Freitas', 'Rua Brasil', '32071468', 'Joinville', 550.00, 'M', '6666666');
INSERT INTO public.funcionarios VALUES (4, 'Ana Ritz', 'Rua XanxerÊ', '2444444', 'Joinville', 550.00, 'T', '5555555');
INSERT INTO public.funcionarios VALUES (1, 'Rui Hack', 'Rua Benjamim Constant', '434578741', 'Joinville', 605.00, 'N', '1111111');


--
-- TOC entry 2872 (class 0 OID 115694)
-- Dependencies: 208
-- Data for Name: locacoes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.locacoes VALUES (2, 4, 5, '2006-11-30', '2006-12-02', 3, '2006-12-05');
INSERT INTO public.locacoes VALUES (1, 7, 4, '2006-12-01', '2006-12-03', 2, '2006-12-04');
INSERT INTO public.locacoes VALUES (2, 7, 2, '2007-04-01', '2007-04-03', 1, '2007-04-04');
INSERT INTO public.locacoes VALUES (1, 6, 6, '2007-04-01', '2007-04-03', 2, '2007-04-04');
INSERT INTO public.locacoes VALUES (2, 6, 8, '2007-03-02', '2007-03-05', 3, '2007-03-05');
INSERT INTO public.locacoes VALUES (1, 2, 3, '2017-09-30', '2017-10-02', 2, '2017-10-02');
INSERT INTO public.locacoes VALUES (2, 3, 2, '2007-03-01', '2007-03-03', 3, '2007-03-03');
INSERT INTO public.locacoes VALUES (2, 3, 5, '2007-03-04', '2007-03-06', 1, '2007-03-07');
INSERT INTO public.locacoes VALUES (2, 3, 6, '2007-04-04', '2007-04-06', 1, '2007-04-07');
INSERT INTO public.locacoes VALUES (1, 9, 6, '2007-04-01', '2007-04-03', 2, '2007-04-04');
INSERT INTO public.locacoes VALUES (1, 2, 8, '2007-03-01', '2007-03-03', 1, '2007-03-03');
INSERT INTO public.locacoes VALUES (1, 3, 8, '2007-03-01', '2007-03-03', 1, '2007-03-03');
INSERT INTO public.locacoes VALUES (1, 4, 8, '2007-03-01', '2007-03-03', 1, '2007-03-03');
INSERT INTO public.locacoes VALUES (1, 5, 6, '2007-03-01', '2007-03-03', 1, '2007-03-03');
INSERT INTO public.locacoes VALUES (1, 5, 8, '2007-03-01', '2007-03-03', 1, '2007-03-03');
INSERT INTO public.locacoes VALUES (1, 6, 8, '2007-03-01', '2007-03-03', 1, '2007-03-03');
INSERT INTO public.locacoes VALUES (1, 7, 8, '2007-03-02', '2007-03-05', 1, '2007-03-05');
INSERT INTO public.locacoes VALUES (1, 8, 8, '2007-03-01', '2007-03-03', 1, '2007-03-03');
INSERT INTO public.locacoes VALUES (1, 9, 8, '2007-03-01', '2007-03-03', 1, '2007-03-03');
INSERT INTO public.locacoes VALUES (1, 10, 6, '2007-05-01', '2007-05-03', 1, '2007-05-03');
INSERT INTO public.locacoes VALUES (1, 10, 8, '2007-03-01', '2007-03-03', 1, '2007-03-03');
INSERT INTO public.locacoes VALUES (1, 11, 6, '2007-05-01', '2007-05-03', 1, '2007-05-03');
INSERT INTO public.locacoes VALUES (1, 11, 8, '2007-03-01', '2007-03-03', 3, '2007-03-03');
INSERT INTO public.locacoes VALUES (1, 1, 2, '2017-10-01', '2017-10-03', 4, '2017-10-01');
INSERT INTO public.locacoes VALUES (1, 1, 6, '2007-03-01', '2007-03-03', 4, '2007-03-03');
INSERT INTO public.locacoes VALUES (1, 1, 8, '2007-03-01', '2007-03-03', 4, '2007-03-03');
INSERT INTO public.locacoes VALUES (2, 7, 8, '2018-04-01', '2018-05-01', 3, NULL);
INSERT INTO public.locacoes VALUES (2, 2, 1, '2018-04-18', '2018-05-01', 1, NULL);
INSERT INTO public.locacoes VALUES (1, 2, 1, '2018-04-18', '2018-05-01', 1, NULL);


--
-- TOC entry 2873 (class 0 OID 115697)
-- Dependencies: 209
-- Data for Name: reservas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reservas VALUES (1, 3, 2, '2006-11-01', '2006-11-03', 2, '2006-10-30');
INSERT INTO public.reservas VALUES (2, 2, 2, '2007-03-01', '2006-12-02', 3, '2006-11-30');
INSERT INTO public.reservas VALUES (1, 2, 7, '2007-03-01', '2006-11-02', 1, '2007-03-03');
INSERT INTO public.reservas VALUES (1, 1, 1, '2006-10-01', '2006-10-03', 1, '2016-10-01');
INSERT INTO public.reservas VALUES (1, 5, 6, '2006-10-01', '2006-10-03', 3, '2016-10-01');


--
-- TOC entry 2714 (class 2606 OID 115701)
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);


--
-- TOC entry 2716 (class 2606 OID 115703)
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);


--
-- TOC entry 2719 (class 2606 OID 115705)
-- Name: copias copias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.copias
    ADD CONSTRAINT copias_pkey PRIMARY KEY (id, filme);


--
-- TOC entry 2721 (class 2606 OID 115707)
-- Name: estilos estilos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estilos
    ADD CONSTRAINT estilos_pkey PRIMARY KEY (id);


--
-- TOC entry 2723 (class 2606 OID 115709)
-- Name: filmes filmes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filmes
    ADD CONSTRAINT filmes_pkey PRIMARY KEY (id);


--
-- TOC entry 2725 (class 2606 OID 115711)
-- Name: funcionarios funcionarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT funcionarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2727 (class 2606 OID 115713)
-- Name: locacoes locacoes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locacoes
    ADD CONSTRAINT locacoes_pkey PRIMARY KEY (id, filme, cliente, datar);


--
-- TOC entry 2729 (class 2606 OID 115715)
-- Name: reservas reservas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservas
    ADD CONSTRAINT reservas_pkey PRIMARY KEY (id, filme, cliente, datar);


--
-- TOC entry 2717 (class 1259 OID 115716)
-- Name: fki_resp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_resp ON public.clientes USING btree (responsavel);


--
-- TOC entry 2731 (class 2606 OID 115717)
-- Name: copias copias_filme_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.copias
    ADD CONSTRAINT copias_filme_fkey FOREIGN KEY (filme) REFERENCES public.filmes(id);


--
-- TOC entry 2732 (class 2606 OID 115722)
-- Name: filmes filmes_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filmes
    ADD CONSTRAINT filmes_categoria_fkey FOREIGN KEY (categoria) REFERENCES public.categorias(id);


--
-- TOC entry 2733 (class 2606 OID 115727)
-- Name: filmes filmes_estilo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filmes
    ADD CONSTRAINT filmes_estilo_fkey FOREIGN KEY (estilo) REFERENCES public.estilos(id);


--
-- TOC entry 2730 (class 2606 OID 115732)
-- Name: clientes fk_resp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT fk_resp FOREIGN KEY (responsavel) REFERENCES public.clientes(id);


--
-- TOC entry 2734 (class 2606 OID 115737)
-- Name: locacoes locacoes_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locacoes
    ADD CONSTRAINT "locacoes_ID_fkey" FOREIGN KEY (id, filme) REFERENCES public.copias(id, filme);


--
-- TOC entry 2735 (class 2606 OID 115742)
-- Name: locacoes locacoes_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locacoes
    ADD CONSTRAINT locacoes_cliente_fkey FOREIGN KEY (cliente) REFERENCES public.clientes(id);


--
-- TOC entry 2736 (class 2606 OID 115747)
-- Name: locacoes locacoes_funcionario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locacoes
    ADD CONSTRAINT locacoes_funcionario_fkey FOREIGN KEY (funcionario) REFERENCES public.funcionarios(id);


--
-- TOC entry 2737 (class 2606 OID 115752)
-- Name: reservas reservas_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservas
    ADD CONSTRAINT "reservas_ID_fkey" FOREIGN KEY (id, filme) REFERENCES public.copias(id, filme);


--
-- TOC entry 2738 (class 2606 OID 115757)
-- Name: reservas reservas_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservas
    ADD CONSTRAINT reservas_cliente_fkey FOREIGN KEY (cliente) REFERENCES public.clientes(id);


--
-- TOC entry 2739 (class 2606 OID 115762)
-- Name: reservas reservas_funcionario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservas
    ADD CONSTRAINT reservas_funcionario_fkey FOREIGN KEY (funcionario) REFERENCES public.funcionarios(id);


-- Completed on 2020-09-09 16:16:17

--
-- PostgreSQL database dump complete
--

