-- 1 - Formule expressões em SQL que retornem o id, nome e gênero de autores que publicaram artigos que tem tipo com nome igual à 'Graduação'. Forneça pelo menos duas expressões que sejam capazes de retornar estes dados.
-- primeira:
SELECT DISTINCT au.autorid, au.nome, au.genero 
FROM autores au 
JOIN autoresartigo x ON au.autorid = x.autorid 
JOIN artigos ar ON ar.artigoid = x.artigoid
JOIN tipos ON ar.tipoid = tipos.tipoid
WHERE tipos.nome = 'Graduação';
-- segunda:
SELECT autorid, nome, genero 
FROM autores 
WHERE autorid IN (
	SELECT x.autorid
	FROM autoresartigo x
	JOIN  artigos ar ON ar.artigoid = x.artigoid
	WHERE ar.tipoid = (
		SELECT tipoid 
		FROM tipos
		WHERE nome = 'Graduação'
	)
	
);
-- 2 - Faça uma expressão em SQL que retorne o nome dos autores que publicaram artigos de todos os tipos.
SELECT nome 
FROM autores au
WHERE NOT EXISTS (
	SELECT * FROM tipos t
	WHERE NOT EXISTS (
		SELECT * FROM autoresartigo aa
		NATURAL JOIN artigos a
		WHERE au.autorid = aa.autorid
		AND a.tipoid = t.tipoid
	)
);
-- 3 - Formule uma expressão em SQL que retorne o id e nome de todos os tipos, bem como o título dos seus respectivos artigos. Caso o tipo não possua artigo, apresentar o título do artigo como nulo ou branco.

SELECT t.tipoid, t.nome, ar.titulo AS titulos_artigos
FROM tipos t 
NATURAL LEFT JOIN artigos ar;

-- 4 - Formule uma expressão em SQL que retorne id e nome de pares de autores diferentes mas que publicaram juntos um mesmo artigo. Garanta que um mesmo par de autores não seja retornado na resposta, nem mesmo em posições invertidas.

SELECT a1.autorid, a1.nome, a2.autorid, a2.nome 
FROM autores a1 
natural join autoresartigo aa1
JOIN autoresartigo aa2 ON aa1.artigoid=aa2.artigoid
JOIN autores a2 ON a1.autorid=aa2.autorid AND a1.autorid<a2.autorid;

/*
Explicação

1. `FROM autores a1 natural join autoresartigo aa1`
   - Começa com a tabela de autores (a1)
   - Faz um natural join com autoresartigo (aa1) para pegar os artigos do primeiro autor

2. `JOIN autoresartigo aa2 ON aa1.artigoid=aa2.artigoid`
   - Junta com outra instância da tabela autoresartigo (aa2)
   - A condição `aa1.artigoid=aa2.artigoid` garante que estamos pegando o mesmo artigo

3. `JOIN autores a2 ON a1.autorid=aa2.autorid AND a1.autorid<a2.autorid`
   - Junta com outra instância da tabela autores (a2)
   - A condição `a1.autorid<a2.autorid` é crucial:
     - Evita duplicatas (ex: se temos par A-B, não queremos B-A)
     - Evita que um autor seja pareado com ele mesmo

Por exemplo, se temos:
- Autor 1 (ID: 1) e Autor 2 (ID: 2) escreveram o Artigo X
- Autor 1 (ID: 1) e Autor 3 (ID: 3) escreveram o Artigo Y

A consulta retornará:
- Par (1,2) - porque escreveram juntos o Artigo X
- Par (1,3) - porque escreveram juntos o Artigo Y

Mas não retornará:
- Par (2,1) - porque 2>1
- Par (3,1) - porque 3>1
- Par (1,1) - porque um autor não é pareado com ele mesmo

*/

-- 5 - Crie expressões em SQL que retornem o ano e a cidade das edições que tiveram a maior quantidade de participantes. Forneça pelo menos duas expressões que sejam capazes de retornar estes dados.
SELECT ano, cidade 
FROM edicoes 
WHERE qtdparticipantes >= ALL (
	SELECT qtdparticipantes 
	FROM edicoes
	WHERE qtdparticipantes IS NOT NULL
)

SELECT ano, cidade 
FROM edicoes 
WHERE qtdparticipantes = (
	SELECT MAX(qtdparticipantes) 
	FROM edicoes
	WHERE qtdparticipantes IS NOT NULL
)

-- obs: Caso a coluna seja opcional, ou seja, podem ter valores nulos é preciso usar o WHERE valor IS NOT NULL. 