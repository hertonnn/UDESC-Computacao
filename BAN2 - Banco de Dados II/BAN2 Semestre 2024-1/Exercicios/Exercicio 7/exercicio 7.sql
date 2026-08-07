-- 1) Função para inserção de um mecânico.

		CREATE OR REPLACE FUNCTION insert_mecanico (pcodm int, pcpf char(11), pnome varchar(50), pidade int, pendereco varchar(100), 
		pfuncao varchar(50), pcods int) RETURNS int AS
		$$
		DECLARE
			quant int DEFAULT 0;
		BEGIN
			INSERT INTO mecanico VALUES(pcodm, pcpf, pnome, pidade, pendereco, pfuncao, pcods);
			GET DIAGNOSTICS quant = ROW_COUNT;
			RAISE NOTICE'Quantidade de registros alterados: %', quant;
			RETURN quant;
		END;
		$$
		LANGUAGE plpgsql;
		
		SELECT insert_mecanico(20, '12345678901', 'Mario', 32, 'Toribio', 'Cambio', '1');
		

-- 2) Função para exclusão de um mecânico.

		CREATE OR REPLACE FUNCTION delete_mecanico (pcodm int) RETURNS void AS
		$$
		BEGIN
			DELETE FROM mecanico m WHERE codm = pcodm;
		END;
		$$
		LANGUAGE plpgsql

		SELECT * FROM mecanico;
		SELECT delete_mecanico(20);
		SELECT * FROM mecanico;

-- 3) Função única para inserção, atualizar e exclusão de um cliente.

		CREATE OR REPLACE FUNCTION inst_atl_delet(op char(1), pcodc int, pcpf varchar(11), pnome varchar, pidade int, 
		pendereco varchar(500), pcidade varchar(30)) RETURNS void AS
		$$
		BEGIN
    		IF (UPPER(op) = 'I') THEN
        		INSERT INTO cliente VALUES (pcodc, pcpf, pnome, pidade, pendereco, pcidade);
    		ELSIF (UPPER(op) = 'U') THEN
        		UPDATE cliente
        			SET
            		cpf = pcpf,
            		nome = pnome,
            		idade = pidade,
            		endereco = pendereco,
            		cidade = pcidade
        			WHERE codc = pcodc;
    		ELSIF (UPPER(op) = 'D') THEN
        		DELETE FROM cliente WHERE codc = pcodc;
			ELSE
        		RAISE EXCEPTION 'Comando não encontrado';
    		END IF;
		END;
		$$
		LANGUAGE plpgsql;


-- 4) Função que limita o cadastro de no máximo 10 setores na oficina mecânica.

		CREATE OR REPLACE FUNCTION limite_cadastro (pcods int, pnome varchar[30]) RETURNS VOID AS
		$$
		BEGIN
			iF(SELECT count(cods) FROM setor) < 10 THEN
				INSERT INTO setor VALUES(pcods, pnome);
			ELSE
				RAISE EXCEPTION 'Cadastro de setores chegou ao limite';
			END IF;
		END;
		$$
		LANGUAGE plpgsql

-- 5) Função que limita o cadastro de um conserto apenas se o mecânico não tiver mais de 3 consertos agendados para o mesmo dia.

		CREATE OR REPLACE FUNCTION limite_conserto (pcodm int, pcodv int, pdata date, phora time) RETURNS VOID AS
		$$
		DECLARE
			quant int DEFAULT 0;
		BEGIN 
			SELECT count(codm) FROM conserto WHERE codm = pcodm AND data = pdata INTO quant;
			raise notice 'Quantidade de consertos para este mecanico: %', quant;
			IF QUANT < 3 THEN 
				INSERT INTO conserto VALUES(pcodm, pcodv, pdata, ptime);
			ELSE 
				RAISE EXCEPTION 'Quantidade de consertos para este mecanico foi ultrapassada';
			END IF;
		END;
		$$
		LANGUAGE plpgsql

-- 6) Função para calcular a média geral de idade dos Mecânicos e Clientes.

		CREATE OR REPLACE FUNCTION calcula_media() RETURNS FLOAT AS
		$$
		DECLARE
			media float;
		BEGIN
			SELECT AVG(idade)::float INTO media FROM(
			SELECT idade FROM mecanico
			UNION ALL
			SELECT idade FROM cliente
			) AS todas_idades;
			RETURN media;
		END;
		$$
		LANGUAGE plpgsql

