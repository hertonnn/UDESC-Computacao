-- Auto-junções
-- Formule uma expressão em SQL que retorne id e título de pares de artigos diferentes mas que foram publicados em um mesmo estado (uf). Garanta que um mesmo par de artigos não seja retornado na resposta, nem mesmo em posições invertidas.
 SELECT a1.artigoid, a1.titulo, a2.artigoid, a2.titulo 
 FROM artigos a1 NATURAL JOIN edicoes e1 JOIN edicoes e2 ON e1.uf=e2.uf
 JOIN artigos a2 ON a2.edicaoid=e2.edicaoid and a1.artigoid<a2.artigoid;
 
-- Formule uma expressão em SQL que retorne id e nome de pares de autores diferentes mas que publicaram juntos um mesmo artigo.
SELECT a1.autorid, a1.nome, a2.autorid, a2.nome 
FROM autores a1 
natural join autoresartigo aa1
JOIN autoresartigo aa2 ON aa1.artigoid=aa2.artigoid
JOIN autores a2 ON a1.autorid=aa2.autorid AND a1.autorid<a2.autorid;

-- Formule uma expressão em SQL que retorne id e ano de edições diferentes mas que têm artigos de um mesmo tipo (tipoid na relação artigos). Garanta que um mesmo par de edições não seja retornado na resposta, nem mesmo em posições invertidas.
SELECT e1.edicaoid, e1.ano, e2.edicaoid, e2.ano FROM edicoes e1 NATURAL JOIN 
artigos a1 JOIN artigos a2 ON a1.tipoid=a2.tipoid 
JOIn edicoes e2 ON e1.edicaoid<e2.edicaoid;

-- Forneça uma expressão em SQL que retorne o ano e a quantidade de participantes de pares de edições diferentes que ocorreram na mesma cidade. Garante que um mesmo par não apareça na resposta, nem mesmo em posições inversas.
SELECT e1.qtdparticipantes, e1.ano, e2.qtdparticipantes, e2.ano FROM 
edicoes e1 JOIn edicoes e2 ON e1.cidade=e2.cidade AND 
e1.edicaoid<e2.edicaoid;

-- JUNÇÕES EXTERNAS
-- Formule uma expressão em SQL que retorne o id e título de todos os artigos, bem como o nome dos seus respectivos tipos. 
SELECT artigoid, titulo, nome FROM artigos NATURAL LEFT JOIN tipos;

-- Formule uma expressão em SQL que retorne o id e nome de todos os tipos, bem como o título dos seus respectivos artigos. 
SELECT tipos.tipoid, nome, titulo FROM artigos NATURAL RIGHT JOIN tipos;

-- Formule uma expressão em SQL que retorne o id e ano de todas as edições, bem como o título dos seus respectivos artigos. 
SELECT edicoes.edicaoid, ano, titulo FROM edicoes LEFT JOIN artigos
ON edicoes.edicaoid=artigos.edicaoid;

-- JUNÇÕES INTERNAS
--  Formule expressões em SQL que retornem o id, nome e gênero de autores que publicaram artigos na edição ocorrida na cidade de 'Joinville'. Forneça pelo menos duas expressões que sejam capazes de retornar estes dados.
SELECT distinct au.autorid, nome, genero FROM autores au natural join 
    autoresartigo aa 
    natural join artigos natural join edicoes 
	WHERE cidade='Joinville';
	
SELECT autorid, nome, genero FROM autores WHERE
autorid IN(Select autorid FROM autoresartigo WHERE 
		   artigoid IN(Select artigoid From artigos WHERE 
					  edicaoid IN(Select edicaoid From edicoes Where cidade='Joinville')));	

SELECT autorid, nome, genero FROM autores au WHERE
EXISTS (Select * FROM autoresartigo aa WHERE aa.autorid=au.autorid AND
   EXISTS (Select * From artigos a WHERE a.artigoid=aa.artigoid AND
	  EXISTS(Select * From edicoes e Where cidade='Joinville' and e.edicaoid=a.edicaoid)));

-- Formule expressões em SQL que retornem o id e titulo de artigos cujo tipo tem nome 'Pesquisa'. Garanta que os artigos retornados tenham pelo menos um autor com gênero='f'. 
SELECT A.ARTIGOID, 	A.TITULO FROM ARTIGOS A,TIPOS T, AUTORESARTIGO AA, AUTORES AU
WHERE A.TIPOID = T.TIPOID
	AND T.NOME = 'Pesquisa'
	AND AA.ARTIGOID=A.ARTIGOID
	AND AA.AUTORID = AU.AUTORID
	AND AU.GENERO='f';

