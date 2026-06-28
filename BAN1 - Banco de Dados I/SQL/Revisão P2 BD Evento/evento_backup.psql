--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1
-- Dumped by pg_dump version 12.1

-- Started on 2020-09-02 11:30:08

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
-- TOC entry 202 (class 1259 OID 107421)
-- Name: artigos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.artigos (
    artigoid integer NOT NULL,
    titulo character varying(400) NOT NULL,
    tipoid integer,
    edicaoid integer
);


ALTER TABLE public.artigos OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 107424)
-- Name: artigos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.artigos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.artigos_id_seq OWNER TO postgres;

--
-- TOC entry 2871 (class 0 OID 0)
-- Dependencies: 203
-- Name: artigos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.artigos_id_seq OWNED BY public.artigos.artigoid;


--
-- TOC entry 204 (class 1259 OID 107426)
-- Name: autores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.autores (
    autorid integer NOT NULL,
    nome character varying(75) NOT NULL,
    genero character(1)
);


ALTER TABLE public.autores OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 107429)
-- Name: autores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.autores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.autores_id_seq OWNER TO postgres;

--
-- TOC entry 2872 (class 0 OID 0)
-- Dependencies: 205
-- Name: autores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.autores_id_seq OWNED BY public.autores.autorid;


--
-- TOC entry 206 (class 1259 OID 107431)
-- Name: autoresartigo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.autoresartigo (
    id integer NOT NULL,
    autorid integer NOT NULL,
    artigoid integer NOT NULL
);


ALTER TABLE public.autoresartigo OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 107434)
-- Name: autoresartigo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.autoresartigo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.autoresartigo_id_seq OWNER TO postgres;

--
-- TOC entry 2873 (class 0 OID 0)
-- Dependencies: 207
-- Name: autoresartigo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.autoresartigo_id_seq OWNED BY public.autoresartigo.id;


--
-- TOC entry 208 (class 1259 OID 107436)
-- Name: edicoes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edicoes (
    edicaoid integer NOT NULL,
    cidade character varying(40) NOT NULL,
    uf character(2) NOT NULL,
    qtdparticipantes integer,
    ano integer
);


ALTER TABLE public.edicoes OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 107439)
-- Name: edicoes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.edicoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.edicoes_id_seq OWNER TO postgres;

--
-- TOC entry 2874 (class 0 OID 0)
-- Dependencies: 209
-- Name: edicoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.edicoes_id_seq OWNED BY public.edicoes.edicaoid;


--
-- TOC entry 210 (class 1259 OID 107441)
-- Name: tipos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipos (
    tipoid integer NOT NULL,
    nome character varying(50) NOT NULL
);


ALTER TABLE public.tipos OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 107444)
-- Name: tipos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipos_id_seq OWNER TO postgres;

--
-- TOC entry 2875 (class 0 OID 0)
-- Dependencies: 211
-- Name: tipos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipos_id_seq OWNED BY public.tipos.tipoid;


--
-- TOC entry 2711 (class 2604 OID 107446)
-- Name: artigos artigoid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artigos ALTER COLUMN artigoid SET DEFAULT nextval('public.artigos_id_seq'::regclass);


--
-- TOC entry 2712 (class 2604 OID 107447)
-- Name: autores autorid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autores ALTER COLUMN autorid SET DEFAULT nextval('public.autores_id_seq'::regclass);


--
-- TOC entry 2713 (class 2604 OID 107448)
-- Name: autoresartigo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autoresartigo ALTER COLUMN id SET DEFAULT nextval('public.autoresartigo_id_seq'::regclass);


--
-- TOC entry 2714 (class 2604 OID 107449)
-- Name: edicoes edicaoid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edicoes ALTER COLUMN edicaoid SET DEFAULT nextval('public.edicoes_id_seq'::regclass);


--
-- TOC entry 2715 (class 2604 OID 107450)
-- Name: tipos tipoid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos ALTER COLUMN tipoid SET DEFAULT nextval('public.tipos_id_seq'::regclass);