-- 7) Função única que permita fazer a exclusão de um Setor, Mecânico, Cliente ou Veículo.

		CREATE OR REPLACE FUNCTION exclusao(pid int, tipo int) RETURNS void AS
		$$
		BEGIN
    		IF tipo = 0 THEN
        		DELETE FROM setor WHERE id = pid;
    		ELSIF tipo = 1 THEN
        		DELETE FROM mecanico WHERE id = pid;
    		ELSIF tipo = 2 THEN
        		DELETE FROM cliente WHERE id = pid;
    		ELSE
        		DELETE FROM veiculo WHERE id = pid;
    		END IF;
		END;
		$$
		LANGUAGE plpgsql;

		-- Outra forma de fazer
		CREATE OR REPLACE FUNCTION alteraBD(nome_tabela varchar, chave varchar[], valor varchar[]) RETURNS void AS
		$$
		BEGIN
			IF UPPER(nome_tabela) = 'SETOR' THEN
				EXECUTE excluir_setor(chave, valor);
			ELSIF UPPER(nome_tabela) = 'CLIENTE' THEN
				EXECUTE excluir_cliente(chave, valor);
			ELSIF UPPER(nome_tabela) = 'MECANICO' THEN
				EXECUTE  excluir_mecanico(chave, valor);
			ELSIF UPPER(nome_tabela) = 'VEICULO' THEN
				EXECUTE  excluir_veiculo(chave, valor);
			END IF;
		END;
		$$
		LANGUAGE plpgsql;

		CREATE OR REPLACE FUNCTION excluir_setor(chave varchar [], valor varchar[]) RETURNS void AS 
		$$
		BEGIN
			EXECUTE 'delete from setor where' || chave[1] || '=' || valor[1];
		END;
		$$
		LANGUAGE plpgsql;
		
		CREATE OR REPLACE FUNCTION excluir_cliente(chave varchar [], valor varchar[]) RETURNS void AS 
		$$
		BEGIN
			EXECUTE 'delete from cliente where' || chave[1] || '=' || valor[1];
		END;
		$$
		LANGUAGE plpgsql;

		CREATE OR REPLACE FUNCTION excluir_mecanico (chave varchar [], valor varchar[]) RETURNS void AS 
		$$
		BEGIN
			EXECUTE 'delete from mecanico where' || chave[1] || '=' || valor[1];
		END;
		$$
		LANGUAGE plpgsql;

		CREATE OR REPLACE FUNCTION excluir_veiculo(chave varchar [], valor varchar[]) RETURNS void AS 
		$$
		BEGIN
			EXECUTE 'delete from veiculo where' || chave[1] || '=' || valor[1];
		END;
		$$
		LANGUAGE plpgsql;

-- 8) Considerando que na tabela Cliente apenas codc é a chave primária, faça uma função que remova clientes com CPF repetido, 
-- deixando apenas um cadastro para cada CPF. Escolha o critério que preferir para definir qual cadastro será mantido: 
-- aquele com a menor idade, que possuir mais consertos agendados, etc. Para testar a função, não se esqueça de inserir na 
-- tabela alguns clientes com este problema.

		CREATE OR REPLACE FUNCTION excluiclientecpf() RETURNS int AS 
		$$
		BEGIN
			DELETE FROM cliente WHERE codc NOT IN (SELECT MIN(codc) FROM cliente GROUP BY cpf);
		END;
		$$
		LANGUAGE plpgsql;

-- 9) Função para calcular se o CPF é válido*.

		CREATE OR REPLACE FUNCTION cpf_valido(cpf_input CHAR(11)) RETURNS BOOLEAN AS
		$$
		DECLARE
    		soma INT;
    		resto INT;
    		dv1 INT;
    		dv2 INT;
		BEGIN
    		soma := 0;
    		FOR i IN 1..9 LOOP
       			soma := soma + (CAST(SUBSTRING(cpf_input, i, 1) AS INT) * (11 - i));
    		END LOOP;

    		resto := soma % 11;
    		IF resto < 2 THEN
        		dv1 := 0;
    		ELSE
        		dv1 := 11 - resto;
    		END IF;
    		soma := 0;
    		FOR i IN 1..9 LOOP
        		soma := soma + (CAST(SUBSTRING(cpf_input, i, 1) AS INT) * (12 - i));
    		END LOOP;
    		soma := soma + dv1 * 2;	
    		resto := soma % 11;
    		IF resto < 2 THEN
      			dv2 := 0;
    		ELSE
        		dv2 := 11 - resto;
    		END IF;

    		IF dv1 = CAST(SUBSTRING(cpf_input, 10, 1) AS INT) AND
      			dv2 = CAST(SUBSTRING(cpf_input, 11, 1) AS INT) THEN
       			RETURN TRUE;
    		ELSE
        		RETURN FALSE;
    		END IF;
		END;
		$$
		LANGUAGE plpgsql;

-- 10) Função que calcula a quantidade de horas extras de um mecânico em um mês de trabalho. O número de horas extras é calculado 
-- a partir das horas que excedam as 160 horas de trabalho mensais. O número de horas mensais trabalhadas é calculada a 
-- partir dos consertos realizados. Cada conserto tem a duração de 1 hora.

		CREATE OR REPLACE FUNCTION calcula_hora_extra(pcodm int, pmes int, pano int) RETURNS INT AS
		$$
		DECLARE
			total_horas INT;
			horas_extras INT;
		BEGIN
			SELECT COUNT(*) INTO total_horas
			FROM conserto
			WHERE codm = pcodm
			AND EXTRACT(MONTH FROM data) = pmes;
			AND EXTRACT(YEAR FROM data) = pano;

			IF total_horas > 160 THEN
				horas_extras := total_horas - 160;
			ELSE
				horas_extras := 0;
			END IF;
			RETURN horas_extras;
		END;
		$$
		LANGUAGE plpgsql;