select artigos.artigoid, titulo from (artigos join (autoresartigo join 
autores on autores.autorid = autoresartigo.autorid) 
on artigos.artigoid = autoresartigo.artigoid)
where autores.autorid in 
(select autorid from autores where genero = 'f') and 
artigos.tipoid = (select tipoid from tipos where nome = 'Pesquisa')

-- Formule expressões em SQL que retornem o id, nome e gênero de autores que publicaram artigos que tem tipo com nome igual à 'Graduação'.
select autorid, nome, genero from autores where autorid in
(select autoresartigo.autorid from artigos 
       natural join autoresartigo where tipoid =
	(select tipoid from tipos where nome = 'Graduação'))

select autorid, nome, genero from autores where autorid in
	(select autorid from autoresartigo where artigoid in
		(select artigoid from artigos where tipoid =
   		   (select tipoid from tipos where nome = 'Graduação')))

-- Formule expressões em SQL que retornem o id e titulo de todos os artigos publicados pela autora que tem nome 'Renata Galante', e que foram publicados em edições no estado do RS. 
select a.artigoid, a.titulo from artigos a natural join autoresartigo c 
natural join autores b 
natural join edicoes e where b.nome='Renata Galante' and e.uf='RS'

Select b.artigoid, b.titulo
	From 
  (autoresartigo join autores on autoresartigo.autorid = autores.autorid 
   and autores.nome = 'Renata Galante') a 
  join
  (artigos join edicoes on artigos.edicaoid = edicoes.edicaoid and 
   edicoes.uf = 'RS') b
	on a.artigoid = b.artigoid;


-- MAIOR e MENOR
-- Crie expressões em SQL que retornem o ano e a cidade das edições que tiveram a menor 
-- quantidade de participantes. Forneça pelo menos duas expressões que sejam capazes de 
-- retornar estes dados.
SELECT ano, cidade FROM edicoes WHERE qtdparticipantes is not null 
EXCEPT
SELECT e1.ano, e1.cidade FROM edicoes e1 JOIN edicoes e2 
   ON e1.qtdparticipantes>e2.qtdparticipantes AND e1.qtdparticipantes is not null AND
   e2.qtdparticipantes is not null;
   
SELECT ano, cidade, qtdparticipantes FROM edicoes 
where qtdparticipantes = (Select min(qtdparticipantes) from edicoes where 
						  qtdparticipantes is not null);
						  
select ano, cidade from edicoes where qtdparticipantes IS NOT NULL
AND qtdparticipantes <= ALL (select qtdparticipantes from edicoes where qtdparticipantes IS NOT NULL)

-- DIVISÃO
-- Faça uma expressão em SQL que retorne o nome dos autores que publicaram em todas as edições que ocorreram na cidade de Passo Fundo.
SELECT nome FROM autores a WHERE
NOT EXISTS (Select * From edicoes e where cidade='Passo Fundo' AND
	NOT EXISTS (Select * From autoresartigo aa NATURAL JOIN artigos au
	  WHERE au.edicaoid=e.edicaoid AND a.autorid=aa.autorid));

SELECT nome FROM autores a WHERE
(Select COUNT(distinct au.edicaoid) From autoresartigo aa NATURAL JOIN artigos au
	  NATURAL JOIN edicoes e WHERE a.autorid=aa.autorid AND e.cidade='Passo Fundo') = 
(Select COUNT(*) From edicoes e where cidade='Passo Fundo');  

-- Faça uma expressão em SQL que retorne o nome dos autores que publicaram artigos de todos os tipos.
SELECT nome 
FROM autores au 
WHERE NOT EXISTS(Select * From tipos t 
	WHERE NOT EXISTS(SELECT * From autoresartigo aa 
		natural join artigos a
		WHERE aa.autorid=au.autorid 
		AND t.tipoid=a.tipoid)); 

SELECT nome FROM autores au WHERE
  NOT EXISTS(Select * From tipos t WHERE
	 NOT EXISTS(SELECT * From autoresartigo aa WHERE 
				EXISTS(Select * From artigos a
			           WHERE a.artigoid=aa.artigoid AND aa.autorid=au.autorid AND 
					   t.tipoid=a.tipoid))); 
					   
SELECT nome FROM autores au WHERE
(SELECT COUNT(distinct tipoid) FROM artigos natural join autoresartigo aa
WHERE aa.autorid=au.autorid) = (Select count(*) FROM tipos);

-- Faça uma expressão em SQL que retorne o nome dos autores que publicaram em todas as edições que ocorreram no estado do Paraná (PR).
Select nome From autores
Where not exists (
	Select * From edicoes Where uf = 'PR' and not exists
	(Select * From artigos, autoresartigo
		where artigos.artigoid = autoresartigo.artigoid 
			and autores.autorid = autoresartigo.autorid
	 		and artigos.edicaoid = edicoes.edicaoid));










 