--
-- TOC entry 2856 (class 0 OID 107421)
-- Dependencies: 202
-- Data for Name: artigos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (1, 'Árvore TM: Melhorando Árvores Métricas Agrupando Melhor os Objetos', NULL, 1);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (2, 'Ferramenta para estimativa de Recall/Precision usando amostras do Banco de Dados', NULL, 1);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (3, 'Suporte a argumentos de consulta vagos através da XPath', NULL, 1);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (4, 'Data Warehouse voltado ao Monitoramento de Processos de Desenvolvimento de Software através de Métricas', NULL, 1);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (5, 'Pré-Processamento de Dados para Descoberta de Conhecimento em Processos de Workflow Modelados sobre Plataforma Oracle', NULL, 1);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (6, 'Comportamento Ativo em Web services', NULL, 1);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (7, 'Arquiteturas para Coordenação de Banco de Dados num Ambiente de Rede Peer-to-Peer (P2P)', NULL, 1);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (8, 'Evolução de Esquemas e Documentos XML no Oracle XML DB', NULL, 1);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (9, 'Um middleware para replicação entre bancos de dados usando sistemas de comunicação de grupo', NULL, 1);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (10, 'Carla: uma técnica para comparação de cadeias de caracteres', NULL, 1);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (11, 'Obtenção de Metadados de Objetos de Aprendizagem no AdaptWeb(r)', NULL, 1);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (12, 'Identificação de Áreas de Interesse a partir da Extração de Informações de Currículos Lattes/XML', NULL, 1);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (13, 'DB Guardian - Sistema para Diagnóstico de Desempenho em Banco de Dados', NULL, 1);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (14, 'Decomposição de Consultas sobre Múltiplas Fontes XML', NULL, 1);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (15, 'Estudo Sobre a Viabilidade de Implementação de Aspectos Temporais em SGBDs Livres (open-source)', NULL, 1);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (16, 'PetroQuery: Uma ferramenta para consulta e navegação sobre ontologias', NULL, 1);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (17, 'RSRural/Web: Uma interface Web para consultas e execução de processos geográficos', NULL, 1);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (18, 'Uma Abordagem para Viabilizar o Processo de Data Warehouse de Dados Biológicos', NULL, 1);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (19, 'Uma Proposta de Navegação na Web Utilizando Facetas', NULL, 2);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (20, 'Implementação de uma infra-estrutura para controle de versões e adaptação de páginas Web', NULL, 2);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (21, 'Comparativo de Desempenho entre Bancos de Dados de Código Aberto', NULL, 2);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (22, 'Implementação de um Mecanismo para Gerência de Evolução de Esquemas de DW', NULL, 2);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (23, 'Extensão para a Execução de Regras Através da Detecção de Eventos Temporais', NULL, 2);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (24, 'Similaridade entre documentos semi-estruturados', NULL, 2);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (25, 'Replicação em Banco de Dados PostgreSQL', NULL, 2);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (26, 'Ferb: um framework para casamento de esquemas', NULL, 2);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (27, 'Aplicação de Técnicas de Mineração do Uso da Web para Análise de Processos de Negócio: um Estudo de Caso', NULL, 2);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (28, 'Determinando Equivalências Semânticas entre Componentes de Esquemas GML', NULL, 2);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (29, 'Método TPC-H para sintonia em SGBDs livres', NULL, 2);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (30, 'Definição e Implementação de Regras de Conversão de um Esquema XML Schema para um Esquema Conceitual', NULL, 2);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (31, 'Protótipo de Interpretador para cTVQL', NULL, 2);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (32, 'Requisitos para modelos analíticos de armazém de dados, voltados ao acompanhamento de processos de negócio', NULL, 2);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (33, 'BDTerm: um Sistema de Gerenciamento de Bases de Dados Terminológicas', NULL, 2);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (34, 'Integração de dados em múltiplos níveis', NULL, 2);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (56, 'Aplicação de consultas baseadas em ambientes de conhecimentos definidos por tesauros', 1, 4);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (57, 'Aplicação de padrão Data Access Object (DAO) em projetos desenvolvidos com Delphi', 1, 4);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (58, 'Atualização do Ontocover: Uma biblioteca Java para manipular ontologias em aplicações Web semântica', 1, 4);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (59, 'Desenvolvimento de ferramenta de apoio à atualização de sistemas de informação baseado no Banco de Dados Pós-Relacional Cachê', 1, 4);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (60, 'Estudo de ferramentas de visualização cartográfica para acoplamento com OLAP sobre a Web', 1, 4);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (61, 'Implementação da BDMODONTO: Biblioteca Digital Multimídia Odontológica', 1, 4);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (62, 'Replicação Assíncrona entre banco de dados médicos distribuídos', 1, 4);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (63, 'Sistema BlnXS: Gerador de esquema conceitual global', 1, 4);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (64, 'Uma aplicação OLAP com visualização cartográfica via Web', 1, 4);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (65, 'Uma ferramenta de apoio à normalização de tabelas relacionais baseadas na análise de dados', 1, 4);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (66, 'Uma ferramenta de conversão de esquemas conceituais EER para esquemas lógicos XML', 1, 4);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (67, 'Uma interface Web para identificação de equivalências em bancos de dados heterogêneos', 1, 4);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (68, 'Um processo automático para extração de metadados de documentos PDF usando um template XML', 1, 4);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (35, 'Análise de Abordagens para Modelagem Conceitual e Lógica de Bancos de Dados XML', 2, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (37, 'Melhorando comparações XML com funções de pré-processamento', 2, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (42, 'Athena Model Beta: Um Modelo Analítico Para Descoberta de Conhecimento em Processos de Negócio', 2, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (44, 'Automação do Processo de ETC de Métricas para um Ambiente de Desenvolvimento de Software', 2, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (45, 'Uma Arquitetura para Recuperação de Informação Baseada em Semântica e sua Aplicação no Apoio a Jurisprudência', 2, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (51, 'Mineração em Métricas de Software', 2, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (52, 'Um Estudo e Proposta de Abordagem a respeito de Extração Semi-Automática de Restrições de Integridade Semântica de Dados XML', 2, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (53, 'Utilizando o modelo de atração para representar casadores de esquema', 2, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (69, 'Um tradutor de esquemas relacionais em XML para esquemas SQL', 1, 4);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (70, 'XSimilarity: Uma ferramenta para consultas por similaridade embutidas na linguagem XQuery', 1, 4);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (71, 'Gerenciamento de Domínios de Aplicação através do uso de ontologias', 2, 4);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (72, 'Uma proposta para o uso de detecção de versões de páginas Web para melhoria do desempenho do algoritmo de PageRank', 2, 4);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (73, 'Um sistema de auditoria baseado na análise de registros de log', 2, 4);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (74, 'XDCL 1.1 Uma proposta de linguagem de definição de restrições de integridade de domínio em documentos XML', 2, 4);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (75, 'Banco de Dados para o Núcleo de Pesquisa e Aplicação de Geotecnologias em Desastres Naturais e Eventos Extremos do Centro Regional Sul de Pesquisas Espaciais do INPE', NULL, 5);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (76, 'TUNING - Técnicas de Otimização de Banco de Dados - Um estudo Comparativo: Mysql e Postgresql', NULL, 5);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (77, 'Avaliando o Desempenho do SGBD PostgreSQL Considerando os Diferentes Sistemas de Arquivos', NULL, 5);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (78, 'Desenvolvimento de uma Aplicação Utilizando SOA: Um Estudo de Caso', NULL, 5);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (79, 'As ''Ouvidorias'' Virtuais em Instituições de Ensino Superior', NULL, 5);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (80, 'Estudo Comparativo dos BDXML eXist e Xindice', NULL, 5);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (81, 'Avaliação de Desempenho no Acesso a Dados Utilizando Índices Multidimensionais', NULL, 5);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (82, 'Uma Integração Gráfica para Algoritmos de Detecção de Diferenças entre Documentos XML', NULL, 5);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (83, 'Ferramentas para Suporte a Consultas Temporais em SGBDs convencionais', NULL, 5);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (92, 'Um Panorama do Uso do Tempo em Motores de Busca Web', 3, 7);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (93, 'Uma Ferramenta Para Análise Quantitativa da Produção Científica de Pesquisadores', 3, 7);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (94, 'Gerência de Informações de Mapeamento no Sistema de Integração de Esquemas XML BInXS', 3, 7);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (95, 'Um Modelo de Grupos para MANETs', 3, 7);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (96, 'PGSimilarity: executando consultas aproximadas em um SGBDR', 3, 7);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (97, 'O Uso de Descoberta de Conhecimento em Bases de Dados Associado a Sistemas de Informações Geográficas no Auxílio à Definição de Políticas de Saúde Pública', 3, 7);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (98, 'Uma Ferramenta para Consulta Estruturada na Web', 3, 7);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (99, 'Banco de Dados em Nuvem: Conceitos, Gerenciamento e Desafios', 3, 7);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (100, 'Implementação de um Simulador de Consultas em Álgebra Relacional', 4, 7);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (101, 'Aplicando tuning no PostgreSQL', 4, 7);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (102, 'Projeto e Implementação da Interface com Usuário do Sistema BInXS', 4, 7);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (103, 'Proposta de um WebSIG para Visualização de Informações sobre a Qualidade da Água Superficial de um Sistema de Informações Ambientais', 4, 7);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (104, 'Reallog: Uma Ferramenta para Monitorar Fluxo Contínuo de Dados', 4, 7);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (105, 'Uma Ferramenta para Geração Automática de Código Java a partir do Modelo de Dados', 4, 7);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (106, 'Análise comparativa dos recursos de alta disponibilidade entre os bancos de dados Oracle e SQL Server', 4, 7);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (107, 'Desenvolvimento de um Sistema para a Centralização e Consulta de Informações da Estação SONDA/OES', 4, 7);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (127, 'Lógica Paraconsistente aplicada como Solução de Inconsistências entre Classificadores de Aprendizagem Simbólica', 3, 9);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (121, 'Análise espaço-temporal de mensagens do Twitter', 3, 9);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (125, 'Extração de Nomes de Pessoas Baseado em Etapas de Etiquetamento', 3, 9);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (123, 'DBClassMapper: Uma Ferramenta de Apoio ao Mapeamento e Consultas para o ORM Gendal', 4, 9);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (122, 'Classificação de documentos do Exército Brasileiro utilizando o algoritmo de Naive Bayes e técnicas de Seleção de Sentenças', 3, 9);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (126, 'Implementação de um Repositório de Versões de Serviços Web usando OrientDB', 4, 9);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (124, 'DBModeler: Um sistema web para criação, manutenção e consulta de diagramas de bancos de dados', 4, 9);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (108, 'Abordagens de Particionamento de Dados para Redes Sociais', 3, 8);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (115, 'Pré-processamento de tabelas Web heterogêneas para execução do algoritmo de junção merge', 3, 8);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (117, 'Um sistema para análise de redes de pesquisa baseado na Plataforma Lattes', 3, 8);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (119, 'Usando informações do contexto para melhoria da precisão nas buscas por similaridade', 3, 8);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (110, 'CMAP: Geração e Representação de Equivalências entre Documentos XML,Ontologia e Modelo Relacional', 3, 8);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (112, 'Estratégias de Persistência de Clusters em uma Técnica de Casamento por Similaridade para Web Forms', 3, 8);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (109, 'Análise de Abordagens para Matching de Formulários na Deep Web', 3, 8);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (120, 'XVersioning - Uma Ferramenta para Versionamento de Esquemas XML', 3, 8);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (111, 'Detectando diferentes representações de entidades usando Classificadores Bayesianos', 4, 8);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (118, 'Uma Ferramenta para Coleta e Análise de Dados do Segmento Naval', 4, 8);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (114, 'Mineração de Dados Para Inferir Padrões Associados aos Fenômenos: El Niño, La Niña e Anos Neutros', 4, 8);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (113, 'GroupShare: Distribuição e Gerência de Conteúdo em Grupos de Interesse para Dispositivos Móveis', 4, 8);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (116, 'Representação Gráfica de Documentos XML', 4, 8);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (91, 'Um Modelo para Projetar e Implementar Bancos de Dados Analítico-Temporais para Apoio à Tomada de Decisões, Auditorias e Recuperação de Dados', 3, 6);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (87, 'Mapeamento Automático de Modelos de Dados XML Temporais Ad-hoc para um Modelo de Dados XML Temporal Padrão', 3, 6);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (84, 'Da importância de modelos preditivos compreensíveis: Um estudo de caso em saúde bucal', 3, 6);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (85, 'Especificação de uma Taxonomia para Metadados Multifacetados em Ambientes de Integração de Dados na Web', 3, 6);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (86, 'Interagindo com Data Warehouses Espaciais através de Descrições Semânticas', 3, 6);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (88, 'RYLY - Query Analizer: Ferramenta de Visualização e de Análise do Plano de Execução de Consultas ORACLE', 3, 6);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (89, 'Similaridade entre Objetos Localizados em Fontes de Dados Heterogêneas', 3, 6);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (90, 'Um estudo de caso com análise comparativa entre ferramentas a de BI livre e proprietária', 3, 6);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (155, 'Os desafios de uma aplicação de Carpooling no contexto de uma comunidade universitária brasileira', NULL, 11);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (156, 'Um Estudo sobre Modelagem Lógica para Bancos de Dados NoSQL', NULL, 11);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (157, 'Desenvolvimento de um sistema de gestão para apoio à tomada de decisão no agronegócio da região do Alto Paranaíba', NULL, 11);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (158, 'Integração de Dados Biológicos no Programa Net2HomologyWeb', NULL, 11);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (159, 'Análise de Abordagens para Interoperabilidade entre Bancos de Dados Relacionais e Bancos de Dados NoSQL', NULL, 11);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (160, 'Uma DSL de Engenharia Reversa para Modelagem de Banco de Dados Relacionais e Geográficos Baseado em SQL/SFS', NULL, 11);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (161, 'Modelando Banco de Dados Relacionais e Geográficos Utilizando a Ferramenta GenDBM Tool', NULL, 11);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (162, 'Utilização da técnica de árvore de decisão para identificação de espécies de aves do estado do Rio Grande do Sul - Brasil', NULL, 11);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (163, 'Sistemas de Recomendação e Computação Ubíqua: Um Survey', NULL, 11);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (164, 'Um Estudo das Abordagens para Correspondência entre Esquemas Através de Amostras', NULL, 11);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (165, 'ntSQL: Um Conversor de Documentos RDF para SQL', NULL, 11);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (166, 'Aplicando Técnicas de Business Intelligence sobre dados de desempenho Acadêmico: Um estudo de caso', NULL, 11);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (167, 'Módulo para Business Intelligence Compatível com Dispositivos Móveis para o Software de Gestão Empresarial Elementare', NULL, 11);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (168, 'A utilização do Método Cross-Industry Standard Process for Data Mining no Processo de Mineração de Textos: Extração de Termos para Criação de uma Tecnologia Assistiva para o Auxílio à Alunos com Deficiência Motora', NULL, 12);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (169, 'Uma Avaliação de Algoritmos para Mineração de Dados Disponíveis na Web', NULL, 12);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (170, 'Avaliação de Desempenho de Sistemas Relacionais para Armazenamento de dados RDF', NULL, 12);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (171, 'Compressão de Arquivos Orientados a Colunas com PPM', NULL, 12);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (172, 'Estratégias para importação de grandes volumes de dados para um servidor PostgreSQL', NULL, 12);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (173, 'Identificação de contatos duplicados em dispositivos móveis utilizando similaridade textual', NULL, 12);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (174, 'Implementação de Operadores OLAP Utilizando o Modelo de Programação Map Reduce no MongoDB', NULL, 12);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (175, 'Mineração de dados para modelos NoSQL: um survey', NULL, 12);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (176, 'Mineração de opiniões em microblogs com abordagem CESA', NULL, 12);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (177, 'Um processo de avaliação de dados em um Data Warehouse', NULL, 12);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (178, 'Utilizando Técnicas de Data Science para Definir o Perfil do Pesquisador Brasileiro da Área de Ciência da Computação', NULL, 12);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (179, 'Workflows para a Experimentação em Análise de Similaridade de Imagens Médicas em um Ambiente Distribuído', NULL, 12);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (180, 'XplNet - Análise exploratória aplicada à redes complexas', NULL, 12);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (181, 'Uma Proposta de Abordagem de Recomendação para Carreira de Pesquisadores Baseada em Personalização, Similaridade de Perfil e Reputação Acadêmica', 3, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (182, 'Um Survey sobre Extração de Esquemas de Documentos JSON', 3, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (183, 'Análise e Comparação de Algoritmos de Similaridade e Distância entre strings Adaptados ao Português Brasileiro', 3, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (184, 'Redblock: Uma ferramenta para a deduplicação de grandes bases de dados em tempo real', 3, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (185, 'Combinando Técnicas de Recomendação e Smart Posters', 3, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (186, 'Inclusão de Técnicas de Interpolação de Pontos em Algoritmos de Descoberta On-Line do Padrão Flock', 3, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (187, 'Estudo Comparativo de Banco de Dados Chave-Valor com Armazenamento em Memória', 3, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (188, 'MahoutGUI: Uma Interface Gráfica para Gerar Recomendações com o Apache Mahout Diretamente de Banco de Dados usando Mapeamento Objeto-Relacional', 4, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (189, 'Desenvolvimento do Sistema de Acompanhamento do Fluxo de Demandas do Plano de Ação do Instituto Federal Farroupilha Campus Alegrete', 4, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (190, 'Consulta de Dados Espaciais em um Sistema de Informações de uma Bacia Hidrográfica', 4, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (191, 'Mapeamento de Padrões de Acidentes de Trânsito com Vítimas Fatais a partir de Dados Públicos do Governo do Estado do Rio Grande do Sul', 4, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (192, 'Ferramenta de Modelagem de Bancos de Dados Relacionais brModelo v3', 4, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (193, 'Estudo comparativo entre sistemas de gerenciamento de banco de dados relacionais e não relacionais para o armazenamento e busca de metadados MARC', 4, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (194, 'Aplicação da Análise de Sentimentos em Frases das Redes Sociais sobre Empresas de Serviços de Telecomunicação', 4, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (136, 'Uma ferramenta para distribuição e mapeamento de dados Paleogeográficos', 4, 9);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (139, 'Uma Proposta de Entity Ranking Baseada no Uso de Entidades como Objetos de Consulta', 3, 9);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (133, 'Uma Aplicação baseada em SIG para Análise de Acidentes de Trânsito: Estudo de caso na Rodovia BR-101/ES', 4, 9);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (135, 'Uma Ferramenta MDA para Modelagem de Banco de Dados Relacionais', 4, 9);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (138, 'Uma implementação do algoritmo Naïve Bayes para classificação de texto', 4, 9);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (151, 'Uma Aplicação baseada em SIG para Análise de Infrações Cometidas por Menores Infratores: Estudo de caso no Município de Vitória no estado do Espírito Santo', 4, 10);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (148, 'OMT-G Design: uma ferramenta para modelagem de dados espaciais', 4, 10);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (154, 'Uso de Expressões Temporais em Busca na Web: Uma análise através das sugestões de consulta', 3, 10);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (144, 'Armazenamento de trajetórias de objetos móveis para a Plataforma UrbanMob', 4, 10);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (152, 'Uma Extensão MDA para Geração Automática de Codificação SFS para Banco de Dados Geográficos', 4, 10);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (145, 'Comparação de Performance entre PostgreSQL e MongoDB', 3, 10);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (195, 'Desenvolvimento de um Objeto de Aprendizagem baseado em Mobile Learning e sistemas de recomendações para o auxílio ao processo de letramento infantil na educação básica', 4, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (196, 'Mobility Open Data: Use Case for Curitiba and New York', 4, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (197, 'SIRME: Sistema Inteligente de Recomendação para Matrículas Escolares', 4, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (198, 'EasyTest: Plataforma Crowdsourcing para testes funcionais', 4, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (199, 'Integração de Dados de Redutores de Velocidade no Transporte Público de Curitiba', 4, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (200, 'Uma Ferramenta Online para Execução de Scripts em SQL', 4, 13);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (201, 'Uma Proposta de Abordagem de Recomendação para Carreira de Pesquisadores Baseada em Personalização, Similaridade de Perfil e Reputação Acadêmica', 3, 14);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (202, 'Caracterização dos Dados Públicos de Saúde do Paraguai', 3, 14);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (203, 'Análise de evolução de emissão de alvarás próximos a dois shoppings em Curitiba', 3, 14);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (204, 'Comparação entre MySQL e Neo4J para o Acesso a Dados Complexos Usando Linguagens Declarativas', 3, 14);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (205, 'Otimização do Mapeamento de Consultas SPARQL para SQL', 3, 14);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (206, 'Comparação entre Diferentes Implementações de BK-trees para o Problema de Busca por Intervalo', 3, 14);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (207, 'Predição do volume de atendimentos de saúde na cidade de Curitiba utilizando dados abertos', 3, 14);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (208, 'Predição de Indicadores Zootécnicos de Carcaças Bovinas a Partir de Variáveis de Cria', 3, 14);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (209, 'Diferenciação de Perfis de Curva de Carga para Identificação de Perdas Não-Técnicas em Redes de Distribuição Utilizando Mineração de Dados e Aprendizado de Máquina', 3, 14);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (210, 'Aplicações de Mineração de Dados na Pecuária de Corte: Previsão de Indicadores de Qualidade de Carcaças', 3, 14);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (211, 'Análise da Popularidade de Tuítes com Base em Características Extraídas de seu Conteúdo', 3, 14);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (212, 'Extração de elementos textuais em imagens capturadas por smartphones: análise da relação entre as características das imagens e a eficácia da extração', 3, 14);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (213, 'Análise da situação dos redutores de velocidade de Curitiba', 4, 14);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (214, 'Research.NET Web: uma aplicação para análise e exibição de redes de colaboração acadêmica utilizando grafos dinâmicos', 4, 14);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (215, 'Publicação de Dados da Internet das Coisas usando Recursos da Web Semântica: Um estudo de Caso usando uma Tomada Inteligente', 4, 14);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (216, 'DINo: uma ferramenta para importação de dados em bancos de dados NoSQL', 4, 14);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (217, 'Uma Proposta de Abordagem de Recomendação para Carreira de Pesquisadores Baseada em Personalização, Similaridade de Perfil e Reputação Acadêmica', 3, 15);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (218, 'Especificando um Middleware para Integração de Dados do Registro Eletrônico em Saúde', 3, 15);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (219, 'Um Estudo Exploratório das Ferramentas de Código Aberto para a Replicação de Dados no PostgreSQL', 3, 15);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (220, 'Uma Análise de Soluções NewSQL', 3, 15);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (221, 'Unificação de Dados de Saúde Através do Uso de Blockchain e Smart Contracts', 3, 15);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (222, 'Um Data Warehouse baseado no Twitter para análise de Sentimento em Língua Portuguesa: Estudo de Caso das Eleições de 2018', 3, 15);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (223, 'Avaliação de Abordagens Probabilísticas de Extração de Tópicos em Documentos Curtos', 3, 15);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (224, 'Extração de característica para identificação de discurso de ódio em documentos', 3, 15);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (225, 'Acidentes nas rodovias brasileiras nos últimos 10 anos: uma análise com dados abertos', 3, 15);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (226, 'REx - NoSQL Redis Schema Extraction Module', 4, 15);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (227, 'Redes sociais intra-classe e desempenho acadêmico - uma análise inicial', 4, 15);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (228, 'Consolidação de Bases para o Diagnóstico do Distrito de Inovação de Blumenau', 4, 15);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (229, 'Proposta de uma arquitetura de Data Warehouse para análise de SDN e aplicações de Aprendizado de Máquina', 4, 15);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (230, 'Desenvolvimento de um sistema para a classificação de Fakenews acoplado à etapa de ETL de um Data Warehouse de Textos de Notícias em língua Portuguesa', 4, 15);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (231, 'Integração semântica entre dados dos domínios da educação e segurança: um caso em Curitiba', 4, 15);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (232, 'Visualização de dados do índice de Qualidade da Água aplicado a múltiplos pontos em um Sistema de Informação Ambiental', 4, 15);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (132, 'Uma abordagem de código único para aplicações independentes de provedor de bases de dados relacionais', 3, 9);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (134, 'Uma aplicação de Rede Social de Consumo Baseada em uma Arquitetura de Data Warehouse', 3, 9);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (129, 'Modelo de Banco de Dados Colunar: Características, Aplicações e Exemplos de Sistemas', 3, 9);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (130, 'Um Método para Indexação de Formulários Web visando Consultas por Similaridade', 3, 9);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (128, 'Métodos Estatísticos para Segmentação de Listas Web', 3, 9);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (131, 'Um Módulo de Fusão de Dados para Mashups', 3, 9);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (137, 'Uma implementação de feedback da relevância utilizando o algoritmo Rocchio', 4, 9);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (150, 'Um Estudo sobre Bancos de Dados em Grafos Nativos', 3, 10);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (153, 'Uma Metodologia Agile ROLAP para Implantação de Ambientes de Inteligência de Negócios', 3, 10);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (140, 'Abordagem de suporte a transação através de consulta HiveQL', 3, 10);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (146, 'Conectando Dados de Movimento Textualmente Anotados a Dados Ligados', 3, 10);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (141, 'Análise de Abordagens para Recuperação de Informação em Tabelas na Web', 3, 10);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (149, 'Um Estudo das Abordagens para Extração de Esquemas XML', 3, 10);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (143, 'Anotação de Trajetórias via Fusão com Trilhas de Mídias Sociais', 3, 10);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (142, 'Análise de Inconsistências Espaçotemporais entre Trajetórias e Tarefas Planejadas ou Relatadas', 3, 10);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (147, 'LinkMapia: Uma Abordagem para Converter Dados Geográficos Livremente Anotados em Dados Ligados', 3, 10);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (233, 'Base de dados de gestão de ordens de serviço: extração de regras interessantes para apoio à decisão', 4, 6);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (234, 'Um Modelo de Dados Temporal para Sistemas de Recomendação de Calagem e Adubação de Solos', 4, 6);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (236, 'TerraER: Uma Ferramenta voltada ao Ensino do Modelo de Entidade-Relacionamento', 4, 6);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (237, 'EdMaSe - Editor de Marcação semântica de dados na Web baseado em ontologias', 4, 6);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (238, 'KDD Cleaning – Ferramenta para pré-processamento de dados em Descoberta de Conhecimento em Bases de Dados', 4, 6);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (239, 'Processo de Descoberta de conhecimento em Base de Dados aplicado a Bolsa de Valores', 4, 6);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (240, 'Uma Aplicação de Banco de Dados Espacial para Filtragem de Dados para Agricultura de Precisão', 4, 6);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (241, 'Uma ferramenta para gerar bancos de dados geográficos a partir de diagramas OMT-G', 4, 6);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (242, 'StereoMap: Um Mashup para Busca de Eventos Musicais', 4, 6);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (243, 'Uma Experiência de Sincronização de Bases de Dados Relacionais Utilizando SyncML', 4, 6);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (36, 'Geração automática de esquemas relacionais a partir de esquemas XML', 1, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (38, 'Acesso a Banco de Dados através de Celulares', 1, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (39, 'Um ambiente de armazenamento e consulta de documentos baseado em GED e tesauros', 1, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (40, 'Análise quantitativa e temporal do Wikigrafo-PT', 1, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (41, 'Ferramenta para Visualização de Informações Temporais para Bancos de Dados Mestre/Detalhe', 1, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (43, 'Analysis: uma proposta de ferramenta OLAP-Web para a análise de informações ambientais do Vale do Rio do Sinos', 1, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (46, 'Um Sistema de Extração e Publicação de Informações Georreferenciadas em um Domínio Turístico', 1, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (47, 'INTRABUSCA - Um Mecanismo de Recuperação de Informações Corporativo', 1, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (48, 'Técnica para Analisar a Evolução do Perfil do Usuário com Base nas Suas Publicações', 1, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (49, 'Uma análise comparativa de algoritmos de regras de associação: minerando dados da indústria automotiva', 1, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (50, 'Mineração de uso em sistema de informação', 1, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (54, 'Um Framework para Suporte à Preparação e Comparação de Similaridade de Documentos XML', 1, 3);
INSERT INTO public.artigos (artigoid, titulo, tipoid, edicaoid) VALUES (55, 'Uma Ferramenta de Apoio à Determinação de Equivalências Semânticas entre Esquemas GML', 1, 3);


--
-- TOC entry 2858 (class 0 OID 107426)
-- Dependencies: 204
-- Data for Name: autores; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.autores (autorid, nome, genero) VALUES (120, 'Alisson Rosa', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (417, 'Danilo S. da Cunha', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (418, 'Miriam L. Domingues', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (124, 'Márcio Roberto de Mello', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (125, 'Glauber da Silva', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (126, 'Fernando Simon', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (127, 'Aldri Santos', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (419, 'Cristina Paludo Santos', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (130, 'Jolvani Morgan', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (132, 'Alessandro Pinto Carneiro', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (134, 'André Luis Castro de Freitas', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (135, 'Robinson F. de Camargo', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (136, 'Tácio Castanhede', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (137, 'Roberto Felipe Caliendo', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (138, 'Daniel Notari', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (140, 'Fábio Pasquali', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (420, 'Henrique S. C. Rocha', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (142, 'Regis Schuch', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (143, 'Paulo Sérgio Sausen', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (144, 'Mauricio de Campos', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (145, 'Frantchesco Cecchin', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (146, 'Rodrigo C. Barros', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (147, 'Luciano C. Blomberg', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (148, 'José A. P. Figueiredo', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (150, 'Renato Deggau', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (112, 'Lucas Silveira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (113, 'Miguel Soares', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (114, 'Michel Avila', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (115, 'Cláudio Lima', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (116, 'Fabiano Gama Paes', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (117, 'Fernando Maneghetti', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (118, 'Edimar Manica', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (133, 'Juliano Lucas Moreira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (227, 'Paulo Fernandes', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (421, 'Ricardo Terra', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (422, 'Débora C. Nazário', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (423, 'Tiago Brandes', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (424, 'Juliano Augusto Carreira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (425, 'Tiago Luis de Andrade', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (426, 'Carlos Roberto Valêncio', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (427, 'Rogério Giacomini de Almeida', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (428, 'Edson Murakami', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (429, 'Fabiana S. Santana', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (430, 'Antonio M. Saraiva', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (229, 'Giancarlo Lucca', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (431, 'Bruno U. Grisi', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (230, 'Igor A. Pereira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (432, 'Marcos Nogueira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (433, 'Albert M. Kuniyoshi', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (434, 'Klaus W. Schaly,', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (231, 'Thiago C. Krug', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (232, 'Juliano Gomes da Silveira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (435, 'Josiane M. D. Duszczak', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (436, 'Lucas B. Zambon', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (437, 'Leandro Ferreira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (438, 'Issam Ibrahim', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (439, 'Alison L. B. Alonso', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (440, 'Cristiano Oliveira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (441, 'Leonardo Fedalto', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (442, 'Fulvio Vilas Boas', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (443, 'Tiago L. G. de Assis', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (40, 'Cassio Prazeres', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (275, 'Marcos Roberto Pimenta dos Santos', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (277, 'Jones Fernando Giacon', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (278, 'Ronaldo Canofre M. dos Santos', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (279, 'William Pereira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (280, 'Tiago Heinrich', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (281, 'Vinicius F. Garcia', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (284, 'Vilmar Schmelzer', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (285, 'Fernando José Braz', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (286, 'Eduardo da Silva', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (287, 'Rafael F. Machado', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (288, 'Rafael F. Pinheiro', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (292, 'Alex M. G. de Almeida', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (293, 'Sylvio Barbon Jr.', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (294, 'Rodrigo A. Igawa', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (299, 'Carlos H. Arima', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (300, 'Gláucio R. Vivian', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (301, 'Luis Fernando Milano Oliveira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (302, 'Matheus Peviani Vellone', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (304, 'Luiz Gomes Jr.', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (306, 'Rudimar Imhof', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (307, 'Diogo Luis Von Grafen Ruberto', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (308, 'Rodrigo Luiz Antoniazzi', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (309, 'Luan Félix Pimentel', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (310, 'Igor Lemos Vicente', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (311, 'Guilherme Dal Bianco', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (312, 'Joedeson Fontana Junior', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (313, 'Carlos Vinicius F. Gracioli', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (314, 'Vitor Hugo Bezerra', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (315, 'Dinei A. Rockenbach', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (317, 'Dalvan Griebler', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (318, 'Samuel Souza', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (319, 'Lenon Ricardo Machado de Souza', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (322, 'Odacir Deonisio Graciolli', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (323, 'Roberto Canuto Spiandorello', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (324, 'Guilherme Vanzin Hoffmann', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (325, 'Miguel Ângelo Pontalti Giordani', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (326, 'Jorge Alberto F. Flores Jr.', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (327, 'Leonardo C. Steffenello', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (329, 'Carlos Henrique Candido', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (330, 'Jader Osvino Fiegenbaum', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (331, 'Evandro Franzen', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (332, 'Elvis Kesley de Assis', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (334, 'Demóstenes Z. Rodríguez', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (338, 'Saimor Raduan Aráujo Souza', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (339, 'Luis Filipe de Castro Sampaio', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (340, 'Lucas Felipe Alves de Aráujo', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (345, 'Felipe Lanzarin', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (346, 'Eder Pazinatto', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (347, 'José Maurício Carré Maciel', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (348, 'Ângelo N. V. Crestani', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (349, 'Gian L. M. Flores', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (350, 'Mateus H. Dal Forno', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (351, 'Giovane N. M. Costa', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (355, 'Marcos V. de Moura Lima', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (356, 'Paulo R. Rodegheri', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (357, 'Jean Luca Bez', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (358, 'Neilor A. Tonin', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (359, 'Matheus Oliveira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (361, 'Horacio Legal-Ayala', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (363, 'Émerson Homrich', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (365, 'André Luciano Rakowski', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (366, 'Natan Luiz Paetzhold Berwaldt', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (368, 'Cristiano da Cunha Ribas', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (369, 'Thales Vaz Maciel', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (370, 'Vinícius Lampert', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (371, 'Denizar Souza', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (372, 'Rodrigo Silva', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (373, 'Jorge Sandoval Simão', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (383, 'Rian Brüggemann', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (384, 'André Aráujo', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (385, 'Carlos Andrew Bezerra', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (386, 'Danilo Carlo', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (387, 'Darlan Andrade', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (388, 'Rafael Liberato', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (389, 'André Schwerz', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (390, 'Ronan Knob', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (391, 'Bruno Agostinho', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (393, 'Alex Sandro Roschildt Pinto', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (394, 'Jonathan Suter', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (395, 'Rodrigo Nogueira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (397, 'Daniel Anderle', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (398, 'Rafael Speroni', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (399, 'Michel Costa', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (400, 'Cleiton Lima', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (401, 'Bruni R. L. Machado', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (402, 'João Fernandes', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (403, 'Aurélio Hoppe', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (404, 'Christian Krambeck', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (406, 'Julio Cesar Refosco', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (407, 'Ralf Marcos Ehmke', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (408, 'Fernando Moro', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (409, 'Alexandre Amaral', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (411, 'Roger Monteiro', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (413, 'Pedro Auceli', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (415, 'Adriano Silva', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (1, 'César Feijó Nadvorny', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (5, 'Alvaristo Padilha', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (9, 'Rafael Garcia', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (10, 'Duncan Ruiz', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (11, 'Marcel Felipe Weschenfelder', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (14, 'Deivith Maia Soares', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (15, 'Giuliano Alves Massaro', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (16, 'Miguel Rodrigues Fornari', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (17, 'Eduardo Johann', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (18, 'Eduardo Kroth', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (19, 'Sérgio Mergen', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (21, 'Luiz Carlos Ribeiro Junior', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (22, 'Thyago Borges', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (23, 'Daniel Lichtnow', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (24, 'Stanley Loh', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (25, 'Ramiro Saldaña', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (26, 'Everton Sparenberger Dias', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (27, 'Felipe Victolla Silveira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (28, 'Eugênio de Oliveira Simonetto', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (29, 'Eduardo Studzinski Estima de Castro', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (32, 'Luiz Fernando De Ros', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (33, 'André Dias Bastos', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (34, 'Guillermo Hess', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (35, 'Cirano Iochpe', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (36, 'José Guilherme C. de Souza', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (37, 'Eduardo Battistella', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (39, 'José Carlos M. Mombach', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (41, 'Luiz Carlos de Freitas Santos Júnior', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (42, 'Rodrigo Giacomini Moro', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (44, 'Rilson Nascimento', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (46, 'Mauro Leal', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (48, 'Jeferson Kasper', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (49, 'Rodrigo Gonçalves', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (53, 'Cristian Tristão', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (54, 'Angelo Frozza', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (55, 'Leandro Castoldi López', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (56, 'Sérgio Dill', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (57, 'Edson Padoin', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (58, 'Leonardo G. Garcia', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (61, 'Gustavo R. Forgiarini', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (62, 'Fabrício Santos da Silva', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (63, 'Rodrigo Luis Suder', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (65, 'Stevan Viapiana', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (66, 'Alexander Vinson', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (67, 'Marcos Nunes', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (69, 'Diego Kreutz', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (70, 'Daniel Rosa Soares', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (71, 'Cezar Molinar', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (72, 'Marcelo Zambiasi', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (73, 'Thiago A. Presa', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (76, 'Edécio Iepsen', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (77, 'Paulo Luzzardi', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (78, 'Mário Martins', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (79, 'Juliano Carvalho', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (82, 'Anselmo Maciel Nunes', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (83, 'Renato Fileto', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (84, 'Rafael Vasel', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (85, 'Antonio Alves', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (86, 'Jacques Schreiber', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (87, 'Sílvio Cazella', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (88, 'Paulo Gillmeister', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (89, 'Sandro Rigo', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (90, 'Marco Schwertner', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (92, 'Khaue Rodrigues', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (93, 'Fabio dos Santos', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (94, 'Carlos Souza Junior', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (95, 'Leonardo da Rosa', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (96, 'Ricardo Fagundes', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (97, 'Marcelo Sardagna', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (98, 'Adilson Valhdick', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (99, 'Marcelo Moraes', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (100, 'Carlos A. S. Rocha', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (101, 'Helton Alixandre Raiciki', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (102, 'Muriel F. Bernhardt Rocha', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (103, 'Rafael Boaventura Luiz', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (104, 'Ricardo Gross', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (105, 'André Oliveira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (106, 'Cristiano Cervi', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (107, 'Douglas Dyllon J. de Macedo', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (108, 'Hilton Parantunes', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (109, 'Luiz Maia', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (111, 'Mário Dantas', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (4, 'Raquel Kolitski Stasiu', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (7, 'Taisa C. Novello', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (12, 'Daniela Leal Musa', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (20, 'Mariusa Warpechowski', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (30, 'Laura Silvera Mastella', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (31, 'Mara Abel', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (51, 'Lisiane M. Pedroni', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (52, 'Helena Ribeiro', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (74, 'Luciana Salete Buriol', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (81, 'Patrícia Silveira', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (91, 'Fernanda Figueira', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (121, 'Maria Estela Vieira da Silva', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (123, 'Deise Saccol', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (131, 'Tânia Maria Sausen', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (139, 'Cleusa Maria Andrade Scrofernecker', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (149, 'Raquel Cruz', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (155, 'Manuele Ferreira', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (157, 'Carina Guimarãoes', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (163, 'Raqueline Penteado', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (167, 'Marta Bez', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (168, 'Poline Lottin', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (171, 'Larissa Lautert', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (174, 'Fabiola Jaeger', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (175, 'Rejane Basso', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (177, 'Carla Berkenbrock', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (181, 'Miriam Colpo', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (190, 'Elisa Mannes', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (201, 'Karine B. de Oliveira', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (203, 'Renata de J. Silva', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (208, 'Karina S. Machado', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (221, 'Karin S. Komati', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (226, 'Maria Pivel', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (228, 'Caroline Tomasini', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (234, 'Daiane Hemerich', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (246, 'Jaqueline Nande', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (249, 'Maria Luiza G. Silva', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (260, 'Adriana Zanella Martinhago', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (263, 'Jeane Paz', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (264, 'Viviani Lopes Bastos', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (265, 'Scheila de Avila e Silva', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (267, 'Juçara Salete Gubiani', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (271, 'Ana Magela Rodriguez Almeida', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (282, 'Vanessa Barbosa Rolim', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (283, 'Marilia Ribeiro da Silva', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (289, 'Eliza A. Nunes', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (166, 'Suian Menegas', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (152, 'Bruno Visioli', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (153, 'Leandro Pompermaier', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (154, 'Rubens Guimarães', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (156, 'Robson Silva', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (158, 'Alex Sandro Romeo de Souza Poletto', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (159, 'Jorge Rady de Almeida Júnior', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (160, 'Jardel Gugel', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (161, 'Eduardo Vaz Bozzi', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (162, 'Henrique Santos', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (164, 'Luiz Carlos Albini', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (165, 'Euler Oliveira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (169, 'Darlan Florêncio de Arruda', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (170, 'José Júnior', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (172, 'Marcelo Telles', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (173, 'Douglas Machado', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (176, 'Marcelo Ferreira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (178, 'Jansser Costa', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (179, 'Renato Novais', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (180, 'Fabio Lopes', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (182, 'Adriano Petry', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (183, 'Fabrício Viero de Araújo', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (184, 'Márcio Ceconi', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (185, 'Bruno S. Velasco', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (187, 'Douglas Negrini', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (188, 'Daniel S. de Oliveira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (189, 'Filipe Roberto Silva', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (191, 'Fernando Gielow', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (192, 'Paulo Ferreira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (193, 'Vinicius P. Lima', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (194, 'José Mauricio Fernandes', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (195, 'Willington Pavan', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (196, 'Josué Toebe', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (197, 'Matheus K. Zanella', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (198, 'Lucas R. de Farias', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (199, 'André Prisco', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (200, 'Tiago F. Otero', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (202, 'Renan Bet Rodrigues', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (204, 'Luis Otávio Alvares', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (205, 'Sander P. Pivetta', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (206, 'Diego Magno da Silva', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (207, 'Samuel S. Troina', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (209, 'Henrico B. Brum', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (210, 'Lucas J. K. Alves', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (211, 'Luiz Gustavo Moro Senko', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (212, 'William Marx', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (213, 'Bruno Eduardo Soares', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (214, 'Clodis Boscarioli', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (215, 'Willian Ventura Koerich', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (216, 'Oliver Moraes Batista', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (217, 'William Komura', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (218, 'Hugo Bulegon', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (219, 'Willian Eduardo de Moura Casante', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (220, 'Wdnei R. Paixão', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (222, 'Holisson S. da Cunha', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (223, 'André S. Rosa', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (224, 'Carlos Eduardo Pantoja', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (225, 'Joaquim Assunção', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (38, 'Ney Lemke', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (151, 'Luzia A. Mendes', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (233, 'Tobias Stifft', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (235, 'Felipe Pinto da Silva', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (236, 'Ricardo Gil Belther Nabo', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (237, 'Cleto May', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (238, 'Lucas André de Alencar', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (239, 'Gustavo Costa Meireles', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (240, 'Cristiano Politowski', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (241, 'Vinícius Maran', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (242, 'Juarez A. P. Sacenti', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (243, 'Álvaro Osvaldo Teixeira Martínez', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (244, 'Geomar Schreiner', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (245, 'Diego Hoss', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (247, 'Ricardo M. Maeda', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (248, 'Walmir O. Couto', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (352, 'Keiko Fonseca', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (250, 'Edvaldo C. Mantovanelli', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (251, 'Jefferson O. Andrade', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (252, 'João Victor Guinelli', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (253, 'Elielson B. de Souza', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (254, 'André L. Andrade Menolli', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (255, 'Ricardo G. Coelho', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (256, 'Augusto B. Corrêa', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (257, 'Tiago Stapenhorst Martins', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (259, 'Rodrigo Moreira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (261, 'Luis César Dias Drummond', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (262, 'Daniel Orlandi Mincato', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (266, 'Igor Eduardo Viana Rudel', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (268, 'Jacson L. Matte', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (269, 'Flávio R. Bayer', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (270, 'Lucas L. Nesi', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (272, 'Sandro da Silva Camargo', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (273, 'Ismael Martiny', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (274, 'Kaio Alexandre da Silva', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (276, 'Michel da Silva', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (374, 'Raimundo Teive', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (375, 'Lucas Lima de Oliveira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (376, 'Daniel Kuhn', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (378, 'Yussef Parcianello', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (379, 'Erick Lopes', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (380, 'Vinícios Tomazetti', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (381, 'Diovane Soligo', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (382, 'Alencar Machado', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (141, 'Denio Duarte', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (3, 'Juliana Bonato dos Santos', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (290, 'Roberto Walter', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (59, 'Rodrigo Machado', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (60, 'Álvaro Freitas Moreira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (47, 'Nina Edelweiss', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (122, 'Eduardo Borges', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (129, 'Alexandre Lazzaretti', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (68, 'Gustavo Kantorski', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (110, 'Aldo Wangenheim', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (258, 'Nádia Kozievitch', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (186, 'Augusto Ferreira de Souza', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (303, 'Daniel S. Kaster', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (305, 'André Santanchè', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (13, 'José Palazzo Moreira de Oliveira', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (80, 'Leandro Wives', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (64, 'Rebeca Schroeder', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (75, 'Viviane Moreira Orengo', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (119, 'Renata Galante', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (43, 'Carlos Eduardo Pires', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (6, 'Carina Dorneles', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (2, 'Carlos Heuser', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (50, 'Ronaldo Mello', 'm');
INSERT INTO public.autores (autorid, nome, genero) VALUES (8, 'Karin Becker', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (45, 'Ana Carolina Salgado', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (128, 'Carmem Hara', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (291, 'Fhabiana Thieli dos Santos Machado', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (295, 'Stella Naomi Moriguchi', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (296, 'Tânia M. Cernach', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (297, 'Edit Grassiani', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (298, 'Renata M. de Oliveira', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (316, 'Nadine Anderle', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (320, 'Marta Breunig Loose', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (321, 'Vania Elisabete Schneider', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (328, 'Ana T. Winck', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (333, 'Renata L. Rosa', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (335, 'Rosangela de Fátima Pereira', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (336, 'Tereza Cristina Melo de Brito Carvalho', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (337, 'Graça Bressan', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (341, 'Elis C. Nakonetchnei', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (342, 'Cinzia Cappiello', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (343, 'Monica Vitali', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (344, 'Monika Akbar', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (353, 'Tatiana Gadda', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (354, 'Rita Berardi', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (360, 'Silvia Amelia Bim', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (362, 'Renata Carvalho', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (367, 'Mayara Lorenzi', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (377, 'Gabriely Simette', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (392, 'Fernanda Gomes', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (396, 'Tatiana Tozzi', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (405, 'Rosemeri Laurindo', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (410, 'Ana Amaral', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (412, 'Greisse Moser', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (414, 'Vania Elisabete Scheneider', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (416, 'Mayara Cechinatto', 'f');
INSERT INTO public.autores (autorid, nome, genero) VALUES (364, 'Mariana Machado Garcez Duarte', 'f');


--
-- TOC entry 2860 (class 0 OID 107431)
-- Dependencies: 206
-- Data for Name: autoresartigo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (635, 417, 233);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (636, 418, 233);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (637, 419, 234);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (638, 201, 234);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (639, 420, 236);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (640, 421, 236);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (641, 422, 237);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (642, 423, 237);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (643, 424, 238);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (644, 425, 238);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (645, 426, 238);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (646, 422, 239);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (647, 427, 239);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (648, 428, 240);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (649, 429, 240);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (650, 430, 240);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (651, 431, 240);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (652, 432, 240);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (653, 433, 240);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (654, 434, 241);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (655, 54, 241);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (656, 435, 242);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (657, 436, 242);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (658, 216, 242);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (659, 437, 242);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (660, 438, 242);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (661, 128, 242);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (662, 439, 243);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (663, 440, 243);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (664, 441, 243);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (665, 442, 243);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (666, 443, 243);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (667, 128, 243);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (81, 50, 35);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (82, 65, 36);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (83, 6, 36);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (84, 66, 37);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (85, 67, 37);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (86, 2, 37);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (88, 69, 38);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (89, 70, 38);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (90, 71, 39);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (91, 18, 39);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (92, 72, 40);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (93, 73, 40);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (94, 74, 40);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (95, 75, 40);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (96, 76, 41);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (97, 77, 41);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (98, 24, 41);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (99, 9, 42);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (100, 10, 42);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (101, 78, 43);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (102, 79, 43);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (103, 80, 43);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (104, 81, 44);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (105, 10, 44);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (106, 82, 45);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (107, 83, 45);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (108, 84, 46);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (109, 50, 46);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (110, 85, 47);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (111, 86, 47);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (112, 67, 48);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (113, 24, 48);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (114, 87, 49);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (115, 88, 49);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (116, 89, 50);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (117, 90, 50);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (118, 13, 50);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (119, 91, 51);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (120, 8, 51);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (121, 10, 51);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (122, 92, 52);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (123, 50, 52);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (124, 19, 53);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (125, 2, 53);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (126, 93, 54);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (127, 94, 54);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (128, 49, 54);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (129, 50, 54);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (130, 95, 55);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (131, 54, 55);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (132, 50, 55);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (133, 96, 56);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (134, 18, 56);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (135, 97, 57);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (136, 98, 57);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (137, 99, 58);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (138, 83, 58);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (139, 100, 59);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (140, 101, 59);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (141, 102, 59);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (142, 103, 59);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (143, 104, 60);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (144, 83, 60);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (145, 105, 61);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (146, 106, 61);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (147, 107, 62);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (148, 108, 62);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (149, 109, 62);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (150, 110, 62);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (151, 111, 62);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (152, 112, 63);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (153, 50, 63);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (154, 113, 64);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (155, 83, 64);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (156, 114, 65);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (157, 50, 65);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (158, 115, 66);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (159, 64, 66);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (160, 50, 66);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (162, 116, 67);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (163, 117, 67);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (164, 106, 68);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (165, 118, 68);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (166, 119, 68);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (167, 120, 69);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (168, 50, 69);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (169, 121, 70);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (170, 119, 70);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (171, 122, 70);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (172, 123, 71);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (173, 47, 71);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (174, 119, 71);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (175, 124, 71);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (176, 125, 72);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (177, 119, 72);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (178, 123, 72);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (179, 126, 73);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (180, 127, 73);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (181, 128, 73);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (183, 130, 75);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (184, 131, 75);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (185, 132, 76);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (186, 133, 76);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (187, 134, 76);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (188, 135, 77);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (189, 136, 77);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (190, 56, 77);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (191, 57, 77);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (192, 137, 78);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (193, 138, 78);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (194, 139, 79);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (195, 10, 79);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (196, 140, 80);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (197, 141, 80);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (198, 56, 81);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (182, 129, 74);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (286, 129, 114);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (87, 68, 38);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (161, 68, 67);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (544, 364, 205);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (80, 64, 35);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (668, 128, 150);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (199, 142, 81);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (200, 143, 81);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (201, 57, 81);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (202, 144, 81);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (203, 145, 82);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (204, 128, 82);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (205, 118, 83);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (206, 106, 83);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (207, 6, 83);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (208, 119, 83);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (209, 146, 84);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (210, 147, 84);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (211, 148, 84);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (212, 10, 84);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (213, 149, 85);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (214, 6, 85);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (215, 119, 85);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (216, 150, 86);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (217, 83, 86);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (218, 118, 87);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (219, 119, 87);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (220, 6, 87);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (221, 151, 88);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (222, 146, 88);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (223, 152, 88);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (224, 153, 88);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (225, 154, 89);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (226, 68, 89);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (227, 155, 90);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (228, 156, 90);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (229, 157, 90);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (230, 158, 91);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (231, 159, 91);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (232, 118, 92);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (233, 6, 92);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (234, 119, 92);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (235, 160, 93);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (236, 106, 93);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (237, 119, 93);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (238, 13, 93);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (239, 50, 94);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (240, 161, 94);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (241, 162, 95);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (242, 163, 95);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (243, 128, 95);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (244, 164, 95);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (245, 165, 96);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (246, 166, 97);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (247, 167, 97);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (248, 34, 97);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (249, 168, 98);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (250, 6, 98);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (251, 169, 99);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (252, 170, 99);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (253, 171, 100);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (254, 123, 100);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (255, 172, 101);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (256, 119, 101);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (257, 6, 101);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (258, 50, 102);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (259, 173, 102);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (260, 174, 102);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (261, 175, 103);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (262, 176, 104);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (263, 177, 104);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (264, 178, 105);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (265, 179, 105);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (266, 180, 106);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (267, 181, 107);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (268, 182, 107);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (269, 183, 107);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (270, 184, 107);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (271, 185, 108);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (272, 128, 108);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (274, 50, 109);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (275, 187, 110);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (276, 123, 110);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (277, 188, 111);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (278, 6, 111);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (279, 189, 112);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (280, 50, 112);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (281, 190, 113);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (282, 191, 113);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (283, 192, 113);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (284, 127, 113);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (285, 128, 113);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (287, 193, 114);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (288, 194, 114);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (289, 195, 114);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (290, 196, 114);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (291, 171, 115);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (292, 6, 115);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (293, 197, 116);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (294, 123, 116);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (295, 198, 117);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (296, 199, 117);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (297, 122, 117);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (298, 200, 118);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (299, 198, 118);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (300, 199, 118);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (301, 122, 118);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (302, 201, 119);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (303, 6, 119);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (304, 141, 120);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (305, 202, 120);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (306, 203, 121);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (307, 204, 121);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (308, 205, 122);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (309, 19, 122);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (310, 206, 123);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (311, 50, 123);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (312, 207, 124);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (313, 208, 124);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (314, 209, 125);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (315, 19, 125);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (316, 210, 126);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (317, 8, 126);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (318, 211, 127);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (319, 212, 128);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (320, 19, 128);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (321, 213, 129);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (322, 214, 129);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (323, 215, 130);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (324, 50, 130);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (325, 216, 131);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (326, 217, 131);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (327, 218, 131);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (328, 128, 131);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (329, 219, 132);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (330, 220, 133);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (331, 221, 133);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (332, 222, 134);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (333, 19, 134);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (334, 223, 135);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (335, 224, 135);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (336, 225, 136);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (337, 226, 136);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (338, 227, 136);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (339, 10, 136);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (340, 228, 137);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (341, 199, 137);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (342, 122, 137);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (343, 229, 138);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (344, 230, 138);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (345, 199, 138);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (346, 122, 138);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (347, 231, 139);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (348, 19, 139);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (349, 232, 140);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (350, 233, 140);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (351, 234, 140);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (352, 10, 140);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (353, 189, 141);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (354, 50, 141);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (355, 235, 142);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (356, 83, 142);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (357, 236, 143);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (358, 83, 143);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (359, 237, 143);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (360, 238, 143);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (361, 239, 144);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (362, 54, 144);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (363, 240, 145);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (364, 241, 145);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (365, 237, 146);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (366, 83, 146);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (367, 242, 147);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (368, 83, 147);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (369, 243, 148);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (370, 54, 148);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (371, 244, 149);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (372, 141, 149);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (373, 163, 150);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (374, 64, 150);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (375, 245, 150);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (376, 246, 150);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (377, 247, 150);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (378, 248, 150);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (379, 249, 151);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (380, 250, 151);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (381, 251, 151);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (382, 221, 151);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (383, 252, 152);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (273, 186, 109);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (384, 223, 152);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (385, 224, 152);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (386, 253, 153);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (387, 254, 153);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (388, 255, 153);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (389, 256, 154);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (390, 118, 154);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (391, 119, 154);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (392, 6, 154);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (393, 257, 155);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (394, 258, 155);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (395, 115, 156);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (396, 50, 156);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (397, 259, 157);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (398, 260, 157);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (399, 261, 157);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (400, 262, 158);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (401, 138, 158);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (402, 244, 159);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (403, 141, 159);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (404, 50, 159);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (405, 252, 160);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (406, 224, 160);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (407, 252, 161);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (408, 223, 161);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (409, 224, 161);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (410, 263, 162);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (411, 264, 162);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (412, 138, 162);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (413, 265, 162);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (414, 266, 163);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (415, 267, 163);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (416, 23, 163);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (417, 268, 164);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (418, 141, 164);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (419, 269, 165);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (420, 270, 165);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (421, 64, 165);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (422, 271, 166);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (423, 272, 166);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (424, 273, 167);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (425, 52, 167);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (426, 274, 168);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (427, 275, 168);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (428, 276, 168);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (429, 277, 168);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (430, 22, 168);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (431, 278, 169);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (432, 122, 169);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (433, 208, 169);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (434, 279, 170);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (435, 280, 170);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (436, 64, 170);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (437, 281, 171);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (438, 19, 171);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (439, 282, 172);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (440, 283, 172);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (441, 284, 172);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (442, 285, 172);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (443, 286, 172);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (444, 287, 173);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (445, 288, 173);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (446, 289, 173);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (447, 122, 173);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (449, 141, 174);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (450, 291, 175);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (451, 123, 175);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (452, 292, 176);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (453, 293, 176);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (454, 294, 176);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (455, 295, 176);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (456, 296, 177);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (457, 297, 177);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (458, 298, 177);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (459, 299, 177);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (460, 300, 178);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (461, 106, 178);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (462, 301, 179);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (463, 302, 179);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (464, 303, 179);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (465, 304, 180);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (466, 258, 180);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (467, 305, 180);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (468, 300, 181);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (469, 106, 181);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (470, 306, 182);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (471, 54, 182);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (472, 50, 182);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (473, 307, 183);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (474, 308, 183);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (475, 309, 184);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (476, 310, 184);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (504, 332, 194);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (505, 333, 194);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (506, 334, 194);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (507, 335, 194);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (508, 336, 194);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (509, 337, 194);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (510, 338, 195);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (511, 339, 195);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (512, 340, 195);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (513, 274, 195);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (514, 341, 196);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (515, 258, 196);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (516, 342, 196);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (517, 343, 196);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (518, 344, 196);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (519, 345, 197);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (520, 346, 197);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (521, 347, 197);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (522, 348, 198);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (523, 349, 198);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (524, 350, 198);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (525, 351, 199);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (526, 258, 199);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (527, 352, 199);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (528, 353, 199);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (529, 354, 199);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (530, 355, 200);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (531, 356, 200);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (532, 357, 200);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (533, 358, 200);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (534, 300, 201);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (535, 106, 201);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (536, 359, 202);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (537, 258, 202);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (538, 360, 202);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (539, 361, 202);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (540, 258, 203);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (541, 362, 203);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (542, 363, 204);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (543, 19, 204);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (545, 128, 205);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (546, 365, 206);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (547, 366, 206);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (548, 19, 206);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (549, 367, 207);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (550, 368, 207);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (551, 304, 207);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (552, 369, 208);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (553, 370, 208);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (554, 371, 208);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (555, 372, 208);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (556, 373, 209);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (557, 374, 209);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (558, 372, 210);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (559, 369, 210);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (560, 370, 210);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (561, 371, 210);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (562, 375, 211);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (563, 19, 211);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (564, 376, 212);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (565, 106, 212);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (566, 118, 212);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (567, 377, 213);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (568, 378, 213);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (569, 258, 213);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (570, 352, 213);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (571, 379, 214);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (572, 122, 214);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (573, 380, 215);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (574, 381, 215);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (575, 382, 215);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (576, 23, 215);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (577, 54, 216);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (578, 244, 216);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (579, 383, 216);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (580, 50, 216);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (581, 300, 217);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (582, 106, 217);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (583, 384, 218);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (584, 385, 218);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (585, 386, 219);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (586, 387, 219);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (587, 388, 219);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (588, 389, 219);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (589, 390, 220);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (590, 244, 220);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (591, 54, 220);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (592, 50, 220);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (593, 391, 221);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (594, 244, 221);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (595, 392, 221);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (448, 290, 174);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (1, 1, 1);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (2, 2, 1);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (4, 4, 2);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (5, 2, 2);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (6, 5, 3);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (7, 6, 3);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (8, 2, 3);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (9, 7, 4);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (10, 8, 4);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (11, 9, 5);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (12, 10, 5);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (13, 11, 6);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (14, 12, 6);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (15, 13, 6);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (16, 14, 7);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (17, 15, 8);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (18, 16, 8);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (19, 17, 9);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (20, 18, 9);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (21, 19, 10);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (22, 2, 10);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (23, 20, 11);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (24, 13, 11);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (25, 21, 12);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (26, 22, 12);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (27, 23, 12);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (28, 24, 12);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (29, 25, 12);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (30, 26, 13);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (31, 27, 14);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (32, 2, 14);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (33, 28, 15);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (34, 10, 15);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (35, 29, 16);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (36, 30, 16);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (37, 31, 16);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (38, 32, 16);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (39, 33, 17);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (40, 34, 17);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (41, 35, 17);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (42, 36, 18);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (43, 37, 18);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (44, 38, 18);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (45, 39, 18);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (46, 40, 19);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (47, 41, 20);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (48, 42, 20);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (49, 2, 20);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (51, 44, 21);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (52, 45, 21);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (53, 46, 22);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (54, 47, 22);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (55, 48, 23);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (56, 28, 23);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (57, 49, 24);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (58, 50, 24);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (59, 51, 25);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (60, 52, 25);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (61, 19, 26);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (62, 2, 26);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (63, 53, 27);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (64, 8, 27);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (65, 54, 28);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (66, 50, 28);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (67, 55, 29);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (68, 56, 29);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (69, 57, 29);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (70, 58, 30);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (71, 50, 30);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (73, 60, 31);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (74, 61, 32);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (75, 10, 32);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (76, 62, 33);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (77, 50, 33);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (78, 63, 34);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (79, 6, 34);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (50, 43, 21);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (3, 3, 2);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (72, 59, 31);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (477, 311, 184);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (478, 312, 185);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (479, 313, 185);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (480, 23, 185);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (481, 314, 186);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (482, 303, 186);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (483, 315, 187);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (484, 316, 187);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (485, 317, 187);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (486, 318, 187);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (487, 300, 188);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (488, 106, 188);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (489, 319, 189);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (490, 320, 189);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (491, 321, 190);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (492, 322, 190);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (493, 52, 190);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (494, 323, 190);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (495, 324, 190);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (496, 325, 190);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (497, 326, 191);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (498, 327, 191);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (499, 328, 191);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (500, 329, 192);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (501, 50, 192);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (502, 330, 193);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (503, 331, 193);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (596, 393, 221);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (597, 111, 221);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (598, 394, 222);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (599, 395, 222);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (600, 396, 222);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (601, 397, 222);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (602, 398, 222);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (603, 399, 223);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (604, 141, 223);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (605, 400, 224);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (606, 311, 224);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (607, 258, 225);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (608, 354, 225);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (609, 54, 226);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (610, 244, 226);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (611, 401, 226);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (612, 50, 226);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (613, 304, 227);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (614, 402, 228);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (615, 403, 228);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (616, 404, 228);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (617, 405, 228);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (618, 406, 228);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (619, 407, 228);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (620, 408, 229);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (621, 395, 229);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (622, 409, 229);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (623, 410, 229);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (624, 411, 230);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (625, 395, 230);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (626, 412, 230);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (627, 413, 231);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (628, 354, 231);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (629, 258, 231);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (630, 414, 232);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (631, 322, 232);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (632, 52, 232);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (633, 415, 232);
INSERT INTO public.autoresartigo (id, autorid, artigoid) VALUES (634, 416, 232);


--
-- TOC entry 2862 (class 0 OID 107436)
-- Dependencies: 208
-- Data for Name: edicoes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.edicoes (edicaoid, cidade, uf, qtdparticipantes, ano) VALUES (1, 'Porto Alegre', 'RS', 250, 2005);
INSERT INTO public.edicoes (edicaoid, cidade, uf, qtdparticipantes, ano) VALUES (2, 'Passo Fundo', 'RS', 278, 2006);
INSERT INTO public.edicoes (edicaoid, cidade, uf, qtdparticipantes, ano) VALUES (3, 'Caxias do Sul', 'RS', 350, 2007);
INSERT INTO public.edicoes (edicaoid, cidade, uf, qtdparticipantes, ano) VALUES (4, 'Florianópolis', 'SC', 350, 2008);
INSERT INTO public.edicoes (edicaoid, cidade, uf, qtdparticipantes, ano) VALUES (12, 'Londrina', 'PR', 350, 2016);
INSERT INTO public.edicoes (edicaoid, cidade, uf, qtdparticipantes, ano) VALUES (5, 'Ijuí', 'RS', 400, 2009);
INSERT INTO public.edicoes (edicaoid, cidade, uf, qtdparticipantes, ano) VALUES (9, 'Camboriú', 'SC', 400, 2013);
INSERT INTO public.edicoes (edicaoid, cidade, uf, qtdparticipantes, ano) VALUES (10, 'São Francisco do Sul', 'SC', 400, 2014);
INSERT INTO public.edicoes (edicaoid, cidade, uf, qtdparticipantes, ano) VALUES (14, 'Rio Grande', 'RS', 150, 2018);
INSERT INTO public.edicoes (edicaoid, cidade, uf, qtdparticipantes, ano) VALUES (6, 'Joinville', 'SC', 150, 2010);
INSERT INTO public.edicoes (edicaoid, cidade, uf, qtdparticipantes, ano) VALUES (7, 'Novo Hamburgo', 'RS', 250, 2011);
INSERT INTO public.edicoes (edicaoid, cidade, uf, qtdparticipantes, ano) VALUES (8, 'Curitiba', 'PR', 290, 2012);
INSERT INTO public.edicoes (edicaoid, cidade, uf, qtdparticipantes, ano) VALUES (11, 'Caxias do Sul', 'RS', 315, 2015);
INSERT INTO public.edicoes (edicaoid, cidade, uf, qtdparticipantes, ano) VALUES (13, 'Passo Fundo', 'RS', 380, 2017);
INSERT INTO public.edicoes (edicaoid, cidade, uf, qtdparticipantes, ano) VALUES (15, 'Chapecó', 'SC', 190, 2019);
INSERT INTO public.edicoes (edicaoid, cidade, uf, qtdparticipantes, ano) VALUES (16, 'Santa Maria', 'RS', NULL, 2020);


--
-- TOC entry 2864 (class 0 OID 107441)
-- Dependencies: 210
-- Data for Name: tipos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipos (tipoid, nome) VALUES (1, 'Graduação');
INSERT INTO public.tipos (tipoid, nome) VALUES (2, 'Pós-Graduação');
INSERT INTO public.tipos (tipoid, nome) VALUES (3, 'Pesquisa');
INSERT INTO public.tipos (tipoid, nome) VALUES (4, 'Aplicações/Experiências');
INSERT INTO public.tipos (tipoid, nome) VALUES (5, 'Completos');
INSERT INTO public.tipos (tipoid, nome) VALUES (6, 'Curtos');


--
-- TOC entry 2876 (class 0 OID 0)
-- Dependencies: 203
-- Name: artigos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.artigos_id_seq', 243, true);


--
-- TOC entry 2877 (class 0 OID 0)
-- Dependencies: 205
-- Name: autores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.autores_id_seq', 443, true);


--
-- TOC entry 2878 (class 0 OID 0)
-- Dependencies: 207
-- Name: autoresartigo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.autoresartigo_id_seq', 668, true);


--
-- TOC entry 2879 (class 0 OID 0)
-- Dependencies: 209
-- Name: edicoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.edicoes_id_seq', 16, true);


--
-- TOC entry 2880 (class 0 OID 0)
-- Dependencies: 211
-- Name: tipos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipos_id_seq', 6, true);


--
-- TOC entry 2717 (class 2606 OID 107452)
-- Name: artigos artigos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artigos
    ADD CONSTRAINT artigos_pkey PRIMARY KEY (artigoid);


--
-- TOC entry 2719 (class 2606 OID 107454)
-- Name: autores autores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autores
    ADD CONSTRAINT autores_pkey PRIMARY KEY (autorid);


--
-- TOC entry 2721 (class 2606 OID 107456)
-- Name: autoresartigo autoresartigo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autoresartigo
    ADD CONSTRAINT autoresartigo_pkey PRIMARY KEY (id);


--
-- TOC entry 2723 (class 2606 OID 107458)
-- Name: edicoes edicoes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edicoes
    ADD CONSTRAINT edicoes_pkey PRIMARY KEY (edicaoid);


--
-- TOC entry 2725 (class 2606 OID 107460)
-- Name: tipos tipos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos
    ADD CONSTRAINT tipos_pkey PRIMARY KEY (tipoid);


--
-- TOC entry 2726 (class 2606 OID 107461)
-- Name: artigos artigos_edicao_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artigos
    ADD CONSTRAINT artigos_edicao_id_fkey FOREIGN KEY (edicaoid) REFERENCES public.edicoes(edicaoid);


--
-- TOC entry 2727 (class 2606 OID 107466)
-- Name: artigos artigos_tipo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artigos
    ADD CONSTRAINT artigos_tipo_id_fkey FOREIGN KEY (tipoid) REFERENCES public.tipos(tipoid);


--
-- TOC entry 2728 (class 2606 OID 107471)
-- Name: autoresartigo autoresartigo_artigo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autoresartigo
    ADD CONSTRAINT autoresartigo_artigo_id_fkey FOREIGN KEY (artigoid) REFERENCES public.artigos(artigoid);


--
-- TOC entry 2729 (class 2606 OID 107476)
-- Name: autoresartigo autoresartigo_autor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autoresartigo
    ADD CONSTRAINT autoresartigo_autor_id_fkey FOREIGN KEY (autorid) REFERENCES public.autores(autorid);


-- Completed on 2020-09-02 11:30:08

--
-- PostgreSQL database dump complete
--

