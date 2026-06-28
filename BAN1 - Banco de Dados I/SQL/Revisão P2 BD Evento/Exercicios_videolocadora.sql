-- 1) buscar os IDs e títulos dos filmes dos anos 2002 e 2003 com duração superior a 90 e inferior a 120.Exibir o resultado ordenado por título;
SELECT id, titulo 
FROM filmes
WHERE ano IN (2002, 2003) 
AND duracao BETWEEN 90 AND 120
ORDER BY titulo;


-- 2) buscar os IDs e nomes dos funcionários do noturno que também são clientes e realizaram reservas em 01/10/2006;
SELECT fu.id, fu.nome
FROM funcionarios fu
JOIN clientes c ON fu.cpf = c.cpf
JOIN reservas r ON c.id = r.cliente
WHERE turno = 'N' AND datar = '2006-10-01';


-- 3) buscar os títulos e nomes de estilos dos filmes locados em 30/09/2006 e 01/10/2006; Exibir oresultado ordenado de forma decrescente por estilo e de forma crescente por título;
SELECT f.titulo, e.nome
FROM filmes f 
JOIN estilos e ON f.estilo = e.id
JOIN locacoes l ON l.filme = f.id
WHERE  datar IN ('2006-09-30', '2006-10-01')
ORDER BY estilo DESC, estilo ASC;

-- 4) buscar os nomes e endereços dos clientes de Florianópolis e os nomes dos clientes que eles são responsáveis;
SELECT c1.nome, c1.endereco, c2.nome AS responsabilidades 
FROM clientes c1
JOIN clientes c2 ON c1.id = c2.responsavel 
WHERE c1.cidade = 'Florianopolis';


-- 5) buscar os nomes e endereços dos clientes que já entregaram DVDs com atraso;

SELECT c.nome, c.endereco
FROM clientes c
JOIN locacoes l ON c.id = l.cliente
WHERE l.datapd < l.datad;

-- 6) buscar os nomes, cidades e endereços dos funcionários do diurno (manhã e tarde) e dos clientes com reserva;

SELECT nome, cidade, endereco
FROM funcionarios 
WHERE turno IN ('M','T')
UNION
SELECT nome, cidade, endereco
FROM clientes 
WHERE EXISTS (
	SELECT * FROM reservas
	WHERE cliente=clientes.id
) 




-- 7) buscar as identificações(ID+filme) das cópias do filme X-Men 3 que estão disponíveis para locação oureserva em 30/11/2006;


-- 8) buscar os IDs, nomes e fones dos clientes que já locaram tanto filmes em VHS quanto filmes em DVD;


-- 9) buscar pares de identificadores de cópias diferentes que pertencem ao mesmo filme, sem repetir ummesmo par na resposta;


-- 10) buscar os IDs, nomes e fones dos clientes que locaram apenas filmes de ação e de suspense;


-- 11) buscar os IDs, nomes e fones dos clientes de Florianópolis que já locaram todos os VHS legendados;


-- 12) buscar os IDs e títulos dos filmes de ação que possuem duração superior a duração de todos os filmes de suspense, terror e drama.
