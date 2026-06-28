GABARITO - EXERC�CIOS DE REVIS�O - SQL
--------------------------------------

1) SELECT ID, titulo FROM filmes WHERE ano IN(2002,2003) AND duracao BETWEEN 90 AND 120 ORDER BY titulo;

2) SELECT f.ID, f.nome FROM funcionarios f, clientes c, reservas r WHERE turno='N' AND f.cpf=c.cpf AND c.ID=r.cliente AND dataR='2006-10-01';

3) buscar os t�tulos e nomes de estilos dos filmes locados em 30/09/2006 e 01/10/2006; Exibir o resultado ordenado de forma decrescente por estilo e de forma crescente por t�tulo

SELECT F.titulo, E.nome FROM Filmes F 
       JOIN Estilos E ON F.estilo=E.ID  
       WHERE EXISTS(Select * From Locacoes Where (dataR="2006-09-30" OR 
       dataR="2006-10-01") AND filme = F.ID)
       ORDER BY E.nome desc, F.titulo asc;


4) buscar os nomes e endere�os dos clientes de Florian�polis e os nomes dos clientes que eles s�o respons�veis;

SELECT c.nome, c.endereco, d.nome 
FROM Clientes c 
JOIN Clientes d ON c.ID=d.responsavel where c.cidade="Florian�polis";


5) buscar os nomes e endere�os dos clientes que j� entregaram DVDs com atraso;

SELECT c.nome, c.endereco, d.nome 
FROM Clientes c 
JOIN Locacoes l ON c.ID = l.cliente 
WHERE l.dataD > l.dataPD;


6) buscar os nomes, cidades e endere�os dos funcion�rios do diurno (manh� e tarde) e dos clientes com reserva;

SELECT nome, cidade, endereco 
FROM Funcionarios 
WHERE turno="diurno" 
UNION 
SELECT nome, cidade, endereco 
FROM Clientes WHERE EXISTS(Select * from Reservas where cliente=Clientes.ID);


7) buscar as identifica��es (ID+filme) das c�pias do filme X-Men 3 que est�o dispon�veis para loca��o ou reserva em 30/11/2006;

SELECT c.ID, c.filme FROM C�pias c WHERE filme IN 
(Select ID from Filmes where t�tulo="X-Men 3") 
AND NOT EXISTS (Select * From Loca��es Where dataR<='30/11/2006'and 
dataD>='30/11/2006' and ID=c.ID and filme=.c.filme) 
AND NOT EXISTS (Select * From Reservas where dataR<='30/11/2006' and 
dataPD>='30/11/2006' and  and ID=c.ID and filme=.c.filme);


8) buscar os IDs, nomes e fones dos clientes que j� locaram tanto filmes em VHS quanto filmes em DVD;

Select c.ID, c.nome, c.fone FROM Clientes WHERE 
EXISTS (Select * From Locacoes Where cliente=c.ID and EXISTS (Select * From Copias where midia='VHS' and Locacoes.ID=ID AND Locacoes.filme=filme))
AND EXISTS (Select * From Locacoes Where cliente=c.ID and EXISTS (Select * From Copias where midia='DVD' and Locacoes.ID=ID AND Locacoes.filme=filme));


9) buscar pares de identificadores de c�pias diferentes que pertencem ao mesmo filme, sem repetir um mesmo par na resposta;

SELECT DISTINCT c1.id, c1.filme, c2.id, c2.filme  FROM Copias c1 JOIN 
Copias c2 WHERE c1.filme=c2.filme AND c1.ID<c2.ID;


10) buscar os IDs, nomes e fones dos clientes que locaram apenas filmes de a��o e de suspense;

SELECT c.id, c.nome, c.fone FROM Clientes c WHERE 
NOT EXISTS (SELECT * FROM Locacoes l JOIN Filmes f ON f.ID=l.filme 
JOIN Estilos e ON e.ID=f.estilo WHERE l.cliente=c.ID and e.nome NOT IN 
("acao","suspense"))
AND EXISTS (SELECT * FROM Locacoes l JOIN Filmes f ON f.ID=l.filme 
JOIN Estilos e ON e.ID=f.estilo WHERE l.cliente=c.ID and e.nome IN 
("acao","suspense"));



11) buscar os IDs, nomes e fones dos clientes de Florian�polis que j� locaram todos os VHS legendados;

SELECT c.ID, c.nome, c.fone FROM Clientes c WHERE c.cidade="Florianopolis" 
AND (SELECT COUNT(*) FROM Copias WHERE Copias.midia="VHS" AND 
Copias.tipo="legendado")=(SELECT COUNT(*) FROM Copias INNER JOIN Locacoes 
ON Copias.id=Locacoes.id AND Copias.filme=Locacoes.filme WHERE 
Copias.midia="VHS" AND Copias.tipo="legendado" AND 
Locacoes.cliente=Clientes.id);

OU

SELECT c.ID, c.nome, c.fone FROM Clientes c WHERE c.cidade="Florianopolis" 
AND NOT EXISTS(SELECT * FROM Copias cp WHERE cp.midia="VHS" AND 
cp.tipo="legendado" AND NOT EXISTS(SELECT * FROM Locacoes l
Where cp.id=l.id AND cp.filme=l.filme AND l.cliente=C.id));


12) buscar os IDs e t�tulos dos filmes de a��o que possuem dura��o superior a dura��o de todos os filmes de suspense, terror e drama;

SELECT f.ID, f.titulo FROM Filmes f WHERE f.estilo 
IN(Select ID From Estilos where nome='a��o') AND f.duracao >ALL(
Select duracao From Filmes Where estilo IN(Select ID From Estilos Where
 nome IN('suspense', 'terror', 'drama')));
